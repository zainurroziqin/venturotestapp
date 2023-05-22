import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:venturotestapp/api/app_format.dart';
import 'package:venturotestapp/card/checkoutcard.dart';
import 'package:venturotestapp/controller/c_checkout.dart';
import 'package:venturotestapp/model/items.dart';
import 'package:venturotestapp/model/vouchers.dart';
import 'package:venturotestapp/page/checkout_page.dart';

import '../card/cartCard.dart';
import '../model/checkout.dart';

class CheckoutSuccessPage extends StatefulWidget {
  const CheckoutSuccessPage({super.key});

  @override
  State<CheckoutSuccessPage> createState() => _CheckoutSuccessPageState();
}

class _CheckoutSuccessPageState extends State<CheckoutSuccessPage> {
  final cItems = Get.put(CCheckout());

  TextEditingController voucherController = TextEditingController();


  getVoucher() async {
    await cItems.getVoucher(voucherController.text);
    if (cItems.successVoucher) {
      cItems.updateVoucher(cItems.voucher.nominal!);
    } else {
      // cItems.resetTotal(cItems.voucher.nominal!);
      // ignore: use_build_context_synchronously
      DInfo.dialogError(context, "Total pembayaran kurang dari diskon");
      // ignore: use_build_context_synchronously
      DInfo.closeDialog(context);
    }
  }

  cancel()async{
    print(cItems.idCheckout);
    await cItems.cancel(cItems.idCheckout);
    if (cItems.isCancelSuccess) {
      // ignore: use_build_context_synchronously
      DInfo.dialogSuccess(context, 'Berhasil cancel');
      // ignore: use_build_context_synchronously
      DInfo.closeDialog(context, actionAfterClose: () {
        Get.back();
      });
    } else {
      Get.snackbar(
        'Gagal',
        'Batalkan pesanan gagal',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void initState() {
    // getPanjang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          bottom: false,
          child: GetBuilder<CCheckout>(builder: (_) {
            if (_.loading) return DView.loadingCircle();
            if (_.checkout.isEmpty) return DView.empty('Kosong');
            return Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                          itemCount: _.checkout.length,
                          itemBuilder: (context, index) {
                            Checkout checkout = _.checkout[index];
                            return CartCard(
                              checkout: checkout,
                            );
                          },
                        )),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width - 36.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      "Total Pesanan ",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 16.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(_.checkout.length.toString(),
                                        style: GoogleFonts.montserrat(
                                            fontSize: 16.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ),
                              Text(
                                AppFormat.currency(_.totalHarga.toString()),
                                style: GoogleFonts.montserrat(
                                    fontSize: 14.sp,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          // showVoucher();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 18.w,
                          ),
                          child: SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width - 36.w,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Image.asset("assets/voucher.png"),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      Text("Voucher",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 18.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    _.successVoucher
                                        ? Column(
                                            children: [
                                              Text("${_.voucher.kode}",
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 12.sp,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                              Text(
                                                  AppFormat.currency(_
                                                      .voucher.nominal
                                                      .toString()),
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 12.sp,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                            ],
                                          )
                                        : Text("Input Voucher",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            )),
                                    const Icon(Icons.arrow_forward_ios)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                        width: 428.w,
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.w),
                                topRight: Radius.circular(30.w)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 12.0)
                            ]),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.w),
                          child: Row(children: [
                            Image.asset("assets/keranjang.png"),
                            SizedBox(
                              width: 8.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  Text(
                                    "Total Pembayaran",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    AppFormat.currency(
                                        _.totalPembayaran.toString()),
                                    style: GoogleFonts.montserrat(
                                        fontSize: 20.sp,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                cancel();
                              },
                              child: Container(
                                width: 200.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.blue),
                                child: Center(
                                  child: Text(
                                    'Batalkan',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            )
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          })),
    );
  }

  void showVoucher() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        ),
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: GetBuilder<CCheckout>(builder: (_) {
              return Container(
                height: 260.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.w),
                        topRight: Radius.circular(40.w))),
                child: Padding(
                  padding: EdgeInsets.all(27.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          Image.asset("assets/voucher.png"),
                          SizedBox(
                            width: 11.w,
                          ),
                          Text(
                            "Punya kode Voucher?",
                            style: GoogleFonts.montserrat(
                                fontSize: 23.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      Text(
                        "Masukkan kode voucher disini",
                        style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      TextFormField(
                        controller: voucherController,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          getVoucher();
                          navigator?.pop(context);
                          if(_.voucher.id != null){
                            _.resetTotal(_.voucher.nominal!);
                          }
                          _.resetVoucher();
                        },
                        child: Container(
                          width: 377.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.blue),
                          child: Center(
                            child: Text(
                              'Validasi Voucher',
                              style: GoogleFonts.montserrat(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }
}
