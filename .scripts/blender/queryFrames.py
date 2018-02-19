#!/usr/bin/env python

import bpy

scene = bpy.context.scene
print("%d:" % (scene.frame_end - scene.frame_start + 1 )) # frame_end is included

