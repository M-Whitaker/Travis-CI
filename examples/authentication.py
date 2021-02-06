"""
Quick mockup of Oauth with Github & Travis
"""
import os

import requests
from oauthlib.oauth2 import BackendApplicationClient
from requests_oauthlib import OAuth2Session

CLIENT_ID = os.environ['GH_BASIC_CLIENT_ID']
CLIENT_SECRET = os.environ['GH_BASIC_SECRET_ID']
SCOPES = "read:user,repo,user:email"

AUTHORIZATION_BASE_URL = 'https://github.com/login/oauth/authorize'
TOKEN_URL = 'https://github.com/login/oauth/access_token'


def get_token_from_file():
    try:
        with open("token.txt", "r") as fp:
            token = fp.readline()
            fp.close()
    except IOError:
        token = -1

    try:
        token = eval(token)
    except Exception:
        token = -1

    return token


def save_token_to_file(token):
    with open("token.txt", "w") as fp:
        fp.write(str(token))
        fp.close()


def main():
    response = get_token_from_file()
    if response != -1:
        github = OAuth2Session(CLIENT_ID, token=response, scope=SCOPES)
    else:
        github = OAuth2Session(CLIENT_ID, scope=SCOPES)
        authorization_url, _ = github.authorization_url(AUTHORIZATION_BASE_URL)
        print('Please go here and authorize,', authorization_url)
        redirect_response = input('Paste the full redirect URL here:')
        response = github.fetch_token(TOKEN_URL, client_secret=CLIENT_SECRET,
                            authorization_response=redirect_response)

        save_token_to_file(github.token)

    # Get an auth key for travis
    r = requests.post("https://api.travis-ci.com/auth/github",
                        params={"github_token": github.access_token})
    response = r.json()
    travis_token = response['access_token']
    print(travis_token)

    # Access a part of the travis API
    r = requests.get("https://api.travis-ci.com/user",
                        headers={"Travis-API-Version": "3", 
                        "Authorization": "token %s" % travis_token})
    print(r.json())

if __name__ == '__main__':
    main()
