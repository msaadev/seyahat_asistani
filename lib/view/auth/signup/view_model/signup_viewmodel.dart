import 'package:mobx/mobx.dart';
import 'package:seyahat_asistani/main.dart';
part 'signup_viewmodel.g.dart';

class SignupViewModel = _SignupViewModelBase with _$SignupViewModel;

abstract class _SignupViewModelBase with Store {
  void register(
      {required String name, required String email, required String password}) {
    firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }
}
