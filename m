Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39C01B011B
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926227; cv=none; b=OkgG6mxmaU6phSjZCxt0vG6PRNPc1ePN8t8xGpWBDDfqb3qy99H84EyvpjuMCJVNPxWjs2p6T93VQhW1VvXcn5+u0MJYMcqMGxJNcl5HxtpGe04jhdUN8B7vUCjsT0mKEHivNaGL2mUXnVc/cnmfxbeSV+JQhnDWLp+mWjwgjW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926227; c=relaxed/simple;
	bh=w0ZLtkpjEv3odb0GfouyXVdIbuPriXsc+K8yvwCobPk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J6SMggTj1Wb87VM+c/8XuflhJIRE8DBIIeSUVf27y4JsOMspC+2GNwgZeEK+r1WXCelFRm1/nxnc4p6075FBrBkh+CViDLtmmcQ74aNVMkpf7eXM8QxGKhw1y32oPd95ucCSqXIHyTEuZTq0djmlgFv6TDpyEuKZhlXNUXj8HDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WD3H22bS9z1T4b9;
	Tue,  2 Jul 2024 21:12:30 +0800 (CST)
Received: from dggems702-chm.china.huawei.com (unknown [10.3.19.179])
	by mail.maildlp.com (Postfix) with ESMTPS id 8092E1800C1;
	Tue,  2 Jul 2024 21:16:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 21:16:00 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.039;
 Tue, 2 Jul 2024 14:15:58 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Will Deacon <will@kernel.org>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "mshavit@google.com" <mshavit@google.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, jiangkunkun <jiangkunkun@huawei.com>, zhukeqian
	<zhukeqian1@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v6 0/6] Add IOMMUFD dirty tracking support for SMMUv3
Thread-Topic: [PATCH v6 0/6] Add IOMMUFD dirty tracking support for SMMUv3
Thread-Index: AQHavaAtXJbwpOXZKECCEVEjdmiJ9bHjiG1Q
Date: Tue, 2 Jul 2024 13:15:57 +0000
Message-ID: <f88aeb0364884db994e4cba22b1e9ad5@huawei.com>
References: <20240613144149.38672-1-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20240613144149.38672-1-shameerali.kolothum.thodi@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
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

SGkgV2lsbCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1h
cm0ta2VybmVsIDxsaW51eC1hcm0ta2VybmVsLWJvdW5jZXNAbGlzdHMuaW5mcmFkZWFkLm9yZz4g
T24NCj4gQmVoYWxmIE9mIFNoYW1lZXIgS29sb3RodW0NCj4gU2VudDogVGh1cnNkYXksIEp1bmUg
MTMsIDIwMjQgMzo0MiBQTQ0KPiBUbzogaW9tbXVAbGlzdHMubGludXguZGV2OyBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gQ2M6IHJvYmluLm11cnBoeUBhcm0uY29tOyB3
aWxsQGtlcm5lbC5vcmc7IGpvcm9AOGJ5dGVzLm9yZzsNCj4gamdnQG52aWRpYS5jb207IHJ5YW4u
cm9iZXJ0c0Bhcm0uY29tOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4ga2V2aW4udGlhbkBpbnRl
bC5jb207IG5pY29saW5jQG52aWRpYS5jb207IG1zaGF2aXRAZ29vZ2xlLmNvbTsNCj4gZXJpYy5h
dWdlckByZWRoYXQuY29tOyBqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tOyBqaWFuZ2t1bmt1bg0K
PiA8amlhbmdrdW5rdW5AaHVhd2VpLmNvbT47IHpodWtlcWlhbiA8emh1a2VxaWFuMUBodWF3ZWku
Y29tPjsNCj4gTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFtQQVRD
SCB2NiAwLzZdIEFkZCBJT01NVUZEIGRpcnR5IHRyYWNraW5nIHN1cHBvcnQgZm9yIFNNTVV2Mw0K
PiANCj4gSGksDQo+IA0KPiB2NSAtLT4gdjYNCj4gIC1NaW5vciB1cGRhdGVzIGJhc2VkIG9uIE5p
Y29saW4ncyBmZWVkYmFjay4NCj4gIC1QaWNrZWQgdXAgUi1ieSB0YWdzIGJ5IEphc29uLCBOaWNv
bGluIGFuZCBLZXZpbihUaGFua3MhKQ0KPiANCj4gSGkgV2lsbCwNCj4gDQo+IE5vdCBzdXJlIHlv
dSBnb3QgYSBjaGFuY2UgdG8gdGFrZSBhIGxvb2sgYXQgdGhpc8Kgc2VyaWVzIHlldC4gSG9wZWZ1
bGx5DQo+IHRoaXMgd2lsbCBtYWtlIGl0IGZvciA2LjExLg0KDQpBIGdlbnRsZSBwaW5nIG9uIHRo
aXMuDQoNClRoYW5rcywNClNoYW1lZXINCiANCg0K
