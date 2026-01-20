import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../services/auth_service.dart';
import '../services/post_service.dart';
import '../utils/error_handler.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  final _authService = AuthService();
  final _postService = PostService();
  bool _isLoading = false;
  bool _isPublic = true;

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _handleCreatePost() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final currentUser = _authService.currentUser;
        if (currentUser == null) {
          throw Exception('Please login to create a post');
        }

        final userData = await _authService.getUserData(currentUser.uid);
        if (userData == null) {
          throw Exception('Unable to fetch user data. Please try again.');
        }

        await _postService.createPost(
          userId: currentUser.uid,
          userName: userData.fullName,
          content: _contentController.text.trim(),
          isPublic: _isPublic,
        );

        if (mounted) {
          ErrorHandler.showSuccess(
            context,
            'Post ${_isPublic ? "published" : "saved"} successfully!',
          );
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ErrorHandler.handleError(
            context,
            e,
            customMessage: 'Failed to create post. Please try again.',
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
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          AppStrings.createPost,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Content Field
              CustomTextField(
                controller: _contentController,
                hintText: AppStrings.postContent,
                maxLines: 10,
                maxLength: 500,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter some content';
                  }
                  if (value.trim().length < 3) {
                    return 'Post must be at least 3 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Visibility Selection
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Post Visibility',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<bool>(
                            value: true,
                            groupValue: _isPublic,
                            onChanged: (value) {
                              setState(() => _isPublic = value ?? true);
                            },
                            title: const Text(
                              AppStrings.publicPost,
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 14,
                              ),
                            ),
                            subtitle: const Text(
                              'Visible to everyone',
                              style: TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 12,
                              ),
                            ),
                            activeColor: AppColors.success,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<bool>(
                            value: false,
                            groupValue: _isPublic,
                            onChanged: (value) {
                              setState(() => _isPublic = value ?? false);
                            },
                            title: const Text(
                              AppStrings.privatePost,
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 14,
                              ),
                            ),
                            subtitle: const Text(
                              'Only you can see',
                              style: TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 12,
                              ),
                            ),
                            activeColor: AppColors.warning,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Create Button
              CustomButton(
                text: AppStrings.createPost,
                onPressed: _handleCreatePost,
                isLoading: _isLoading,
                icon: Icons.send,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
