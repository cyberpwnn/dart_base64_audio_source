import 'package:base64_audio_source/base64_audio_source.dart';
import 'package:flutter/foundation.dart';
import 'package:universal_io/io.dart';

bool isAndroid() => !kIsWeb && Platform.isAndroid;

bool isIOS() => !kIsWeb && Platform.isIOS;

bool isMacos() => !kIsWeb && Platform.isMacOS;

bool isWeb() => kIsWeb;
