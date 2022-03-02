#!/usr/bin/env bash

# criacom.sh
# Shell script para criacao de comunicados
# Dependencia: sudo apt install imagemagick-6.q16
# Uso 

set +x


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
WIDTH=650
BGCOLOR="#68007F"

fold -s -w80 "$TXTNAME" > "new-$TXTNAME"
mv -f "new-$TXTNAME" "$TXTNAME"

TXTLINES=$(wc -l < "$TXTNAME")
HEIGHT=$(expr "$TXTLINES" '*' 15 + 300 )
# pointsize 15 = ~15 pixels por linha de texto

convert "$LOGONAME" -resize 20000@  "resized-$LOGONAME"
LOGOWIDTH=$(identify -format "%w" "resized-$LOGONAME")
LOGOHEIGHT=$(identify -format "%h" "resized-$LOGONAME")

LOGOPOSWIDTH=$(expr "$WIDTH" - "$LOGOWIDTH" )
LOGOPOSHEIGHT=$(expr "$HEIGHT" - "$LOGOHEIGHT" )

convert \
    -size "$WIDTH"x"$HEIGHT" xc:"$BGCOLOR"  \
    -font helvetica \
    -pointsize 25 \
    -fill white \
        -draw "text +30,+100 '#AdministraçãoSalesforce'" \
    -font helvetica \
    -pointsize 20 \
    -fill white \
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