#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import json
import urllib2
import urllib

SLACK_API_CHAT_POSTMSG = 'https://slack.com/api/chat.postMessage'

def push(text, token, channel):
    data = {
        "text" : text,
        "token" : token,
    }

    if channel:
        data['channel'] = channel 
    payload = urllib.urlencode(data)

    req = urllib2.Request(SLACK_API_CHAT_POSTMSG)
    r = urllib2.urlopen(req, payload, timeout=5)

if __name__ == '__main__':
    parser = argparse.ArgumentParser("Slack incoming bot")
    parser.add_argument('text', help='text ')
    parser.add_argument('--token', dest='token', help='user token',
                        default='')
    parser.add_argument('--channel', dest='channel', help='channel msg will be sent to')
    args = parser.parse_args()

    push(args.text, args.token, args.channel)
