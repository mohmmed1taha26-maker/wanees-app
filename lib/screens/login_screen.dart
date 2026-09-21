import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_button.dart';

/// صفحة تسجيل الدخول وإنشاء الحساب
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'user@wanees.app');
  final _passwordController = TextEditingController(text: '123456');
  final _nameController = TextEditingController();

  bool _isSignUp = false;
  bool _obscurePassword = true;
  bool _isLoading = false;

  void _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(milliseconds: 600));
      if (!mounted) return;
      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isSignUp ? 'تم إنشاء الحساب بنجاح! مرحباً بك في ونيس' : 'تم تسجيل الدخول بنجاح! مرحباً بك مجدداً',
            style: const TextStyle(fontFamily: 'Tajawal'),
          ),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.pushReplacementNamed(context, '/chat');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(_isSignUp ? 'إنشاء حساب جديد' : 'تسجيل الدخول'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: AppColors.border),
              ),
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // أيقونة لطيفة
                      Center(
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text('🦊', style: TextStyle(fontSize: 32)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _isSignUp ? 'انضم إلى عائلة ونيس' : 'مرحباً بعودتك إلى ونيس',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.heading3,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _isSignUp
                            ? 'أنشئ حسابك واستمتع بمحادثات لا تنتهي'
                            : 'سجّل دخولك لمتابعة محادثاتك وحفظ ذكرياتك',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium,
                      ),
                      const SizedBox(height: 24),

                      // حقل الاسم في حال إنشاء حساب
                      if (_isSignUp) ...[
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'الاسم الكريم',
                            hintText: 'مثال: عبد الله أو سارة',
                            prefixIcon: Icon(Icons.person_outline_rounded),
                          ),
                          validator: (v) {
                            if (_isSignUp && (v == null || v.trim().isEmpty)) {
                              return 'يرجى إدخال اسمك';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                      ],

                      // حقل البريد الإلكتروني
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textDirection: TextDirection.ltr,
                        decoration: const InputDecoration(
                          labelText: 'البريد الإلكتروني',
                          hintText: 'name@example.com',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'يرجى إدخال البريد الإلكتروني';
                          }
                          if (!v.contains('@')) {
                            return 'البريد الإلكتروني غير صحيح';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),

                      // حقل كلمة المرور
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        textDirection: TextDirection.ltr,
                        decoration: InputDecoration(
                          labelText: 'كلمة المرور',
                          hintText: '••••••••',
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.length < 6) {
                            return 'كلمة المرور يجب أن لا تقل عن 6 خانات';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 22),

                      // زر تسجيل الدخول
                      AppButton(
                        label: _isSignUp ? 'إنشاء الحساب' : 'تسجيل الدخول',
                        isLoading: _isLoading,
                        isFullWidth: true,
                        onPressed: _submit,
                      ),
                      const SizedBox(height: 12),

                      // المتابعة كضيف
                      AppButton(
                        label: 'المتابعة كضيف بدون حساب',
                        variant: AppButtonVariant.outlined,
                        isFullWidth: true,
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/chat');
                        },
                      ),
                      const SizedBox(height: 16),

                      // التبديل بين الدخول والإنشاء
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _isSignUp ? 'لديك حساب بالفعل؟' : 'ليس لديك حساب؟',
                            style: AppTextStyles.bodyMedium,
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isSignUp = !_isSignUp;
                              });
                            },
                            child: Text(
                              _isSignUp ? 'تسجيل الدخول' : 'إنشاء حساب جديد',
                              style: const TextStyle(
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
