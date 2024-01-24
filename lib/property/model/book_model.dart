// To parse this JSON data, do
//
//     final bookingModel = bookingModelFromJson(jsonString);

import 'dart:convert';

List<BookingModel> bookingModelFromJson(String str) => List<BookingModel>.from(json.decode(str).map((x) => BookingModel.fromJson(x)));

String bookingModelToJson(List<BookingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingModel {
  int? id;
  int? userId;
  int? propertyId;
  String? bookingDate;
  int? status;
  num? bookingPrice;

  BookingModel({
    this.id,
    this.userId,
    this.propertyId,
    this.bookingDate,
    this.status,
    this.bookingPrice,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
    id: json["id"],
    userId: json["user_id"],
    propertyId: json["property_id"],
    bookingDate: json["booking_date"],
    status: json["status"],
    bookingPrice: json["booking_price"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "property_id": propertyId,
    "booking_date": bookingDate,
    "status": status,
    "booking_price": bookingPrice,
  };
}
