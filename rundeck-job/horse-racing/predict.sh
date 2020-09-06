curl -v -f \
    -u $RD_OPTION_AUTH_USER:$RD_OPTION_AUTH_PASS \
    -H "Content-Type: application/json" \
    -d "{\"race_id\":\"$RD_OPTION_RACE_ID\",\"asset\":$RD_OPTION_ASSET}" \
    https://horse-racing-predict.u6k.me/api/predict
