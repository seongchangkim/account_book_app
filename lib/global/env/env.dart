import 'package:envied/envied.dart';

part 'env_g.dart';

@Envied(path: '.env')
abstract class Env {
  // 공통 url
  @EnviedField(varName: 'BASEURL', obfuscate: true)
  static const baseUrl = _Env.BASEURL;

  // Firebase Android 환경 설정값
  @EnviedField(varName: "FIREBASE_ANDROID_APIKEY", obfuscate: true)
  static const androidApiKey = _Env.FIREBASE_ANDROID_APIKEY;
  @EnviedField(varName: "FIREBASE_ANDROID_APPID", obfuscate: true)
  static const androidAppId = _Env.FIREBASE_ANDROID_APPID;
  @EnviedField(varName: "FIREBASE_ANDROID_MESSAGING_SENDER_ID", obfuscate: true)
  static const androidMessagingSenderId =
      _Env.FIREBASE_ANDROID_MESSAGING_SENDER_ID;
  @EnviedField(varName: "FIREBASE_ANDROID_PROJECT_ID", obfuscate: true)
  static const androidProjectId = _Env.FIREBASE_ANDROID_PROJECT_ID;
  @EnviedField(varName: "FIREBASE_ANDROID_STORAGE_BUCKET", obfuscate: true)
  static const androidStorageBucket = _Env.FIREBASE_ANDROID_STORAGE_BUCKET;

  // Firebase IOS 환경 설정값
  @EnviedField(varName: "FIREBASE_IOS_APIKEY", obfuscate: true)
  static const iosApiKey = _Env.FIREBASE_IOS_APIKEY;
  @EnviedField(varName: "FIREBASE_IOS_APPID", obfuscate: true)
  static const iosAppId = _Env.FIREBASE_IOS_APPID;
  @EnviedField(varName: "FIREBASE_IOS_MESSAGING_SENDER_ID", obfuscate: true)
  static const iosMessagingSenderId = _Env.FIREBASE_IOS_MESSAGING_SENDER_ID;
  @EnviedField(varName: "FIREBASE_IOS_PROJECT_ID", obfuscate: true)
  static const iosProjectId = _Env.FIREBASE_IOS_PROJECT_ID;
  @EnviedField(varName: "FIREBASE_IOS_DATABASE_URL", obfuscate: true)
  static const iosDatabaseUrl = _Env.FIREBASE_IOS_DATABASE_URL;
  @EnviedField(varName: "FIREBASE_IOS_STORAGE_BUCKET", obfuscate: true)
  static const iosStorageBucket = _Env.FIREBASE_IOS_STORAGE_BUCKET;
  @EnviedField(varName: "FIREBASE_ANDROID_CLIENT_ID", obfuscate: true)
  static const androidClientId = _Env.FIREBASE_ANDROID_CLIENT_ID;
  @EnviedField(varName: "FIREBASE_IOS_CLIENT_ID", obfuscate: true)
  static const iosClientId = _Env.FIREBASE_IOS_CLIENT_ID;
  @EnviedField(varName: "FIREBASE_IOS_BUNDLE_ID", obfuscate: true)
  static const iosBundleId = _Env.FIREBASE_IOS_BUNDLE_ID;

  // KAKAO 환경 설정값
  @EnviedField(varName: "KAKAO_NATIVE_APP_KEY", obfuscate: true)
  static const kakaoNativeAppKey = _Env.KAKAO_NATIVE_APP_KEY;
}
