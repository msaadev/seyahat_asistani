import 'package:mobx/mobx.dart';
part 'auth_viewmodel.g.dart';

class AuthViewModel = _AuthViewModelBase with _$AuthViewModel;

abstract class _AuthViewModelBase with Store {
  @observable
  int page = 1;

  @action
  void setPage(int i) => page = i;
}
