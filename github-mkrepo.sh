#!/bin/bash
set -e 

GITHUB_USERNAME=$1
REPOSITORY_NAME=$2


if test -z $GITHUB_USERNAME 
then
    echo 'github-mkrepo.sh 
Create a new Github repository 
Usage: 
github-mkrepo.sh GITHUB_USERNAME REPOSITORY_NAME'

      echo "Missing input GITHUB_USERNAME"
      exit 1
fi

if test -z $REPOSITORY_NAME 
then
    echo 'github-mkrepo.sh 
Create a new Github repository 
Usage: 
git-new-repo GITHUB_USERNAME REPOSITORY_NAME'

      echo "Missing input REPOSITORY_NAME"
      exit 1
fi

echo "Github username: $GITHUB_USERNAME"
echo "Github repository name: $REPOSITORY_NAME"
curl -u $GITHUB_USERNAME https://api.github.com/user/repos -d '{"name":"'$REPOSITORY_NAME'"}'

echo "

  Check Github message above.
  If success, proceed connecting your local folder to Github with

git remote add origin https://github.com/$GITHUB_USERNAME/$REPOSITORY_NAME
  
  and then push your commit with

git push origin master"