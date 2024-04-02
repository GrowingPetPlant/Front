import 'package:flutter/material.dart';

void main() {
  runApp(const MyPlant());
}

class MyPlant extends StatelessWidget {
  const MyPlant({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPetPlant',
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(50),
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 80, 0, 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Image(
                        image: AssetImage('assets/images/logo.png'),
                        fit: BoxFit.fitHeight,
                        alignment: Alignment.center,
                      )
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      TextField(
                          decoration: InputDecoration(
                            hintText: '아이디를 입력하세요',
                            labelText: '아이디',
                          )
                      ),



                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: '비밀번호를 입력하세요',
                          labelText: '비밀번호',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              child: Text('아이디찾기'),
                              onPressed :null,
                          ),
                          TextButton(
                              onPressed: null, // 비밀번호찾기 화면으로 이동
                              child: Text('비밀번호찾기')
                          ),
                          TextButton(
                              onPressed: null, //회원가입화면으로 이동
                              child: Text('회원가입')
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: ElevatedButton(
              onPressed: null, // 로그인
              style: ButtonStyle(
                backgroundColor : MaterialStateProperty.all(Color.fromRGBO(185, 208, 132, 1)),
              ),
              child: Text('로그인')
          ),
        ),
      ),
    );
  }}