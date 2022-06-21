import 'dart:async';
import 'dart:convert' show json, utf8;
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:unit_converter_app_udacity/constants/api_constants.dart';
import 'package:unit_converter_app_udacity/work_self_sign_certificate.dart';

class RestApi {
  final HttpClient _httpClient = HttpClient()
    //Resolve work's self sign certificate issue
    ..badCertificateCallback = (X509Certificate cert, String host, int port) =>
        cert.subject.contains(WorkSelfSignCertificate.certificateName);

  Future<List?> getUnits(String? category) async {
    final uri = Uri.https(ApiConstants.apiUrl, '/$category');
    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null || jsonResponse['units'] == null) {
      debugPrint('Error retrieving units.');
      return null;
    }
    return jsonResponse['units'];
  }

  Future<double?> convert(
      String? category, String amount, String? fromUnit, String? toUnit) async {
    final uri = Uri.https(ApiConstants.apiUrl, '/$category/convert',
        {'amount': amount, 'from': fromUnit, 'to': toUnit});
    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null || jsonResponse['status'] == null) {
      debugPrint('Error retrieving conversion.');
      return null;
    } else if (jsonResponse['status'] == 'error') {
      debugPrint(jsonResponse['message']);
      return null;
    }
    return jsonResponse['conversion'].toDouble();
  }

  Future<Map<String, dynamic>?> _getJson(Uri uri) async {
    try {
      final httpRequest = await _httpClient.getUrl(uri);
      final httpResponse = await httpRequest.close();
      if (httpResponse.statusCode != HttpStatus.ok) {
        return null;
      }
      final responseBody = await httpResponse.transform(utf8.decoder).join();
      return json.decode(responseBody);
    } on Exception catch (e) {
      debugPrint('$e');
      return null;
    }
  }
}
