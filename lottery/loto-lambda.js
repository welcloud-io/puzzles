var array = [];

function http_request_in_pure_node(callback) {
  var http = require('http');

  var options = {
    host: 'ks5vfo4pih.execute-api.eu-west-1.amazonaws.com',   
    port: 443,
    path: '/prod/Loto-lambda',
    method: 'GET'
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

/*http_request_in_pure_node(done);
http_request_in_pure_node(done);
array.push('1rst-element');
console.log(array);*/


var request = require("request");

for (var i=0; i<14000000; i++) {
request("https://ks5vfo4pih.execute-api.eu-west-1.amazonaws.com/prod/Loto-lambda", function(error, response, body) {
  if (body == "[1, 2, 3, 4, 5, 6]") console.log(body);
});
}