A base64 audio source for just audio

## Usage

```dart
import 'package:just_audio/just_audio.dart';
import 'package:base64_audio_source/base64_audio_source.dart';

...

await player.setAudioSource( Base64AudioSource('<base64>', kAudioFormatMP3));
// or kAudioFormatOGG, but there are issues with duration reading on web
```
