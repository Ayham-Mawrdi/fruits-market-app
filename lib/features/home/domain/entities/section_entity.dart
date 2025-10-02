import 'package:equatable/equatable.dart';
import 'category.dart';

class SectionEntity extends Equatable {
  final Category category;
  final String title1;
  final String subtitle1;
  final String title2;
  final String subtitle2;

  const SectionEntity({
    required this.category,
    required this.title1,
    required this.subtitle1,
    required this.title2,
    required this.subtitle2,
  });

  // Factory to get model by category (reusable)
  static SectionEntity getByCategory(Category category) {
    switch (category) {
      case Category.vegetables:
        return const SectionEntity(
          category: Category.vegetables,
          title1: 'Organic Vegetables',
          subtitle1: 'Pick up from organic farms',
          title2: 'Allium Vegetables',
          subtitle2: 'Fresh Allium Vegetables',
        );
      case Category.fruits:
        return const SectionEntity(
          category: Category.fruits,
          title1: 'Organic Fruits',
          subtitle1: 'Pick up from organic farms',
          title2: 'Stone Fruits',
          subtitle2: 'Fresh Stone Fruits',
        );
      case Category.organic:
        return const SectionEntity(
          category: Category.organic,
          title1: 'Indehiscent Dry Fruits',
          subtitle1: 'Pick up from organic farms',
          title2: 'Dehiscent Dry Fruits',
          subtitle2: 'Fresh Dehiscent Dry Fruits',
        );
    }
  }

  @override
  List<Object> get props => [category, title1, subtitle1, title2, subtitle2];
}
