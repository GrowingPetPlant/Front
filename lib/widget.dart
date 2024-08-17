import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

// 초록색 입력박스(큰 버전)
class inputBox extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final void Function(String)? function;
  final double margin;
  final bool obscure;

  const inputBox(
      {super.key, required this.hint, required this.controller, this.function, this.margin=0, this.obscure = false});

  @override
  State<inputBox> createState() => _inputBoxState();
}

class _inputBoxState extends State<inputBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, widget.margin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF81AE17), width: 2),
        color: Color(0xffffffff)
      ),
      child: SizedBox(
        height: 50, // 텍스트 필드 창 높이 조절
        child: TextField(
          controller: widget.controller,
          onChanged: widget.function,
          style: const TextStyle(fontSize: 16),
          obscureText: widget.obscure,
          decoration: InputDecoration(
            hintText: widget.hint,
            contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            border: InputBorder.none,
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }
}

// 입력박스 위의 제목
class titleInputBox extends StatelessWidget {
  final String title;
  final double screenHeight;

  const titleInputBox(
      {super.key, required this.title, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(screenHeight * 0.01),
      child: Text(
        title,
        style: TextStyle(fontSize: 14),
      ),
    );

    throw UnimplementedError();
  }
}

// 입력박스 옆 빨간 워닝 문구
class warningText extends StatelessWidget {
  final String text;
  final double screenHeight;

  const warningText(
      {super.key, required this.text, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
      child: Text(
        text,
        style: TextStyle(fontSize: 11, color: Colors.red),
      ),
    );
    throw UnimplementedError();
  }
}

// 로그인창 하단의 회색 텍스트 버튼
class textButton_Login extends StatefulWidget {
  final String text;
  final Widget page;

  const textButton_Login({super.key, required this.text, required this.page});

  @override
  State<textButton_Login> createState() => _textButton_LoginState();
}

class _textButton_LoginState extends State<textButton_Login> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget.page),
        );
      }, // 지정한 화면으로 이동
      child: Text(
        widget.text,
        style: TextStyle(fontSize: 14, color: Color(0xFF515151)),
      ),
    );
    throw UnimplementedError();
  }
}

// 초록색 입력 박스(작은 버전)
/*class inputBox extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final void Function(String)? function;

  const inputBox(
      {super.key, required this.hint, required this.controller, this.function});

  @override
  State<inputBox> createState() => _inputBoxState();
}

class _inputBoxState extends State<inputBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF81AE17), width: 2),
      ),
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: widget.controller,
        onChanged: widget.function,
        style: TextStyle(fontSize: 13),
        decoration: InputDecoration(
            hintText: widget.hint,
            contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            border: InputBorder.none),
      ),
    );

    throw UnimplementedError();
  }
}*/

// 하단 초록색 버튼
class bottomGreenButton extends StatefulWidget {
  final String text;
  final void Function()? onPressed;

  const bottomGreenButton({super.key, required this.text, this.onPressed});

  @override
  State<bottomGreenButton> createState() => _bottomGreenButtonState();
}

class _bottomGreenButtonState extends State<bottomGreenButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 60),
      color: const Color(0xfff2f2f2),
      child: BottomAppBar(
        color: const Color(0xfff2f2f2),
        elevation: 0,
        child: ElevatedButton(
          onPressed: widget.onPressed, // 로그인
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xff81AE17)), // 로그인 버튼의 색상

            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), // 버튼 테두리의 둥글기 정도 설정
              ),
            ),
            fixedSize: MaterialStateProperty.all<Size>(
                const Size.fromHeight(60)), // 높이 설정
          ),
          child: Text(
            widget.text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFFF2F2F2)), // 로그인 버튼의 텍스트 색상
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }
}

// 로고있는 제목
class logoTitle extends StatelessWidget {
  final String text;
  final double screenHeight;

  const logoTitle({super.key, required this.text, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: screenHeight * 0.1,
          ),
          Text(
              //로고 아래 제목
              text,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF56280F))),
        ],
      ),
    );
    throw UnimplementedError();
  }
}

//식물로고
class plantLogoTitle extends StatelessWidget {
  final String text;
  final double screenHeight;

  const plantLogoTitle({super.key, required this.text, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            'assets/images/plantLogo.png',
            height: screenHeight * 0.1,
          ),
          Text(
            //로고 아래 제목
              text,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF56280F))),
        ],
      ),
    );
    throw UnimplementedError();
  }
}

// 식물 종 선택 드롭박스
List<String> dropdownList = ['토마토', '바질', '수박'];

class dropDownBox extends StatelessWidget {
  final String? value;
  final void Function(String?)? onChanged;

  const dropDownBox({super.key, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<String>(
      style: const TextStyle(fontSize: 16, color: Color(0xFF515151)),
      hint: const Text('식물 종 선택'),
      isExpanded: true,
      underline: Container(),
      value: value,
      items: dropdownList.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      buttonStyleData: ButtonStyleData(
        height: 55,
        decoration: BoxDecoration(
          color: const Color(0xfff2f2f2),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xff81ae17), width: 2),
        ),
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    throw UnimplementedError();
  }
}

//상태바
class statusBar extends StatelessWidget {
  final String image;
  final int? data;

  const statusBar({super.key, required this.image, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 280,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.cover)),
            ),
            Container(
                padding: const EdgeInsets.all(3),
                child: Align(
                  child: Stack(
                    children: [
                      // 흰색 테두리 효과를 위한 텍스트
                      Text(
                        data != null ? '$data%' : 'Loading...',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = Colors.white, // 흰색 텍스트 스트로크
                          shadows: const [
                            Shadow(
                              blurRadius: 2,
                              color: Colors.white, // 흰색 테두리
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                      // 원래의 검정색 텍스트
                      Text(
                        data != null ? '$data%' : 'Loading...',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black, // 검정색 텍스트
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                )),
          ],
        ));
    throw UnimplementedError();
  }
}

// 홈화면 하단 아이콘버튼 위 컨트롤 text
class controllText extends StatelessWidget {
  final String text;

  const controllText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 80,
        height: 20,
        child: Align(
          child: Stack(
            children: [
              // 흰색 테두리 효과를 위한 텍스트
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 3
                    ..color = Colors.white, // 흰색 텍스트 스트로크
                  shadows: const [
                    Shadow(
                      blurRadius: 2,
                      color: Colors.white, // 흰색 테두리
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              // 원래의 검정색 텍스트
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black, // 검정색 텍스트
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ));
    throw UnimplementedError();
  }
}

//홈화면 하단 아이콘버튼
class iconButton extends StatelessWidget {
  final String image;
  final void Function()? onPressed;

  const iconButton({super.key, required this.image, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed, // 물주기
      icon: Container(
        width: 80,
        height: 80,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            image,
            width: 55,
            height: 55,
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }
}

class textButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const textButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: 14, color: Color(0xFF515151)),
      ),
    );
    throw UnimplementedError();
  }
}
