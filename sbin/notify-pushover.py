#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
import urllib
import urllib2
import argparse

PUSHOVER_URL = "https://api.pushover.net/1/messages.json"

def push(token, user, title, message, device):
    '''
    push
    '''
    data = {
        'token': token,
        'user': user,
        'title': title,
        'message': message,
    }

    if device:
        data['device'] = device

    req = urllib2.Request(PUSHOVER_URL)
    req.add_header('Content-Type', 'application/x-www-form-urlencoded')
    r = urllib2.urlopen(req, urllib.urlencode(data), timeout=5)


if __name__ == '__main__':
    parser = argparse.ArgumentParser("Pushover notification")
    parser.add_argument("--token", required=True, help='pushover API token')
    parser.add_argument('--user-key', required=True, help='pushover user key')
    parser.add_argument('--title', required=True, help='pushover title')
    parser.add_argument('--message', required=True, help='pushover message')
    parser.add_argument('--device', required=False, help='pushover device')
    args = parser.parse_args()

    push(args.token, args.user_key, args.title, args.message, args.device)
