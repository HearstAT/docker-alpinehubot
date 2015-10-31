SCRIPTS='hubot-pager-me hubot-chef hubot-plusplus hubot-tell hubot-devops-reactions hubot-team hubot-github-repo-event-notifier hubot-reload-scripts hubot-jenkins hubot-jenkins-notifer'

for script in $SCRIPTS; do
  npm install $script --save
done
