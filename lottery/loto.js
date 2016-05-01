var array = [];

function http_request_in_pure_node(callback) {
  var http = require('http');

  var options = {
    host: 'www.welcloud.io',
    path: '/',
  };
  
  var request_callback = function(response) {
    var str = '';

    response.on('data', function (chunk) {
      str += chunk;
    });

    response.on('end', function () {
      array.push(str);
      if (callback) callback();
    });
  };

  http.request(options, request_callback).end();
}

var done = function done(argument) {
  if (array.length == 3) console.log(array);
};

http_request_in_pure_node(done);
http_request_in_pure_node(done);
array.push('1rst-element');
console.log(array);

function new_draw() {
  var balls = Array.apply(null, {length: 50}).map(Number.call, Number)
  balls.splice(0,1);

  var draw_balls = []
  for (var draw_ball_number=0; draw_ball_number<6; draw_ball_number++) {
    var random_index = Math.floor(Math.random() * balls.length);
    draw_balls.push(balls[random_index]);
    balls.splice(random_index, 1);
  }
  draw_balls.sort(function(a, b) { return a - b; });
  return draw_balls;
}

for (var i=0; i<14; i++) {
  var draw = new_draw();
  if (draw[0]==1 && draw[1]==2 && draw[2]==3 && draw[3]==4 && draw[4]==5 && draw[5]==6) console.log(i + " : " + draw);
}