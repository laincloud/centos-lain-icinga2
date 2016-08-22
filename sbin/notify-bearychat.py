#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import json
import urllib2

TIMEOUT=5

def push(text, team, token, channel):
    data = {
        "text" : text,
    }

    if channel:
        data['channel'] = channel.lstrip('#')
    payload = json.dumps(data)

    url = 'https://hook.bearychat.com/{}/incoming/{}'.format(team, token)
    req = urllib2.Request(url)
    req.add_header('Content-Type', 'application/json')
    r = urllib2.urlopen(req, payload, timeout=TIMEOUT)

if __name__ == '__main__':
    parser = argparse.ArgumentParser('Bearychat incoming bot')
    parser.add_argument('text', help='text ')
    parser.add_argument('--channel', dest='channel', help='channel')
    parser.add_argument('--team', dest='team', help='team. default value: ',
                        default='')
    parser.add_argument('--token', dest='token', help='bearychat token',
                        default='')
    args = parser.parse_args()

    push(args.text, args.team, args.token, args.channel)
