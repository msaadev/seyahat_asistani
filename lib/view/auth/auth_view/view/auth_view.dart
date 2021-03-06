import 'package:flutter/material.dart';
import 'package:lib_msaadev/lib_msaadev.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../forgot_password/forgot_password_view.dart';
import '../../login/view/login_view.dart';
import '../../signup/view/signup_view.dart';
import '../view_model/auth_viewmodel.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  late final AuthViewModel _viewModel;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _viewModel = AuthViewModel();
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(1, 35, 64, 1),
        ),
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: 10.paddingAll,
              height: context.customHeight(4),
              child: Observer(builder: (_) {
                return AnimatedSwitcher(
                    duration: 200.millisecondsDuration,
                    transitionBuilder: (c, a) => SizeTransition(
                          sizeFactor: a,
                          child: c,
                        ),
                    child: headerSwitch(_viewModel.page));
              }),
            ),
            SizedBox(
              height: context.customHeight(1.35) - 30,
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  _viewModel.setPage(page);
                },
                children: [
                  ForgetPasswordView(
                    pageController: _pageController,
                  ),
                  LoginView(pageController: _pageController),
                  SignupView(pageController: _pageController)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget headerSwitch(int i) {
    switch (i) {
      case 0:
        return headerText('Parolay??  S??f??rla');
      case 1:
        return SizedBox(child: headerText('Giri?? Yap'));
      case 2:
        return Padding(
          padding: const EdgeInsets.all(0.0),
          child: headerText('Kay??t Ol'),
        );
      default:
        return headerText('Giri?? Yap');
    }
  }

  Widget headerText(String text) {
    return Text(
      text,
      style: context.textTheme.headline2!
          .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      textAlign: TextAlign.left,
    );
  }
}
