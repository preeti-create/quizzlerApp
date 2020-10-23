import 'package:flutter/material.dart';
//import 'question.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
          home: Scaffold(
              backgroundColor: Colors.black,
              body: SafeArea(
                  child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: QuizPage(),
                    ),//padding
                ),//safeArea
            ),//scaffold
        );//material
    }
}

class QuizPage extends StatefulWidget{
    @override
    _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage>{
    List<Icon> scoreKeeper= [];
    
    void checkAnswer(bool userAnswer) 
    {
        bool  correctAnswer = quizBrain.get_answer();
        setState(() {
            if (quizBrain.isFinished() == true) {
                Alert(
                    context: context,
                    title: 'Finished!',
                    desc: 'You\'ve reached the end of the quiz.',
                ).show();
                quizBrain.reset();
                scoreKeeper = [];
            }
            else 
            {
                if(correctAnswer == userAnswer)
                {
                    scoreKeeper.add(Icon(Icons.check, color: Colors.green,));
                }
                else {
                    scoreKeeper.add(Icon(Icons.close, color: Colors.red,));
                }
                quizBrain.nextQuestion();
            }
        });//The user picked false  
    }

    @override
    Widget build(BuildContext context){
        return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Center(
                            child: Text(
                                quizBrain.get_question(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.white,
                                ),//textstyle
                            ),//text
                        ),//center
                    ),//padding
                ),//expanded
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: FlatButton(
                            color: Colors.green,
                            child: Text(
                                'TRUE',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color:Colors.white,
                                ),//textstyle
                            ),//text
                            onPressed: () {
                                checkAnswer(true);
                            },//onpressed
                        ),//flatbutton
                    ),//padding
                ),//expanded
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: FlatButton(
                            color: Colors.red,
                            child: Text(
                                'FALSE',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                ),//textstyle
                            ),//text
                            onPressed: (){
                                checkAnswer(false);
                            //the user picked false
                            },
                        ),//flatbutton
                    ),//padding
                ),//expanded
                Row(
                    children: scoreKeeper,
                ),//row
            ],//widget
        );//column
    }
}