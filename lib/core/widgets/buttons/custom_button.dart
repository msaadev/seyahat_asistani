import 'package:flutter/material.dart';
import 'package:lib_msaadev/lib_msaadev.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Function()? onTap;
  final Color backgroundColor;

  const CustomButton(
      {Key? key,
      required this.text,
      this.onTap,
      this.backgroundColor = const Color.fromRGBO(4, 217, 57,1)})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      alignment: Alignment.center,
      padding: 15.paddingAll,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: 0.radius5,
      ),
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Text(
              widget.text,
              style: context.textTheme.headline4!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
    ).onTap(isLoading
        ? null
        : () async {
            _changeLoading;
            if (widget.onTap != null) {
              await widget.onTap!();
            }
            _changeLoading;
          });
  }

  void get _changeLoading {
    setState(() {
      isLoading = !isLoading;
    });
  }
}
