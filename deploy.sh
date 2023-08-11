echo -e "Building page(s)"
./hugo

# I've moved to a pull request-based workflow. At most, I might tag each
# deployment with a timestamp.
#echo -e "Committing changes to Github..."
#git add -A
#git commit -m "Publishing site on `date`."
#git push origin master

echo -e "Uploading..."
rsync -arz ./public/ aisrael@ftp.adamisrael.com:adamisrael.com
