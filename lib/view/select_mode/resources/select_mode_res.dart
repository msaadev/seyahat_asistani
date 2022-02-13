part of '../view/select_mode.dart';

extension SelectModeRes on SelectModeView {
  FloatingActionButton buildFloatingButton(
      TravelModel travelModel, BuildContext context) {
    return FloatingActionButton.extended(
        onPressed: () async {
          await DatabaseService(uid: CacheManager.instance.getUser!.uid)
              .updateUserDataOnTour(travelModel, viewModel.isCar);

          if (viewModel.isCar) {
            NavigationService.instance.navigateToPageWidget(
                page: FaceDetectorView(travelModel: travelModel));
          } else {
            Navigator.pop(context);
          }
          // NavigationService.instance.navigateToPageWidget(page: page);
        },
        label: const Text('Başlat'));
  }

  Center _buildMapInfo(BuildContext context) {
    return Center(
      child: Card(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Olağan dışıdurumlar harita üzerinde gösterilmektedir',
              style: context.textTheme.bodyText1
                  ?.copyWith(color: Theme.of(context).scaffoldBackgroundColor),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox arabaCard() {
    return SizedBox(
      child: Card(
          margin: 0.paddingAll,
          color: Colors.red,
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
      color: Colors.green,
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
          Expanded(
              child: Text(
            label,
            style: TextStyle(color: Colors.white),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )),
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
            tap: () => viewModel.change(true),
          )),
          10.wSized,
          Expanded(
              child: SelectButton(
            isEnabled: !viewModel.isCar,
            tap: () => viewModel.change(false),
            label: 'Yürüme',
          )),
        ],
      );
    });
  }
}
