deploy:
	#ssh deploy@${HOST} -p ${PORT} 'rm -rf wireguard-server && mkdir wireguard-server'
	scp -P ${PORT} compose.yml deploy@${HOST}:wireguard-server/compose.yml
	ssh deploy@${HOST} -p ${PORT} 'cd wireguard-server && docker compose down --remove-orphans'
	ssh deploy@${HOST} -p ${PORT} 'cd wireguard-server && docker compose pull'
	ssh deploy@${HOST} -p ${PORT} 'cd wireguard-server && docker compose up -ed'