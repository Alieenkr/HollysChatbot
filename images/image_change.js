// 이미지 순서를 저장하는 변수
var num = 0;

function next() {
  var images = document.getElementsByClassName("image");
  var output = document.getElementById("output");
  var image_number = document.getElementById("image_number");

  //인덱스 하나 증가. 다음 이미지로
  num++;

	console.log("images.length : " + images.length);
	for(var i = 0; i < images.length; i++) {
    console.log(images[i]);
	}

  //인덱스가 배열의 크기 이상이면
  if (num >= images.length) {
    // 인덱스를 다시 0으로
    num = 0;
  }

  // 출력 이미지 번호 설정
  image_number.innerHTML = num + 1 + "번째 이미지";
  //출력 이미지에 배열의 이미지 설정
  output.src = images[num].src;
}

function prev() {
  var images = document.getElementsByClassName("image");
  var output = document.getElementById("output");
  var image_number = document.getElementById("image_number");

  //인덱스 하나 감소. 이전 이미지로
  num--;

  // 인덱스가 0보다 작아지면
  if (num < 0) {
    // 인덱스를 배열의 크기-1 로
    num = images.length - 1;
  }

  // 출력 이미지 번호 설정
  image_number.innerHTML = num + 1 + "번째 이미지";
  //출력 이미지에 배열의 이미지 설정
  output.src = images[num].src;
}
