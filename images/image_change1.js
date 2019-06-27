// 이미지 순서를 저장하는 변수
var num = 0;

function next() {
  var images = document.getElementsByClassName("image");
  var output = document.getElementById("output");
  var image_number = document.getElementById("image_number");

  num++;

  if (num >= images.length) {
    num = 0;
  }
  image_number.innerHTML = num + 1 + "번째 이미지";
  output.src = images[num].src;
}

function prev() {
  var images = document.getElementsByClassName("image");
  var output = document.getElementById("output");
  var image_number = document.getElementById("image_number");

  num--;

  if (num < 0) {
    num = images.length - 1;
  }
  image_number.innerHTML = num + 1 + "번째 이미지";
  output.src = images[num].src;
}
