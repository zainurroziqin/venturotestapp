import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:venturotestapp/api/app_format.dart';
import 'package:venturotestapp/controller/c_checkout.dart';

import '../model/items.dart';

class CheckoutCard extends StatefulWidget {
  final Items item;
  const CheckoutCard({super.key, required this.item});

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  final TextEditingController controller = TextEditingController();
  final cCheckout = Get.put(CCheckout());
  int count = 0;
  int id = 0;

  bool clicked = true;

  tambahTotalHarga(int value) async {
    await cCheckout.tambahTotalHarga(value);
  }

  kurangTotalHarga(int value) async {
    await cCheckout.kurangiTotalHarga(value);
  }

  setCheckout(Items item, String catatan, int count) async {
    await cCheckout.setCheckout(catatan, item, count);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
      child: Container(
        width: 378.w,
        height: 110.h,
        decoration: BoxDecoration(
            color: const Color(0xffF6F6F6),
            borderRadius: BorderRadius.circular(10.w)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Image.network(
                widget.item.gambar,
                width: 75.w,
                height: 75.h,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 7.w,
                    ),
                    Text(
                      widget.item.nama,
                      style: GoogleFonts.montserrat(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 7.w,
                    ),
                    Text(
                      AppFormat.currency(widget.item.harga.toString()),
                      style: GoogleFonts.montserrat(
                          fontSize: 18.sp,
                          color: Colors.blue,
                          fontWeight: FontWeight.w700),
                    ),
                    TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Tambahkan catatan",
                          hintStyle: TextStyle(fontSize: 12.sp)),
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  child: Image.asset("assets/minus.png"),
                  onTap: () {
                    int voucher = 0;
                    if (cCheckout.voucher.nominal != null) {
                      voucher = cCheckout.voucher.nominal!;
                    }
                    if (count > 0 && cCheckout.totalPembayaran > voucher) {
                      setState(() {
                        count--;
                        kurangTotalHarga(widget.item.harga);
                        setCheckout(widget.item, controller.text, count);
                      });
                    }
                  },
                ),
                SizedBox(
                  width: 11.w,
                ),
                Text(
                  "$count",
                  style: GoogleFonts.montserrat(
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 11.w,
                ),
                GestureDetector(
                  child: Image.asset("assets/plus.png"),
                  onTap: () {
                    setState(() {
                      count++;
                      id = cCheckout.id;
                      tambahTotalHarga(widget.item.harga);
                      if (clicked) {
                        clicked = false;
                        id++;
                      }
                      cCheckout.setId(id);
                      print(id);

                      setCheckout(widget.item, controller.text, count);
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
