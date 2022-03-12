# bin/zsh

HOST=ubuntu@13.124.250.68

echo "start"

ssh $HOST \
"cd rails-app \
&& git fetch \
&& git checkout main \
&& git pull \
&& docker exec web rails db:migrate \
&& docker-compose restart web"

echo "end"