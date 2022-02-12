import 'package:mobx/mobx.dart';
import 'package:seyahat_asistani/main.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/init/navigation/navigation_service.dart';
import '../../../../core/services/database_service.dart';
import '../../../home/view/home_view.dart';
part 'signup_viewmodel.g.dart';

class SignupViewModel = _SignupViewModelBase with _$SignupViewModel;

abstract class _SignupViewModelBase with Store {
  Future register(
      {required email,
      required password,
      required name,
      required fuelCost,
      required totalCalories,
      required totalDrive}) async {
    var result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    var user = result.user;
    await DatabaseService(uid: user!.uid)
        .updateUserData(email, name, fuelCost, totalCalories, totalDrive);
    if (result.user != null) {
      NavigationService.instance
          .navigateToPageWidgetClear(page: const HomeView());
    } else {
      AppConstants.showErrorToas(message: 'Error');
    }
  }
}
