#!/usr/bin/env bash

echo 'Ever encounter files you wanted to use but have strange permissions or unwiedly permissions on them?
This is exactly for you then! Copy files over with their original content but with default file permissions!
Format: ./copy.sh PATH_TO_COPY
This will copy all files in PATH_TO_COPY in the CURRENT directory
'

COPY_PATH=$1

[ $# -eq 0 ] && echo -n "No paths supplied" && kill -INT $$

[ ! -d "$COPY_PATH" ] && echo -n "Path does not exist" && kill -INT $$

echo "Copying directories from $COPY_PATH..."

for dir in $(find $COPY_PATH -type d | grep -w "\./.*"); do
    mkdir ${dir/"$COPY_PATH"/'.'} 2>/dev/null
done

echo "Completed Directories"
echo "Starting to copy files..."

for file in $(find $COPY_PATH -type f | grep -w "\./.*"); do
    /bin/cat $file > ${file/"$COPY_PATH"/'.'}
    if [ $? -ne 0 ]; then
      sudo /bin/cat $file > ${file/"$COPY_PATH"/'.'}
    fi
done

echo "Complete!"
