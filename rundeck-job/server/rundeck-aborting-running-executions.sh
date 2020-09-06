#!/usr/bin/env python3

import os, requests
import xml.etree.ElementTree as ET



print("=== listing running executions ===")

headers = {
    "X-Rundeck-Auth-Token": os.getenv("RD_OPTION_AUTH_RUNDECK_TOKEN"),
}
url = "https://rundeck.u6k.me/api/35/project/%s/executions/running?max=1000" % (os.getenv("RD_OPTION_PROJECT"),)

response = requests.get(url, headers=headers)
print("status_code=%s" % (response.status_code,))



executions = ET.fromstring(response.text)
for execution in executions:
    print("=== aborting execution ===")
    print("id=%s" % execution.attrib["id"])
    
    url = "https://rundeck.u6k.me/api/35/execution/%s/abort" % (execution.attrib["id"],)
    
    response = requests.get(url, headers=headers)
    print("status_code=%s" % (response.status_code,))
    print("body=%s" % (response.text,))
