/// incoming : "0.1234"
/// outgoing : "0.1"

class GetWalletBalance {
  GetWalletBalance({
      this.incoming, 
      this.outgoing,});

  GetWalletBalance.fromJson(dynamic json) {
    incoming = json['incoming'];
    outgoing = json['outgoing'];
  }
  String? incoming;
  String? outgoing;
GetWalletBalance copyWith({  String? incoming,
  String? outgoing,
}) => GetWalletBalance(  incoming: incoming ?? this.incoming,
  outgoing: outgoing ?? this.outgoing,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['incoming'] = incoming;
    map['outgoing'] = outgoing;
    return map;
  }

}