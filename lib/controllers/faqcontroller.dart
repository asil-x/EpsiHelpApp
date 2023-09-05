import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epsihelp_app/models/faq.dart';
import 'package:get/state_manager.dart';

class FAQController extends GetxController {
  RxBool isLoading = false.obs;
  List<FAQ> faqs = <FAQ>[];
  @override
  void onInit() {
    getFaqsFromFirebase();
    super.onInit();
  }

  void getFaqsFromFirebase() async {
    isLoading.value = true;

    FirebaseFirestore.instance
        .collection('faqs')
        .get()
        .then((QuerySnapshot querySnapshot) {
      faqs = [];
      update();
      if (querySnapshot.docs.isNotEmpty) {
        for (var snap in querySnapshot.docs) {
          FAQ faq = FAQ.fromMap(snap.data() as Map<String, dynamic>);
          faqs.add(faq);
          update();
        }
      }
      isLoading.value = false;
    });
  }

  Future<bool> deleteFAQFromFirebase(FAQ faq) async {
    bool ans = true;
    isLoading.value = true;
    final collectionReference = FirebaseFirestore.instance.collection('faqs');

    final querySnapshot =
        await collectionReference.where('faqid', isEqualTo: faq.faqId).get();
    for (final documentSnapshot in querySnapshot.docs) {
      await documentSnapshot.reference.delete().onError((error, stackTrace) {
        ans = false;
      });
    }
    isLoading.value = false;
    getFaqsFromFirebase();
    return ans;
  }

  Future<bool> saveFAQInFirebase(FAQ faq) async {
    bool ans = true;
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('faqs')
        .where('faqid', isEqualTo: faq.faqId)
        .get();
    for (DocumentSnapshot<Map<String, dynamic>> docSnapshot in snapshot.docs) {
      await docSnapshot.reference.update(faq.toMap()).whenComplete(() {
        getFaqsFromFirebase();
      }).catchError((error) {
        ans = false;
      });
    }
    return ans;
  }

  Future<bool> addFAQInFirebase(FAQ faq) async {
    bool ans = true;
    isLoading.value = true;
    FirebaseFirestore.instance
        .collection('faqs')
        .add(faq.toMap())
        .whenComplete(() {
      ans = true;
      isLoading.value = false;
      getFaqsFromFirebase();
      // ignore: body_might_complete_normally_catch_error
    }).catchError((error) {
      ans = false;
    });
    return ans;
  }
}
