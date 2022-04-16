// ignore: file_names
class TopUp {
  String name;
  String icon;
  bool checked;
  TopUp({required this.name, required this.icon, this.checked = false});
  static List<TopUp> topups = [
    TopUp(name: "Mobile Payment", icon: "assets/images/mobile.png"),
    TopUp(name: "Credit Card", icon: "assets/images/mobile.png"),
    TopUp(name: "PayPal", icon: "assets/images/mobile.png"),
  ];
}
