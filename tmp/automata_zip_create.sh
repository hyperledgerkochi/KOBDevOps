#!/bin/bash

echo "Before..."
ls -latr ../kobman_zip_file.zip
sudo zip kobman_zip_file.zip kobman-*
sudo cp -i kobman_zip_file.zip ../kobman_zip_file.zip
echo "....after."
ls -latr ../kobman_zip_file.zip


