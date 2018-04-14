From: "Mehta, Sohil" <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
	AMD IOMMU
Date: Sat, 14 Apr 2018 00:08:55 +0000
Message-ID: <1523664612.2747.13.camel@intel.com>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
	<152302067362.47565.628887796165116844.stgit@sosxen2.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <152302067362.47565.628887796165116844.stgit-tq90VzyE+wXkLsZ8J5Uweg@public.gmane.org>
Content-Language: en-US
Content-ID: <CF21F5DFCD25FD46A7289FE14D9FBEAD-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "gary.hook-5C7GfCeVMHo@public.gmane.org" <gary.hook-5C7GfCeVMHo@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gRnJpLCAyMDE4LTA0LTA2IGF0IDA4OjE3IC0wNTAwLCBHYXJ5IFIgSG9vayB3cm90ZToNCj7C
oA0KPiArDQo+ICt2b2lkIGFtZF9pb21tdV9kZWJ1Z2ZzX3NldHVwKHN0cnVjdCBhbWRfaW9tbXUg
KmlvbW11KQ0KPiArew0KPiArCWNoYXIgbmFtZVtNQVhfTkFNRV9MRU4gKyAxXTsNCj4gKwlzdHJ1
Y3QgZGVudHJ5ICpkX3RvcDsNCj4gKw0KPiArCWlmICghZGVidWdmc19pbml0aWFsaXplZCgpKQ0K
DQpQcm9iYWJseSBub3QgbmVlZGVkLg0KDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCW11dGV4X2xv
Y2soJmFtZF9pb21tdV9kZWJ1Z2ZzX2xvY2spOw0KPiArCWlmICghYW1kX2lvbW11X2RlYnVnZnMp
IHsNCj4gKwkJZF90b3AgPSBpb21tdV9kZWJ1Z2ZzX3NldHVwKCk7DQo+ICsJCWlmIChkX3RvcCkN
Cj4gKwkJCWFtZF9pb21tdV9kZWJ1Z2ZzID0NCj4gZGVidWdmc19jcmVhdGVfZGlyKCJhbWQiLCBk
X3RvcCk7DQo+ICsJfQ0KPiArCW11dGV4X3VubG9jaygmYW1kX2lvbW11X2RlYnVnZnNfbG9jayk7
DQoNCg0KWW91IGNhbiBkbyB0aGUgYWJvdmUgb25seSBvbmNlIGlmIHlvdSBpdGVyYXRlIG92ZXIg
dGhlIElPTU1VcyBoZXJlDQrCoGluc3RlYWQgb2YgZG9pbmcgaXQgaW7CoGFtZF9pb21tdV9pbml0
Lg0KDQo+ICsJaWYgKGFtZF9pb21tdV9kZWJ1Z2ZzKSB7DQo+ICsJCXNucHJpbnRmKG5hbWUsIE1B
WF9OQU1FX0xFTiwgImlvbW11JTAyZCIsIGlvbW11LQ0KPiA+aW5kZXgpOw0KPiArCQlpb21tdS0+
ZGVidWdmcyA9IGRlYnVnZnNfY3JlYXRlX2RpcihuYW1lLA0KPiArCQkJCQkJwqDCoMKgwqBhbWRf
aW9tbXVfZGVidWdmDQo+IHMpOw0KPiArCQlpZiAoIWlvbW11LT5kZWJ1Z2ZzKSB7DQo+ICsJCQlk
ZWJ1Z2ZzX3JlbW92ZV9yZWN1cnNpdmUoYW1kX2lvbW11X2RlYnVnZnMpOw0KPiArCQkJYW1kX2lv
bW11X2RlYnVnZnMgPSBOVUxMOw0KPiArCQl9DQo+ICsJfQ0KPiArfQ0KDQotU29oaWwKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
