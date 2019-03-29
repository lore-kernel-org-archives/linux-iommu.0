From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Subject: Re: [PATCH 13/13] dpaa_eth: fix SG frame cleanup
Date: Fri, 29 Mar 2019 15:25:22 +0000
Message-ID: <702d2baba6c2c131c1ae59607943eb8f8813d250.camel@infinera.com>
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
         <20190329140014.8126-14-laurentiu.tudor@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329140014.8126-14-laurentiu.tudor@nxp.com>
Content-Language: en-US
Content-ID: <9880E2E7CACB754F879567570CD6CEF2@namprd10.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "madalin.bucur@nxp.com" <madalin.bucur@nxp.com>, "leoyang.li@nxp.com" <leoyang.li@nxp.com>, "laurentiu.tudor@nxp.com" <laurentiu.tudor@nxp.com>, "roy.pledge@nxp.com" <roy.pledge@nxp.com>, "camelia.groza@nxp.com" <camelia.groza@nxp.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

DQpTaG91bGQgdGhpcyBvbmUgZ28gc3RhYmxlIDQuMTQvNC4xOSB0b28/DQoNCk9uIEZyaSwgMjAx
OS0wMy0yOSBhdCAxNjowMCArMDIwMCwgbGF1cmVudGl1LnR1ZG9yQG54cC5jb20gd3JvdGU6DQo+
IA0KPiBGcm9tOiBMYXVyZW50aXUgVHVkb3IgPGxhdXJlbnRpdS50dWRvckBueHAuY29tPg0KPiAN
Cj4gRml4IGlzc3VlIHdpdGggdGhlIGVudHJ5IGluZGV4aW5nIGluIHRoZSBzZyBmcmFtZSBjbGVh
bnVwIGNvZGUgYmVpbmcNCj4gb2ZmLWJ5LTEuIFRoaXMgcHJvYmxlbSBzaG93ZWQgdXAgd2hlbiBk
b2luZyBzb21lIGJhc2ljIGlwZXJmIHRlc3RzIGFuZA0KPiBtYW5pZmVzdGVkIGluIHRyYWZmaWMg
Y29taW5nIHRvIGEgaGFsdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExhdXJlbnRpdSBUdWRvciA8
bGF1cmVudGl1LnR1ZG9yQG54cC5jb20+DQo+IEFja2VkLWJ5OiBNYWRhbGluIEJ1Y3VyIDxtYWRh
bGluLmJ1Y3VyQG54cC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNj
YWxlL2RwYWEvZHBhYV9ldGguYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ZyZWVzY2FsZS9kcGFhL2RwYWFfZXRoLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVl
c2NhbGUvZHBhYS9kcGFhX2V0aC5jDQo+IGluZGV4IGRhZWRlNzI3Mjc2OC4uNDA0MjBlZGM5Y2U2
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZHBhYS9kcGFh
X2V0aC5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9kcGFhL2RwYWFf
ZXRoLmMNCj4gQEAgLTE2NjMsNyArMTY2Myw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqZHBh
YV9jbGVhbnVwX3R4X2ZkKGNvbnN0IHN0cnVjdCBkcGFhX3ByaXYgKnByaXYsDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHFtX3NnX2VudHJ5X2dldF9sZW4oJnNndFswXSksIGRt
YV9kaXIpOw0KPiANCj4gICAgICAgICAgICAgICAgIC8qIHJlbWFpbmluZyBwYWdlcyB3ZXJlIG1h
cHBlZCB3aXRoIHNrYl9mcmFnX2RtYV9tYXAoKSAqLw0KPiAtICAgICAgICAgICAgICAgZm9yIChp
ID0gMTsgaSA8IG5yX2ZyYWdzOyBpKyspIHsNCj4gKyAgICAgICAgICAgICAgIGZvciAoaSA9IDE7
IGkgPD0gbnJfZnJhZ3M7IGkrKykgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBXQVJOX09O
KHFtX3NnX2VudHJ5X2lzX2V4dCgmc2d0W2ldKSk7DQo+IA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICBkbWFfdW5tYXBfcGFnZShkZXYsIHFtX3NnX2FkZHIoJnNndFtpXSksDQo+IC0tDQo+IDIu
MTcuMQ0KPiANCg0K
