import 'package:fifamanager/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:fifamanager/routes/app_routes.dart';
import 'package:fifamanager/widgets/app_brand_logo.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.backgroundDark,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/splash_bg_new.png',
            fit: BoxFit.cover,
            color: Colors.black54,
            colorBlendMode: BlendMode.darken,
          ),
          Container(color: Colors.black.withValues(alpha: 0.35)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 24.0,
              ),
              child: _ScrollableBody(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 12),
                    const Center(
                      child: AppBrandLogo(size: 88, showLabel: true),
                    ),
                    const SizedBox(height: 44),
                    const _LoginTitle(),
                    const SizedBox(height: 32),
                    _EmailField(),
                    const SizedBox(height: 16),
                    _PasswordField(
                      obscureText: _obscurePassword,
                      onToggle: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    const SizedBox(height: 14),
                    _RememberForgotRow(
                      rememberMe: _rememberMe,
                      onRememberToggle: () {
                        setState(() {
                          _rememberMe = !_rememberMe;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    _LoginButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushReplacementNamed(AppRoutes.home);
                      },
                    ),
                    const SizedBox(height: 22),
                    const _ContinueWithDivider(),
                    const SizedBox(height: 22),
                    const _GoogleButton(),
                    const SizedBox(height: 22),
                    const _SignupFooter(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── SCROLLABLE BODY ─────────────────────────────────────────────────────────

class _ScrollableBody extends StatelessWidget {
  final Widget child;

  const _ScrollableBody({required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: child,
          ),
        );
      },
    );
  }
}

// ─── TÍTULO ──────────────────────────────────────────────────────────────────

class _LoginTitle extends StatelessWidget {
  const _LoginTitle();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      children: [
        Text(
          'FAÇA LOGIN',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Entre para gerenciar seu clube',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colors.white,
            fontSize: 14,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }
}

// ─── EMAIL ───────────────────────────────────────────────────────────────────

class _EmailField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return TextField(
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: colors.textPrimary),
      decoration: InputDecoration(
        hintText: 'E-mail ou usuário',
        hintStyle: TextStyle(color: colors.muted),
        filled: true,
        fillColor: colors.card,
        prefixIcon: Icon(Icons.person, color: colors.muted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

// ─── SENHA ───────────────────────────────────────────────────────────────────

class _PasswordField extends StatelessWidget {
  const _PasswordField({required this.obscureText, required this.onToggle});

  final bool obscureText;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return TextField(
      obscureText: obscureText,
      style: TextStyle(color: colors.textPrimary),
      decoration: InputDecoration(
        hintText: 'Senha',
        hintStyle: TextStyle(color: colors.muted),
        filled: true,
        fillColor: colors.card,
        prefixIcon: Icon(Icons.lock, color: colors.muted),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: colors.muted,
          ),
          onPressed: onToggle,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

// ─── LEMBRAR / ESQUECEU ───────────────────────────────────────────────────────

class _RememberForgotRow extends StatelessWidget {
  const _RememberForgotRow({
    required this.rememberMe,
    required this.onRememberToggle,
  });

  final bool rememberMe;
  final VoidCallback onRememberToggle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      children: [
        GestureDetector(
          onTap: onRememberToggle,
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: rememberMe ? colors.accent : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: rememberMe ? colors.accent : colors.border,
                    width: 1.8,
                  ),
                ),
                child: rememberMe
                    ? Icon(Icons.check, size: 16, color: colors.onAccent)
                    : null,
              ),
              const SizedBox(width: 10),
              Text(
                'Lembrar meu acesso',
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(50, 30),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Esqueceu a senha?',
            style: TextStyle(
              color: colors.accent,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

// ─── BOTÃO ENTRAR ─────────────────────────────────────────────────────────────

class _LoginButton extends StatelessWidget {
  const _LoginButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.accent,
        foregroundColor: colors.onAccent,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.8,
        ),
      ),
      child: const Text('ENTRAR'),
    );
  }
}

// ─── DIVISOR ──────────────────────────────────────────────────────────────────

class _ContinueWithDivider extends StatelessWidget {
  const _ContinueWithDivider();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      children: [
        Expanded(child: Divider(color: colors.border, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'OU CONTINUE COM',
            style: TextStyle(
              color: colors.muted,
              fontSize: 12,
              letterSpacing: 1.4,
            ),
          ),
        ),
        Expanded(child: Divider(color: colors.border, thickness: 1)),
      ],
    );
  }
}

// ─── BOTÃO GOOGLE ─────────────────────────────────────────────────────────────

class _GoogleButton extends StatelessWidget {
  const _GoogleButton();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return OutlinedButton.icon(
      onPressed: () {},
      icon: SvgPicture.asset('assets/google_logo.svg', width: 20, height: 20),
      label: Text(
        'Google',
        style: TextStyle(
          color: colors.textPrimary,
          fontWeight: FontWeight.w700,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: colors.border, width: 1.4),
        backgroundColor: colors.card,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}

// ─── FOOTER CADASTRO ──────────────────────────────────────────────────────────

class _SignupFooter extends StatelessWidget {
  const _SignupFooter();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Center(
      child: TextButton(
        onPressed: () {},
        child: Text.rich(
          TextSpan(
            text: 'Não tem uma conta? ',
            style: TextStyle(color: colors.textSecondary, fontSize: 13),
            children: [
              TextSpan(
                text: 'Cadastre-se',
                style: TextStyle(
                  color: colors.accent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
