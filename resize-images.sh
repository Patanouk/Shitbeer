#!/usr/bin/env bash

human_print() {
  numfmt --to=iec-i --suffix=B --format="%.0f" "$1"
}

target_size=250000
human_readable_target_size=$(human_print "$target_size")
target_directory="images-copy"

is_image_small_enough() {
    if [ "$target_size" -gt "$1" ]; then
      echo "Image $f has size $human_readable_image_size, smaller than target size $human_readable_target_size. Skipping conversion"
      return 0
    else
      return 1
    fi
}

mkdir -p "$target_directory"
cp ./*.jpg "$target_directory"

for f in *.jpg; do
  echo "Processing image $f"

  while true; do
    image_size=$(stat --printf="%s" "$target_directory/$f")
    human_readable_image_size=$(human_print "$image_size")
    echo "Copied image size is $human_readable_image_size"

      if is_image_small_enough "$image_size"; then
        break;
      fi

      convert -resize 80% "${target_directory}/${f}" "${target_directory}/temp-image.jpg"
      mv "${target_directory}/temp-image.jpg" "${target_directory}/${f}"
  done
done;