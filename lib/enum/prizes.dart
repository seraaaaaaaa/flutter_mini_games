import 'package:flutter/material.dart';
import 'package:mini_games/themes/constant.dart';

enum Prizes {
  percent10(
    id: 1,
    name: '10% OFF',
  ),
  specialgift(
      id: 2,
      name: 'Special Gift',
      img: 'assets/prizes/reward.png',
      color: kAmberColor),
  percent50(
    id: 3,
    name: '50% OFF',
  ),
  coins888(
    id: 4,
    name: '888 Coins',
    img: 'assets/prizes/packet.png',
    amount: 888,
    color: kAmberColor,
    isCoin: true,
  ),
  coins100(
    id: 5,
    name: '100 Coins',
    img: 'assets/prizes/coin2.png',
    amount: 100,
    color: kAmberColor,
    isCoin: true,
  ),
  bomb(
    id: 6,
    name: 'KA BOOM!',
    img: 'assets/prizes/bomb.png',
    amount: -100,
    color: kBlackColor,
    isCoin: true,
  ),
  tryagain(
      id: 7,
      name: 'Try Again',
      img: 'assets/prizes/tryagain.png',
      color: kSecondaryColor),
  coins300(
    id: 8,
    name: '300 Coins',
    img: 'assets/prizes/coin3.png',
    amount: 300,
    color: kAmberColor,
    isCoin: true,
  ),
  coins10(
    id: 9,
    name: '10 Coins',
    img: 'assets/prizes/coin1.png',
    amount: 10,
    color: kAmberColor,
    isCoin: true,
  ),
  ;

  const Prizes({
    this.id = 0,
    this.name = '',
    this.img = '',
    this.amount = 0,
    this.color = kPrimaryColor,
    this.isCoin = false,
  });

  final int id;
  final String name;
  final String img;
  final int amount;
  final Color color;
  final bool isCoin;
}
