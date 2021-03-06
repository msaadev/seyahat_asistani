import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lib_msaadev/lib_msaadev.dart';
import '../../../core/widgets/inputs/login_input.dart';
import '../view_model/add_pin_viewmodel.dart';

class AddPinView extends StatelessWidget {
  final LatLng myPosition;
  const AddPinView({Key? key, required this.myPosition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddPinViewModel viewModel = AddPinViewModel(myPosition: myPosition);

    return Scaffold(
      floatingActionButton: buildFloatingButton(viewModel),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            children: [
              buildInput(viewModel),
              Expanded(child: buildMap(viewModel))
            ],
          ),
        ),
      ),
    );
  }

  Observer buildFloatingButton(AddPinViewModel viewModel) {
    return Observer(builder: (_) {
      return viewModel.isLoading
          ? const SizedBox()
          : FloatingActionButton(
              child: const Icon(Icons.upload_rounded),
              onPressed: viewModel.savePin);
    });
  }

  LoginInput buildInput(AddPinViewModel viewModel) {
    return LoginInput(
      controller: viewModel.controller,
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
