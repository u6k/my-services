#!/usr/bin/env python3

import os, requests
from requests.auth import HTTPBasicAuth
from datetime import datetime, timedelta



print("=== env ===")

print("TARGET_DATE=%s" % (os.getenv("RD_OPTION_TARGET_DATE"),))



print("=== crawl ===")

target_date = os.getenv("RD_OPTION_TARGET_DATE", None)
if target_date is not None:
    target_date = datetime.strptime(target_date, "%Y-%m-%d")
else:
    target_date = datetime.now()
end_date = target_date + timedelta(days=1)

params = {
    "start_date": target_date.strftime("%Y-%m-%d"),
    "end_date": end_date.strftime("%Y-%m-%d"),
    "recache_race": True,
    "recache_horse": False,
}
print("params=%s" % (params,))

auth = HTTPBasicAuth(os.getenv("RD_OPTION_AUTH_USER"), os.getenv("RD_OPTION_AUTH_PASS"))

print("crawling...")
response = requests.post("https://horse-racing-crawler.u6k.me/api/crawl", auth=auth, json=params)

print("status_code=%s" % (response.status_code,))
print("response=%s" % (response.json(),))
if response.status_code != 200:
    raise RuntimeError("crawl fail")



print("=== schedule vote/close ===")

print("finding...")
response = requests.get("https://horse-racing-crawler.u6k.me/api/race_info?target_date=%s" % (target_date.strftime("%Y-%m-%d"),), auth=auth)
print("status_code=%s" % (response.status_code,))
print("response=%s" % (response.json(),))
if response.status_code != 200:
    raise RuntimeError("schedule fail")



for race_info in response.json()["race_info"]:
    print("--- schedule vote ---")
    print("race_info=%s" % (race_info,))
    
    start_datetime = datetime.strptime(race_info["start_datetime"], "%Y-%m-%d %H:%M:%S")
    vote_job_interval = int(os.getenv("RD_OPTION_VOTE_JOB_INTERVAL"))
    close_job_interval = int(os.getenv("RD_OPTION_CLOSE_JOB_INTERVAL"))

    headers = {
        "X-Rundeck-Auth-Token": os.getenv("RD_OPTION_AUTH_RUNDECK_API_TOKEN"),
    }
    params = {
        "runAtTime": (start_datetime - timedelta(minutes=vote_job_interval)).strftime("%Y-%m-%dT%H:%M:%S+09:00"),
        "options": {
            "RACE_ID": race_info["race_id"],
        }
    }
    url = "https://rundeck.u6k.me/api/35/job/c229f11c-d55b-4fef-95b1-fd10368904be/run"
    
    print("params=%s" % (params,))
    response = requests.post(url, headers=headers, json=params)
    print("status_code=%s" % (response.status_code,))
    print("response=%s" % (response.text,))



    print("--- schedule close ---")
    params = {
        "runAtTime": (start_datetime + timedelta(minutes=close_job_interval)).strftime("%Y-%m-%dT%H:%M:%S+09:00"),
        "options": {
            "RACE_ID": race_info["race_id"],
        }
    }
    url = "https://rundeck.u6k.me/api/35/job/9232928e-ded8-4127-9baa-67de1cb1055e/run"
    
    print("params=%s" % (params,))
    response = requests.post(url, headers=headers, json=params)
    print("status_code=%s" % (response.status_code,))
    print("response=%s" % (response.text,))
