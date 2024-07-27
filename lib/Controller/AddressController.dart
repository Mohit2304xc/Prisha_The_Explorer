import 'package:prishathe/Controller/UserController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Model/AddressModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Widgets/API_Connection/API_connection.dart';
import '../Widgets/Animation/FullScreenLoader.dart';
import '../Widgets/network/NetworkManger.dart';
import '../Widgets/snackbar/Snackbar.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final address1 = TextEditingController();
  final address2 = TextEditingController();
  final phoneNumber = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  // final addressRepository = Get.put(AddressRepository());

  // Future<List<AddressModel>> getAllUserAddresses() async {
  //   try {
  //     final addresses = await addressRepository.fetchUserAddresses();
  //     // selectedAddress.value = addresses.firstWhere(
  //     //     (element) => element.selectedAddress,
  //     //     orElse: () => AddressModel.empty());
  //     return addresses;
  //   } catch (e) {
  //     SnackBars.ErrorSnackBar(
  //         title: 'Address not found.', message: e.toString());
  //     return [];
  //   }
  // }

  // Future selectAddress(AddressModel newSelectedAddress) async {
  //   try {
  //     print(selectedAddress.value.id);
  //     FullScreenLoader.openLoadingDialog('Processing your order',
  //         'assets/images/success/72462-check-register.json');
  //     print(selectedAddress.value.id);
  //     if (selectedAddress.value.id.isNotEmpty) {
  //       print(selectedAddress.value.id.runtimeType);
  //       await addressRepository.updateSelectedField(
  //           selectedAddress.value.id, false);
  //       print(selectedAddress.value.id);
  //     }
  //     print(selectedAddress.value.id);
  //     newSelectedAddress.selectedAddress = true;
  //     selectedAddress.value = newSelectedAddress;
  //     print(selectedAddress.value.id);
  //     await addressRepository.updateSelectedField(
  //         selectedAddress.value.id, true);
  //     print(selectedAddress.value.id);
  //     Get.to(()=>const CheckoutScreen());
  //     SnackBars.SuccessSnackBar(
  //         title: 'Address Selection Updated',
  //         message: 'The address selection has been updated successfully.');
  //     FullScreenLoader.stopLoading();
  //
  //
  //   } catch (e) {
  //     SnackBars.ErrorSnackBar(
  //         title: 'Error in selection', message: e.toString());
  //   } finally{
  //     FullScreenLoader.stopLoading();
  //   }
  // }

  Future<String> addAddress(AddressModel address) async {
    try {
      final body = {
        'user_id': address.userId,
        'billing_first_name': address.billingFirstName,
        'billing_last_name': address.billingLastName,
        'billing_address_1': address.billingAddress1,
        'billing_address_2': address.billingAddress2 ?? '',
        'billing_city': address.billingCity,
        'billing_state': address.billingState,
        'billing_country': address.billingCountry,
        'billing_postcode': address.billingPostcode,
        'billing_phone': address.billingPhone,
      };
      print(body);
      final response = await http.post(Uri.parse(API.userAddress), body: body);
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final responseData = json.decode(response.body);
          print(responseData);
          if (responseData['success'] == true) {
            SnackBars.SuccessSnackBar(
                message: 'Address added successfully',
                title: "Congratulations");
            return responseData['id'].toString();
          } else {
            throw 'Failed to add address: ${responseData['success']} ${responseData['message']}';
          }
        } else {
          throw 'Empty response body';
        }
      } else {
        throw 'Failed to add address: ${response.reasonPhrase}';
      }
    } catch (e) {
      print(e);
      throw 'Unable to add your address. Try again later ${e.toString()}';
    }
  }


  Future addNewAddresses() async {
    try {
      FullScreenLoader.openLoadingDialog('Storing Address...',
          'assets/images/success/141594-animation-of-docer.json');

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (!addressFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }
      final address = AddressModel(
        userId: UserController.instance.user.value.id,
        billingFirstName: firstName.text.trim(),
        billingLastName: lastName.text.trim(),
        billingAddress1: address1.text.trim(),
        billingAddress2: address2.text.trim(),
        billingCity: city.text.trim(),
        billingState: state.text.trim(),
        billingCountry: country.text.trim(),
        billingPostcode: postalCode.text.trim(),
        billingPhone: phoneNumber.text.trim(),
        id: '',
      );
      print(address);
      print(UserController.instance.user.value.id);

      final id = await addAddress(address);

      address.id = id;

      selectedAddress.value = address;
      // await selectAddress(address);

      FullScreenLoader.stopLoading();

      SnackBars.SuccessSnackBar(
          title: 'Congratulations',
          message: 'Your address has been saved successfully.');

      refreshData.toggle();

      resetFormFields();

      Navigator.of(Get.context!).pop();
    } catch (e) {
      FullScreenLoader.stopLoading();
      SnackBars.ErrorSnackBar(
          title: 'Address not found.', message: e.toString());
    }
  }

  // Future<dynamic> selectNewAddressPopup(BuildContext context) {
  //   return showModalBottomSheet(
  //     context: context,
  //     builder: (_) => SingleChildScrollView(
  //       child: Container(
  //         padding: const EdgeInsets.all(32),
  //         child: Column(
  //           children: [
  //             const SectionHeading(
  //               title: 'Select Address',
  //               showActionButton: false,
  //               textColor: Colors.black,
  //             ),
  //             const SizedBox(
  //               height: 16,
  //             ),
  //             FutureBuilder(
  //               future: getAllUserAddresses(),
  //               builder: (_, snapshot) {
  //                 final response = helper.checkMultiRecord(snapshot: snapshot);
  //                 if (response != null) return response;
  //
  //                 return ListView.builder(
  //                   itemBuilder: (_, index) => SingleAddress(
  //                     address: snapshot.data![index],
  //                     onTap: () async {
  //                       // await selectAddress(snapshot.data![index]);
  //                       selectedAddress.value = snapshot.data![index];
  //                       Get.back();
  //                     },
  //                   ),
  //                   shrinkWrap: true,
  //                   itemCount: snapshot.data!.length,
  //                 );
  //               },
  //             ),
  //             const SizedBox(
  //               height: 32,
  //             ),
  //             SizedBox(
  //               width: double.infinity,
  //               child: ElevatedButton(
  //                   onPressed: () => Get.to(() => const AddNewAddressScreen()),
  //                   child: const Text("Add new address")),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void resetFormFields() {
    firstName.clear();
    lastName.clear();
    address1.clear();
    address2.clear();
    postalCode.clear();
    phoneNumber.clear();
    state.clear();
    city.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}
