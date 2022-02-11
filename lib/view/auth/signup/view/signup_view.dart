import 'package:flutter/material.dart';
import 'package:lib_msaadev/lib_msaadev.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/buttons/custom_button.dart';
import '../../../../core/widgets/buttons/login_button.dart';
import '../../../../core/widgets/inputs/login_input.dart';

class SignupView extends StatefulWidget {
  final PageController pageController;

  const SignupView({Key? key, required this.pageController}) : super(key: key);

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late final GlobalKey<FormState> _key;
  late final TextEditingController _mail, _name, _password;

  @override
  void initState() {
    super.initState();
    _key = GlobalKey<FormState>();
    _mail = TextEditingController();
    _name = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    if (_key.currentState != null) _key.currentState!.dispose();
    _mail.dispose();
    _name.dispose();
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Form(
            key: _key,
            child: Column(
              children: [
                LoginInput(
                  controller: _name,
                  icon: Icons.person,
                  hint: 'İsim Soyisim',
                  validator: (value) => AppConstants.validator(value,
                      len: 4, message: 'Lütfen en az 4 karakter giriniz'),
                ),
                LoginInput(
                  type: TextInputType.emailAddress,
                  controller: _mail,
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
                LoginInput(
                    icon: Icons.vpn_key,
                    obscure: true,
                    controller: _password,
                    hint: 'Şifre',
                    validator: (value) => AppConstants.validator(value,
                        len: 4, message: 'Lütfen en az 4 karakter giriniz')),
                LoginInput(
                  icon: Icons.vpn_key,
                  obscure: true,
                  validator: (value) {
                    if (value == _password.text) {
                      return null;
                    } else {
                      return 'Şifreler uyuşmuyor';
                    }
                  },
                  hint: 'Şifre tekrar',
                ),
              ],
            ),
          ),
          CustomButton(
            text: 'Kayıt Ol',
            onTap: () => signup,
          ),
          LoginButton(
            pageController: widget.pageController,
            isNext: false,
          )
        ],
      ),
    );
  }

  void get signup {
    if (_key.currentState!.validate()) {
      AppConstants.showSuccesToas(message: 'Kayıt başarılı');
      widget.pageController
          .previousPage(duration: 250.millisecondsDuration, curve: Curves.ease);
    } else {
      AppConstants.showErrorToas(message: 'Lütfen gerekli yerleri doldurunuz');
    }
  }
}
