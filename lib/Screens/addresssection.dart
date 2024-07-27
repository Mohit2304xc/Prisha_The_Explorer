import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../Controller/AddressController.dart';
import '../Widgets/Circular_container/RoundedContainer.dart';
import '../Widgets/Validator/Validator.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key, required this.wantSaveButton});

  final bool wantSaveButton;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return RoundedContainer(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.firstName,
                        validator: (value) =>
                            Validators.validateEmptyText('First Name', value),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.user),
                            labelText: 'First Name'),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: controller.lastName,
                        validator: (value) =>
                            Validators.validateEmptyText('Last Name', value),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.user),
                            labelText: 'Last Name'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.phoneNumber,
                        validator: (value) =>
                            Validators.validatePhoneNumber(value),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            labelText: 'Phone Number'),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: controller.postalCode,
                        validator: (value) =>
                            Validators.validateEmptyText("Postal Code", value),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(FontAwesomeIcons.locationPin),
                            labelText: 'Postal Code'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: controller.address1,
                  validator: (value) =>
                      Validators.validateEmptyText('Address 1', value),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.building_31),
                      labelText: 'Address 1'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: controller.address2,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.building_31),
                      labelText: 'Address 2'),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: (value) =>
                            Validators.validateEmptyText('City', value),
                        controller: controller.city,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.building),
                            labelText: 'City'),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextFormField(
                        validator: (value) =>
                            Validators.validateEmptyText('State', value),
                        controller: controller.state,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.activity),
                            labelText: 'State'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  validator: (value) =>
                      Validators.validateEmptyText('Country', value),
                  controller: controller.country,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.global), labelText: 'Country'),
                ),
                const SizedBox(
                  height: 24,
                ),
                wantSaveButton
                    ? SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              controller.addNewAddresses();
                            },
                            child: const Text('Save')),
                      )
                    : const SizedBox(
                        height: 10,
                        width: 10,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
