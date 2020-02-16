#!/bin/sh
pass show "$1" | sed -n 1p
