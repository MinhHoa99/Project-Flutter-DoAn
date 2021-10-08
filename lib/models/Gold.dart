class Gold {
  double buyNhan24k;
  double buyNt10k;
  double buyNt14k;
  double buyNt18k;
  double buyNt24k;
  String datetime;
  double sellNhan24k;
  double sellNt10k;
  double sellNt14k;
  double sellNt18k;
  double sellNt24k;

  Gold(
      {this.buyNhan24k,
      this.buyNt10k,
      this.buyNt14k,
      this.buyNt18k,
      this.buyNt24k,
      this.datetime,
      this.sellNhan24k,
      this.sellNt10k,
      this.sellNt14k,
      this.sellNt18k,
      this.sellNt24k});

  Gold.fromJson(Map<String, dynamic> json) {
    buyNhan24k = json['buy_nhan_24k'];
    buyNt10k = json['buy_nt_10k'];
    buyNt14k = json['buy_nt_14k'];
    buyNt18k = json['buy_nt_18k'];
    buyNt24k = json['buy_nt_24k'];
    datetime = json['datetime'];
    sellNhan24k = json['sell_nhan_24k'];
    sellNt10k = json['sell_nt_10k'];
    sellNt14k = json['sell_nt_14k'];
    sellNt18k = json['sell_nt_18k'];
    sellNt24k = json['sell_nt_24k'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buy_nhan_24k'] = this.buyNhan24k;
    data['buy_nt_10k'] = this.buyNt10k;
    data['buy_nt_14k'] = this.buyNt14k;
    data['buy_nt_18k'] = this.buyNt18k;
    data['buy_nt_24k'] = this.buyNt24k;
    data['datetime'] = this.datetime;
    data['sell_nhan_24k'] = this.sellNhan24k;
    data['sell_nt_10k'] = this.sellNt10k;
    data['sell_nt_14k'] = this.sellNt14k;
    data['sell_nt_18k'] = this.sellNt18k;
    data['sell_nt_24k'] = this.sellNt24k;
    return data;
  }
}
