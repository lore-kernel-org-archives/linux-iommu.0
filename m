From: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v4 06/12] iommu/vt-d: Add second level page table
 interface
Date: Thu, 8 Nov 2018 04:00:20 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D60506@SHSMSX104.ccr.corp.intel.com>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
 <20181105053151.7173-7-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D5FB11@SHSMSX104.ccr.corp.intel.com>
 <e987773c-a547-01e4-a04f-1f34506420ac@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e987773c-a547-01e4-a04f-1f34506420ac@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "peterx@redhat.com" <peterx@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

SGksDQoNCj4gRnJvbTogTHUgQmFvbHUgW21haWx0bzpiYW9sdS5sdUBsaW51eC5pbnRlbC5jb21d
DQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciA4LCAyMDE4IDEwOjI4IEFNDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjQgMDYvMTJdIGlvbW11L3Z0LWQ6IEFkZCBzZWNvbmQgbGV2ZWwgcGFnZSB0
YWJsZSBpbnRlcmZhY2UNCj4gDQo+IEhpLA0KPiANCj4gT24gMTEvNy8xOCAzOjEzIFBNLCBMaXUs
IFlpIEwgd3JvdGU6DQo+ID4gSGkgQmFvbHUsDQo+ID4NCj4gPj4gRnJvbTogTHUgQmFvbHUgW21h
aWx0bzpiYW9sdS5sdUBsaW51eC5pbnRlbC5jb21dDQo+ID4+IFNlbnQ6IE1vbmRheSwgTm92ZW1i
ZXIgNSwgMjAxOCAxOjMyIFBNDQo+ID4+DQo+ID4+IFRoaXMgYWRkcyB0aGUgaW50ZXJmYWNlcyB0
byBzZXR1cCBvciB0ZWFyIGRvd24gdGhlIHN0cnVjdHVyZXMgZm9yDQo+ID4+IHNlY29uZCBsZXZl
bCBwYWdlIHRhYmxlIHRyYW5zbGF0aW9ucy4gVGhpcyBpbmNsdWRlcyB0eXBlcyBvZiBzZWNvbmQN
Cj4gPj4gbGV2ZWwgb25seSB0cmFuc2xhdGlvbiBhbmQgcGFzcyB0aHJvdWdoLg0KPiA+DQo+ID4g
QSBsaXR0bGUgYml0IHJlZmluaW5nIHRvIHRoZSBkZXNjcmlwdGlvbjopICJUaGlzIHBhdGNoIGFk
ZHMgaW50ZXJmYWNlcw0KPiA+IGZvciBzZXR1cCBvciB0ZWFyIGRvd24gc2Vjb25kIGxldmVsIHRy
YW5zbGF0aW9uIGluIFBBU0lEIGdyYW51bGFyaXR5Lg0KPiA+IFRyYW5zbGF0aW9uIHR5cGUgaW5j
bHVkZXMgc2Vjb25kIGxldmVsIG9ubHkgdHlwZSBhbmQgcGFzcy10aHJvdWdoDQo+ID4gdHlwZS4i
DQo+ID4NCj4gPj4gQ2M6IEFzaG9rIFJhaiA8YXNob2sucmFqQGludGVsLmNvbT4NCj4gPj4gQ2M6
IEphY29iIFBhbiA8amFjb2IuanVuLnBhbkBsaW51eC5pbnRlbC5jb20+DQo+ID4+IENjOiBLZXZp
biBUaWFuIDxrZXZpbi50aWFuQGludGVsLmNvbT4NCj4gPj4gQ2M6IExpdSBZaSBMIDx5aS5sLmxp
dUBpbnRlbC5jb20+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFNhbmpheSBLdW1hciA8c2FuamF5Lmsu
a3VtYXJAaW50ZWwuY29tPg0KPiA+DQo+ID4gWy4uLl0NCj4gPg0KPiA+PiArDQo+ID4+ICt2b2lk
IGludGVsX3Bhc2lkX3RlYXJfZG93bl9lbnRyeShzdHJ1Y3QgaW50ZWxfaW9tbXUgKmlvbW11LA0K
PiA+PiArCQkJCSBzdHJ1Y3QgZGV2aWNlICpkZXYsIGludCBwYXNpZCkNCj4gPj4gK3sNCj4gPj4g
KwlzdHJ1Y3QgcGFzaWRfZW50cnkgKnB0ZTsNCj4gPg0KPiA+IHB0ZSBpcyBjb25mdXNpbmcgYXMg
aXQgaXMgc2ltaWxhciB3aXRoIHB0ZSBpbiBwYWdpbmcgc3RydWN0dXJlcy4gbWF5DQo+ID4gdXNl
IHB0X2VudHJ5IG9yIGp1c3QgcGFzaWRfZW50cnkuIFRoaXMgY29tbWVudCBhcHBsaWVzIHRvIG90
aGVyICJwdGUicw0KPiA+IGluIHRoaXMgcGF0Y2guDQo+IA0KPiAicHRlIiBpbiB0aGlzIGZpbGUg
bWVhbnMgInBhc2lkIHRhYmxlIGVudHJ5Iiwgbm90ICJwYWdlIHRhYmxlIGVudHJ5Ii4NCj4gVGhp
cyBmaWxlIGhvbGRzIGNvZGUgdG8gaGFuZGxlIHBhc2lkIHRhYmxlIHJlbGF0ZWQgc3RhZmYuIEl0
IGhhcyBub3RoaW5nIHRvIGRvIHdpdGgNCj4gcGFnaW5nIHN0cnVjdHVyZS4gSSB0aGluayB0aGVy
ZSBzaG91bGQgYmUgbm8gY29uZnVzaW9uIGhlcmUuDQo+IDotKQ0KDQpJIHNlZS4gVGhlbiB1cCB0
byB5b3UuIDopIEl0J3MganVzdCBteSBmZWVsaW5nIHdoZW4gcmVhZGluZyB0aGUgcGF0Y2gsIGl0
IGxlYWRzIG1lIHRvDQpiZWxpZXZlIGl0IGlzIHBhZ2luZyBzdHJ1Y3R1cmUuDQoNClJlZ2FyZHMs
DQpZaSBMaXUNCg==
