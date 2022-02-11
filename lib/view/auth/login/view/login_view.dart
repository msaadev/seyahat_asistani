import 'package:flutter/material.dart';
import 'package:lib_msaadev/lib_msaadev.dart';
import 'package:seyahat_asistani/view/auth/login/view_model/login_view_model.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/buttons/custom_button.dart';
import '../../../../core/widgets/inputs/login_input.dart';

class LoginView extends StatefulWidget {
  final PageController pageController;

  const LoginView({Key? key, required this.pageController}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final GlobalKey<FormState> _key;
  late final TextEditingController _mail, _password;
  late final LoginViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = LoginViewModel();
    _key = GlobalKey<FormState>();
    _mail = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    if (_key.currentState != null) _key.currentState!.dispose();
    _mail.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: 10.paddingAll,
        padding: 20.paddingAll,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: 0.radius10,
        ),
        alignment: Alignment.center,
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  LoginInput(
                    controller: _mail,
                    icon: Icons.mail,
                    hint: 'E-Mail',
                    validator: (String? value) {
                      if (value != null) {
                        if (value.isValidEmail) {
                          return null;
                        }
                      }
                      return 'Geçersiz email';
                    },
                  ),
                  10.hSized,
                  LoginInput(
                    controller: _password,
                    icon: Icons.vpn_key,
                    obscure: true,
                    hint: 'Şifre',
                    validator: (value) => AppConstants.validator(value,
                        len: 4, message: 'Lütfen en az 4 karakter giriniz'),
                  ),
                  10.hSized,
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Şifremi unuttum',
                      style: context.textTheme.bodyText1!
                          .copyWith(color: AppConstants.BUTTON),
                    ).onTap(() => widget.pageController.previousPage(
                        duration: 250.millisecondsDuration,
                        curve: Curves.ease)),
                  )
                ],
              ),
              CustomButton(
                text: 'Giriş Yap',
                onTap: () => login,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Henüz hesabınız yok mu? ",
                    style: context.textTheme.bodyText1!
                        .copyWith(color: Colors.grey.shade600),
                  ),
                  Text(
                    'Kayıt ol',
                    style: context.textTheme.bodyText1!
                        .copyWith(color: AppConstants.BUTTON),
                  ).onTap(() => widget.pageController.nextPage(
                      duration: 250.millisecondsDuration, curve: Curves.ease))
                ],
              )
            ],
          ),
        ));
  }

  void get login async {
    // await Future.delayed(5.secondDuration).then((value) => debugPrint('samil'));
    if (_key.currentState!.validate()) {
     await  viewModel.login(email: _mail.text, password: _password.text);
    } else {
      AppConstants.showErrorToas(message: 'Lütfen gerekli yerleri doldurunuz');
    }
  }
}
