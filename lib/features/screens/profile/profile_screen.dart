import 'package:ecommerceapp/features/screens/profile/bloc/profile_bloc.dart';
import 'package:ecommerceapp/features/screens/profile/bloc/profile_event.dart';
import 'package:ecommerceapp/features/screens/profile/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();

  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.close : Icons.edit),
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),

      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },

        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProfileUpdatingLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfileLoaded || state is ProfileUpdated) {
            final user = state is ProfileLoaded ? state.profileData : (state as ProfileUpdated).updatedProfile;

            if (firstNameController.text.isEmpty) {
              firstNameController.text = user.firstName ?? "";
              lastNameController.text = user.lastName ?? "";
              phoneController.text = user.phone ?? "";
              cityController.text = user.city ?? "";
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    /// PROFILE CARD
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 36,
                            child: Icon(Icons.person, size: 40),
                          ),
                          const SizedBox(height: 20),

                          _buildField(
                            controller: firstNameController,
                            label: "First Name",
                            enabled: isEditing,
                          ),

                          _buildField(
                            controller: lastNameController,
                            label: "Last Name",
                            enabled: isEditing,
                          ),

                          _buildField(
                            controller: phoneController,
                            label: "Phone",
                            enabled: isEditing,
                          ),

                          _buildField(
                            controller: cityController,
                            label: "City",
                            enabled: isEditing,
                          ),

                          const SizedBox(height: 20),

                          if (isEditing)
                            SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<ProfileBloc>().add(
                                      UpdateProfile(
                                        firstName: firstNameController.text.trim(),
                                        lastName: lastNameController.text.trim(),
                                        phone: phoneController.text.trim(),
                                        city: cityController.text.trim(),
                                      ),
                                    );
                                  }
                                },
                                child: const Text("Save Changes",style: TextStyle(color: Colors.white)  ,),
                              ),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// LOGOUT
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade50,
                        ),
                        onPressed: () {
                          context.go('/login');
                        },
                        child: const Text(
                          "Logout",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required bool enabled,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter $label";
          }
          return null;
        },
      ),
    );
  }
}
