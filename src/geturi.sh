#!/bin/sh
pass show "$1" | sed -n 's/^uri://p'
