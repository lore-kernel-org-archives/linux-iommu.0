Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1524F15B546
	for <iommu@lists.linux.dev>; Fri, 29 Nov 2024 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732868547; cv=none; b=GcbcftE6j3GS8Uyfg3v6CVIveI6ZKB7STpe9ItTldhRgZ19gipK7+/pn3gmLFKePBSocdReW2vNo/8tDpu2KhwQ2+VcN3BJhhisaMZ3BxLhRqA2xmHTkyiV/MuN6X4rHu7FeH2vax3Bil7okE4kC+KxnnYF2SxMNzMec9eLRzLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732868547; c=relaxed/simple;
	bh=hcb2LqCyAjpwoJMf5fOXlZ1ZFJqCTJG00jA5M7m3a30=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iKPHPzIqjDqKw1AqU/CHz/c8AsPbIPwmx56zZaCUyRpqz0xt1f2qateISb7xj9Ljbt56lXKtoxoMAguVQLKbzZ0ekPR6z+Jbd5EnO6QBPSnrYYHBZnPqRuIWPGSnyL1aIn2F4DnpAPvsnMtxI6Y5N1E3n4B4xrsfGqRCncyqaZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Robin Murphy <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
Subject: =?gb2312?B?tPC4tDogtPC4tDogW83isr/Tyrz+XSBSZTogW1BBVENIXSBpb21tdTogRG93?=
 =?gb2312?Q?ngrade_print_level_for_iommu_group_information?=
Thread-Topic: =?gb2312?B?tPC4tDogW83isr/Tyrz+XSBSZTogW1BBVENIXSBpb21tdTogRG93bmdyYWRl?=
 =?gb2312?Q?_print_level_for_iommu_group_information?=
Thread-Index: AQHbP9QeWUzuckcZdkSzAw8EsVkyY7LI7J8AgACIV2CAAPAlgIAAk2dwgALMshA=
Date: Fri, 29 Nov 2024 08:21:51 +0000
Message-ID: <c30af43b93f04125bf9befe631922653@baidu.com>
References: <20241126072339.25714-1-lirongqing@baidu.com>
 <84cb9155-4793-45f9-bb67-6926e103dc84@arm.com>
 <e790f039210f4bd78a015a6fa439c607@baidu.com> <Z0bxg0P9AtSHW82A@google.com>
 <48c3a7570e7140ec8c429f00112de7f7@baidu.com>
In-Reply-To: <48c3a7570e7140ec8c429f00112de7f7@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-baidu-bdmsfe-datecheck: 1_BJHW-Mail-Ex16_2024-11-29 16:21:52:081
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.45
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 52:10:53:SYSTEM

PiANCj4gSSBmcmVlIHRoaXMgbG9nIGlzIHVzZWxlc3M7IHNpbmNlIGlvbW11X2dyb3VwX2FsbG9j
X2RldmljZSBvbmx5IGFsbG9jYXRlcyBkZXZpY2UNCj4gYW5kIHN5c2ZzLCBub3QgYXR0YWNoIGdy
b3VwIGRvbWFpbiBjdXJyZW50bHkuDQo+IElmIGZhaWxlZCwgIiBGYWlsZWQgdG8gYWRkIHRvIGlv
bW11IGdyb3VwICIgd2lsbCBiZSBwcmludGVkLCBpdCBpcyBtb3JlIGltcG9ydGFudCB0bw0KPiBu
b3RpY2UgdXNlci4NCj4gDQoNCkFmdGVyIHRoaXMgcGF0Y2goaW9tbXU6IFNwbGl0IGlvbW11X2dy
b3VwX2FkZF9kZXZpY2UoKSksIHNob3VsZCB0aGlzIGxvZyBiZSBtb3ZlZCB0byBpb21tdV9ncm91
cF9hZGRfZGV2aWNlIGFuZCBfX2lvbW11X3Byb2JlX2RldmljZSA/IHRoZXkgYXJlIGFkZGluZyBk
ZXZpY2UgdG8gaW9tbXUgZ3JvdXAsIG5vdCBiZSBpbiBpb21tdV9ncm91cF9hbGxvY19kZXZpY2Ug
d2hpY2ggb25seSBhbGxvY2F0ZSByZXNvdXJjZSANCg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
b21tdS9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pb21tdS5jDQppbmRleCA4M2M4ZTYxLi5jMzNm
ZjBlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9pb21tdS5jDQorKysgYi9kcml2ZXJzL2lv
bW11L2lvbW11LmMNCkBAIC01ODEsNiArNTgxLDkgQEAgc3RhdGljIGludCBfX2lvbW11X3Byb2Jl
X2RldmljZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBsaXN0X2hlYWQgKmdyb3VwX2xpc3QN
Cg0KICAgICAgICBtdXRleF91bmxvY2soJmdyb3VwLT5tdXRleCk7DQoNCisgICAgICAgdHJhY2Vf
YWRkX2RldmljZV90b19ncm91cChncm91cC0+aWQsIGRldik7DQorICAgICAgIGRldl9pbmZvKGRl
diwgIkFkZGluZyB0byBpb21tdSBncm91cCAlZFxuIiwgZ3JvdXAtPmlkKTsNCisNCiAgICAgICAg
cmV0dXJuIDA7DQoNCiBlcnJfcmVtb3ZlX2dkZXY6DQpAQCAtMTE5MSw5ICsxMTk0LDYgQEAgc3Rh
dGljIHN0cnVjdCBncm91cF9kZXZpY2UgKmlvbW11X2dyb3VwX2FsbG9jX2RldmljZShzdHJ1Y3Qg
aW9tbXVfZ3JvdXAgKmdyb3VwLA0KICAgICAgICAgICAgICAgIGdvdG8gZXJyX2ZyZWVfbmFtZTsN
CiAgICAgICAgfQ0KDQotICAgICAgIHRyYWNlX2FkZF9kZXZpY2VfdG9fZ3JvdXAoZ3JvdXAtPmlk
LCBkZXYpOw0KLQ0KLSAgICAgICBkZXZfaW5mbyhkZXYsICJBZGRpbmcgdG8gaW9tbXUgZ3JvdXAg
JWRcbiIsIGdyb3VwLT5pZCk7DQoNCiAgICAgICAgcmV0dXJuIGRldmljZTsNCg0KQEAgLTEyMjks
NiArMTIyOSwxMCBAQCBpbnQgaW9tbXVfZ3JvdXBfYWRkX2RldmljZShzdHJ1Y3QgaW9tbXVfZ3Jv
dXAgKmdyb3VwLCBzdHJ1Y3QgZGV2aWNlICpkZXYpDQogICAgICAgIG11dGV4X2xvY2soJmdyb3Vw
LT5tdXRleCk7DQogICAgICAgIGxpc3RfYWRkX3RhaWwoJmdkZXYtPmxpc3QsICZncm91cC0+ZGV2
aWNlcyk7DQogICAgICAgIG11dGV4X3VubG9jaygmZ3JvdXAtPm11dGV4KTsNCisNCisgICAgICAg
dHJhY2VfYWRkX2RldmljZV90b19ncm91cChncm91cC0+aWQsIGRldik7DQorICAgICAgIGRldl9p
bmZvKGRldiwgIkFkZGluZyB0byBpb21tdSBncm91cCAlZFxuIiwgZ3JvdXAtPmlkKTsNCisNCiAg
ICAgICAgcmV0dXJuIDA7DQogfQ0KIEVYUE9SVF9TWU1CT0xfR1BMKGlvbW11X2dyb3VwX2FkZF9k
ZXZpY2UpOw0K
