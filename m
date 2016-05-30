From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [PATCH v2 5/6] pci-ioda: Set PCI_BUS_FLAGS_MSI_REMAP for IODA host
 bridge
Date: Mon, 30 May 2016 21:32:12 +0800
Message-ID: <201605301337.u4UDY6Nw030482@mx0a-001b2d01.pphosted.com>
References: <1464615133-12050-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1464615133-12050-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org
Cc: alistair@popple.id.au, nikunj@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com, eric.auger@linaro.org, aik@ozlabs.ru, joro@8bytes.org, will.deacon@arm.com, gwshan@linux.vnet.ibm.com, kevin.tian@intel.com, warrier@linux.vnet.ibm.com, alex.williamson@redhat.com, David.Laight@ACULAB.COM, paulus@samba.org, bhelgaas@google.com
List-Id: iommu@lists.linux-foundation.org

QW55IElPREEgaG9zdCBicmlkZ2UgaGF2ZSB0aGUgY2FwYWJpbGl0eSBvZiBJUlEgcmVtYXBwaW5n
LgpTbyB3ZSBzZXQgUENJX0JVU19GTEFHU19NU0lfUkVNQVAgd2hlbiB0aGlzIGtpbmQgb2YgaG9z
dCBiaXJkZ2UKaXMgZGV0ZWN0ZWQuCgpTaWduZWQtb2ZmLWJ5OiBZb25namkgWGllIDx4eWp4aWVA
bGludXgudm5ldC5pYm0uY29tPgpSZXZpZXdlZC1ieTogQWxleGV5IEthcmRhc2hldnNraXkgPGFp
a0BvemxhYnMucnU+Ci0tLQogYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L3BjaS1pb2Rh
LmMgfCAgICA4ICsrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L3BjaS1pb2RhLmMgYi9hcmNo
L3Bvd2VycGMvcGxhdGZvcm1zL3Bvd2VybnYvcGNpLWlvZGEuYwppbmRleCBjNWJhYWYzLi45MDEx
MjY4IDEwMDY0NAotLS0gYS9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bvd2VybnYvcGNpLWlvZGEu
YworKysgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bvd2VybnYvcGNpLWlvZGEuYwpAQCAtMzA5
NCw2ICszMDk0LDEyIEBAIHN0YXRpYyB2b2lkIHBudl9wY2lfaW9kYV9maXh1cCh2b2lkKQogCXBu
dl9ucHVfaW9kYV9maXh1cCgpOwogfQogCitpbnQgcG52X3BjaV9pb2RhX3Jvb3RfYnJpZGdlX3By
ZXBhcmUoc3RydWN0IHBjaV9ob3N0X2JyaWRnZSAqYnJpZGdlKQoreworCWJyaWRnZS0+YnVzLT5i
dXNfZmxhZ3MgfD0gUENJX0JVU19GTEFHU19NU0lfUkVNQVA7CisJcmV0dXJuIDA7Cit9CisKIC8q
CiAgKiBSZXR1cm5zIHRoZSBhbGlnbm1lbnQgZm9yIEkvTyBvciBtZW1vcnkgd2luZG93cyBmb3Ig
UDJQCiAgKiBicmlkZ2VzLiBUaGF0IGFjdHVhbGx5IGRlcGVuZHMgb24gaG93IFBFcyBhcmUgc2Vn
bWVudGVkLgpAQCAtMzM5NSw2ICszNDAxLDggQEAgc3RhdGljIHZvaWQgX19pbml0IHBudl9wY2lf
aW5pdF9pb2RhX3BoYihzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLAogCSAqLwogCXBwY19tZC5wY2li
aW9zX2ZpeHVwID0gcG52X3BjaV9pb2RhX2ZpeHVwOwogCisJcHBjX21kLnBjaWJpb3Nfcm9vdF9i
cmlkZ2VfcHJlcGFyZSA9IHBudl9wY2lfaW9kYV9yb290X2JyaWRnZV9wcmVwYXJlOworCiAJaWYg
KHBoYi0+dHlwZSA9PSBQTlZfUEhCX05QVSkKIAkJaG9zZS0+Y29udHJvbGxlcl9vcHMgPSBwbnZf
bnB1X2lvZGFfY29udHJvbGxlcl9vcHM7CiAJZWxzZQotLSAKMS43LjkuNQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMtZGV2IG1haWxpbmcg
bGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xpc3RzLm96bGFicy5v
cmcvbGlzdGluZm8vbGludXhwcGMtZGV2
