import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

const kMainColor = Color(0xFF69A03A);
const kLogo = 'assets/images/logo.png';
const kName = 'name';
const kAddress = 'address';

const kEmail = 'email';
const lorem =
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum';

const kPhoneNumber = 'phone number';
List<BottomNavigationBarItem> items = [
  BottomNavigationBarItem(
    backgroundColor: kMainColor,
    icon: Icon(FeatherIcons.home), // Custom icon for "Home"
    label: "Home",
  ),
  BottomNavigationBarItem(
    icon: Icon(FeatherIcons.shoppingCart), // Custom icon for "Shopping cart"
    label: "Shopping cart",
  ),
  BottomNavigationBarItem(
    icon: Icon(FeatherIcons.heart), // Custom icon for "Favourite"
    label: "Favourite",
  ),
  BottomNavigationBarItem(
    icon: Icon(FeatherIcons.user), // Custom icon for "My Account"
    label: "My Account",
  ),
];
