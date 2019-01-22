From: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Fix IOMMU page flush when detach all devices
 from a domain
Date: Tue, 22 Jan 2019 15:53:18 +0000
Message-ID: <e27055c1-89b0-e804-b99c-c94965de5344@amd.com>
References: <20190116041546.3541-1-Suravee.Suthikulpanit@amd.com>
 <20190116132648.i5n3hz3k7d2wxbrx@8bytes.org>
 <60c24182-c58e-0575-b085-c7eebc00c49b@amd.com>
 <20190116170852.GD4681@8bytes.org>
 <0a61c07d-edfe-2738-380d-33d39e40fc0a@amd.com>
 <20190122104454.nke2knuyqiswfh5w@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190122104454.nke2knuyqiswfh5w@8bytes.org>
Content-Language: en-US
Content-ID: <4C06E346A8976942BC2F062223E2406A@namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "joro@8bytes.org" <joro@8bytes.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Singh, Brijesh" <brijesh.singh@amd.com>
List-Id: iommu@lists.linux-foundation.org

Sm9lcmcsDQoNCk9uIDEvMjIvMTkgNTo0NCBQTSwgam9yb0A4Ynl0ZXMub3JnIHdyb3RlOg0KPiBI
aSBTdXJhdmVlLA0KPiANCj4gT24gVGh1LCBKYW4gMTcsIDIwMTkgYXQgMDg6NDQ6MzZBTSArMDAw
MCwgU3V0aGlrdWxwYW5pdCwgU3VyYXZlZSB3cm90ZToNCj4+IFRoZW4sIGluIF9fZG9tYWluX2Zs
dXNoX3BhZ2VzLCB3ZSBpc3N1ZSBjb21tYW5kIHdoZW4gdGhlIGRldl9pb21tdVtdID49IDAuDQo+
PiBUaGlzIHNob3VsZCBwcmVzZXJ2ZSBwcmV2aW91cyBiZWhhdmlvciwgYW5kIG9ubHkgYWRkIGZs
dXNoaW5nIGNvbmRpdGlvbiB0bw0KPj4gdGhlIHNwZWNpZmljIElPTU1VIGluIGRldGFjaGVkIHN0
YXRlLiBQbGVhc2UgbGV0IG1lIGtub3cgd2hhdCB5b3UgdGhpbmsuDQo+IA0KPiBJIHRoaW5rIHRo
ZSB3aG9sZSBwb2ludCB3aHkgVkZJTyBpcyBkZXRhY2hpbmcgYWxsIGRldmljZXMgZmlyc3QgYW5k
IHRoZW4NCj4gZ29lcyBpbnRvIHVubWFwcGluZyBwYWdlcyBpcyB0aGF0IHRoZXJlIGFyZSBubyBm
bHVzaGVzIG5lZWRlZCBhbnltb3JlDQo+IHdoZW4gZGV2aWNlcyBhcmUgZGV0YWNoZWQuDQo+IA0K
PiBCdXQgd2hlbiB3ZSBmb2xsb3cgeW91ciBwcm9wb3NhbCB3ZSB3b3VsZCBzdGlsbCBkbyBJT1RM
QiBmbHVzaGVzIGV2ZW4NCj4gd2hlbiBubyBkZXZpY2VzIGFyZSBhdHRhY2hlZCBhbnltb3JlLiBT
byBJJ2QgbGlrZSB0byBhdm9pZCB0aGlzLCBnaXZlbg0KPiB0aGUgaW1wbGljYXRpb25zIG9uIHVu
bWFwcGluZyBwZXJmb3JtYW5jZS4gV2Ugc2hvdWxkIGp1c3QgZmx1c2ggdGhlDQo+IElPTU1VIFRM
QiBhdCBkZXRhY2ggdGltZSBhbmQgYmUgZG9uZSB3aXRoIGl0Lg0KPiANCj4gTWFrZXMgc2Vuc2U/
DQo+IA0KPiBSZWdhcmRzLA0KPiANCj4gCUpvZXJnDQo+IA0KDQpUaGFua3MgZm9yIHRoZSBkZXRh
aWwuIEFscmlnaHQgdGhlbiwgbGV0J3MganVzdCBnbyB3aXRoIHRoZSB2ZXJzaW9uIHlvdQ0Kc2Vu
dCBvbiAxLzE2LzE5LiBEbyB5b3Ugd2FudCBtZSB0byByZXNlbmQgVjMgd2l0aCB0aGF0IGNoYW5n
ZXMsIG9yDQp3b3VsZCB5b3UgYmUgdGFraW5nIGNhcmUgb2YgdGhhdD8NCg0KVGhhbmtzLA0KU3Vy
YXZlZQ0K
