// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:camera/camera.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;


/// A widget showing a live camera preview.
class CameraPreview extends StatelessWidget {
  /// Creates a preview widget for the given camera controller.
  const CameraPreview(this.controller);

  /// The controller for the camera that the preview is shown for.
  final CameraController controller;

  int getRotation(currentOrientation){
    if(Platform.isIOS){
      return 1;
    }
    
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return controller.value.isInitialized
        ?
    OrientationBuilder(
        builder: (context, orientation) {
    return RotatedBox(
      quarterTurns: getRotation(orientation),
      child: AspectRatio(
        aspectRatio: Platform.isAndroid
            ? 1 / controller.value.aspectRatio
            : controller.value.aspectRatio,
        child: CameraPlatform.instance.buildPreview(controller.cameraId),
      ),
    ); }): Container();
  }
}
