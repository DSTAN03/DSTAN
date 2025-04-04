import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../consts.dart';

class PostImage {
  Future<String?> uploadFile(File file) async {
    const url = AppConstant.endPointUploadFile;
    final request = http.MultipartRequest('POST', Uri.parse(url));

    request.files.addAll([
      await http.MultipartFile.fromPath('file', file.path),
    ]);
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${null}',
    });

    final stream = await request.send();

    final response = await http.Response.fromStream(stream).then((value) {
      if (value.statusCode == 200) {
        return value;
      }
      throw Exception('Failed to load data');
    });

    Map<String, dynamic> result = jsonDecode(response.body);
    print('object ${result['body']['file']}');
    return result['body']['file'];
  }

  Future<String?> post({required File image}) async { // khi upload thì mình úp 1 file vào và nó trả về 1 string
    return await uploadFile(image);
  }
}
