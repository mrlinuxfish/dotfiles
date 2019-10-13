#!/bin/sh

Pen=`xinput list |grep -i HUION\ 420\ Pen | awk -F= '{ print $2}'| awk '{print $1}'| awk 'BEGIN{ RS = "" ; FS = "\n" }{print $1}'`

xinput set-prop --type=float $Pen 'Coordinate Transformation Matrix' 1.35 0 -.2 0 1.35 -.1 0 0 1
