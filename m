From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [RFC PATCH] dma-mapping: create iommu mapping for newly allocated
 dma coherent mem
Date: Thu, 25 Apr 2019 11:30:54 +0000
Message-ID: <b9f2b425-dde9-f9a1-b8fa-b7710e764b16@nxp.com>
References: <20190422165125.21704-1-laurentiu.tudor@nxp.com>
 <20190422181100.GB32490@lst.de>
 <VI1PR04MB513407A66107759EC0DFE175EC230@VI1PR04MB5134.eurprd04.prod.outlook.com>
 <20190424145705.GB21480@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424145705.GB21480@lst.de>
Content-Language: en-US
Content-ID: <C3DAFF8A2E6710478B0D4E110DCF3AE3@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: "robin.murphy@arm.com" <robin.murphy@arm.com>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Leo Li <leoyang.li@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

SGkgQ2hyaXN0b3BoLA0KDQpPbiAyNC4wNC4yMDE5IDE3OjU3LCBDaHJpc3RvcGggSGVsbHdpZyB3
cm90ZToNCj4gSSdkIGJlIGhhcHB5IHRvIG9mZmxvYWQgYWxsIG9mIHRoZSBtZW50aW9uZWQgdGFz
a3MgdG8geW91IGlmIHlvdQ0KPiB2b2x1bnRlZXIuDQoNCkFscmlnaHQsIEkgdGhpbmsgSSBtb3N0
bHkgZ290IGl0IGFuZCBjYW4gc3RhcnQgd2l0aCB0aGUgdHdvIHVzYiBkcml2ZXJzIA0KeW91IG1l
bnRpb25lZC4gSnVzdCBuZWVkIGEgZmV3IGNsYXJpZmljYXRpb25zLCBwbGVhc2Ugc2VlIGlubGlu
ZS4NCg0KPiBJIHRoaW5rIHRoZSBmaXJzdCBzdGVwIGlzIHRvIG1vdmUgdGhlIHR3byBVU0IgY29u
dHJvbGxlciB0aGF0IGNhbiBvbmx5DQo+IERNQSB0byB0aGVpciBvd24gQkFSIG9mZiB0aGUgZXhp
c3RpbmcgRE1BIGNvaGVyZW50IGluZnJhc3RydWN0dXJlLiAgVGhlDQo+IGNvbnRyb2xsZXJzIGFy
ZSBhbHJlYWR5IGlkZW50aWZpZWQgdXNpbmcgdGhlIEhDRF9MT0NBTF9NRU0gZmxhZywgc28gd2UN
Cj4ganVzdCBuZWVkIHRvIGtleSBvZmYgdGhhdCBpbiB0aGUgaGNkX2J1ZmZlcl8qIHJvdXRpbmVz
IGFuZCBjYWxsIGludG8gYQ0KDQpTbyBpZiBIQ0RfTE9DQUxfTUVNIGlzIHNldCBJIHNob3VsZCBj
YWxsIGludG8gdGhlIGdlbl9wb29sIGFwaSBpbnN0ZWFkIA0Kb2YgZXhpc3RpbmcgZG1hX3thbGxv
YyxmcmVlfV9jb2hlcmVudCgpLg0KDQo+IGdlbmFsbG9jIHRoYXQgaGFzIGJlZW4gZmVkIHVzaW5n
IHRoZSBiYXIsIHJlcGxhY2luZyB0aGUgY3VycmVudA0KPiBkbWFfZGVjbGFyZV9jb2hlcmVudCB1
c2FnZS4gIFRha2UgYSBsb29rIGF0IGRyaXZlcnMvcGNpL3AycGRtYS5jDQo+IGZvciBhbm90aGVy
IGV4YW1wbGUgb2YgYWxsb2NhdGluZyBiaXRzIG9mIGEgQkFSIHVzaW5nIGdlbmFsbG9jLg0KDQpX
aGVyZSBzaG91bGQgSSBwbGFjZSB0aGUgcmVmZXJlbmNlIHRvIHRoZSBnZW5fcG9vbD8gSG93IGRv
ZXMgbG9jYWxfcG9vbCANCmluICdzdHJ1Y3QgaGNkX3VzYicgc291bmQ/DQoNCi0tLQ0KVGhhbmtz
ICYgQmVzdCBSZWdhcmRzLCBMYXVyZW50aXU=
