#!/bin/bash
xrandr --newmode "3440x1440_120.00"  818.25  3440 3488 3520 3600  1440 1443 1453 1513 -hsync +vsync
xrandr --addmode Virtual1 3440x1440_120.00
xrandr --output Virtual1 --mode 3440x1440_120.00

