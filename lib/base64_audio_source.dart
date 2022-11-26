library base64_audio_source;

import 'dart:convert';

import 'package:base64_audio_source/util.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

typedef AudioSupportCheck = bool Function();

AudioFormat? getIdealAudioFormat() =>
    kAudioFormats.firstWhere((element) => element.isSupported());

final AudioFormat kAudioFormatMP3 = AudioFormat(
    name: "MP3",
    extension: "mp3",
    mime: "audio/mpeg",
    encoding: "MP3",
    isSupported: () => isAndroid() || isWeb() || isIOS());

final AudioFormat kAudioFormatOGG = AudioFormat(
    name: "OGG",
    extension: "ogg",
    mime: "audio/ogg",
    encoding: "OGG_OPUS",
    isSupported: () =>
        false); // Web has a bug where the duration is 10% less than reality

final List<AudioFormat> kAudioFormats = <AudioFormat>[
  kAudioFormatMP3,
  kAudioFormatOGG,
];

class AudioFormat {
  final String name;
  final String extension;
  final String mime;
  final String encoding;
  final AudioSupportCheck isSupported;

  AudioFormat(
      {required this.name,
      required this.extension,
      required this.mime,
      required this.encoding,
      required this.isSupported});

  @override
  String toString() => "Audio[$name, $mime, '*.$extension', $encoding]";
}

class Base64AudioSource extends StreamAudioSource {
  final String audio;
  Uint8List? _raw;
  final AudioFormat format;

  Base64AudioSource(this.audio, this.format);

  Uint8List _decoded() {
    _raw ??= base64Decode(audio);
    return _raw!;
  }

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    Uint8List buffer = _decoded();
    start = start ?? 0;
    end = end ?? buffer.length - 1;
    Stream<List<int>> steam =
        Stream.value(List<int>.from(buffer.skip(start).take(end - start)));

    return Future.value(
      StreamAudioResponse(
        sourceLength: buffer.length,
        contentLength: end - start,
        offset: start,
        contentType: format.mime,
        stream: steam,
      ),
    );
  }
}
