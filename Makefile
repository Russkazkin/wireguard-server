deploy:
	ssh deploy@${HOST} -p ${PORT} 'rm -rf wireguard-server && mkdir wireguard-server'
	ssh deploy@${HOST} -p ${PORT} 'mkdir wireguard-server/secrets'
	scp -P ${PORT} compose.yml deploy@${HOST}:wireguard-server/compose.yml
	#scp -P ${PORT} ./docker/secrets/aws_secret_access_key deploy@${HOST}:s3/secrets
	ssh deploy@${HOST} -p ${PORT} 'cd wireguard-server && echo "COMPOSE_PROJECT_NAME=wireguard-server" >> .env'
	ssh deploy@${HOST} -p ${PORT} 'cd wireguard-server && docker compose down --remove-orphans'
	ssh deploy@${HOST} -p ${PORT} 'cd wireguard-server && docker compose pull'
	ssh deploy@${HOST} -p ${PORT} 'cd wireguard-server && docker compose up -d'