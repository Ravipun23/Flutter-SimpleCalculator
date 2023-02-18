import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'My Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userInput = '';
  var result = '';
  final List<String> arrButtons = [
    "AC",
    "DEL",
    "%",
    "/",
    "7",
    "8",
    "9",
    "x",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "0",
    ".",
    "00",
    "=",
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(162, 185, 188, 1.0),
        body: Column(
          children: [
            SizedBox(height: 30,),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          userInput,
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        child: Text(
                          result,
                          style: TextStyle(fontSize: 30),
                        ),
                        alignment: Alignment.centerRight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  color: Color.fromRGBO(96, 219, 232, 1.0),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GridView.builder(
                      itemCount: arrButtons.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemBuilder: (context, int index) {

                        // Ac button
                        if (index == 0) {
                          return MyButtons(
                            textButton: arrButtons[index],
                            color: Color.fromRGBO(239, 223, 72, 1.0),
                            textColor: Colors.black,
                            buttonTapped: () {
                              setState(() {
                                userInput = " ";
                                result = " ";
                              });
                            },
                          );
                        }

                        // Delete Button
                        else if (index == 1) {

                          return MyButtons(
                            buttonTapped: (){
                              setState(() {
                                userInput = userInput.substring(0,userInput.length-1);
                              });
                            },
                            textButton: arrButtons[index],
                            color: Color.fromRGBO(139, 211, 70, 1.0),
                            textColor: Colors.black,
                          );
                        }

                        // Equal Button
                        else if (index == arrButtons.length-1) {
                          return MyButtons(
                            buttonTapped: (){
                              setState(() {
                                onEqualPressed();
                              });
                            },
                            textButton: arrButtons[index],
                            color: Color.fromRGBO(249, 165, 44, 1.0),
                            textColor: Colors.black,
                          );
                        }
                        // Remaining Buttons
                        else {
                          return MyButtons(
                            buttonTapped: () {
                              setState(() {
                                userInput =  userInput + arrButtons[index];
                              });
                            },
                            textButton: arrButtons[index],
                            color: isOperator(arrButtons[index])
                                ? Color.fromRGBO(214, 78, 18, 1.0)
                                : Color.fromRGBO(155, 95, 224, 1.0),
                            textColor: Colors.black,
                          );
                        }
                      },
                    ),
                  ),
                ))
          ],
        ));
  }

  bool isOperator(String string) {
    if (string == "+" ||
        string == "-" ||
        string == "/" ||
        string == "%" ||
        string == "x" ||
        string == "=") {
      return true;
    } else {
      return false;
    }
  }

  void onEqualPressed(){
    String finalUserInput = userInput;
    finalUserInput = finalUserInput.replaceAll("x", "*");
    Parser p = Parser();
    Expression exp = p.parse(finalUserInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    result = eval.toString();
  }
}
