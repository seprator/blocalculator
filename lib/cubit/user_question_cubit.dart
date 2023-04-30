import 'package:bloc/bloc.dart';

part 'user_question_state.dart';

class UserQuestionCubit extends Cubit<UserQuestionState> {
  UserQuestionCubit() : super(UserQuestionState(userQ: ''));

  void usersq(String str) {
    emit(UserQuestionState(userQ: state.userQ + str));
  }

  void usercq() {
    emit(UserQuestionState(userQ: ''));
  }

  void userdq() {
    emit(UserQuestionState(userQ: state.userQ.substring(0, state.userQ.length - 1)));
  }
}
