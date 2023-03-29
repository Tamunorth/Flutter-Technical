/// mnemonic : "urge pulp usage sister evidence arrest palm math please chief egg abuse"
/// xpub : "xpub6EsCk1uU6cJzqvP9CdsTiJwT2rF748YkPnhv5Qo8q44DG7nn2vbyt48YRsNSUYS44jFCW9gwvD9kLQu9AuqXpTpM1c5hgg9PsuBLdeNncid"

class GenWalletRes {
  GenWalletRes({
      this.mnemonic, 
      this.xpub,});

  GenWalletRes.fromJson(dynamic json) {
    mnemonic = json['mnemonic'];
    xpub = json['xpub'];
  }
  String? mnemonic;
  String? xpub;
GenWalletRes copyWith({  String? mnemonic,
  String? xpub,
}) => GenWalletRes(  mnemonic: mnemonic ?? this.mnemonic,
  xpub: xpub ?? this.xpub,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mnemonic'] = mnemonic;
    map['xpub'] = xpub;
    return map;
  }

}