import 'package:flutter/material.dart';
import 'package:uhk_onboarding/types.dart';

class ContactCard extends StatelessWidget {
  final User user;
  final EdgeInsets innerPadding;
  final EdgeInsets outerPadding;
  final void Function()? onTap;
  final IconData? trailingIcon;
  final void Function()? onTrailingIconTap;

  const ContactCard({
    super.key,
    required this.user,
    this.innerPadding = const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    this.outerPadding = const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
    this.onTap,
    this.trailingIcon,
    this.onTrailingIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
      elevation: 2, // No shadow on the card to match iOS style
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding:
          const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Row(
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircleAvatar(
                    radius: 20,
                    child: Text(user.firstName[0] + user.lastName[0])),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${user.firstName} ${user.lastName}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(user.role.name.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 16, color: Colors.grey)),
                  ],
                ),
              ),
              if(trailingIcon != null)
                IconButton(
                  icon: Icon(trailingIcon),
                  onPressed: onTrailingIconTap,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
