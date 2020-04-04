#!/bin/sh

# Uniform x/y size adjustment (old size 1.35)
size=1.7

# x/y offset
x_offset=-.2
y_offset=-.1

Pen=`xinput list |grep -i HUION\ 420\ Pen | awk -F= '{ print $2}'| awk '{print $1}'| awk 'BEGIN{ RS = "" ; FS = "\n" }{print $1}'`

xinput set-prop --type=float $Pen 'Coordinate Transformation Matrix' $size 0 $x_offset 0 $size $y_offset 0 0 1
