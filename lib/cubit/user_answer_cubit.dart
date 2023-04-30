import 'package:bloc/bloc.dart';
import 'package:math_expressions/math_expressions.dart';

part 'user_answer_state.dart';

class UserAnswerCubit extends Cubit<UserAnswerState> {
  UserAnswerCubit() : super(UserAnswerState(userA: '0'));

  void usersa(String str) {
    emit(UserAnswerState(userA: str));
  }

  void userca() {
    emit(UserAnswerState(userA: '0'));
  }

  void equalPressed(String str) {
    String finalQuestion = str;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    emit(UserAnswerState(userA: eval.toStringAsFixed(0)));
  }
}
