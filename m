From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH] kernel/dma/direct: Do not include SME mask in the DMA
 supported check
Date: Mon, 17 Dec 2018 14:49:00 +0000
Message-ID: <1423e1f4-425f-433e-6b85-0240b2f03aa2@amd.com>
References: <20181213225110.6567.69313.stgit@tlendack-t1.amdoffice.net>
 <20181215105510.GA1806@lst.de> <6954879c-90df-b6bd-7925-f0985980ed18@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6954879c-90df-b6bd-7925-f0985980ed18@amd.com>
Content-Language: en-US
Content-ID: <ABB1DF475B806A40A44904ACA6139D3B@namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Alexander Duyck <alexander.duyck@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Robin Murphy <robin.murphy@arm.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: iommu@lists.linux-foundation.org

T24gMTIvMTYvMjAxOCAwNTo0MSBQTSwgVG9tIExlbmRhY2t5IHdyb3RlOg0KPiBPbiAxMi8xNS8y
MDE4IDA0OjU1IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4+IFRoZSBtYWlsIHNlZW1z
IHRvIGJlIHNvIG9kZGx5IGVuY29kZWQgc28gdGhhdCBnaXQtYW0gZmFpbHMgb24gaXQuICBDYW4N
Cj4+IHlvdSByZXNlbmQgYXMgcGxhaW4gdGV4dD8NCj4gDQo+IEhtbW0uLi4gbm90IHN1cmUgd2hh
dCBoYXBwZW5lZCB3aXRoIHRoYXQsIGJ1dCB5ZWFoLCBsb29raW5nIGF0IHRoZSBtZXNzYWdlDQo+
IHNvdXJjZSBzaG93cyBzb21ldGhpbmcgc3RyYW5nZSB3ZW50IG9uLiBMZXQgbWUgdGFrZSBhIGxv
b2sgYW5kIEknbGwgdHJ5IHRvDQo+IGdldCBhIGdvb2QgdmVyc2lvbiB0byB5b3UgdG9tbW9yb3cg
KE1vbmRheSkuDQoNCk11c3QgaGF2ZSBiZWVuIHNvbWV0aGluZyB3aXRoIHN0Z2l0Li4uIGp1c3Qg
cmVzZW50IHVzaW5nIGdpdCBmb3JtYXQtcGF0Y2gNCmFuZCBnaXQgc2VuZC1lbWFpbCBhbmQgaXQg
bG9va3Mgb2suICBMZXQgbWUga25vdyBpZiBpdCdzIHN0aWxsIG5vdCByaWdodA0Kd2hlbiBpdCBn
ZXRzIHRvIHlvdS4NCg0KVGhhbmtzLA0KVG9tDQoNCj4gDQo+IFRoYW5rcywNCj4gVG9tDQo+IA0K
Pj4NCg==
