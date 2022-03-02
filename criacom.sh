#!/usr/bin/env bash

# criacom.sh
# Shell script para criacao de comunicados
# Dependencia: sudo apt install imagemagick-6.q16
# Uso 

set -x


if [[ ! "$1" ]] || [[ ! -f "$2" ]] || [[ ! -f "$3" ]]
then
    echo -e "ERROR: Missing parameters.\n\n$0\n"
    echo -e "Usage:\n  criacom.sh <filename.png> <logoname.png> <txtname.txt>\n\nWhere:"
    echo -e "  - filename.png = nome do arquivo png desejado"
    echo -e "  - logoname.png = nome do arquivo png com a logo Sulamerica"
    echo -e "  - txtname.txt = nome do arquivo txt com o texto do comunicado"  
    exit 1  
fi

IMGNAME="$1"
LOGONAME="$2"
TXTNAME="$3"
WIDTH=700

echo -e "@0\n\nWhich color scheme?"
echo -e "1 Fundo laranja com fonte azul"
echo -e "2 Fundo azul com fonte laranja"
echo -e "3 Fundo azul com fonte laranja"
read -n1 COLORSCHEME

case "$COLORSCHEME" in
    1)
        #BGCOLOR="#68007F"
        BGCOLOR="#FF5733"
        FONTCOLOR="#250EB6"
        ;;
    2) 
        BGCOLOR="#250EB6"
        FONTCOLOR="#FF5733"
        ;;
    *)
        echo -n "unknown"
        ;;
esac        

fold -s -w80 "$TXTNAME" > "new-$TXTNAME"
mv -f "new-$TXTNAME" "$TXTNAME"

TXTLINES=$(wc -l < "$TXTNAME")
HEIGHT=$(expr "$TXTLINES" '*' 17 + 300 )
# pointsize 15 = ~15 pixels por linha de texto

convert "$LOGONAME" -resize 20000@  "resized-$LOGONAME"
LOGOWIDTH=$(identify -format "%w" "resized-$LOGONAME")
LOGOHEIGHT=$(identify -format "%h" "resized-$LOGONAME")

LOGOPOSWIDTH=$(expr "$WIDTH" - "$LOGOWIDTH" )
LOGOPOSHEIGHT=$(expr "$HEIGHT" - "$LOGOHEIGHT" )

convert \
    -size "$WIDTH"x"$HEIGHT" xc:"$BGCOLOR"  \
    -font helvetica \
    -pointsize 23 \
    -fill "$FONTCOLOR" \
        -draw "text +30,+100 '#AdministraçãoSalesforce'" \
    -font helvetica \
    -pointsize 17 \
    -fill "$FONTCOLOR" \
        -annotate +30+200 "@$TXTNAME" "$IMGNAME"

composite \
    -geometry +"$LOGOPOSWIDTH"+"$LOGOPOSHEIGHT" "resized-$LOGONAME"  "$IMGNAME" "temp-$IMGNAME"

rm -f "resized-$LOGONAME"
mv -f  "temp-$IMGNAME" "$IMGNAME" 

if [[ -f "$IMGNAME" ]]
then 
    echo "Arquivo com comunicado criado com sucesso: $IMGNAME"
    xdg-open "$IMGNAME"
else
    echo "Algo deu errado."
fi