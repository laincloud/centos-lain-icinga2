#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import urllib
import urllib2
import argparse


def post(url, query_args):
    service_id = query_args['service_id']
    url = "%s/services/%s/callback/" % (url, service_id)
    encoded_args = urllib.urlencode(query_args)
    try:
        resp = urllib2.urlopen(url, encoded_args).read()
    except Exception as e:
        print "Error: "+ str(e) +" - " + url
        sys.exit(-1)


def main():
    parser = argparse.ArgumentParser("Post hagrid event")
    parser.add_argument("--url", help="hagrid url", default='http://hagrid.lain.example')
    parser.add_argument("--service-id", help="hagrid service id", required=True)
    parser.add_argument("--name", help="service name", required=True)
    parser.add_argument("--state", help="service state", required=True)
    parser.add_argument("--state-type", help="service state type", required=True)
    parser.add_argument("--last-check-result", help="service last check result", required=True)
    args = parser.parse_args()

    query_args = {}
    if args.name:
        query_args['service_name'] = args.name

    if args.service_id:
        query_args['service_id'] = args.service_id

    if args.state:
        query_args['service_state'] = args.service_state

    if args.state_type:
        query_args['service_state_type'] = args.state_type

    if args.last_check_result:
        query_args['last_check_result'] = args.last_check_result

    post(args.url, query_args)


if __name__ == '__main__':
    main()
