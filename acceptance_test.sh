#!/bin/bash
test $(curl --location 'http://calculator:8081/sum?a=1&b=2') -eq 3