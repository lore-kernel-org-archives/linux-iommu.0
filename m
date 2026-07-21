Received: from outbound.baidu.com (mx13.baidu.com [220.181.3.100])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A8F0624886A
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784636672; cv=none; b=sRygMFDL79yydRvP+BVyP9cjMDCQ6ApRqAq/dp44mF3+N9/afLs/JWhr7yUV+CdA87HMlNQ4yiITf71NGQN4KaXAWHWrNr6TMq9jpZSyX+g/N/0V1CtKCk0f/jjzUGkquiwurtYx53yhHBwtJ0GXBrx3fiF6L5pmazwNxZuUpLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784636672; c=relaxed/simple;
	bh=qTqSJGxWkheoygVyDICb1jc2Me7C7NIvQ1XvP7qr0n0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dW4WoK/mZ8XqlhYGDDl8yJP9h6bmwWQVtOc/nhy5Kvkt9k5XbmBnxpTdZTRp3SzfMcnFCwQMJbMAnCzrwIeD8eEUtVYJTbh/pomLrdUojvMOFa717FXIBt8CEGDWYuKCjFz78oM2IFrheOHFaLE5+YfBHoKAGgjEs+wessyXqyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=CPNJylwj; arc=none smtp.client-ip=220.181.3.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="CPNJylwj"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Ankit Soni <Ankit.Soni@amd.com>
CC: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogWz8/Pz9dIFJlOiBbUEFUQ0hdIGlvbW11L2FtZDogRml4IHVuZGVm?=
 =?gb2312?Q?ined_behavior_in_devid=5Fwrite_debugfs_function?=
Thread-Topic: [????] Re: [PATCH] iommu/amd: Fix undefined behavior in
 devid_write debugfs function
Thread-Index: AQHc8b/1QkL41RIAXEGJ3lOYTEmafLYqLIWAgE4HUgA=
Date: Tue, 21 Jul 2026 12:24:18 +0000
Message-ID: <5cd2519944854cc0b3c5e5d509f378dc@baidu.com>
References: <20260601121240.2474-1-lirongqing@baidu.com>
 <sw4p7b4v5fhguzoxu7oxiy3tjtarcivzalr36cjn3e5okbngw5@zj3oaab3ctxt>
In-Reply-To: <sw4p7b4v5fhguzoxu7oxiy3tjtarcivzalr36cjn3e5okbngw5@zj3oaab3ctxt>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1784636662;
	bh=qTqSJGxWkheoygVyDICb1jc2Me7C7NIvQ1XvP7qr0n0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=CPNJylwjJO3l34NLSMfT9O1bOXpZVQOZmt6P7quF16LnXS0XhooBaT28ZPuadpcy1
	 +/r7VyGN6T/YwgpMfmLG2CM+J23iLvpFz25WS6TN8vJP26Y1ZJuPvaA7ghMyBnmOW6
	 QOQpmbDyIYTuKZzlmEBaANAg34Gk4iu6HBOryI7FHlIPpSE4VOifN0NgEE9YZsfBGZ
	 iSxh5u/7lchq8oPijIOUq2EX8sYkr14lZyvOIVjm3QFGNlUsR1Hbvu0OKVvPt9fgA0
	 YIFhl8E14LL9RbLN6lx2O7lG9QFRjdnx4qdnDthNZuXwbVFOSc76h2lugiBxCGlT2s
	 NZnOEVN89p4zQ==

DQoNCj4gDQo+IE9uIE1vbiwgSnVuIDAxLCAyMDI2IGF0IDA4OjEyOjQwQU0gLTA0MDAsIGxpcm9u
Z3Fpbmcgd3JvdGU6DQo+ID4gRnJvbTogTGkgUm9uZ1FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29t
Pg0KPiA+DQo+ID4gV2hlbiBmb3JfZWFjaF9wY2lfc2VnbWVudCgpIGxvb3AgY29tcGxldGVzIHdp
dGhvdXQgZmluZGluZyBhIG1hdGNoaW5nDQo+ID4gc2VnbWVudCwgdGhlIHBjaV9zZWcgcG9pbnRl
ciBpcyBub3QgTlVMTCBidXQgcG9pbnRzIHRvIGFuIGludmFsaWQNCj4gPiBtZW1vcnkgbG9jYXRp
b24gKHRoZSBsaXN0IGhlYWQpLiBBY2Nlc3NpbmcgcGNpX3NlZy0+aWQgYWZ0ZXIgdGhlIGxvb3AN
Cj4gPiBjYXVzZXMgdW5kZWZpbmVkIGJlaGF2aW9yLg0KPiA+DQo+ID4gRml4IHRoaXMgYnkgaGFu
ZGxpbmcgdGhlIHN1Y2Nlc3NmdWwgY2FzZSBpbnNpZGUgdGhlIGxvb3AgYW5kIHJldHVybmluZw0K
PiA+IC1FSU5WQUwgYWZ0ZXIgdGhlIGxvb3AgaWYgbm8gbWF0Y2hpbmcgc2VnbWVudCBpcyBmb3Vu
ZC4NCj4gPg0KPiA+IEZpeGVzOiAyZTk4OTQwZjEyM2Q5ICgiaW9tbXUvYW1kOiBBZGQgc3VwcG9y
dCBmb3IgZGV2aWNlIGlkIHVzZXINCj4gPiBpbnB1dCIpDQo+ID4gU2lnbmVkLW9mZi1ieTogTGkg
Um9uZ1FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPg0KPiANCj4gSGksDQo+IA0KPiBUaGFua3Mg
Zm9yIHRoZSBmaXguIExvb2tzIGdvb2QgdG8gbWUuDQo+IA0KPiBSZXZpZXdlZC1ieTogQW5raXQg
U29uaSA8QW5raXQuU29uaUBhbWQuY29tPg0KPiANCg0KUGluZw0KDQpbTGksUm9uZ3FpbmddIA0K
DQoNCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9pb21tdS9hbWQvZGVidWdmcy5jIHwgMTIgKysrLS0t
LS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25z
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hbWQvZGVidWdmcy5jIGIv
ZHJpdmVycy9pb21tdS9hbWQvZGVidWdmcy5jDQo+ID4gaW5kZXggNGM1M2I2My4uNWM1NzNlYyAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L2FtZC9kZWJ1Z2ZzLmMNCj4gPiArKysgYi9k
cml2ZXJzL2lvbW11L2FtZC9kZWJ1Z2ZzLmMNCj4gPiBAQCAtMTc2LDE5ICsxNzYsMTMgQEAgc3Rh
dGljIHNzaXplX3QgZGV2aWRfd3JpdGUoc3RydWN0IGZpbGUgKmZpbHAsIGNvbnN0DQo+IGNoYXIg
X191c2VyICp1YnVmLA0KPiA+ICAJCQlrZnJlZShzcmNpZF9wdHIpOw0KPiA+ICAJCQlyZXR1cm4g
LUVOT0RFVjsNCj4gPiAgCQl9DQo+ID4gLQkJYnJlYWs7DQo+ID4gLQl9DQo+ID4gLQ0KPiA+IC0J
aWYgKHBjaV9zZWctPmlkICE9IHNlZykgew0KPiA+ICsJCXNiZGYgPSBQQ0lfU0VHX0RFVklEX1RP
X1NCREYoc2VnLCBkZXZpZCk7DQo+ID4gIAkJa2ZyZWUoc3JjaWRfcHRyKTsNCj4gPiAtCQlyZXR1
cm4gLUVJTlZBTDsNCj4gPiArCQlyZXR1cm4gY250Ow0KPiA+ICAJfQ0KPiA+DQo+ID4gLQlzYmRm
ID0gUENJX1NFR19ERVZJRF9UT19TQkRGKHNlZywgZGV2aWQpOw0KPiA+IC0NCj4gPiAgCWtmcmVl
KHNyY2lkX3B0cik7DQo+ID4gLQ0KPiA+IC0JcmV0dXJuIGNudDsNCj4gPiArCXJldHVybiAtRUlO
VkFMOw0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIGludCBkZXZpZF9zaG93KHN0cnVjdCBzZXFf
ZmlsZSAqbSwgdm9pZCAqdW51c2VkKQ0KPiA+IC0tDQo+ID4gMi45LjQNCj4gPg0K
