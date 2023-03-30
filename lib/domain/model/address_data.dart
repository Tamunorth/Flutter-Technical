/// data : [{"address":"this.address","addressCurrency":""}]

class AddressMainData {
  AddressMainData({
    this.data,
  });

  AddressMainData.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(AddressData.fromJson(v));
      });
    }
  }

  List<AddressData>? data;

  AddressMainData copyWith({
    List<AddressData>? data,
  }) =>
      AddressMainData(
        data: data ?? this.data,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// address : "this.address"
/// addressCurrency : ""

class AddressData {
  AddressData({
    this.address,
    this.addressCurrency,
  });

  AddressData.fromJson(dynamic json) {
    address = json['address'];
    addressCurrency = json['addressCurrency'];
  }

  String? address;
  String? addressCurrency;

  AddressData copyWith({
    String? address,
    String? addressCurrency,
  }) =>
      AddressData(
        address: address ?? this.address,
        addressCurrency: addressCurrency ?? this.addressCurrency,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = address;
    map['addressCurrency'] = addressCurrency;
    return map;
  }
}
