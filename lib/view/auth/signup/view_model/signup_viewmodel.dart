import 'package:mobx/mobx.dart';
import '../../../../main.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/init/cache/cache_manager.dart';
import '../../../../core/init/navigation/navigation_service.dart';
import '../../../../core/models/user.dart';
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
      required totalDrive,
      required totalWalk}) async {
    var result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    var user = result.user;
    await DatabaseService(uid: user!.uid).updateUserData(
        email, name, fuelCost, totalCalories, totalDrive, totalWalk);
    if (result.user != null) {
      var dat = DatabaseService.instance.getUserData(result.user!.uid);
      UserData userdata;
      dat.then((e) async {
        userdata = UserData(
            uid: e.data()["uid"],
            email: e.data()["email"],
            name: e.data()["name"],
            fuelCost: e.data()["fuelCost"],
            totalCalories: e.data()["totalCalories"],
            totalDrive: e.data()["totalDrive"],
            totalWalk: e.data()["totalWalk"]);
        await CacheManager.instance.setUserData(userdata);
        NavigationService.instance
            .navigateToPageWidgetClear(page: const HomeView());
      });
    } else {
      AppConstants.showErrorToas(message: 'Error');
    }
  }
}
