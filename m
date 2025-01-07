Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB2C1714CF
	for <iommu@lists.linux.dev>; Tue,  7 Jan 2025 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736253056; cv=none; b=Hc6hWqTwy6mw70Ws1vIc9raU25jljZF6sHIdZCrgQZjB/jWMzX/ZO2GEdb/822w26A0uNcmMFxQtzMAKdo5T55oam5r0v+qNY/sPlt+/pPBEo5oa00fNLWvG/UHEmDuIXQ0utl180mEkknBxiUyLvZjaxUtp0mv14UACuGnE3tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736253056; c=relaxed/simple;
	bh=yugBSyNcjYHfb2PYcGv2dvxLoaAt4avXElViN4jAPGI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AFLMfVSIbcvNPXkVKPzG4vXYO81YYrrm63cOcVFzuE/BNsqicBxVtJXCyF4r81ZnEgb4wdeBdsJJPEFHvWF8NhosqJnmxdtfzNgdQJD+P1vd2POC9NhFBMUdhei+mOWKwa8IJYw8IZGdD54YrT6Z3KTNnLpJKB3H/OxJRHWJqCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Vasant Hegde <vasant.hegde@amd.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogW1BBVENIXVt2Ml0gaW9tbXU6?=
 =?utf-8?Q?_move_the_adding_group_info_to_proper_place?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF1bdjJdIGlvbW11OiBtb3ZlIHRo?=
 =?utf-8?Q?e_adding_group_info_to_proper_place?=
Thread-Index: AQHbYLVFO1AW+mElyEO41nYmqp3VlLMKtgGAgACHpyA=
Date: Tue, 7 Jan 2025 12:30:09 +0000
Message-ID: <a78452d7e99e49e7af2b6e3a3c312bda@baidu.com>
References: <20250107033558.41135-1-lirongqing@baidu.com>
 <cafe5714-aeaa-4774-bdad-124e4e036ae7@amd.com>
In-Reply-To: <cafe5714-aeaa-4774-bdad-124e4e036ae7@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-FEAS-Client-IP: 10.127.64.36
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 52:10:53:SYSTEM

PiA+IC0JaWYgKElTX0VSUihnZGV2KSkNCj4gPiAtCQlyZXR1cm4gUFRSX0VSUihnZGV2KTsNCj4g
PiArCWlmIChJU19FUlIoZ2RldikpIHsNCj4gPiArCQlyZXQgPSBQVFJfRVJSKGdkZXYpOw0KPiA+
ICsJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGFkZCB0byBpb21tdSBncm91cCAlZDogJWRcbiIs
IGdyb3VwLT5pZCwNCj4gcmV0KTsNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiANCj4gV2h5IG5vdCBq
dXN0IHJldHVybiBQVFJfRVJSKGdkZXYpPw0KPiANCg0KU2luY2UgZGV2X2VyciB3aWxsIHByaW50
IFBUUl9FUlIoZ2RldiksIHNvIEkgZGVmaW5lIGEgbG9jYWwgdmFyaWFibGUgdG8gY29udmVyc2lv
biBvbmNlDQoNCg0KVGhhbmtzDQoNCi1MaQ0KDQo+IC1WYXNhbnQNCg0K
