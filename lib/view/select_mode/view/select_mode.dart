import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lib_msaadev/lib_msaadev.dart';
import 'package:seyahat_asistani/core/init/cache/cache_manager.dart';
import 'package:seyahat_asistani/core/models/travel_model.dart';
import 'package:seyahat_asistani/core/services/database_service.dart';
import 'package:seyahat_asistani/core/widgets/buttons/select_button.dart';
import 'package:seyahat_asistani/view/drowsiness_detection/view/face_detector_view.dart';
import 'package:seyahat_asistani/view/select_mode/view_model/select_mode_viewmodel.dart';

import '../../../core/init/navigation/navigation_service.dart';
part '../resources/select_mode_res.dart';

class SelectModeView extends StatelessWidget {
  final TravelModel travelModel;
  SelectModeView({Key? key, required this.travelModel}) : super(key: key);
  late SelectModeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = SelectModeViewModel(context);
    print(viewModel.markers);
    return Scaffold(
      floatingActionButton: buildFloatingButton(travelModel,context),
      body: ListView(
          physics: NeverScrollableScrollPhysics(),
          padding: 10.paddingAll,
          children: [
            10.hSized,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Nasil gideceksiniz?',
                style: context.textTheme.headline4,
              ),
            ),
            10.hSized,
            _buildTopButtons(viewModel),
            10.hSized,
            Observer(builder: (_) {
              return AnimatedSwitcher(
                duration: 500.millisecondsDuration,
                child: viewModel.isCar ? arabaCard() : yurumeCard(),
              );
            }),
            Observer(builder: (_) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: viewModel.lastMapPosition,
                      zoom: 8.0,
                    ),
                    mapType: viewModel.currentMapType,
                    markers: viewModel.markers,
                    onCameraMove: viewModel.onCameraMove,
                    myLocationButtonEnabled: false,
                    myLocationEnabled: true,
                    zoomControlsEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      viewModel.mapController = controller;
                    },
                  ),
                ),
              ),
            );
          }),
          ]),
    );
  }
}
