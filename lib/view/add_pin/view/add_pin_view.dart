import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lib_msaadev/lib_msaadev.dart';
import 'package:seyahat_asistani/core/widgets/inputs/login_input.dart';
import 'package:seyahat_asistani/view/add_pin/view_model/add_pin_viewmodel.dart';

class AddPinView extends StatelessWidget {
  final LatLng myPosition;
  const AddPinView({Key? key, required this.myPosition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddPinViewModel viewModel = AddPinViewModel(myPosition: myPosition);
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      floatingActionButton: buildFloatingButton(viewModel),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            children: [
              buildInput(controller),
              Expanded(child: buildMap(viewModel))
            ],
          ),
        ),
      ),
    );
  }

  Observer buildFloatingButton(AddPinViewModel viewModel) {
    return Observer(builder: (_) {
      return FloatingActionButton(
          child: const Icon(Icons.upload_rounded),
          onPressed: viewModel.savePin);
    });
  }

  LoginInput buildInput(TextEditingController controller) {
    return LoginInput(
      controller: controller,
      hint: 'Açıklama',
      icon: Icons.info,
    );
  }

  Observer buildMap(AddPinViewModel viewModel) {
    return Observer(builder: (_) {
      return ClipRRect(
        borderRadius: 5.customRadius,
        child: GoogleMap(
            zoomControlsEnabled: false,
            compassEnabled: false,
            markers: {
              Marker(markerId: const MarkerId('pin'), position: viewModel.pin!)
            },
            onTap: viewModel.addPin,
            onMapCreated: (c) {
              c.animateCamera(CameraUpdate.newLatLngZoom(myPosition, 15));
            },
            initialCameraPosition: CameraPosition(target: myPosition)),
      );
    });
  }
}
