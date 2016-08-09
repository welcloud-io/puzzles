import random

def new_draw():
    balls = range(1,49)
    draw_balls = []
    for draw_ball_number in range(6):
        draw_ball = random.choice(balls)
        draw_balls.append(draw_ball)
        balls = [ball for ball in balls if ball != draw_ball]
    draw_balls.sort()
    return draw_balls

for draw_number in range(14000000):
    draw = new_draw()
    if draw == [1, 2, 3, 4, 5, 6]:
        print "Draw number:%s, Draw:%s", (draw_number, draw)
    if draw == [1, 12, 31, 42, 45, 46]:
        print "Draw number:%s, Draw:%s", (draw_number, draw)