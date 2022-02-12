import 'package:mobx/mobx.dart';
part 'select_mode_viewmodel.g.dart';

class SelectModeViewModel = _SelectModeViewModelBase with _$SelectModeViewModel;

abstract class _SelectModeViewModelBase with Store {

  @observable
  bool isCar = false;

  @action
  void change(bool v) => isCar = v;
  
}
