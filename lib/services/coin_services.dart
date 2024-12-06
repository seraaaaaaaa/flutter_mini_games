import 'package:shared_preferences/shared_preferences.dart';

class CoinServices {
  Future<int?> useCoins(int currentCoins, int deductCoins) async {
    if (deductCoins < 0 || deductCoins > currentCoins) {
      return null;
    }

    currentCoins -= deductCoins;

    await setCoins(currentCoins);

    return currentCoins;
  }

  Future<int> updateCoins(int currentCoins, int totalCoins) async {
    currentCoins += totalCoins;

    await setCoins(currentCoins);

    return currentCoins;
  }

  Future<int> getCoins() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int coins = prefs.getInt('coins') ?? 0;

    return coins;
  }

  Future setCoins(int coins) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('coins', coins);
  }
}
