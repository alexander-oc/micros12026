#!/bin/bash
# Ejecutar en la carpeta donde esta codigo_fuente.txt:  bash compilar_todo.sh
XC8=/opt/microchip/xc8/v4.00/bin/xc8-cc
DFP=$HOME/packs/PIC16Fxxx_DFP/xc8
CMD="$XC8 -mcpu=16f84a -mdfp=$DFP main.c"

# --- Linea base: ejemplo de clase sin cambios ---
mkdir -p base
cat > base/main.c <<'EOC'
#pragma config FOSC = HS, WDTE = OFF, PWRTE = ON, CP = OFF
#include <xc.h>
#define _XTAL_FREQ 16000000

unsigned int luces[12]={0x03,0x06,0x0C,0x18,0x30,0x60,
                        0xC0,0x60,0x30,0x18,0x0C,0x06};
int i=0;

void main(void) {
    TRISB=0;                  // Puerto B como salida
    while (1) {
        PORTB=luces[i];
        __delay_ms(125);
        i++;
        if (i>11) i=0;
    }
}
EOC
(cd base && echo "\$ $CMD" > ../compilacion_base.txt && $CMD >> ../compilacion_base.txt 2>&1)

# --- Version final ---
cp codigo_fuente.txt main.c
echo "\$ $CMD" > compilacion_final.txt
$CMD >> compilacion_final.txt 2>&1

# --- Un solo archivo para entregar ---
{ echo "===== LINEA BASE (EJEMPLO DE CLASE) ====="; cat compilacion_base.txt; echo;
  echo "===== VERSION FINAL ====="; cat compilacion_final.txt; } > compilacion.txt

echo; echo "######## RESUMEN (copia esto y pegalo en el chat) ########"
cat compilacion.txt
echo; echo "Archivo para descargar y simular: main.hex  (tambien base/main.hex)"
