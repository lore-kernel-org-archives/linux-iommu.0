From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH 2/2] x86/kvmclock: set_memory_decrypted() takes number of
 pages
Date: Tue, 22 Jan 2019 21:43:39 +0000
Message-ID: <d40ab37e-ae46-dce8-21f9-b62c062cab84@amd.com>
References: <20190122211758.8317-1-bauerman@linux.ibm.com>
 <20190122211758.8317-2-bauerman@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190122211758.8317-2-bauerman@linux.ibm.com>
Content-Language: en-US
Content-ID: <DF724676218A724C9BD29A9E44D6E310@namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, "x86@kernel.org" <x86@kernel.org>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Ram Pai <linuxram@us.ibm.com>
List-Id: iommu@lists.linux-foundation.org

T24gMS8yMi8xOSAzOjE3IFBNLCBUaGlhZ28gSnVuZyBCYXVlcm1hbm4gd3JvdGU6DQo+IEZyb206
IFJhbSBQYWkgPGxpbnV4cmFtQHVzLmlibS5jb20+DQo+IA0KPiBzZXRfbWVtb3J5X2RlY3J5cHRl
ZCgpIGV4cGVjdHMgdGhlIG51bWJlciBvZiBQQUdFX1NJWkUgcGFnZXMgdG8gZGVjcnlwdC4NCj4g
a3ZtY2xvY2tfaW5pdF9tZW0oKSBpbnN0ZWFkIHBhc3NlcyBudW1iZXIgb2YgYnl0ZXMuIFRoaXMg
ZGVjcnlwdHMgYSBodWdlDQo+IG51bWJlciBvZiBwYWdlcyByZXN1bHRpbmcgaW4gZGF0YSBjb3Jy
dXB0aW9uLg0KDQpTYW1lIGNvbW1lbnQgYXMgcGF0Y2ggMS8yIGluIHRoaXMgc2VyaWVzLiAgVGhp
cyBpcyBub3QgY29ycmVjdC4gU2VlDQpjb21tZW50cyBiZWxvdy4NCg0KPiANCj4gRml4ZWQgaXQu
DQo+IA0KPiBbIGJhdWVybWFubjogU2xpZ2h0bHkgcmV3b3JkZWQgY29tbWl0IG1lc3NhZ2UgYW5k
IGFkZGVkIEZpeGVzOiB0YWcuIF0NCj4gRml4ZXM6IDZhMWNhYzU2ZjQxZiAoIng4Ni9rdm06IFVz
ZSBfX2Jzc19kZWNyeXB0ZWQgYXR0cmlidXRlIGluIHNoYXJlZCB2YXJpYWJsZXMiKQ0KPiBTaWdu
ZWQtb2ZmLWJ5OiBSYW0gUGFpIDxsaW51eHJhbUB1cy5pYm0uY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBUaGlhZ28gSnVuZyBCYXVlcm1hbm4gPGJhdWVybWFuQGxpbnV4LmlibS5jb20+DQo+IC0tLQ0K
PiAgYXJjaC94ODYva2VybmVsL2t2bWNsb2NrLmMgfCAzICstLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gTm90ZTogRm91bmQgYnkgY29k
ZSBpbnNwZWN0aW9uLiBJIGRvbid0IGhhdmUgYSB3YXkgdG8gdGVzdC4NCj4gDQo+IGRpZmYgLS1n
aXQgYS9hcmNoL3g4Ni9rZXJuZWwva3ZtY2xvY2suYyBiL2FyY2gveDg2L2tlcm5lbC9rdm1jbG9j
ay5jDQo+IGluZGV4IGU4MTFkNGQxYzgyNC4uYjVjODY3ZGQyYzhkIDEwMDY0NA0KPiAtLS0gYS9h
cmNoL3g4Ni9rZXJuZWwva3ZtY2xvY2suYw0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwva3ZtY2xv
Y2suYw0KPiBAQCAtMjUxLDggKzI1MSw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBrdm1jbG9ja19p
bml0X21lbSh2b2lkKQ0KPiAgCSAqIGJlIG1hcHBlZCBkZWNyeXB0ZWQuDQo+ICAJICovDQo+ICAJ
aWYgKHNldl9hY3RpdmUoKSkgew0KPiAtCQlyID0gc2V0X21lbW9yeV9kZWNyeXB0ZWQoKHVuc2ln
bmVkIGxvbmcpIGh2Y2xvY2tfbWVtLA0KPiAtCQkJCQkgMVVMIDw8IG9yZGVyKTsNCj4gKwkJciA9
IHNldF9tZW1vcnlfZGVjcnlwdGVkKCh1bnNpZ25lZCBsb25nKSBodmNsb2NrX21lbSwgMSk7DQoN
CkFnYWluLCBub3QgY29ycmVjdC4gQSBudW1iZXIgb2YgcGFnZXMgd2VyZSBhbGxvY2F0ZWQgYmFz
ZWQgb24gdGhlIG9yZGVyLg0KVGhhdCBudW1iZXIgaXMgY2FsY3VsYXRlZCB1c2luZyB0aGUgc2hp
ZnQgaW4gdGhlIGNhbGwuIEhhcmRjb2RpbmcgdGhpcyB0bw0KMSBpcyB3cm9uZy4NCg0KVGhhbmtz
LA0KVG9tDQoNCj4gIAkJaWYgKHIpIHsNCj4gIAkJCV9fZnJlZV9wYWdlcyhwLCBvcmRlcik7DQo+
ICAJCQlodmNsb2NrX21lbSA9IE5VTEw7DQo+IA0K
