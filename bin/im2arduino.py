from PIL import Image
import os
import sys
import getopt

#----------------
def im2arduino(name, im):
    (im_x, im_y)=im.size
    sys.stdout.write("#define b_{0}_width {1}\n".format(name,im_x))
    sys.stdout.write("#define b_{0}_height {1}\n".format(name,im_y))

    for (pixel_idx, pixel_name,invert) in  [(0,'btm',0),(1,'msk',0)]:
        sys.stdout.write("static const uint8_t PROGMEM b_{0}_{1}[] = {{\n".format(name,pixel_name))
        struct=[]
        im_idx=0
        iml=list(im.getdata())
        line=[]
        for y in range(0, im_y):
            b=[]
            bi=0
            for x in range(0, im_x):
                p=iml[im_idx][pixel_idx]
                im_idx+=1
                if (invert==1):
                    b.append(('0' if (p>0) else '1'))
                else:
                    b.append(('1' if (p>0) else '0'))
                bi+=1
                if (bi==8):
                    line.append("B{0}".format(''.join(b)))
                    b=[]
                    bi=0
            struct.append(','.join(line))
            line=[]
        sys.stdout.write("{0}\n".format(',\n'.join(struct)))
        sys.stdout.write("};\n")

#----------------
def usage():
    sys.stderr.write('Usage:'+sys.argv[0]+' [-h] [--name={str}] {filename}\n');
        
def main(argv):
    name='image'
    try:
        opts, args = getopt.getopt(argv,'hn:',['help','name='])
    except getopt.GetoptError:
        usage()
        sys.exit(2)
    for opt, arg in opts:
        if opt in ('-h', '--help'):
            usage()
            sys.exit(10)
        if opt in ('-n', '--name'):
            name= arg
    if len(args) != 1:
        usage()
        sys.exit(3)
    #----
    imfilename=args[0]
    im = Image.open(imfilename)
    im = im.convert('LA')
#    sys.stderr.write('MODE:{0}\n'.format(im.mode));
#    sys.stderr.write('INFO:{0}\n'.format(im.info));
#    sys.stderr.write('IML:{0}\n'.format(list(im.getdata())));
    im2arduino(name, im)
    #----
    return 0

if __name__ == "__main__":
    exitcode = main(sys.argv[1:])
    sys.exit(exitcode)
                                                                                        
