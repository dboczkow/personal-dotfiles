#!/bin/sh

# Zrzut REGIONU
spectacle --region -b -n -o /tmp/ocr_screen.png -n 2>/dev/null || spectacle --region -o /tmp/ocr_screen.png

# LEPSZE preprocessing dla OCR (więcej kontrastu + grayscale)
magick /tmp/ocr_screen.png \
  -strip \
  -colorspace Gray \
  -contrast-stretch 2% \
  -sharpen 0x1 \
  -resize 300% \
  /tmp/ocr_enhanced.png

# OCR z lepszymi ustawieniami
tekst=$(tesseract /tmp/ocr_enhanced.png stdout -l eng+pol --psm 6 --oem 3 2>/dev/null || echo "Błąd OCR")

# Kopiuj do schowka
if command -v wl-copy >/dev/null; then
    printf '%s' "$tekst" | wl-copy
    notify-send -u low -a Spectacle -i spectacle "Spectacle" "Skopiowano: $tekst"
elif command -v xclip >/dev/null; then
    printf '%s' "$tekst" | xclip -sel clip
fi

rm -f /tmp/ocr_screen.png /tmp/ocr_enhanced.png
