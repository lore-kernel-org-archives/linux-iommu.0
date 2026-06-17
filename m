Received: from outbound.baidu.com (mx21.baidu.com [220.181.3.85])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 829A13C1992
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 07:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781682733; cv=none; b=c35KjH52WIksppD3kEyvm95MgBAzLSTVPYESn6/cKWNzo6N6DkANYswt08/anBhWri8lmNeSTq75BkHWae/+IoujrGDma18dO84vGRyQYbJnwgT+z9LvRtXpFyxzIy4GlH8IZeqZoMNJF6wEU525d3jhcYmldsrou0kgdl36xRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781682733; c=relaxed/simple;
	bh=7L0WEiCD9CDQiR5uzRwura9lo0Ci0ecdBcOqtxFunEs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BiqM8Huns3mLx3Y84WY+vq/Y22YZSr/cYLZ8YaEv135wwdfqknIlTH07yOLZXnDl1aUnAYZl3FoaMr7qItLgM9xmNZFDkqYExav6GX2EMCCTkjygc3OjDDwZ7ZYyKjp7uc9H75RkwJTqYW9QEs4jThKdge857v15btFG09kRpdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=fail (0-bit key) header.d=baidu.com header.i=@baidu.com header.b=RT1D7Zrb reason="key not found in DNS"; arc=none smtp.client-ip=220.181.3.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=baidu.com header.i=@baidu.com header.b="RT1D7Zrb"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.3.13
From: "Li,Rongqing" <lirongqing@baidu.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBpb21tdS9pbnRlbDogUHJldmVudCB2YXJpYWJsZSBw?=
 =?gb2312?B?b2xsdXRpb24gaW4gY2FjaGVfdGFnX2ZsdXNoX3JhbmdlKCk=?=
Thread-Topic: [PATCH] iommu/intel: Prevent variable pollution in
 cache_tag_flush_range()
Thread-Index: AQHc9IPa1V1PHVqOsUi1nuE3fIU8EbZCcx4A
Date: Wed, 17 Jun 2026 07:51:39 +0000
Message-ID: <2ffd9844662a46d6acb975d14d14947b@baidu.com>
References: <20260605003950.1720-1-lirongqing@baidu.com>
In-Reply-To: <20260605003950.1720-1-lirongqing@baidu.com>
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
	s=selector1; t=1781682704;
	bh=7L0WEiCD9CDQiR5uzRwura9lo0Ci0ecdBcOqtxFunEs=;
	h=From:To:Subject:Date:Message-ID:Content-Type;
	b=RT1D7Zrblv3dyY0KvAY3zb5/OUrNZOU/Ik+wUu5hTE3IWceYRxhsqsmESIQf+151D
	 qr/xiqPApN9a29N0V0U4HnuJEezs3LzwrDEWVyFhkfHP3IQPb1/qmNPn7223qZMxqG
	 PAsevuRksOnZShMmSKAoGHooDftHvrWp4zY8sJGZMdIYe+q34L0AyS9dpkuYJlkGb2
	 Fb6v0MNEEqubv8VUqxVSp8AAyz10ecFRZz3VAfGQSJuYqIPzHR7XpsYIi2dh7NeZD4
	 iLyVZUw1g4g8Be8aw2FMWXjB2GMR1wnimsJJUIVWvPd1pNPkPHVg6Xd6EhWP0viMkg
	 0Lyjy82fbKAAw==

PiANCj4gRnJvbTogTGkgUm9uZ1FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPg0KPiANCj4gVGhl
IGxvb3AgaW4gY2FjaGVfdGFnX2ZsdXNoX3JhbmdlKCkgbW9kaWZpZXMgbG9jYWwgJ2FkZHInIGFu
ZCAnbWFzaycNCj4gdmFyaWFibGVzIHRoYXQgcGVyc2lzdCBhY3Jvc3MgaXRlcmF0aW9ucy4gV2hl
biBDQUNIRV9UQUdfTkVTVElOR19ERVZUTEINCj4gb3ZlcnJpZGVzIHRoZW0gZm9yIGEgZnVsbCBm
bHVzaCBhbmQgZmFsbHMgdGhyb3VnaCwgc3Vic2VxdWVudCB0YWdzIGluY29ycmVjdGx5DQo+IHJl
Y2VpdmUgdGhlIG1vZGlmaWVkIHZhbHVlcyBpbnN0ZWFkIG9mIHRoZSBvcmlnaW5hbCByYW5nZS4N
Cj4gDQo+IEZpeCBieSBjcmVhdGluZyBwZXItaXRlcmF0aW9uIGxvY2FsIGNvcGllcyBpbml0aWFs
aXplZCBmcm9tIHRoZSBvcmlnaW5hbCBwYXJhbWV0ZXJzLA0KPiBlbnN1cmluZyBlYWNoIHRhZyBw
cm9jZXNzZXMgdGhlIGludGVuZGVkIGZsdXNoIHJhbmdlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
TGkgUm9uZ1FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPg0KDQpQaW5nDQoNCg0KW0xpLFJvbmdx
aW5nXSANCg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9pb21tdS9pbnRlbC9jYWNoZS5jIHwgMTMgKysr
KysrKystLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2NhY2hlLmMgYi9k
cml2ZXJzL2lvbW11L2ludGVsL2NhY2hlLmMgaW5kZXgNCj4gZmRjODg4MS4uOTI1MzAyNSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9jYWNoZS5jDQo+ICsrKyBiL2RyaXZlcnMv
aW9tbXUvaW50ZWwvY2FjaGUuYw0KPiBAQCAtNDM3LDYgKzQzNyw5IEBAIHZvaWQgY2FjaGVfdGFn
X2ZsdXNoX3JhbmdlKHN0cnVjdCBkbWFyX2RvbWFpbg0KPiAqZG9tYWluLCB1bnNpZ25lZCBsb25n
IHN0YXJ0LA0KPiANCj4gIAlzcGluX2xvY2tfaXJxc2F2ZSgmZG9tYWluLT5jYWNoZV9sb2NrLCBm
bGFncyk7DQo+ICAJbGlzdF9mb3JfZWFjaF9lbnRyeSh0YWcsICZkb21haW4tPmNhY2hlX3RhZ3Ms
IG5vZGUpIHsNCj4gKwkJdW5zaWduZWQgbG9uZyBmbHVzaF9hZGRyID0gYWRkcjsNCj4gKwkJdW5z
aWduZWQgbG9uZyBmbHVzaF9tYXNrID0gbWFzazsNCj4gKw0KPiAgCQlpZiAoaW9tbXUgJiYgaW9t
bXUgIT0gdGFnLT5pb21tdSkNCj4gIAkJCXFpX2JhdGNoX2ZsdXNoX2Rlc2NzKGlvbW11LCBkb21h
aW4tPnFpX2JhdGNoKTsNCj4gIAkJaW9tbXUgPSB0YWctPmlvbW11Ow0KPiBAQCAtNDQ0LDcgKzQ0
Nyw3IEBAIHZvaWQgY2FjaGVfdGFnX2ZsdXNoX3JhbmdlKHN0cnVjdCBkbWFyX2RvbWFpbg0KPiAq
ZG9tYWluLCB1bnNpZ25lZCBsb25nIHN0YXJ0LA0KPiAgCQlzd2l0Y2ggKHRhZy0+dHlwZSkgew0K
PiAgCQljYXNlIENBQ0hFX1RBR19JT1RMQjoNCj4gIAkJY2FzZSBDQUNIRV9UQUdfTkVTVElOR19J
T1RMQjoNCj4gLQkJCWNhY2hlX3RhZ19mbHVzaF9pb3RsYihkb21haW4sIHRhZywgYWRkciwgbWFz
aywgaWgpOw0KPiArCQkJY2FjaGVfdGFnX2ZsdXNoX2lvdGxiKGRvbWFpbiwgdGFnLCBmbHVzaF9h
ZGRyLCBmbHVzaF9tYXNrLCBpaCk7DQo+ICAJCQlicmVhazsNCj4gIAkJY2FzZSBDQUNIRV9UQUdf
TkVTVElOR19ERVZUTEI6DQo+ICAJCQkvKg0KPiBAQCAtNDU0LDE1ICs0NTcsMTUgQEAgdm9pZCBj
YWNoZV90YWdfZmx1c2hfcmFuZ2Uoc3RydWN0IGRtYXJfZG9tYWluDQo+ICpkb21haW4sIHVuc2ln
bmVkIGxvbmcgc3RhcnQsDQo+ICAJCQkgKiBhZmZlY3RlZCBieSBhIGNoYW5nZSBpbiBTMi4gU28g
anVzdCBmbHVzaCB0aGUgZW50aXJlDQo+ICAJCQkgKiBkZXZpY2UgY2FjaGUuDQo+ICAJCQkgKi8N
Cj4gLQkJCWFkZHIgPSAwOw0KPiAtCQkJbWFzayA9IE1BWF9BR0FXX1BGTl9XSURUSDsNCj4gKwkJ
CWZsdXNoX2FkZHIgPSAwOw0KPiArCQkJZmx1c2hfbWFzayA9IE1BWF9BR0FXX1BGTl9XSURUSDsN
Cj4gIAkJCWZhbGx0aHJvdWdoOw0KPiAgCQljYXNlIENBQ0hFX1RBR19ERVZUTEI6DQo+IC0JCQlj
YWNoZV90YWdfZmx1c2hfZGV2dGxiX3BzaShkb21haW4sIHRhZywgYWRkciwgbWFzayk7DQo+ICsJ
CQljYWNoZV90YWdfZmx1c2hfZGV2dGxiX3BzaShkb21haW4sIHRhZywgZmx1c2hfYWRkciwgZmx1
c2hfbWFzayk7DQo+ICAJCQlicmVhazsNCj4gIAkJfQ0KPiANCj4gLQkJdHJhY2VfY2FjaGVfdGFn
X2ZsdXNoX3JhbmdlKHRhZywgc3RhcnQsIGVuZCwgYWRkciwgbWFzayk7DQo+ICsJCXRyYWNlX2Nh
Y2hlX3RhZ19mbHVzaF9yYW5nZSh0YWcsIHN0YXJ0LCBlbmQsIGZsdXNoX2FkZHIsIGZsdXNoX21h
c2spOw0KPiAgCX0NCj4gIAlxaV9iYXRjaF9mbHVzaF9kZXNjcyhpb21tdSwgZG9tYWluLT5xaV9i
YXRjaCk7DQo+ICAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZG9tYWluLT5jYWNoZV9sb2NrLCBm
bGFncyk7DQo+IC0tDQo+IDIuOS40DQoNCg==
