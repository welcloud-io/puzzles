package main

import "fmt"
import "math/rand"

func new_draw() [6]int {
    var balls [49]int;
    for index := 0; index < 49; index++ {
       balls[index]=index+1
    }
    var draw_balls [6]int
    for draw_number := 0; draw_number < 6; draw_number++ {
      draw_balls[draw_number] = rand.Intn(49)
    }
    return draw_balls
}

func main() {
    var expected = [6]int{1, 2, 3, 4, 5, 6}
    var draw [6]int
    
    for i := 0; i < 14000000; i++ {
        draw = new_draw()
        //fmt.Println(draw)
        if (draw == expected) {
    	    fmt.Println("[1, 2, 3, 4, 5, 6]")
        }
    }
}