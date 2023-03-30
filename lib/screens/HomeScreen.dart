import 'package:flutter/material.dart';
import 'package:flutter_practice/utilities/LinearGradientWidget.dart';

import '../widgets/ElevatedButtonWidget.dart';
import '../widgets/TextWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int _questionNum = 0;

  var questionList = const [
    {
      "question": "select even number ?",
      "answers": {
        "ans 1": "ans 3",
        "ans 2": "ans 9",
        "ans 3": "ans 4",
      }
    },
    {
      "question": "select odd number ?",
      "answers": {
        "ans 1": "ans 3",
        "ans 2": "ans 2",
        "ans 3": "ans 6",
      }
    },
    {
      "question": "select number div by 2 ?",
      "answers": {
        "ans 1": "ans 15",
        "ans 2": "ans 13",
        "ans 3": "ans 4",
      }
    }
  ];

  void _onAnswered() {
    setState(() {
      _questionNum += 1;
    });
  }

  void _onBackPressed() {
    setState(() {
      _questionNum = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _questionNum < questionList.length
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextWidget(
                textData: questionList[_questionNum]["question"] as String,
              ),
              ElevatedButtonWidget(
                textData:
                    getData(questionList[_questionNum], ["answers", "ans 1"]),
                onPressed: _onAnswered,
              ),
              ElevatedButtonWidget(
                textData:
                    getData(questionList[_questionNum], ["answers", "ans 2"]),
                onPressed: _onAnswered,
              ),
              ElevatedButtonWidget(
                textData:
                    getData(questionList[_questionNum], ["answers", "ans 3"]),
                onPressed: _onAnswered,
              )
            ],
          )
        : LinearGradientWidget(
            gradientColors: const [
              Color(0xff5b0060),
              Color(0xff870160),
              Color(0xffac255e),
              Color(0xffca485c),
              Color(0xffe16b5c),
              Color(0xfff39060),
              Color(0xffffb56b),
            ],
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
            const CircleAvatar(
              // network  image
            backgroundImage:NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThwH3uhjDlPyydY9SCwGkPqeF4s1esHTEM2Q&usqp=CAU'),
            ),
                  const TextWidget(textData: "NO Questions to Practice"),
                  TextButton(
                      onPressed: _onBackPressed,
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          maximumSize:
                              MaterialStateProperty.all(const Size(200, 100)),
                          elevation: MaterialStateProperty.all(8),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(10))),
                      child: const Text(
                        "Back To Home",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ))
                ]),
          );
  }
}

dynamic getData(Map data, List<String> list) {
  dynamic dataTemp = data;
  if (list.isNotEmpty) {
    for (int x = 0; x < list.length; x++) {
      dataTemp = dataTemp[list[x]];
    }
  }
  return dataTemp;
}
