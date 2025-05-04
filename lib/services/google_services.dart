import 'package:dio/dio.dart';
import 'package:thuc_tap_1/models/address_model.dart';

class GooglePlaceService {
  final Dio _dio = Dio();
  final String apiKey = 'AIzaSyAMY5NFtMaQD0Mf4RKLBLakwo1Z6jMCxTw';

  Future<List<AddressModel>> autocomplete(String input) async {
    final url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';

    try {
      final response = await _dio.get(url, queryParameters: {
        'input': input,
        'types': 'address', // chỉ tìm địa chỉ
        'components': 'country:vn', // chỉ ở Việt Nam
        'key': apiKey,
      });

      if (response.statusCode == 200) {
        final predictions = response.data['predictions'] as List;
        return predictions.map((item) {
          return AddressModel(
            titleFirst: item['structured_formatting']['main_text'],
            titleSecond: item['structured_formatting']['secondary_text'],
            description: item['description'],
          );
        }).toList();
      } else {
        print('Lỗi khi gọi API: ${response.statusMessage}');
        return [];
      }
    } catch (e) {
      print('Lỗi kết nối: $e');
      return [];
    }
  }
}
