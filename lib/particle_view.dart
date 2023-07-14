import 'package:flutter/material.dart';
import 'package:make_source/particle_animation.dart';

class ParticleView extends StatefulWidget {
  const ParticleView({super.key});

  @override
  State<ParticleView> createState() => _ParticleViewState();
}

class _ParticleViewState extends State<ParticleView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ParticleAnimation(),
    );
  }
}
