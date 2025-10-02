import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable {
  final String id;
  final String? name;
  final String? image;
  final String price;
  final String category;
  final String? numStars;
  final String? description;
  final List<String?> nutritionTitles;
  const ItemEntity({
    required this.id,
    required this.category,
    required this.name,
    required this.image,
    required this.price,
    required this.numStars,
    required this.description,
    required this.nutritionTitles,
  });

  static List<ItemEntity> items = [
    ItemEntity(
      name: 'Apple',
      image: 'assets/images/Apple.png',
      price: '\$2.00 per/kg',
      numStars: '2',
      category: 'fruits',
      description: '',
      nutritionTitles: [],
      id: '1',
    ),
    ItemEntity(
      id: '2',
      name: 'Strawberry',
      image: 'assets/images/OIP.webp',
      price: '\$2.00 per/kg',
      numStars: '3',
      category: 'fruits',
      description: '',
      nutritionTitles: [],
    ),
    ItemEntity(
      id: '3',
      name: 'Banana',
      image: 'assets/images/banana.png',
      price: '\$1.50 per/kg',
      numStars: '4',
      category: 'fruits',
      description: '',
      nutritionTitles: [],
    ),
    ItemEntity(
      id: '4',
      name: 'Orange',
      image: 'assets/images/Orange.webp',
      price: '\$1.80 per/kg',
      numStars: '5',
      category: 'fruits',
      description: '',
      nutritionTitles: [],
    ),
    ItemEntity(
      id: '5',
      name: 'Mango',
      image: 'assets/images/Mango.webp',
      price: '\$2.50 per/kg',
      numStars: '2',
      category: 'fruits',
      description: '',
      nutritionTitles: [],
    ),
    ItemEntity(
      id: '6',
      name: 'Broccoli',
      image: 'assets/images/Broccli.webp',
      price: '\$2.50 per/kg',
      numStars: '2',
      category: 'vegetables',
      description:
          'Broccoli is a green vegetable that vaguely  nutritional  Powerhouse of vitamin,fiber and antioxidents.Broccoli  contains lutein and  which mayPrevent from stress and cellular damage in yourEyes. ',
      nutritionTitles: [],
    ),
    ItemEntity(
      id: '7',
      name: 'Brinjels',
      image: 'assets/images/Brinjel.webp',
      price: '\$2.50 per/kg',
      numStars: '2',
      category: 'vegetables',
      description: '',
      nutritionTitles: [],
    ),
    ItemEntity(
      id: '8',
      name: 'Cashewnuts',
      image: 'assets/images/Cashewnuts.webp',
      price: '\$2.50 per/kg',
      numStars: '2',
      category: 'organic',
      description: '',
      nutritionTitles: [],
    ),
  ];

  @override
  List<Object?> get props => [
    id,
    name,
    image,
    price,
    category,
    numStars,
    description,
    nutritionTitles,
  ];
}
