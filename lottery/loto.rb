def new_draw
    balls = (1..49).to_a
    draw_balls=[]
    6.times do
        draw_ball = balls.sample
        draw_balls << draw_ball
        balls = balls - [draw_ball]
    end
    draw_balls.sort!
end

14000000.times do |draw_number|
    draw=new_draw
    puts "Draw Number: " + draw_number.to_s + ", Draw: " + draw.to_s if draw == [1, 2, 3, 4, 5, 6]
    puts "Draw Number: " + draw_number.to_s + ", Draw: " + draw.to_s if draw == [1, 12, 31, 42, 45, 46]
end