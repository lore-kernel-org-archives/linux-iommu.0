From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v2 01/40] iommu: Introduce Shared Virtual Addressing API
Date: Thu, 13 Sep 2018 07:26:30 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D191301D0A@SHSMSX101.ccr.corp.intel.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
	<20180511190641.23008-2-jean-philippe.brucker@arm.com>
	<bf42affd-e9d0-e4fc-6d28-f3c3f7795348@redhat.com>
	<03d31ba5-1eda-ea86-8c0c-91d14c86fe83@arm.com>
	<ed39159c-087e-7e56-7d29-d1de9fa1677f@amd.com>
	<f0b317d5-e2e9-5478-952c-05e8b97bd68b@arm.com>
	<2fd4a0a1-1a35-bf82-df84-b995cce011d9@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2fd4a0a1-1a35-bf82-df84-b995cce011d9-5C7GfCeVMHo@public.gmane.org>
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
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>
Cc: "xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "Raj,
	Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "robin.murphy-5wv7dgnIgG8@public.gmane.org" <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "rgummal-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <rgummal-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

PiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnDQo+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDcsIDIw
MTggNDo1NiBQTQ0KPiANCj4gNS4gSXQgd291bGQgYmUgbmljZSB0byBoYXZlIHRvIGFsbG9jYXRl
IG11bHRpcGxlIFBBU0lEcyBmb3IgdGhlIHNhbWUNCj4gcHJvY2VzcyBhZGRyZXNzIHNwYWNlLg0K
PiAgwqDCoMKgIMKgwqDCoCBFLmcuIHNvbWUgdGVhbXMgYXQgQU1EIHdhbnQgdG8gdXNlIGEgc2Vw
YXJhdGUgR1BVIGFkZHJlc3Mgc3BhY2UNCj4gZm9yIHRoZWlyIHVzZXJzcGFjZSBjbGllbnQgbGli
cmFyeS4gSSdtIHN0aWxsIHRyeWluZyB0byBhdm9pZCB0aGF0LCBidXQNCj4gaXQgaXMgcGVyZmVj
dGx5IHBvc3NpYmxlIHRoYXQgd2UgYXJlIGdvaW5nIHRvIG5lZWQgdGhhdC4NCj4gIMKgwqDCoCDC
oMKgwqAgQWRkaXRpb25hbCB0byB0aGF0IGl0IGlzIHNvbWV0aW1lcyBxdWl0ZSB1c2VmdWwgZm9y
IGRlYnVnZ2luZw0KPiB0byBpc29sYXRlIHdoZXJlIGV4YWN0bHkgYW4gaW5jb3JyZWN0IGFjY2Vz
cyAoc2VnZmF1bHQpIGlzIGNvbWluZyBmcm9tLg0KPiANCj4gTGV0IG1lIGtub3cgaWYgdGhlcmUg
YXJlIHNvbWUgcHJvYmxlbXMgd2l0aCB0aGF0LCBlc3BlY2lhbGx5IEkgd2FudCB0bw0KPiBrbm93
IGlmIHRoZXJlIGlzIHB1c2hiYWNrIG9uICM1IHNvIHRoYXQgSSBjYW4gZm9yd2FyZCB0aGF0IDop
DQo+IA0KDQpXZSBoYXZlIHNpbWlsYXIgcmVxdWlyZW1lbnQsIGV4Y2VwdCB0aGF0IGl0IGlzICJt
dWx0aXBsZSBQQVNJRHMgZm9yDQpzYW1lIHByb2Nlc3MiIGluc3RlYWQgb2YgImZvciBzYW1lIHBy
b2Nlc3MgYWRkcmVzcyBzcGFjZSIuDQoNCkludGVsIFZULWQgZ29lcyB0byBhICd0cnVlJyBzeXN0
ZW0td2lkZSBQQVNJRCBhbGxvY2F0aW9uIHBvbGljeSwgDQpjcm9zcyBib3RoIGhvc3QgcHJvY2Vz
c2VzIGFuZCBndWVzdCBwcm9jZXNzZXMuIEFzIEphY29iIGV4cGxhaW5zLA0KdGhlcmUgd2lsbCBi
ZSBhIHZpcnR1YWwgY21kIHJlZ2lzdGVyIG9uIHZpcnR1YWwgdnRkLCB0aHJvdWdoIHdoaWNoDQpn
dWVzdCBJT01NVSBkcml2ZXIgcmVxdWVzdHMgdG8gZ2V0IHN5c3RlbS13aWRlIFBBU0lEcyBhbGxv
Y2F0ZWQNCmJ5IGhvc3QgSU9NTVUgZHJpdmVyLg0KDQp3aXRoIHRoYXQgZGVzaWduLCBRZW11IHJl
cHJlc2VudHMgYWxsIGd1ZXN0IHByb2Nlc3NlcyBpbiBob3N0DQpzaWRlLCB0aHVzIHdpbGwgZ2V0
ICJtdWx0aXBsZSBQQVNJRHMgYWxsb2NhdGVkIGZvciBzYW1lIHByb2Nlc3MiLg0KSG93ZXZlciBp
bnN0ZWFkIG9mIGJpbmRpbmcgYWxsIFBBU0lEcyB0byBzYW1lIGhvc3QgYWRkcmVzcyBzcGFjZQ0K
b2YgIFFlbXUsIGVhY2ggb2YgUEFTSUQgZW50cnkgcG9pbnRzIHRvIGd1ZXN0IGFkZHJlc3Mgc3Bh
Y2UgaWYgDQp1c2VkIGJ5IGd1ZXN0IHByb2Nlc3MuDQoNClRoYW5rcw0KS2V2aW4NCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
