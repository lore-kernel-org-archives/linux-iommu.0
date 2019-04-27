From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Subject: Re: [PATCH v2 9/9] dpaa_eth: fix SG frame cleanup
Date: Sat, 27 Apr 2019 17:10:53 +0000
Message-ID: <2c6f5d170edab346e0a87b1dfeb12e2f65801685.camel@infinera.com>
References: <20190427071031.6563-1-laurentiu.tudor@nxp.com>
         <20190427071031.6563-10-laurentiu.tudor@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190427071031.6563-10-laurentiu.tudor@nxp.com>
Content-Language: en-US
Content-ID: <4A981E3F453F6540BDBD9A24364D128E@namprd10.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "madalin.bucur@nxp.com" <madalin.bucur@nxp.com>, "leoyang.li@nxp.com" <leoyang.li@nxp.com>, "laurentiu.tudor@nxp.com" <laurentiu.tudor@nxp.com>, "roy.pledge@nxp.com" <roy.pledge@nxp.com>, "camelia.groza@nxp.com" <camelia.groza@nxp.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

T24gU2F0LCAyMDE5LTA0LTI3IGF0IDEwOjEwICswMzAwLCBsYXVyZW50aXUudHVkb3JAbnhwLmNv
bSB3cm90ZToNCj4gRnJvbTogTGF1cmVudGl1IFR1ZG9yIDxsYXVyZW50aXUudHVkb3JAbnhwLmNv
bT4NCj4gDQo+IEZpeCBpc3N1ZSB3aXRoIHRoZSBlbnRyeSBpbmRleGluZyBpbiB0aGUgc2cgZnJh
bWUgY2xlYW51cCBjb2RlIGJlaW5nDQo+IG9mZi1ieS0xLiBUaGlzIHByb2JsZW0gc2hvd2VkIHVw
IHdoZW4gZG9pbmcgc29tZSBiYXNpYyBpcGVyZiB0ZXN0cyBhbmQNCj4gbWFuaWZlc3RlZCBpbiB0
cmFmZmljIGNvbWluZyB0byBhIGhhbHQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMYXVyZW50aXUg
VHVkb3IgPGxhdXJlbnRpdS50dWRvckBueHAuY29tPg0KPiBBY2tlZC1ieTogTWFkYWxpbiBCdWN1
ciA8bWFkYWxpbi5idWN1ckBueHAuY29tPg0KDQpXYXNuJ3QgdGhpcyBhIHN0YWJsZSBjYW5kaWRh
dGUgdG9vPw0KDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2RwYWEv
ZHBhYV9ldGguYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVz
Y2FsZS9kcGFhL2RwYWFfZXRoLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZHBh
YS9kcGFhX2V0aC5jDQo+IGluZGV4IGRhZWRlNzI3Mjc2OC4uNDA0MjBlZGM5Y2U2IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZHBhYS9kcGFhX2V0aC5jDQo+
ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9kcGFhL2RwYWFfZXRoLmMNCj4g
QEAgLTE2NjMsNyArMTY2Myw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqZHBhYV9jbGVhbnVw
X3R4X2ZkKGNvbnN0IHN0cnVjdCBkcGFhX3ByaXYgKnByaXYsDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHFtX3NnX2VudHJ5X2dldF9sZW4oJnNndFswXSksIGRtYV9kaXIpOw0K
PiANCj4gICAgICAgICAgICAgICAgIC8qIHJlbWFpbmluZyBwYWdlcyB3ZXJlIG1hcHBlZCB3aXRo
IHNrYl9mcmFnX2RtYV9tYXAoKSAqLw0KPiAtICAgICAgICAgICAgICAgZm9yIChpID0gMTsgaSA8
IG5yX2ZyYWdzOyBpKyspIHsNCj4gKyAgICAgICAgICAgICAgIGZvciAoaSA9IDE7IGkgPD0gbnJf
ZnJhZ3M7IGkrKykgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBXQVJOX09OKHFtX3NnX2Vu
dHJ5X2lzX2V4dCgmc2d0W2ldKSk7DQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBkbWFf
dW5tYXBfcGFnZShkZXYsIHFtX3NnX2FkZHIoJnNndFtpXSksDQo+IC0tDQo+IDIuMTcuMQ0KPiAN
Cg0K
