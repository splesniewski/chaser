# -*- mode:python; indent-tabs-mode:nil; -*-
from ctypes import *
import os

################################################################
class xycoord(Structure):
    _fields_ = [
        ('x', c_int16),
        ('y', c_int16)
    ]
    def __init__(self, x,y):
        self.x=x
        self.y=y

class boundingbox(Structure):
    _fields_ = [
        ("ul", xycoord),
        ("lr", xycoord)
    ]
    def __init__(self, ul,lr):
        self.ul=ul
        self.lr=lr

################################################################

class chaser(Structure):
    chaser_so = CDLL(os.getcwd()+'/_chaser.so')

    # states
    CHASER_STOP = 0
    CHASER_JARE = 1
    CHASER_KAKI = 2
    CHASER_AKUBI = 3
    CHASER_SLEEP = 4
    CHASER_AWAKE = 5
    CHASER_U_MOVE = 6
    CHASER_D_MOVE = 7
    CHASER_L_MOVE = 8
    CHASER_R_MOVE = 9
    CHASER_UL_MOVE = 10
    CHASER_UR_MOVE = 11
    CHASER_DL_MOVE = 12
    CHASER_DR_MOVE = 13
    CHASER_U_TOGI = 14
    CHASER_D_TOGI = 15
    CHASER_L_TOGI = 16
    CHASER_R_TOGI = 17

    _fields_ = [
        ("eventstate", c_uint8),
        ("state", c_uint8),
        ("x", c_int16),
        ("y", c_int16),
        ("lastx", c_int16),
        ("lasty", c_int16),
        ("tickcount", c_int16),
        ("statecount", c_int16),
        ("movedx", c_int16),
        ("movedy", c_int16),
        ("box", boundingbox),
        ("speed", c_double),
        ("pointer", xycoord)
    ]

    def __init__(self, box):
        self.chaser_so.setupchaser(pointer(self),box)

    def chaserthink(self):
        self.chaser_so.chaserthink(pointer(self))
