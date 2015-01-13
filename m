From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [v3 13/26] KVM: Define a new interface kvm_find_dest_vcpu() for
	VT-d PI
Date: Tue, 13 Jan 2015 00:27:59 +0000
Message-ID: <E959C4978C3B6342920538CF579893F002341102@SHSMSX104.ccr.corp.intel.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
	<1418397300-10870-14-git-send-email-feng.wu@intel.com>
	<20150109145435.GA22469@potion.brq.redhat.com>
	<54AFEC00.80507@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <54AFEC00.80507-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, =?utf-8?B?UmFkaW0gS3I/bcOhPw==?= <rkrcmar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQm9uemluaSBb
bWFpbHRvOnBib256aW5pQHJlZGhhdC5jb21dDQo+IFNlbnQ6IEZyaWRheSwgSmFudWFyeSAwOSwg
MjAxNSAxMDo1NiBQTQ0KPiBUbzogUmFkaW0gS3LEjW3DocWZOyBXdSwgRmVuZw0KPiBDYzogdGds
eEBsaW51dHJvbml4LmRlOyBtaW5nb0ByZWRoYXQuY29tOyBocGFAenl0b3IuY29tOyB4ODZAa2Vy
bmVsLm9yZzsNCj4gZ2xlYkBrZXJuZWwub3JnOyBkd213MkBpbmZyYWRlYWQub3JnOyBqb3JvQDhi
eXRlcy5vcmc7DQo+IGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tOyBqaWFuZy5saXVAbGludXgu
aW50ZWwuY29tOyBlcmljLmF1Z2VyQGxpbmFyby5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOw0KPiBrdm1Admdlci5r
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbdjMgMTMvMjZdIEtWTTogRGVmaW5lIGEgbmV3IGlu
dGVyZmFjZSBrdm1fZmluZF9kZXN0X3ZjcHUoKSBmb3INCj4gVlQtZCBQSQ0KPiANCj4gDQo+IA0K
PiBPbiAwOS8wMS8yMDE1IDE1OjU0LCBSYWRpbSBLcsSNbcOhxZkgd3JvdGU6DQo+ID4gVGhlcmUg
YXJlIHR3byBwb2ludHMgcmVsZXZhbnQgdG8gdGhpcyBwYXRjaCBpbiBuZXcgS1ZNJ3MgaW1wbGVt
ZW50YXRpb24sDQo+ID4gKCJLVk06IHg4NjogYW1lbmQgQVBJQyBsb3dlc3QgcHJpb3JpdHkgYXJi
aXRyYXRpb24iLA0KPiA+ICBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxNS8xLzkvMzYyKQ0KPiA+
DQo+ID4gMSkgbG93ZXN0IHByaW9yaXR5IGRlcGVuZHMgb24gVFBSDQo+ID4gMikgdGhlcmUgaXMg
bm8gbmVlZCBmb3IgYmFsYW5jaW5nDQo+ID4NCj4gPiAoMSkgaGFzIHRvIGJlIGNvbnNpZGVyZWQg
d2l0aCBQSSBhcyB3ZWxsLg0KPiANCj4gVGhlIGNoaXBzZXQgZG9lc24ndCBzdXBwb3J0IGl0LiA6
KA0KPiANCj4gPiBJIGtlcHQgKDIpIHRvIGF2b2lkIHdoaW5pbmcgZnJvbSBwZW9wbGUgYnVpbGRp
bmcgb24gdGhhdCBiZWhhdmlvdXIsIGJ1dA0KPiA+IGxvd2VzdCBwcmlvcml0eSBiYWNrZWQgYnkg
UEkgY291bGQgYmUgdHJhbnNwYXJlbnQgd2l0aG91dCBpdC4NCj4gPg0KPiA+IFBhdGNoIGJlbG93
IHJlbW92ZXMgdGhlIGJhbGFuY2luZywgYnV0IEkgYW0gbm90IHN1cmUgdGhpcyBpcyBhIHByaWNl
IHdlDQo+ID4gYWxsb3dlZCBvdXJzZWx2ZXMgdG8gcGF5IC4uLiB3aGF0IGFyZSB5b3VyIG9waW5p
b25zPw0KPiANCj4gSSB3b3VsZG4ndCBtaW5kLCBidXQgaXQgcmVxdWlyZXMgYSBsb3Qgb2YgYmVu
Y2htYXJraW5nLg0KDQpJbiBmYWN0LCB0aGUgcmVhbCBoYXJkd2FyZSBtYXkgZG8gbG93ZXN0IHBy
aW9yaXR5IGluIHJvdW5kIHJvYmluIHdheSwgdGhlIG5ldw0KaGFyZHdhcmUgZXZlbiBkb2Vzbid0
IGNvbnNpZGVyIHRoZSBUUFIgZm9yIGxvd2VzdCBwcmlvcml0eSBpbnRlcnJ1cHRzIGRlbGl2ZXJ5
Lg0KDQpBcyBkaXNjdXNzZWQgd2l0aCBQYW9sbyBiZWZvcmUsIEkgd2lsbCBzdWJtaXQgYSBwYXRj
aCB0byBzdXBwb3J0IGxvd2VzdCBwcmlvcml0eSBmb3IgUEkNCmFmdGVyIHRoaXMgc2VyaWVzIGlz
IG1lcmdlZC4NCg0KVGhhbmtzLA0KRmVuZw0KDQo+IA0KPiBQYW9sbw0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
