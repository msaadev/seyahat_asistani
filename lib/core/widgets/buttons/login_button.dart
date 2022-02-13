import 'package:flutter/material.dart';
import 'package:lib_msaadev/lib_msaadev.dart';
import '../../constants/app_constants.dart';

class LoginButton extends StatelessWidget {
  final bool isNext;
  final PageController pageController;

  const LoginButton(
      {Key? key, this.isNext = true, required this.pageController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        !isNext ? back : 1.hSized,
        5.wSized,
        Text(
          'Giriş yap',
          style:
              context.textTheme.headline6!.copyWith(color: AppConstants.BUTTON),
        ),
        isNext ? next : 1.hSized
      ],
    ).onTap(() => pageController.animateToPage(1,
        duration: 250.millisecondsDuration, curve: Curves.ease));
  }

  Row get next {
    return Row(
      children: [
        10.wSized,
        const Icon(
          Icons.arrow_forward_ios,
          size: 18,
          color: AppConstants.BUTTON,
        )
      ],
    );
  }

  Row get back {
    return Row(
      children: [
        const Icon(
          Icons.arrow_back_ios,
          size: 18,
          color: AppConstants.BUTTON,
        ),
        10.wSized,
      ],
    );
  }
}
