echo -e "Building page(s)"
hugo

echo -e "Committing changes to Github..."
git add -A
git commit -m "Publishing site on `date`."
git push origin master

echo -e "Uploading..."
rsync -arz ./public/ aisrael@ftp.adamisrael.com:dev.adamisrael.com
