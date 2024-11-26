Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6347139D07
	for <iommu@lists.linux.dev>; Tue, 26 Nov 2024 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732620191; cv=none; b=rCUdJEro5i7BNhmxUX6e/xuargJ+E0eLOcBLsB9SP7Kn32NIlCYav4a3xHzHJBiIbWiJ0Uf11/nqyNolLbDY79M4bbKKmlxtdYVitrKhdfjrcrKtC3HcmN/Z6GLKM2PJMO03W/VXcOA3vrnRRvnKOzKoVb+3VHGlMhSgpMrr4xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732620191; c=relaxed/simple;
	bh=iuj+9MekggZJPogKEZSmJpClsqdw/CGh45nu397PJoQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TW8kx9HJe3aD4n3zrozzkefV/3KATLmBlJ5MuJSLwDlnvoDXP9x8KhSBKLi3qTEmxJyXSmWV1yGurj7707JCvp/Mh/XJXXtQsRBUeGwd5jbanTA/9wCjVyPV91Q6F3kpadYK3W7PT4JFojMptayCPdKTXsq5QPmOOiR5YAhWNYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Pranjal Shrivastava <praan@google.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
Subject: =?gb2312?B?tPC4tDogWz8/Pz9dIFJlOiBbUEFUQ0hdIGlvbW11OiBEb3duZ3JhZGUgcHJp?=
 =?gb2312?Q?nt_level_for_iommu_group_information?=
Thread-Topic: [????] Re: [PATCH] iommu: Downgrade print level for iommu group
 information
Thread-Index: AQHbP9QeWUzuckcZdkSzAw8EsVkyY7LI1TKAgACMB2A=
Date: Tue, 26 Nov 2024 10:47:17 +0000
Message-ID: <2d41f35db0794b1fbe20a51ccd35e2a9@baidu.com>
References: <20241126072339.25714-1-lirongqing@baidu.com>
 <Z0WiC4lWxFdY-_JO@google.com>
In-Reply-To: <Z0WiC4lWxFdY-_JO@google.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-baidu-bdmsfe-datecheck: 1_BJHW-Mail-Ex15_2024-11-26 18:47:17:582
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-FEAS-Client-IP: 10.127.64.38
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 52:10:53:SYSTEM

PiA+ICAJdHJhY2VfYWRkX2RldmljZV90b19ncm91cChncm91cC0+aWQsIGRldik7DQo+ID4NCj4g
PiAtCWRldl9pbmZvKGRldiwgIkFkZGluZyB0byBpb21tdSBncm91cCAlZFxuIiwgZ3JvdXAtPmlk
KTsNCj4gPiArCWRldl9kYmcoZGV2LCAiQWRkaW5nIHRvIGlvbW11IGdyb3VwICVkXG4iLCBncm91
cC0+aWQpOw0KPiANCj4gSSdtIG5vdCBzdXJlIHRoZSBvcmlnaW5hbCByZWFzb24gYmVoaW5kIHRo
aXMgYGRldl9pbmZvYCBidXQgb2YgbGF0ZSBJJ3ZlIHNlZW4NCj4gcGVvcGxlL3NjcmlwdHMgdXNl
IHRoaXMgbG9nIHRvIGZpbmQgdGhlIGlvbW11X2dyb3VwIGZvciBhIGRldmljZSB0byBsYXRlciBz
ZXQgdGhlDQo+IGRlZmF1bHQgZG9tYWluIHZpYSAvc3lzL2tlcm5lbC9pb21tdV9ncm91cHMvPGdy
cF9pZD4vdHlwZQ0KPiANCj4gVGhhdCBzYWlkIHdpdGggdGhpcyBjaGFuZ2UsIHRob3NlIHNjcmlw
dHMgc2hvdWxkIHN0aWxsIGJlIGFibGUgdG8gZmluZCB0aGUNCj4gaW9tbXVfZ3JvdXAgdmlhIC9z
eXMvYnVzLzxidXNfdHlwZT4vZGV2aWNlcy88ZGV2aWNlPi9pb21tdV9ncm91cA0KPiBNYXliZSBh
ZGRpbmcgdGhpcyBpbmZvIHRvIHRoZSBjb21taXQgbWVzc2FnZSB3aWxsIGhlbHAgdGhlbT8NCj4g
DQoNClRoYW5rcywgSSB3aWxsIHNlbmQgdjINCg0KLUxpDQoNCj4gPg0KPiA+ICAJcmV0dXJuIGRl
dmljZTsNCj4gPg0KPiA+IC0tDQo+ID4gMi45LjQNCj4gPg0KPiA+DQo+IA0KPiBUaGFua3MsDQo+
IFByYWFuDQo=
