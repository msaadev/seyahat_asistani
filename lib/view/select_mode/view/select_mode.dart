import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lib_msaadev/lib_msaadev.dart';
import 'package:seyahat_asistani/core/widgets/buttons/select_button.dart';
import 'package:seyahat_asistani/view/select_mode/view_model/select_mode_viewmodel.dart';

class SelectModeView extends StatelessWidget {
  const SelectModeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SelectModeViewModel viewModel = SelectModeViewModel();
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Nasil gideceksiniz?',
            style: context.textTheme.headline4,
          ),
        ),
        _buildTopButtons(viewModel)
      ]),
    );
  }

  Observer _buildTopButtons(SelectModeViewModel viewModel) {
    return Observer(builder: (_) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            10.wSized,
            Expanded(
                child: SelectButton(
              label: 'Araba',
              isEnabled: viewModel.isCar,
              enabledColor: Colors.red,
              tap: () => viewModel.change(true),
            )),
            10.wSized,
            Expanded(
                child: SelectButton(
              isEnabled: !viewModel.isCar,
              tap: () => viewModel.change(false),
              label: 'Yürüme',
              enabledColor: Colors.green,
            )),
            10.wSized,
          ],
        );
      });
  }
}
