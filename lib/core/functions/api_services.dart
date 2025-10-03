import 'package:dio/dio.dart';
import 'package:e_commerce_app_supabase/core/sensitive_data.dart';

class ApiServices {
  // Dio instance dùng chung: baseUrl là base của Supabase REST, headers mặc định lấy từ anonKey
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://abxdqxazcrrcuofnuktd.supabase.co/rest/v1/",
      headers: {"apiKey": anonKey},
    ),
  );

  // GET: lấy dữ liệu từ endpoint (path là đường dẫn tương đối so với baseUrl).
  Future<Response> getData(String path) async {
    return await _dio.get(path);
  }

  // POST: gửi data để tạo mới resource trên server (path là endpoint, data là body JSON).
  Future<Response> postData(String path, Map<String, dynamic> data) async {
    return await _dio.post(path, data: data);
  }

  // PATCH: cập nhật một phần của resource (thường dùng filter/id trong path).
  Future<Response> patchData(String path, Map<String, dynamic> data) async {
    return await _dio.patch(path, data: data);
  }

  // DELETE: xóa resource (thường dùng filter/id trong path).
  Future<Response> deleteData(String path) async {
    return await _dio.delete(path);
  }
}
