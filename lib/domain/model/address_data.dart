class AddressData {
  final String address;
  final String addressCurrency;

  AddressData({required this.address, required this.addressCurrency});

  Map<String, dynamic> toMap() {
    return {
      'address': this.address,
      'addressCurrency': this.addressCurrency,
    };
  }

  factory AddressData.fromMap(Map<String, dynamic> map) {
    return AddressData(
      address: map['address'] as String,
      addressCurrency: map['addressCurrency'] as String,
    );
  }
}

class AddressMainData {
  final List<AddressData> data;

  AddressMainData({required this.data});

  Map<String, dynamic> toMap() {
    return {
      'data': this.data,
    };
  }

  factory AddressMainData.fromMap(Map<String, dynamic> map) {
    return AddressMainData(
      data: map['data'] as List<AddressData>,
    );
  }
}
