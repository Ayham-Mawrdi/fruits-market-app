enum Category { vegetables, fruits, organic }

extension CategoryExtension on Category {
  String get displayName {
    switch (this) {
      case Category.vegetables:
        return 'Vegetables';
      case Category.fruits:
        return 'Fruits';
      case Category.organic:
        return 'Organic';
    }
  }
}
