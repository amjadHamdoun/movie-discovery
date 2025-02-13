import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Flavor {
  String get baseUrl;
  String get tmdpReadAccessToken;
  String get tmdpApiKey;
  String get name;
  bool get showErrors;
  bool get isMultiDevicePreview;
  bool get isPaymentTest;

}


class DevelopingFlavor extends Flavor {
  @override
  String get baseUrl => dotenv.get('developmentBaseUrl');
  @override
  String get tmdpReadAccessToken =>
      dotenv.get('tmdpReadAccessToken');
  @override
  String get tmdpApiKey =>
      dotenv.get('tmdpApiKey');
  @override
  String get name => 'DevelopingFlavor';
  @override
  bool get showErrors => true;
  @override
  bool get isMultiDevicePreview => false;

  @override
  bool get isPaymentTest => true;
}

class StagingFlavor extends Flavor {
  @override
  String get baseUrl => dotenv.get('stagingBaseUrl');
  @override
  String get tmdpReadAccessToken =>
      dotenv.get('tmdpReadAccessToken');
  @override
  String get tmdpApiKey =>
      dotenv.get('tmdpApiKey');
  @override
  String get name => 'StagingFlavor';
  @override
  bool get showErrors => true;
  @override
  bool get isMultiDevicePreview => false;
  @override
  bool get isPaymentTest => true;
}


class ProductionFlavor extends Flavor {
  @override
  String get baseUrl => dotenv.get('productionBaseUrl');
  @override
  String get tmdpReadAccessToken =>
      dotenv.get('tmdpReadAccessToken');
  @override
  String get tmdpApiKey =>
      dotenv.get('tmdpApiKey');

  @override
  String get name => 'ProductionFlavor';
  @override
  bool get showErrors => true;
  @override
  bool get isMultiDevicePreview => false;
  @override
  bool get isPaymentTest => false;
}
