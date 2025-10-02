import 'package:flutter/material.dart';
import '../../../../../../core/utils/sized_config.dart';
import '../../../../domain/entities/item_entity.dart';

class ItemDetailsWidget extends StatelessWidget {
  const ItemDetailsWidget({super.key, required this.item});

  final ItemEntity item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: AssetImage(item.image ?? ''),
                fit: BoxFit.fill,
              ),
            ),
            height: SizeConfig.screenHeight! * 0.3,
            width: SizeConfig.screenWidth! * 0.9,
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight! * 0.02),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name ?? '',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.02),

              Text(
                item.description!.isEmpty
                    ? 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum'
                    : '${item.description}',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: SizeConfig.screenHeight! * 0.04),
       
        
      ],
    );
  }
}
