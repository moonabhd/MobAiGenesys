import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserProfile {
  final String name;
  final String firstName;
  final String email;
  final String phone;
  final DateTime dateOfBirth;
  final String gender;
  final String profileImage;

  const UserProfile({
    required this.name,
    required this.firstName,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.gender,
    required this.profileImage,
  });

  UserProfile copyWith({
    String? name,
    String? firstName,
    String? email,
    String? phone,
    DateTime? dateOfBirth,
    String? gender,
    String? profileImage,
  }) {
    return UserProfile(
      name: name ?? this.name,
      firstName: firstName ?? this.firstName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}

class ProfileInfoScreen extends StatefulWidget {
  final UserProfile profile;
  final Function(UserProfile) onProfileUpdate;

  const ProfileInfoScreen({
    Key? key,
    required this.profile,
    required this.onProfileUpdate,
  }) : super(key: key);

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  bool _isEditMode = false;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _firstNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  String _gender = '';
  DateTime? _dateOfBirth;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _nameController = TextEditingController(text: widget.profile.name);
    _firstNameController = TextEditingController(text: widget.profile.firstName);
    _emailController = TextEditingController(text: widget.profile.email);
    _phoneController = TextEditingController(text: widget.profile.phone);
    _gender = widget.profile.gender;
    _dateOfBirth = widget.profile.dateOfBirth;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _firstNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _handleProfileUpdate() {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedProfile = widget.profile.copyWith(
        name: _nameController.text,
        firstName: _firstNameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        dateOfBirth: _dateOfBirth,
        gender: _gender,
      );
      widget.onProfileUpdate(updatedProfile);
      setState(() => _isEditMode = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        actions: [
          if (!_isEditMode)
            TextButton(
              onPressed: () => setState(() => _isEditMode = true),
              child: const Text(
                'Edit',
                style: TextStyle(
                  color: Color(0xFF246BFD),
                  fontSize: 16,
                ),
              ),
            ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_isEditMode)
                _buildEditMode()
              else
                _buildViewMode(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditMode() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildProfileImageEdit(),
          Text(
            'Edit photo',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 32),
          _buildEditableInfoSection(),
          const SizedBox(height: 24),
          _buildDoneButton(),
        ],
      ),
    );
  }

  Widget _buildProfileImageEdit() {
    return CircleAvatar(
      radius: 50,
      backgroundImage: NetworkImage(widget.profile.profileImage),
      child: IconButton(
        icon: const Icon(Icons.camera_alt, color: Colors.white),
        onPressed: () {
          // Handle image edit
        },
      ),
    );
  }

  Widget _buildEditableInfoSection() {
    return Card(
      elevation: 0,
      color: Colors.grey[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(
              label: 'Name',
              controller: _nameController,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Name is required' : null,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Date of birth',
              readOnly: true,
              onTap: _showDatePicker,
              value: _dateOfBirth != null
                  ? 'Oct ${_dateOfBirth!.day}, ${_dateOfBirth!.year}'
                  : '',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Phone number',
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                _PhoneNumberFormatter(),
              ],
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Gender',
              readOnly: true,
              value: _gender,
              onTap: _showGenderPicker,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Email',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
            ),
            const SizedBox(height: 16),
            _buildPasswordSection(),
          ],
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  Widget _buildTextField({
    required String label,
    TextEditingController? controller,
    String? value,
    bool readOnly = false,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    VoidCallback? onTap,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[600]),
        border: const UnderlineInputBorder(),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      initialValue: controller == null ? value : null,
    );
  }

  Future<void> _showDatePicker() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() => _dateOfBirth = date);
    }
  }

  void _showGenderPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: ['Male', 'Female', 'Other']
            .map(
              (gender) => ListTile(
                title: Text(gender),
                onTap: () {
                  setState(() => _gender = gender);
                  Navigator.pop(context);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildPasswordSection() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: const Text('Password'),
      trailing: TextButton(
        onPressed: () {
          // Handle password change
        },
        child: Text(
          'Change Password',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildDoneButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _handleProfileUpdate,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF246BFD),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildViewMode() {
    return Column(
      children: [
        const SizedBox(height: 24),
        _buildProfileImage(),
        const SizedBox(height: 16),
        Text(
          widget.profile.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          widget.profile.email,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 32),
        _buildViewInfoSection(),
      ],
    );
  }

  Widget _buildProfileImage() {
    return CircleAvatar(
      radius: 50,
      backgroundImage: NetworkImage(widget.profile.profileImage),
    );
  }

  Widget _buildViewInfoSection() {
    return Card(
      elevation: 0,
      color: Colors.grey[50],
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildInfoTile('Name', widget.profile.name),
          _buildInfoTile(
            'Date of birth',
            'Oct ${widget.profile.dateOfBirth.day}, ${widget.profile.dateOfBirth.year}',
          ),
          _buildInfoTile('Phone number', widget.profile.phone),
          _buildInfoTile('Gender', widget.profile.gender),
          _buildInfoTile('Email', widget.profile.email),
          _buildPasswordTile(),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
        ),
      ),
      trailing: Text(
        value,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPasswordTile() {
    return ListTile(
      title: const Text('Password'),
      trailing: TextButton(
        onPressed: () {
          // Handle password change
        },
        child: Text(
          'Change Password',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}

class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty) return newValue;

    String formatted = '+1';
    String numbers = text.replaceAll(RegExp(r'\D'), '');

    if (numbers.length > 0) {
      formatted += '-${numbers.substring(0, numbers.length.clamp(0, 3))}';
    }
    if (numbers.length > 3) {
      formatted += '-${numbers.substring(3, numbers.length.clamp(3, 6))}';
    }
    if (numbers.length > 6) {
      formatted += '-${numbers.substring(6, numbers.length.clamp(6, 10))}';
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}