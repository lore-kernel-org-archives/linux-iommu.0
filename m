From: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Wed, 30 Jan 2019 10:33:39 +0000
Message-ID: <4e0637ba-0d7c-66a5-d3de-bc1e7dc7c0ef@amd.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com> <20190129193250.GK10108@mellanox.com>
 <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com>
 <20190129205827.GM10108@mellanox.com> <20190130080208.GC29665@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130080208.GC29665@lst.de>
Content-Language: en-US
Content-ID: <0297C7D5305B774FB9CFD8B1E00EE95C@namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@mellanox.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, Jerome Glisse <jglisse@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

QW0gMzAuMDEuMTkgdW0gMDk6MDIgc2NocmllYiBDaHJpc3RvcGggSGVsbHdpZzoNCj4gT24gVHVl
LCBKYW4gMjksIDIwMTkgYXQgMDg6NTg6MzVQTSArMDAwMCwgSmFzb24gR3VudGhvcnBlIHdyb3Rl
Og0KPj4gT24gVHVlLCBKYW4gMjksIDIwMTkgYXQgMDE6Mzk6NDlQTSAtMDcwMCwgTG9nYW4gR3Vu
dGhvcnBlIHdyb3RlOg0KPj4NCj4+PiBpbXBsZW1lbnQgdGhlIG1hcHBpbmcuIEFuZCBJIGRvbid0
IHRoaW5rIHdlIHNob3VsZCBoYXZlICdzcGVjaWFsJyB2bWEncw0KPj4+IGZvciB0aGlzICh0aG91
Z2ggd2UgbWF5IG5lZWQgc29tZXRoaW5nIHRvIGVuc3VyZSB3ZSBkb24ndCBnZXQgbWFwcGluZw0K
Pj4+IHJlcXVlc3RzIG1peGVkIHdpdGggZGlmZmVyZW50IHR5cGVzIG9mIHBhZ2VzLi4uKS4NCj4+
IEkgdGhpbmsgSmVyb21lIGV4cGxhaW5lZCB0aGUgcG9pbnQgaGVyZSBpcyB0byBoYXZlIGEgJ3Nw
ZWNpYWwgdm1hJw0KPj4gcmF0aGVyIHRoYW4gYSAnc3BlY2lhbCBzdHJ1Y3QgcGFnZScgYXMsIHJl
YWxseSwgd2UgZG9uJ3QgbmVlZCBhDQo+PiBzdHJ1Y3QgcGFnZSBhdCBhbGwgdG8gbWFrZSB0aGlz
IHdvcmsuDQo+Pg0KPj4gSWYgSSByZWNhbGwgeW91ciBlYXJsaWVyIGF0dGVtcHRzIGF0IGFkZGlu
ZyBzdHJ1Y3QgcGFnZSBmb3IgQkFSDQo+PiBtZW1vcnksIGl0IHJhbiBhZ3JvdW5kIG9uIGlzc3Vl
cyByZWxhdGVkIHRvIE9fRElSRUNUL3NnbHMsIGV0YywgZXRjLg0KPiBTdHJ1Y3QgcGFnZSBpcyB3
aGF0IG1ha2VzIE9fRElSRUNUIHdvcmssIHVzaW5nIHNnbHMgb3IgYmlvdmVjcywgZXRjIG9uDQo+
IGl0IHdvcmsuICBXaXRob3V0IHN0cnVjdCBwYWdlIG5vbmUgb2YgdGhlIGFib3ZlIGNhbiB3b3Jr
IGF0IGFsbC4gIFRoYXQNCj4gaXMgd2h5IHdlIHVzZSBzdHJ1Y3QgcGFnZSBmb3IgYmFja2luZyBC
QVJzIGluIHRoZSBleGlzdGluZyBQMlAgY29kZS4NCj4gTm90IHRoYXQgSSdtIGEgcGFydGljdWxh
ciBmYW4gb2YgY3JlYXRpbmcgc3RydWN0IHBhZ2UgZm9yIHRoaXMgZGV2aWNlDQo+IG1lbW9yeSwg
YnV0IHdpdGhvdXQgbWFqb3IgaW52YXNpdmUgc3VyZ2VyeSB0byBsYXJnZSBwYXJ0cyBvZiB0aGUg
a2VybmVsDQo+IGl0IGlzIHRoZSBvbmx5IHdheSB0byBtYWtlIGl0IHdvcmsuDQoNClRoZSBwcm9i
bGVtIHNlZW1zIHRvIGJlIHRoYXQgc3RydWN0IHBhZ2UgZG9lcyB0d28gdGhpbmdzOg0KDQoxLiBN
ZW1vcnkgbWFuYWdlbWVudCBmb3Igc3lzdGVtIG1lbW9yeS4NCjIuIFRoZSBvYmplY3QgdG8gd29y
ayB3aXRoIGluIHRoZSBJL08gbGF5ZXIuDQoNClRoaXMgd2FzIGRvbmUgYmVjYXVzZSBhIGdvb2Qg
cGFydCBvZiB0aGF0IHN0dWZmIG92ZXJsYXBzLCBsaWtlIHJlZmVyZW5jZSANCmNvdW50aW5nIGhv
dyBvZnRlbiBhIHBhZ2UgaXMgdXNlZC7CoCBUaGUgcHJvYmxlbSBub3cgaXMgdGhhdCB0aGlzIGRv
ZXNuJ3QgDQp3b3JrIHZlcnkgd2VsbCBmb3IgZGV2aWNlIG1lbW9yeSBpbiBzb21lIGNhc2VzLg0K
DQpGb3IgZXhhbXBsZSBvbiBHUFVzIHlvdSB1c3VhbGx5IGhhdmUgYSBsYXJnZSBhbW91bnQgb2Yg
bWVtb3J5IHdoaWNoIGlzIA0Kbm90IGV2ZW4gYWNjZXNzaWJsZSBieSB0aGUgQ1BVLiBJbiBvdGhl
ciB3b3JkcyB5b3UgY2FuJ3QgZWFzaWx5IGNyZWF0ZSBhIA0Kc3RydWN0IHBhZ2UgZm9yIGl0IGJl
Y2F1c2UgeW91IGNhbid0IHJlZmVyZW5jZSBpdCB3aXRoIGEgcGh5c2ljYWwgQ1BVIA0KYWRkcmVz
cy4NCg0KTWF5YmUgc3RydWN0IHBhZ2Ugc2hvdWxkIGJlIHNwbGl0IHVwIGludG8gc21hbGxlciBz
dHJ1Y3R1cmVzPyBJIG1lYW4gDQppdCdzIHJlYWxseSBvdmVybG9hZGVkIHdpdGggZGF0YS4NCg0K
Q2hyaXN0aWFuLg0KDQoNCg==
