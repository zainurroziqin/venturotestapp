import 'package:get/get.dart';
import 'package:venturotestapp/api/api.dart';
import 'package:venturotestapp/controller/c_checkout.dart';
import 'package:venturotestapp/model/items.dart';
import 'package:venturotestapp/api/appRequest.dart';
import 'package:venturotestapp/model/response_post.dart';
import 'package:venturotestapp/model/vouchers.dart';

import '../model/send_data.dart';

class SourceItem {
  static Future<List<Items>> getItems() async {
    String url = '${Api.baseUrl}/menus';
    Map? responseBody = await AppRequest.gets(url);

    if (responseBody == null) return [];
    if (responseBody.isNotEmpty) {
      List list = responseBody['datas'];
      return list.map((e) => Items.fromJson(e)).toList();
    }
    return [];
  }

  static Future<Vourcher> getVouchers(String kode) async {
    String url = '${Api.baseUrl}/vouchers?kode=$kode';
    Map? responseBody = await AppRequest.gets(url);
    if (responseBody == null) return Vourcher();
    // List<Vourcher> list = [];
    // list.add(Vourcher.fromJson(responseBody['datas']));
    if (responseBody['status_code'] == 204) return Vourcher();
    Vourcher voucher = Vourcher.fromJson(responseBody['datas']);
    return voucher;
  }

  static Future<bool> postData(String body) async {
    String url = '${Api.baseUrl}/order';
    Map? responseBody = await AppRequest.post(url, body);
    if (responseBody == null) return false;
    if (responseBody["status_code"] == 200) {
      print(responseBody['status_code']);
      print(responseBody['message']);
      print(responseBody['status_code'] == 200);
      final cCheckout = Get.put(CCheckout());
      cCheckout.setIdCheckout(responseBody['id']);
      return true;
    }
    print(responseBody['status_code']);
    print(responseBody['message']);
    print(responseBody['status_code'] == 200);
    return responseBody['status_code'] == 200;
  }

  static Future<bool> cancel(int id) async {
    String url = '${Api.baseUrl}/order/cancel/{$id}';
    Map? responseBody = await AppRequest.cancel(url);
    if (responseBody == null) return false;
    if (responseBody['status_code'] == 200) {
      print(responseBody['status_code']);
      return true;
    };
    print(responseBody['status_code']);
    return responseBody['status_code'] == 200;
  }
}
