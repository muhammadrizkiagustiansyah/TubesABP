
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final Widget? leading;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = true,
    this.leading,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return AppBar(
      title: Row(
        children: [
          // Logo aplikasi - ganti dengan Image.asset('assets/logo.jpg') nanti
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.local_laundry_service, color: Colors.blue),
          ),
          const SizedBox(width: 10),
          Text(title),
        ],
      ),
      leading: showBackButton
          ? (leading ?? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ))
          : null,
      actions: [
        IconButton(
          icon: Icon(themeProvider.isDarkMode 
              ? Icons.light_mode 
              : Icons.dark_mode),
          onPressed: () {
            themeProvider.toggleTheme();
          },
        ),
        if (actions != null) ...actions!,
      ],
    );
  }
}