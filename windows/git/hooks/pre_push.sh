git_status_before_synx=$(git status)
synx -q <projectName>.xcodeproj
git_status_after_synx=$(git status)

if [ "$git_status_before_synx" != "$git_status_after_synx" ]
then
  git add --al
  git commit -am "Runs synx to change the strucutre of directory"
  echo "Synx changed the structure of the directory. Push the changes ones again"
  exit 1
else
  echo "Synx has not changed anything. Pushing..."
  exit 0
fi
