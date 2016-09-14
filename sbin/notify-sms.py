#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
import socket
import urllib
import urllib2
import argparse

SMS_HOST = "http://example.com"
SMS_PATH = "/sms/send_sms_single"

timeout = 5
socket.setdefaulttimeout(timeout)


def sendSingleSms(host, msg, template_id, phone):
    """
    send a single sms
    """
    payload = {
        "template_id": template_id,
        "params": json.dumps(
            {
                "docNo": msg
            }
        ),
        "phone_no": phone,
    }
    url = "%s%s?%s" % (host, SMS_PATH, urllib.urlencode(payload))
    urllib2.urlopen(url)


def sendSms(host, msg, template_id, phones):
    """
    send msg via sms to a list of mobile phones
    """
    for phone in phones:
        sendSingleSms(host, msg, template_id, phone)


if __name__ == "__main__":
    parser = argparse.ArgumentParser("Sending sms")
    parser.add_argument("--host", help="sms host", default=SMS_HOST)
    parser.add_argument("to", help="mobile numbers sms will be sent to, seperated by comma")
    parser.add_argument("template_id", help="sms template id")
    parser.add_argument("msg", help="sms content string")
    args = parser.parse_args()

    phone_list = args.to.split(",")

    sendSms(args.host, args.msg, args.template_id, phone_list)
