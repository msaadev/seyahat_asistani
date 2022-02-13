part of '../view/select_mode.dart';

extension SelectModeRes on SelectModeView {
  FloatingActionButton buildFloatingButton() {
    return FloatingActionButton.extended(
        onPressed: () async {
          await DatabaseService(uid: CacheManager.instance.getUser!.uid)
              .updateUserDataOnTour(travelModel, viewModel.isCar);
          // NavigationService.instance.navigateToPageWidget(page: page);
        },
        label: const Text('Başlat'));
  }

  Container arabaCard() {
    return Container(
      child: Card(
          margin: 0.paddingAll,
          color: Colors.red.shade300,
          child: Column(
            children: [
              buildItem(
                  label:
                      'Yaklaşık ${travelModel.totalFuel} litre yakıt yakacaksınız',
                  isGood: false),
              buildItem(
                  label:
                      'Yaklaşık ${travelModel.carbon} kg carbon salınımı yapacaksınız',
                  isGood: false),
            ],
          )),
    );
  }

  Card yurumeCard() {
    return Card(
      color: Colors.green.shade300,
      margin: 0.paddingAll,
      child: Column(
        children: [
          buildItem(
              label: 'Yaklaşık ${travelModel.calories} calori yakacaksınız'),
          buildItem(
            label:
                'Yaklaşık ${travelModel.carbon} kg carbon salınımı yapmayacaksınız',
          )
        ],
      ),
    );
  }

  Widget buildItem({required String label, bool isGood = true}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            maxRadius: 5,
            backgroundColor: isGood ? Colors.green : Colors.red,
          ),
          10.wSized,
          Text(label),
        ],
      ),
    );
  }

  Observer _buildTopButtons(SelectModeViewModel viewModel) {
    return Observer(builder: (_) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
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
        ],
      );
    });
  }
}
