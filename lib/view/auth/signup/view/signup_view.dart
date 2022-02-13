import 'package:flutter/material.dart';
import 'package:lib_msaadev/lib_msaadev.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/buttons/custom_button.dart';
import '../../../../core/widgets/buttons/login_button.dart';
import '../../../../core/widgets/inputs/login_input.dart';
import '../view_model/signup_viewmodel.dart';

class SignupView extends StatefulWidget {
  final PageController pageController;

  const SignupView({Key? key, required this.pageController}) : super(key: key);

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late final GlobalKey<FormState> _key;
  late final TextEditingController _mail, _name, _password, _fuelCost;
  late final SignupViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = SignupViewModel();
    _key = GlobalKey<FormState>();
    _mail = TextEditingController();
    _name = TextEditingController();
    _password = TextEditingController();
    _fuelCost = TextEditingController();
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
                LoginInput(
                    icon: Icons.car_repair,
                    obscure: false,
                    controller: _fuelCost,
                    hint: '100 Kilometrede yakılan benzin litresi',
                    validator: (value) => AppConstants.validator(value,
                        len: 1, message: 'Lütfen en az 1 karakter giriniz')),
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

  void get signup async {
    if (_key.currentState!.validate()) {
      AppConstants.showSuccesToas(message: 'Kayıt başarılı');
      await viewModel.register(
          email: _mail.text,
          password: _password.text,
          name: _name.text,
          fuelCost: _fuelCost.text,
          totalCalories: "0",
          totalDrive: "0",
          totalWalk: "0");
    } else {
      AppConstants.showErrorToas(message: 'Lütfen gerekli yerleri doldurunuz');
    }
  }
}
