import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final _remoteConfig = FirebaseRemoteConfig.instance;

  RemoteConfigService();

  Future<void> initialize() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: Duration(hours: 1),
    ));
    await _remoteConfig.fetchAndActivate();
  }

  String get countryCode => _remoteConfig.getString('country_code');
  String get apiKey => _remoteConfig.getString('api_key');
}
