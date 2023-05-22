import 'dart:convert';

import 'package:get/get.dart';
import 'package:venturotestapp/model/checkout.dart';
import 'package:venturotestapp/model/items.dart';
import 'package:venturotestapp/model/vouchers.dart';
import 'package:venturotestapp/source/source_item.dart';

import '../model/send_data.dart';

class CCheckout extends GetxController {
  final _loading = false.obs;
  bool get loading => _loading.value;

  final _loadingBottomSheet = false.obs;
  bool get loadingBottomSheet => _loadingBottomSheet.value;

  final _listItems = <Items>[].obs;
  List<Items> get listItems => _listItems.value;

  final _vouchers = Vourcher().obs;
  Vourcher get voucher => _vouchers.value;

  final _successVoucher = false.obs;
  bool get successVoucher => _successVoucher.value;

  final _totalItems = 0.obs;
  int get totalItems => _totalItems.value;

  final _totalHarga = 0.obs;
  int get totalHarga => _totalHarga.value;

  final _totalPembayaran = 0.obs;
  int get totalPembayaran => _totalPembayaran.value;

  final _checkout = <Checkout>[].obs;
  List<Checkout> get checkout => _checkout.value;

  final _id = 0.obs;
  int get id => _id.value;

  final _idCheckout = 0.obs;
  int get idCheckout => _idCheckout.value;
  setIdCheckout(int i) => _idCheckout.value = i;

  final _isPostSuccess = false.obs;
  bool get isPostSuccess => _isPostSuccess.value;

  final _isCancelSuccess = false.obs;
  bool get isCancelSuccess => _isCancelSuccess.value;

  setId(int i) => _id.value = i;

  setCheckout(String catatan, Items item, int count) async {
    final index =
        _checkout.value.indexWhere((element) => element.id == _id.value);
    if (index >= 0) {
      _checkout.value[index] =
          Checkout(id: _id.value, item: item, catatan: catatan, count: count);
    } else {
      _checkout.value.add(
          Checkout(id: _id.value, item: item, catatan: catatan, count: count));
    }
  }

  refreshTotal()async{
    _totalHarga.value = 0;
    _totalPembayaran.value = 0; 
  }

  resetCheckout() {
    _checkout.value.clear();
    _id.value = 1;
  }

  getVoucher(String kode) async {
    _loadingBottomSheet.value = true;
    update();
    _vouchers.value = await SourceItem.getVouchers(kode);
    update();
    if (_vouchers.value.nominal != null) {
      if (_vouchers.value.nominal! < _totalHarga.value) {
        _successVoucher.value = true;
      }
    }
    update();
    _loadingBottomSheet.value = false;
    update();
  }

  resetVoucher() {
    _successVoucher.value = false;
  }

  resetTotal(int diskon) {
    if (_vouchers.value.nominal != null) {
      if (_vouchers.value.nominal! < _totalHarga.value) {
        _totalPembayaran.value = _totalPembayaran.value + diskon;
      }
    }
  }

  updateVoucher(int diskon) async {
    _totalPembayaran.value = _totalPembayaran.value - diskon;
  }

  tambahTotalHarga(int total) async {
    _totalHarga.value = _totalHarga.value + total;
    _totalPembayaran.value = _totalPembayaran.value + total;
    update();
  }

  kurangiTotalHarga(int total) async {
    _totalHarga.value = _totalHarga.value - total;
    _totalPembayaran.value = _totalPembayaran.value - total;
    update();
  }

  getListItems() async {
    _loading.value = true;
    update();
    _listItems.value = await SourceItem.getItems();
    update();
    _loading.value = false;
    update();
  }

  getTotal() {
    _totalItems.value = listItems.length;
    update();
  }

  postData(String body) async {
    _loading.value = true;
    update();
    _isPostSuccess.value = await SourceItem.postData(body);
    update();
    _loading.value = false;
  }

  cancel(int id) async {
    _loading.value = true;
    update();
    _isCancelSuccess.value = await SourceItem.cancel(id);
    update();
    _loading.value = false;
  }
}
