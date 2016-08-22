#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
import urllib2
import argparse

PUSHBULLET_PUSH_URL = "https://api.pushbullet.com/v2/pushes"

def push(token, title, body):
    '''
    push
    '''
    data = json.dumps(
        {
            "type": "note",
            "title": title,
            "body": body
        }
    )

    req = urllib2.Request(PUSHBULLET_PUSH_URL)
    req.add_header('Access-Token', token)
    req.add_header('Content-Type', 'application/json')
    r = urllib2.urlopen(req, data, timeout=5)

if __name__ == '__main__':
    parser = argparse.ArgumentParser("Pushbullet interface")
    parser.add_argument("--token", required=True, help='pushbullet access token')
    parser.add_argument('--title', required=True, help='push title')
    parser.add_argument('--body', required=True, help='push body')
    args = parser.parse_args()

    push(args.token, args.title, args.body)
