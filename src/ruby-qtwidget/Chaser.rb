require "ffi"

module ChaserFFI
  extend FFI::Library
  ffi_lib './chaser.so'

  class Struct_xycoord < FFI::Struct
    layout :x, :int16,
           :y, :int16
  end

  class Struct_boundingbox < FFI::Struct
    layout :ul, Struct_xycoord,
           :lr, Struct_xycoord
  end

  class Struct_chaser < FFI::Struct
    layout :eventstate, :uint8,
           :state, :uint8,

           :x, :int16,
           :y, :int16,

           :lastx, :int16,
           :lasty, :int16,

           :tickcount, :int16,
           :statecount, :int16,

           :movedx, :int16,
           :movedy, :int16,

           :box, Struct_boundingbox,

           :speed, :double,
           :pointer, Struct_xycoord
  end

  attach_function('chaserthink', [:pointer], :void)
  attach_function('setupchaser', [:pointer, Struct_boundingbox.by_value], :void)
end

#----------------
include ChaserFFI

class Chaser
  def initialize (ul_x,ul_y, lr_x,lr_y)
    @c=ChaserFFI::Struct_chaser.new

    bb=Struct_boundingbox.new
    bb[:ul][:x]=ul_x
    bb[:ul][:y]=ul_y
    bb[:lr][:x]=lr_x
    bb[:lr][:y]=lr_y

    setupchaser(@c, bb)
  end

  def think
    chaserthink(@c)
  end

  def state
    @c[:state]
  end

  def tickcount
    @c[:tickcount]
  end

  def x
    @c[:x]
  end

  def y
    @c[:y]
  end
end
