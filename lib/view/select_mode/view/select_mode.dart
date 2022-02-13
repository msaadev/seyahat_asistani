import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lib_msaadev/lib_msaadev.dart';
import '../../../core/init/cache/cache_manager.dart';
import '../../../core/models/travel_model.dart';
import '../../../core/services/database_service.dart';
import '../../../core/widgets/buttons/select_button.dart';
import '../../drowsiness_detection/view/face_detector_view.dart';
import '../view_model/select_mode_viewmodel.dart';

import '../../../core/init/navigation/navigation_service.dart';
part '../resources/select_mode_res.dart';

class SelectModeView extends StatelessWidget {
  final TravelModel travelModel;
  SelectModeView({Key? key, required this.travelModel}) : super(key: key);
  late SelectModeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = SelectModeViewModel(context);
    return Scaffold(
      floatingActionButton: buildFloatingButton(travelModel, context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            20.hSized,
            Text(
              'Nasıl gideceksiniz?',
              style: context.textTheme.headline4,
            ),
            20.hSized,
            _buildTopButtons(viewModel),
            20.hSized,
            Observer(builder: (_) {
              return AnimatedSwitcher(
                duration: 500.millisecondsDuration,
                child: viewModel.isCar ? arabaCard() : yurumeCard(),
              );
            }),
            20.hSized,
            _buildMapInfo(context),
            Expanded(
              child: Observer(builder: (_) {
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
                          controller.animateCamera(
                              CameraUpdate.newLatLng(travelModel.start));
                        },
                      ),
                    ),
                  ),
                );
              }),
            ),
          ]),
        ),
      ),
    );
  }
}
