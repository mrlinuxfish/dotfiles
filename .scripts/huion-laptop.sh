#!/bin/sh

Pen=`xinput list |grep -i HUION\ 420\ Pen | awk -F= '{ print $2}'| awk '{print $1}'| awk 'BEGIN{ RS = "" ; FS = "\n" }{print $1}'`

xinput set-prop --type=float $Pen 'Coordinate Transformation Matrix' 2.3 0 -.2 0 2.3 -.8 0 0 1
