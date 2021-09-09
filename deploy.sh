REVISION=`git log -n 1 --pretty=format:"%H"`
sed -i -e "s/<% GIT_REVISION %>/$REVISION/g" .env.production
sed -i -e "s/<% GIT_REVISION %>/$REVISION/g" public/manifest.json

yarn install
yarn run build

echo TODO Upload to S3

git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"

timestamp=`date +%Y-%m-%d_%H%M%S`
git tag -a "$timestamp" -m "Push to production"
git push --tags
