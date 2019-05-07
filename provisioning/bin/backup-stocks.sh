[Unit]
Description=Backup database

[Service]
Type=oneshot
EnvironmentFile=/etc/profile.d/backup-db.sh
ExecStart=/usr/local/bin/backup-db.sh

[Install]
WantedBy=multi-user.target
