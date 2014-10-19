#!/usr/bin/env bash
set -o errexit #abort if any command fails

root=~/src/cs
deploy_to=$root/androcetus.github.io 
deploy_from_root=$root/androcetus.com
deploy_from=$root/androcetus.com/public

echo "from $deploy_from  to $deploy_to"

cd $deploy_from
rm -rf *

cd $deploy_from_root
#for some reason without the --theme the whole site doesn't build
hugo --theme=hyde

cd $deploy_to

git pull origin master

#echo "git ls-files -z | xargs -0 git rm --cached"
#git ls-files -z | xargs -0 git rm --cached
rm -rfv *

echo "cp -Rf $deploy_from/ $deploy_to"

cp -Rf "$deploy_from/" $deploy_to

git add --all .

echo "Push"
git commit -m "Site update" && git push


