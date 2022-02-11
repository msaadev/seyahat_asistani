import 'package:flutter/material.dart';
import 'package:lib_msaadev/lib_msaadev.dart';

class LoginInput extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final IconData? icon;
  final bool obscure;
  final TextInputType type;
  final Function()? onEditingComplete;
  final String? Function(String? text)? validator;

  const LoginInput(
      {Key? key,
      this.hint,
      this.controller,
      this.icon,
      this.obscure = false,
      this.onEditingComplete,
      this.validator,
      this.type = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: 5.paddingSymmetricVertical,
      child: TextFormField(
        validator: validator,
        onEditingComplete:
            onEditingComplete ?? () => FocusScope.of(context).nextFocus(),
        obscureText: obscure,
        controller: controller,
        decoration: InputDecoration(
          errorStyle: context.textTheme.bodyText1!
              .copyWith(color: Colors.red.shade200, fontSize: 10),
          prefixIcon: Icon(
            icon ?? Icons.mail,
            color: Color(0xff7c807f),
          ),
          hintText: hint,
          hintStyle: context.textTheme.bodyText1!.copyWith(
            color: Color(0xff7c807f),
          ),
          filled: true,
          fillColor: Color(0xffe7edeb),
          enabledBorder: buildBorder,
          border: buildBorder,
          errorBorder: buildBorder,
          focusedBorder: buildBorder,
          disabledBorder: buildBorder,
          focusedErrorBorder: buildBorder,
        ),
      ),
    );
  }

  OutlineInputBorder get buildBorder => OutlineInputBorder(
      borderRadius: 0.radius5,
      borderSide: BorderSide(
          // color: AppConstants.PRIMARY_COLOR,
          color: Colors.transparent,
          width: 0));
}
