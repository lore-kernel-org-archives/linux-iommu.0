From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [PATCH v2 3/6] PCI: Set PCI_BUS_FLAGS_MSI_REMAP if IOMMU have
 capability of IRQ remapping
Date: Mon, 30 May 2016 21:32:10 +0800
Message-ID: <201605301338.u4UDY6mp030448@mx0a-001b2d01.pphosted.com>
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

VGhlIGNhcGFiaWxpdHkgb2YgSVJRIHJlbWFwcGluZyBpcyBhYnN0cmFjdGVkIG9uIElPTU1VIHNp
ZGUgb24Kc29tZSBhcmNocy4gVGhlcmUgaXMgYSBleGlzdGluZyBmbGFnIElPTU1VX0NBUF9JTlRS
X1JFTUFQIGZvciB0aGlzLgoKVG8gaGF2ZSBhIHVuaXZlcnNhbCBmbGFnIHRvIHRlc3QgdGhpcyBj
YXBhYmlsaXR5IGZvciBkaWZmZXJlbnQKYXJjaHMgb24gUENJIHNpZGUsIHdlIHNldCBQQ0lfQlVT
X0ZMQUdTX01TSV9SRU1BUCBmb3IgUENJIGJ1c2VzCndoZW4gSU9NTVVfQ0FQX0lOVFJfUkVNQVAg
aXMgc2V0LgoKU2lnbmVkLW9mZi1ieTogWW9uZ2ppIFhpZSA8eHlqeGllQGxpbnV4LnZuZXQuaWJt
LmNvbT4KLS0tCiBkcml2ZXJzL3BjaS9wcm9iZS5jIHwgICAgNCArKysrCiAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcHJvYmUuYyBiL2Ry
aXZlcnMvcGNpL3Byb2JlLmMKaW5kZXggMmI5ZTNiYS4uMTVhMzNlMiAxMDA2NDQKLS0tIGEvZHJp
dmVycy9wY2kvcHJvYmUuYworKysgYi9kcml2ZXJzL3BjaS9wcm9iZS5jCkBAIC0xNiw2ICsxNiw3
IEBACiAjaW5jbHVkZSA8bGludXgvYWVyLmg+CiAjaW5jbHVkZSA8bGludXgvYWNwaS5oPgogI2lu
Y2x1ZGUgPGxpbnV4L2lycWRvbWFpbi5oPgorI2luY2x1ZGUgPGxpbnV4L2lvbW11Lmg+CiAjaW5j
bHVkZSAicGNpLmgiCiAKICNkZWZpbmUgQ0FSREJVU19MQVRFTkNZX1RJTUVSCTE3NgkvKiBzZWNv
bmRhcnkgbGF0ZW5jeSB0aW1lciAqLwpAQCAtMjE2MCw2ICsyMTYxLDkgQEAgc3RydWN0IHBjaV9i
dXMgKnBjaV9jcmVhdGVfcm9vdF9idXMoc3RydWN0IGRldmljZSAqcGFyZW50LCBpbnQgYnVzLAog
CXBjaV9zZXRfYnVzX29mX25vZGUoYik7CiAJcGNpX3NldF9idXNfbXNpX2RvbWFpbihiKTsKIAor
CWlmIChpb21tdV9jYXBhYmxlKCZwY2lfYnVzX3R5cGUsIElPTU1VX0NBUF9JTlRSX1JFTUFQKSkK
KwkJYi0+YnVzX2ZsYWdzIHw9IFBDSV9CVVNfRkxBR1NfTVNJX1JFTUFQOworCiAJaWYgKCFwYXJl
bnQpCiAJCXNldF9kZXZfbm9kZShiLT5icmlkZ2UsIHBjaWJ1c190b19ub2RlKGIpKTsKIAotLSAK
MS43LjkuNQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXhwcGMtZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpo
dHRwczovL2xpc3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2
