class Coin {
  Coin(
      {this.id,
      this.name,
      this.symbol,
      this.imageURL,
      this.price,
      this.change,
      this.changePercentage});

  String id;
  String name;
  String symbol;
  String imageURL;
  num price;
  num change;
  num changePercentage;

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
        id: json['id'],
        name: json['name'],
        symbol: json['symbol'],
        imageURL: json['image'],
        price: json['current_price'],
        change: json['price_change_24h'],
        changePercentage: json['price_change_percentage_24h']);
  }
}
