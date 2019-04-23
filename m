From: Thomas Hellstrom <thellstrom@vmware.com>
Subject: Re: revert dma direct internals abuse
Date: Tue, 23 Apr 2019 12:26:05 +0000
Message-ID: <a5643cb106797f7079c70d63f5031bdc01259bb0.camel@vmware.com>
References: <20190408105525.5493-1-hch@lst.de>
         <7d5f35da4a6b58639519f0764c7edbfe4dd1ba02.camel@vmware.com>
         <20190409095740.GE6827@lst.de>
         <5f0837ffc135560c764c38849eead40269cebb48.camel@vmware.com>
         <20190409133157.GA10876@lst.de>
         <466e658c73607fca5112d718972e87c0b78653ad.camel@vmware.com>
         <20190409152538.GA12816@lst.de>
         <da06614b308500392c179651ef9c6fb835ee4045.camel@vmware.com>
         <20190410064359.GC5543@lst.de>
         <0c897b24b234f8d42ef597dbe31fa8293519a4b2.camel@vmware.com>
         <20190422175623.GA32411@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190422175623.GA32411@lst.de>
Content-Language: en-US
Content-ID: <115D6E66AC3ABA42801EEC939502B6AF@namprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "hch@lst.de" <hch@lst.de>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Deepak Singh Rawat <drawat@vmware.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

SGksIENocmlzdG9waCwNCg0KT24gTW9uLCAyMDE5LTA0LTIyIGF0IDE5OjU2ICswMjAwLCBoY2hA
bHN0LmRlIHdyb3RlOg0KPiBPbiBXZWQsIEFwciAxMCwgMjAxOSBhdCAwMzowMToxNFBNICswMDAw
LCBUaG9tYXMgSGVsbHN0cm9tIHdyb3RlOg0KPiA+ID4gU28gY2FuIHlvdSBwbGVhc2UgcmVzcGlu
IGEgdmVyc2lvbiBhY2NlcHRhYmxlIHRvIHlvdSBhbmQgc3VibWl0DQo+ID4gPiBpdA0KPiA+ID4g
Zm9yIDUuMSBBU0FQPyAgT3RoZXJ3aXNlIEknbGwgbmVlZCB0byBtb3ZlIGFoZWFkIHdpdGggdGhl
IHNpbXBsZQ0KPiA+ID4gcmV2ZXJ0Lg0KPiA+IA0KPiA+IEkgd2lsbC4gDQo+ID4gSSBuZWVkIHRv
IGRvIHNvbWUgdGVzdGluZyB0byBpbnZlc3RpZ2F0ZSBob3cgdG8gYmVzdCBjaG9vc2UgYmV0d2Vl
bg0KPiA+IHRoZQ0KPiA+IG9wdGlvbnMsIGJ1dCB3aWxsIGhhdmUgc29tZXRoaW5nIHJlYWR5IGZv
ciA1LjEuDQo+IA0KPiBJIHN0aWxsIGRvbid0IHNlZSBhbnl0aGluZyBpbiAtcmM2Li4NCg0KQmVl
biBvbiBlYXN0ZXIgdmFjYXRpb24uIEkgaGF2ZSBhIHBhdGNoIHJlYWR5IGZvciByZXZpZXcsIHRo
b3VnaCwgd2lsbA0Kc2VuZCBpdCBvdXQgaW4gYSBtb21lbnQuDQoNCkl0IHR1cm5zIG91dCB0aGF0
IHRvIGRvIHNvbWV0aGluZyB3ZWxsLWJlaGF2ZWQgaW4gY2FzZSBzb21lb25lIHNldHMNCnN3aW90
bGI9Zm9yY2UsIHRoZSB2YXJpYWJsZSBzd2lvdGxiX2ZvcmNlIHdvdWxkIG5lZWQgdG8gYmUgZXhw
b3J0ZWQuDQooSSBjYW4ndCByZWx5IG9uIHN3aW90bGJfbnJfdGJsKCkpLg0KDQpUaGF0J3Mgbm90
IGN1cnJlbnRseSBkb25lIGluIHRoZSBwYXRjaCwgYnV0IGluc3RlYWQgdGhlIGRyaXZlciBqdXN0
DQptYWxmdW5jdGlvbnMgbGlrZSBtb3N0IG90aGVyIGdyYXBoaWNzIGRyaXZlcnMuDQoNCi9UaG9t
YXMNCg0K
