#!/usr/bin/env python

import json
import os
from subprocess import call

with open('external-scripts.json') as data_file:
    scripts = json.load(data_file)
    for script in scripts:
        call( ["npm", "install", script, "--save"])
