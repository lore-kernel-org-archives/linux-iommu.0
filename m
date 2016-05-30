From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [PATCH v2 4/6] iommu: Set PCI_BUS_FLAGS_MSI_REMAP on iommu driver
 initialization
Date: Mon, 30 May 2016 21:32:11 +0800
Message-ID: <201605301337.u4UDY4nb026772@mx0a-001b2d01.pphosted.com>
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

U29tZSBpb21tdSBkcml2ZXJzIHdvdWxkIGJlIGluaXRpYWxpemVkIGFmdGVyIFBDSSBkZXZpY2UK
ZW51bWVyYXRpb24uIFNvIFBDSV9CVVNfRkxBR1NfTVNJX1JFTUFQIHdvdWxkIG5vdCBiZSBzZXQK
d2hlbiBwcm9iaW5nIFBDSSBkZXZpY2VzIGFsdGhvdWdoIElPTU1VIGVuYWJsZXMgY2FwYWJpbGl0
eQpvZiBJUlEgcmVtYXBwaW5nLiBUaGlzIHBhdGNoIHRlc3RzIHRoaXMgY2FwYWJpbGl0eSBhbmQK
c2V0IHRoZSBmbGFnIHdoZW4gaW9tbXUgZHJpdmVyIGlzIGluaXRpYWxpemVkLgoKU2lnbmVkLW9m
Zi1ieTogWW9uZ2ppIFhpZSA8eHlqeGllQGxpbnV4LnZuZXQuaWJtLmNvbT4KLS0tCiBkcml2ZXJz
L2lvbW11L2lvbW11LmMgfCAgICA4ICsrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pb21tdS5jIGIvZHJpdmVycy9pb21t
dS9pb21tdS5jCmluZGV4IGI5ZGYxNDEuLmU2MTU5YWIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW9t
bXUvaW9tbXUuYworKysgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMKQEAgLTg3Miw2ICs4NzIsMTQg
QEAgc3RhdGljIGludCBhZGRfaW9tbXVfZ3JvdXAoc3RydWN0IGRldmljZSAqZGV2LCB2b2lkICpk
YXRhKQogCWNvbnN0IHN0cnVjdCBpb21tdV9vcHMgKm9wcyA9IGNiLT5vcHM7CiAJaW50IHJldDsK
IAorCS8qCisJICogU2V0IFBDSV9CVVNfRkxBR1NfTVNJX1JFTUFQIGZvciBhbGwgUENJIGJ1c2Vz
IHdoZW4gSU9NTVUKKwkgKiBoYXZlIGNhcGFiaWxpdHkgb2YgSVJRIHJlbWFwcGluZy4KKwkgKi8K
KwlpZiAoZGV2X2lzX3BjaShkZXYpICYmIG9wcy0+Y2FwYWJsZSAmJgorCQkJb3BzLT5jYXBhYmxl
KElPTU1VX0NBUF9JTlRSX1JFTUFQKSkKKwkJdG9fcGNpX2RldihkZXYpLT5idXMtPmJ1c19mbGFn
cyB8PSBQQ0lfQlVTX0ZMQUdTX01TSV9SRU1BUDsKKwogCWlmICghb3BzLT5hZGRfZGV2aWNlKQog
CQlyZXR1cm4gMDsKIAotLSAKMS43LjkuNQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXhwcGMtZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZA
bGlzdHMub3psYWJzLm9yZwpodHRwczovL2xpc3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhw
cGMtZGV2
