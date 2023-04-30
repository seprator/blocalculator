import 'package:blocalculator/cubit/user_answer_cubit.dart';
import 'package:blocalculator/cubit/user_question_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'button.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserQuestionCubit(),
          ),
          BlocProvider(
            create: (context) => UserAnswerCubit(),
          ),
        ],
        child: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  Home({super.key});
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '00',
    '.',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: Column(
        children: [
          Expanded(
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: BlocBuilder<UserQuestionCubit, UserQuestionState>(
                    builder: (context, state) {
                      return Text(
                        state.userQ,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: BlocBuilder<UserAnswerCubit, UserAnswerState>(
                    builder: (context, state) {
                      return Text(
                        state.userA,
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ]),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                itemBuilder: (BuildContext ctx, int index) {
                  //clear
                  if (index == 0) {
                    return MyButtons(
                      buttonTapped: () {
                        context.read<UserQuestionCubit>().usercq();
                        context.read<UserAnswerCubit>().userca();
                      },
                      buttonText: buttons[0],
                      color: Colors.green,
                      textColor: Colors.white,
                    );
                    //delete
                  } else if (index == 1) {
                    return BlocBuilder<UserQuestionCubit, UserQuestionState>(
                      builder: (context, state) {
                        return MyButtons(
                          buttonTapped: () {
                            if (state.userQ.isEmpty) {
                              return;
                            } else {
                              context.read<UserQuestionCubit>().userdq();
                            }
                          },
                          buttonText: buttons[1],
                          color: Colors.red,
                          textColor: Colors.white,
                        );
                      },
                    );
                    // equals
                  } else if (index == buttons.length - 1) {
                    return BlocBuilder<UserQuestionCubit, UserQuestionState>(
                      builder: (context, state) {
                        return MyButtons(
                          buttonTapped: () {
                            String userqq =
                                BlocProvider.of<UserQuestionCubit>(context, listen: false)
                                    .state
                                    .userQ;
                            context.read<UserAnswerCubit>().equalPressed(userqq);
                          },
                          buttonText: buttons[index],
                          color: isOperator(buttons[index]) ? Colors.white : Colors.deepPurple[900],
                          textColor: isOperator(buttons[index]) ? Colors.deepPurple : Colors.white,
                        );
                      },
                    );
                  }
                  // the others
                  else if (index < 20) {
                    return BlocBuilder<UserQuestionCubit, UserQuestionState>(
                      builder: (context, state) {
                        return MyButtons(
                          buttonTapped: () {
                            context.read<UserQuestionCubit>().usersq(buttons[index]);
                          },
                          buttonText: buttons[index],
                          color: isOperator(buttons[index]) ? Colors.white : Colors.deepPurple[900],
                          textColor: isOperator(buttons[index]) ? Colors.deepPurple : Colors.white,
                        );
                      },
                    );
                  }
                  return null;
                }),
          )
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '-' || x == '+' || x == 'x' || x == '/' || x == '=' || x == '%') {
      return false;
    }
    return true;
  }
}
