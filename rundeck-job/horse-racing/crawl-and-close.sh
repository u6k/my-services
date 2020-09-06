#!/usr/bin/env python3

import os, requests
from requests.auth import HTTPBasicAuth



print("=== crawl ===")

auth = HTTPBasicAuth(os.getenv("RD_OPTION_AUTH_CRAWLER_USER"), os.getenv("RD_OPTION_AUTH_CRAWLER_PASS"))

params = {
    "start_url": "https://keiba.yahoo.co.jp/race/denma/%s/" % (os.getenv("RD_OPTION_RACE_ID"),),
    "recache_race": True,
    "recache_horse": False,
}
print("params=%s" % (params,))

print("crawling...")
response = requests.post("https://horse-racing-crawler.u6k.me/api/crawl", auth=auth, json=params)
print("status_code=%s" % (response.status_code,))
print("body=%s" % (response.text,))
if response.status_code != 200:
    raise RuntimeError("crawl fail")



print("=== close ===")

auth = HTTPBasicAuth(os.getenv("RD_OPTION_AUTH_TRADER_USER"), os.getenv("RD_OPTION_AUTH_TRADER_PASS"))

params = {
    "race_id": os.getenv("RD_OPTION_RACE_ID"),
}
print("params=%s" % (params,))

print("closeing...")
response = requests.post("https://horse-racing-trader.u6k.me/api/vote/close", auth=auth, json=params)
print("status_code=%s" % (response.status_code,))
print("body=%s" % (response.text,))
if response.status_code != 200:
    raise RuntimeError("vote fail")



response_data = response.json()
if response_data["vote_cost"] > 0:
    print("=== slack ===")
    
    params = {
        "text": "result: <https://keiba.yahoo.co.jp/race/result/%s/|race_link>, horse_number: %s, result: %s, result_odds: %s, vote_cost: %s, vote_return: %s" % (response_data["race_id"], response_data["horse_number"], response_data["result"], response_data["result_odds"], response_data["vote_cost"], response_data["vote_return"]),
    }
    print("params=%s" % (params,))
    url = "https://hooks.slack.com/services/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"
    
    print("slack...")
    response = requests.post(url, json=params)
    print("status_code=%s" % (response.status_code,))
    print("body=%s" % (response.text,))
    if response.status_code != 200:
        raise RuntimeError("vote fail")
