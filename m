From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [RFC PATCH v5 0/5] vfio-pci: Add support for mmapping MSI-X
 table
Date: Tue, 15 Aug 2017 14:48:52 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD0055E4A@AcuExch.aculab.com>
References: <20170807072548.3023-1-aik@ozlabs.ru>
 <8f5f7b82-3c10-7f39-b587-db4c4424f04c@ozlabs.ru>
 <ca2a4550-fb26-28db-0eea-a5940dfa612f@arm.com> <59924B85.5040405@intel.com>
 <1502760820.4493.40.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502760820.4493.40.camel@kernel.crashing.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, Jike Song <jike.song@intel.com>, Robin Murphy <robin.murphy@arm.com>
Cc: Vlad Tsyrklevich <vlad@tsyrklevich.net>, Neo Jia <cjia@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Eric Auger <eric.auger@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Kyle Mahlkuch <Kyle.Mahlkuch@ibm.com>, Kirti Wankhede <kwankhede@nvidia.com>, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Yongji Xie <elohimes@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, Bjorn Helgaas <bhelgaas@google.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists>
List-Id: iommu@lists.linux-foundation.org

RnJvbTogQmVuamFtaW4gSGVycmVuc2NobWlkdA0KPiBTZW50OiAxNSBBdWd1c3QgMjAxNyAwMjoz
NA0KPiBPbiBUdWUsIDIwMTctMDgtMTUgYXQgMDk6MTYgKzA4MDAsIEppa2UgU29uZyB3cm90ZToN
Cj4gPiA+IFRha2luZyBhIHN0ZXAgYmFjaywgdGhvdWdoLCB3aHkgZG9lcyB2ZmlvLXBjaSBwZXJm
b3JtIHRoaXMgY2hlY2sgaW4gdGhlDQo+ID4gPiBmaXJzdCBwbGFjZT8gSWYgYSBtYWxpY2lvdXMg
Z3Vlc3QgYWxyZWFkeSBoYXMgY29udHJvbCBvZiBhIGRldmljZSwgYW55DQo+ID4gPiBraW5kIG9m
IGludGVycnVwdCBzcG9vZmluZyBpdCBjb3VsZCBkbyBieSBmaWRkbGluZyB3aXRoIHRoZSBNU0kt
WA0KPiA+ID4gbWVzc2FnZSBhZGRyZXNzL2RhdGEgaXQgY291bGQgc2ltcGx5IGRvIHdpdGggYSBE
TUEgd3JpdGUgYW55d2F5LCBzbyB0aGUNCj4gPiA+IHNlY3VyaXR5IGFyZ3VtZW50IGRvZXNuJ3Qg
c3RhbmQgdXAgaW4gZ2VuZXJhbCAoc3VyZSwgbm90IGFsbCBQQ0llDQo+ID4gPiBkZXZpY2VzIG1h
eSBiZSBjYXBhYmxlIG9mIGFyYml0cmFyeSBETUEsIGJ1dCB0aGF0IHNlZW1zIGxpa2UgbW9yZSBv
ZiBhDQo+ID4gPiB0ZW51b3VzIHNlY3VyaXR5LWJ5LW9ic2N1cml0eSBhbmdsZSB0byBtZSkuDQo+
IA0KPiBJIHRyaWVkIHRvIG1ha2UgdGhhdCBwb2ludCBmb3IgeWVhcnMsIHRoYW5rcyBmb3IgcmUt
aXRlcmF0aW5nIGl0IDotKQ0KDQpJbmRlZWQsIHdlIGhhdmUgYW4gRlBHQSBiYXNlZCBQQ0llIGNh
cmQgd2hlcmUgdGhlIE1TSS1YIHRhYmxlIGlzIGp1c3QgYQ0KcGllY2Ugb2YgUENJZSBhY2Nlc3Np
YmxlIG1lbW9yeS4NClRoZSBkZXZpY2UgZHJpdmVyIGhhcyB0byByZWFkIHRoZSBNU0ktWCB0YWJs
ZSBhbmQgd3JpdGUgdGhlIGFkZHJlc3MrZGF0YQ0KdmFsdWVzIHRvIG90aGVyIHJlZ2lzdGVycyB3
aGljaCBhcmUgdGhlbiB1c2VkIHRvIHJhaXNlIHRoZSBpbnRlcnJ1cHQuDQooT2ssIEkndmUgd3Jp
dHRlbiBhIGJldHRlciBpbnRlcnJ1cHQgZ2VuZXJhdG9yIHNvIHdlIGRvbid0IGRvIHRoYXQNCmFu
eSBtb3JlLikNCg0KCURhdmlkDQoNCg==
