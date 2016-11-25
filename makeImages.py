import cv2
import numpy as np


ballWidth = 20
varW, varH = 28, 28
imageW, imageH = 200, 200
paddleW, paddleH = 15, 40
dx = float(imageW - ballWidth) / float(varW-1)
dy = float(imageH - ballWidth) / float(varH-1)
print dx, dy
for x in xrange(varW):
    for y in xrange(varH):
        nx, ny = int(dx * x), int(dy * y)
        image = np.zeros((imageH, imageW), np.uint8)
        image[ny:(ny+ballWidth), nx:(nx+ballWidth)] = 255
        cv2.imwrite('BALLS/BALL_%02d_%02d.png'%(x,y), image)

dy = float(imageH - paddleH) / float(varH-1)
print dy
for y in xrange(varH):
    ny = int(dy * y)
    image = np.zeros((imageH, paddleW), np.uint8)
    image[ny:(ny+paddleH),:] = 255
    cv2.imwrite('PADDLES/PADDLE_%02d.png'%(y,), image)
