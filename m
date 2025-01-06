Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D2C1DE2AC
	for <iommu@lists.linux.dev>; Mon,  6 Jan 2025 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736165776; cv=none; b=MD6hF/5QLl94uUAtOWBdrM2+WwWefJ/yak316G3FCxdeOeFQ0Poro9+m/Dx7hkfObmaXA98+xbCZUgfkYjYqhD47qDH2ZJhIqX+8qcPoC1Z94tsv3fz7fcmJ077rHhrDL4iaRjhoHHmkVrF8BCZVQmmGlwsHJ8S2rVzpIQWKgwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736165776; c=relaxed/simple;
	bh=Z2Ax7T3P4sKOBEIfr7TC8Pik/TNgd/Hp3wBp8EFIeOg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GylyiYfeBUu4ohjZZJJTQveTRivoQgtpjlCGAApl73PMlhz/1qMqPjSQemH7XFWpY5ut5k1cBt9sHnoLLVBoj7SPvUTx2n5S9iawnl0zd5ltjX3K5OrCg7R1E77Fnv33IkwLP3CywCF7znXb7dCwEa/zQhrrQJ1e/hBe6c5soFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Vasant Hegde <vasant.hegde@amd.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>
Subject: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogW1BBVENIXSBpb21tdTogbW92?=
 =?utf-8?Q?e_the_adding_group_info_to_proper_place?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF0gaW9tbXU6IG1vdmUgdGhlIGFk?=
 =?utf-8?Q?ding_group_info_to_proper_place?=
Thread-Index: AQHbXaBIEJfoKhEg2Uey3Jmee+SaRrMJEZoAgACcXgA=
Date: Mon, 6 Jan 2025 12:15:36 +0000
Message-ID: <e67792513f494bb385d9ca86d82d10f5@baidu.com>
References: <20250103052811.39544-1-lirongqing@baidu.com>
 <ac420b8a-cd5b-41dc-8a4d-247f560a9043@amd.com>
In-Reply-To: <ac420b8a-cd5b-41dc-8a4d-247f560a9043@amd.com>
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
X-FEAS-Client-IP: 172.31.51.54
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 52:10:53:SYSTEM

PiANCj4gT24gMS8zLzIwMjUgMTA6NTggQU0sIExpIFJvbmdRaW5nIHdyb3RlOg0KPiA+IEFmdGVy
IGNvbW1pdCBmYTA4MjgwMzY0ODggKCJpb21tdTogU3BsaXQgaW9tbXVfZ3JvdXBfYWRkX2Rldmlj
ZSgpIiksDQo+ID4gdGhlIGFkZGluZyBncm91cCBpbmZvcm1hdGlvbiBpcyBsZWZ0IGluIGlvbW11
X2dyb3VwX2FsbG9jX2RldmljZSwgYnV0DQo+ID4NCj4gPiBAQCAtMTIzMCw2ICsxMjI5LDEwIEBA
IGludCBpb21tdV9ncm91cF9hZGRfZGV2aWNlKHN0cnVjdA0KPiBpb21tdV9ncm91cA0KPiA+ICpn
cm91cCwgc3RydWN0IGRldmljZSAqZGV2KQ0KPiANCj4gQWRkIGVycm9yIG1lc3NhZ2UgaWYgaW9t
bXVfZ3JvdXBfYWxsb2NfZGV2aWNlKCkgZmFpbHMgaGVyZT8NCj4gDQoNCk9rLCBJIHdpbGwgYWRk
IGEgZXJyb3IgbWVzc2FnZSBoZXJlDQoNClRoYW5rcw0KDQotTGkNCg0KPiAtVmFzYW50DQoNCg==
