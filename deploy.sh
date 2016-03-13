echo -e "Building page(s)"
hugo

echo -e "Committing changes to Github..."
git add -A
git commit -m "Publishing site on `date`."

echo -e "Uploading..."
rsync -arvz ./public/ aisrael@ftp.adamisrael.com:dev.adamisrael.com
