/// address : "0xa7673161CbfE0116A4De9E341f8465940c2211d4"

class GenAddressRes {
  GenAddressRes({
      this.address,});

  GenAddressRes.fromJson(dynamic json) {
    address = json['address'];
  }
  String? address;
GenAddressRes copyWith({  String? address,
}) => GenAddressRes(  address: address ?? this.address,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = address;
    return map;
  }

}