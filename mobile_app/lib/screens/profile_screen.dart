import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../services/auth_service.dart';
import '../utils/error_handler.dart';
import '../widgets/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  Future<void> _handleLogout() async {
    final confirmed = await ErrorHandler.showConfirmationDialog(
      context,
      title: 'Logout',
      message: 'Are you sure you want to logout?',
      confirmText: AppStrings.logout,
      cancelText: AppStrings.cancel,
      isDangerous: false,
    );

    if (confirmed) {
      setState(() => _isLoading = true);

      try {
        await _authService.logout();
        if (mounted) {
          ErrorHandler.showInfo(context, 'Logged out successfully!');
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
            (route) => false,
          );
        }
      } catch (e) {
        if (mounted) {
          ErrorHandler.handleError(
            context,
            e,
            customMessage: 'Failed to logout. Please try again.',
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = _authService.currentUser;

    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          AppStrings.profile,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: currentUser == null
          ? const Center(
              child: Text(
                'Please log in to view your profile',
                style: TextStyle(color: AppColors.secondaryText, fontSize: 16),
              ),
            )
          : FutureBuilder(
              future: _authService.getUserData(currentUser.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error loading profile: ${snapshot.error}',
                      style: const TextStyle(color: AppColors.error),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                final userData = snapshot.data;

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Profile Avatar
                      Center(
                        child: CircleAvatar(
                          backgroundColor: AppColors.primary,
                          radius: 60,
                          child: Text(
                            userData?.fullName.isNotEmpty == true
                                ? userData!.fullName[0].toUpperCase()
                                : 'U',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // User Info Card
                      Card(
                        color: AppColors.cardBackground,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(
                            color: AppColors.border,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Account Information',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryText,
                                ),
                              ),
                              const SizedBox(height: 16),
                              _buildInfoRow(
                                Icons.person_outline,
                                'Full Name',
                                userData?.fullName ?? 'N/A',
                              ),
                              const Divider(
                                color: AppColors.divider,
                                height: 24,
                              ),
                              _buildInfoRow(
                                Icons.email_outlined,
                                'Email',
                                userData?.email ?? currentUser.email ?? 'N/A',
                              ),
                              const Divider(
                                color: AppColors.divider,
                                height: 24,
                              ),
                              _buildInfoRow(
                                Icons.calendar_today_outlined,
                                'Member Since',
                                userData?.createdAt != null
                                    ? '${userData!.createdAt.day}/${userData.createdAt.month}/${userData.createdAt.year}'
                                    : 'N/A',
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Actions Card
                      Card(
                        color: AppColors.cardBackground,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(
                            color: AppColors.border,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(
                                Icons.public,
                                color: AppColors.success,
                              ),
                              title: const Text(
                                'Public Feed',
                                style: TextStyle(
                                  color: AppColors.primaryText,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.secondaryText,
                                size: 16,
                              ),
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/home',
                                  (route) => false,
                                );
                              },
                            ),
                            const Divider(color: AppColors.divider, height: 1),
                            ListTile(
                              leading: const Icon(
                                Icons.lock,
                                color: AppColors.warning,
                              ),
                              title: const Text(
                                'My Private Posts',
                                style: TextStyle(
                                  color: AppColors.primaryText,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.secondaryText,
                                size: 16,
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, '/private-feed');
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Logout Button
                      CustomButton(
                        text: AppStrings.logout,
                        onPressed: _handleLogout,
                        isLoading: _isLoading,
                        backgroundColor: AppColors.error,
                        icon: Icons.logout,
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
