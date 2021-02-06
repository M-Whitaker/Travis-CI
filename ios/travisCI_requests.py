import requests
from pprint import pprint
import datetime
import netrc

(username, account, token) = netrc.netrc().authenticators('api.travisci.com')


now = datetime.datetime.now()

baseUrl = "https://api.travis-ci.com"

headers = {"Authorization": "token " + token,
           "Travis-API-Version": "3"}

r = requests.get(
    baseUrl + "/repos?include=branch.last_build", headers=headers)

print(r.status_code)

response = r.json()

for repo in response['repositories']:
    if repo['active']:
        print(repo['slug'])
        print(repo['default_branch']['name'])
        build = repo['default_branch']['last_build']
        try:
            print("Last Build: ")
            print(build['state'])
            print(str(datetime.timedelta(
                seconds=build['duration'])))
            datetime_object = datetime.datetime.strptime(
                build['finished_at'], '%Y-%m-%dT%H:%M:%SZ')
            print(datetime_object)
        except:
            pass

        print(" ----------------------------------- ")
