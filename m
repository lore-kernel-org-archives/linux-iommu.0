Received: from outbound.baidu.com (mx16.baidu.com [111.202.115.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957F93FA5D0
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 03:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.115.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785813539; cv=none; b=QJL14nOLd426VP+WfBGtD30ZtxzSlPgjKfqA3hDruQZQrJcyoFudKqKGlDV3ShPla5x03pB6np2JX+KsTaryol0OaiPQmGOro6bFhF2QAZfqk6rwjGZGpgsKoE/aBNdevUxE6g7DQznbaGKfR9ICOsBhwwCnksbN43pfUDs7VVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785813539; c=relaxed/simple;
	bh=4RHsWvtLOPNmOi0/uipM+uK9FZxxhapozy5IbzHcDus=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SpiiFhKRxJ5FX4+34DK6CvyYeop98iXg4Or3YXDxt1A7Bcqf19B5HQ0VjDfiBOqH9R6SlwbviF8jIHBK9lNKGCktgPRJEJ4sN2IG56j20W7xnVcQOlXexYbLMewtkrjY2r9Wn3/y9EzWoJEPPRG3NKvHmxB2wPpERFL2bWh7Y04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=OqDqolrG; arc=none smtp.client-ip=111.202.115.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="OqDqolrG"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.3.13
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
CC: ZhaoJinming <zhaojinming@uniontech.com>, Kevin Tian
	<kevin.tian@intel.com>, Dmitry Antipov <dmantipov@yandex.ru>, Guanghui Feng
	<guanghuifeng@linux.alibaba.com>, Desnes Nunes <desnesn@redhat.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW83isr/Tyrz+XSBbUEFUQ0ggMDMvMjBdIGlvbW11L3Z0LWQ6IEZp?=
 =?gb2312?B?eCBDQUNIRV9UQUdfTkVTVElOR19ERVZUTEIgcG9sbHV0aW5nIHNoYXJlZCB2?=
 =?gb2312?Q?ariables_in_flush_loop?=
Thread-Topic: =?gb2312?B?W83isr/Tyrz+XSBbUEFUQ0ggMDMvMjBdIGlvbW11L3Z0LWQ6IEZpeCBDQUNI?=
 =?gb2312?B?RV9UQUdfTkVTVElOR19ERVZUTEIgcG9sbHV0aW5nIHNoYXJlZCB2YXJpYWJs?=
 =?gb2312?Q?es_in_flush_loop?=
Thread-Index: AQHdI7u9PHLwW8ne3kuSib2E6t7S+7aNNg3A
Date: Tue, 4 Aug 2026 03:16:33 +0000
Message-ID: <d507f3039cec41a0be8782df1196294f@baidu.com>
References: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
 <20260804023714.3080506-4-baolu.lu@linux.intel.com>
In-Reply-To: <20260804023714.3080506-4-baolu.lu@linux.intel.com>
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
	s=selector1; t=1785813401;
	bh=4RHsWvtLOPNmOi0/uipM+uK9FZxxhapozy5IbzHcDus=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=OqDqolrGs9Jz0HtxU/3LUl+MvFSAJGcT0ziraKKS8pso5/KMRgfyZPkFx8ve7GGZq
	 XxQVnCBVfhp2O7ZkT1q5YALDTP5qwjqcAxnpkqoiSRt6P0rpdHw7S1t0vRxFLc9gQ4
	 8y/bm/zDbzHLw3/o8gZJbW/gfeHmm5/YG7lDLfabqqHqDoLRE371tG3JrniuUeAFKt
	 LOKHW1Ua6H8mriJyvTUMIGqJYeyP+1g0QSKAILvlA5mPEnpca7+Q1/mFiij4HSW56v
	 a9ZRki86jXcVe+/+t+a1KWayJfoHFUM2PYalw4XchSnUrbDiX7ZVin8FQtGz1uqmDL
	 vdPAmer42HwTA==

DQoNCj4gRnJvbTogR3VhbmdodWkgRmVuZyA8Z3VhbmdodWlmZW5nQGxpbnV4LmFsaWJhYmEuY29t
Pg0KPiANCj4gSW4gY2FjaGVfdGFnX2ZsdXNoX3JhbmdlKCksIHRoZSBDQUNIRV9UQUdfTkVTVElO
R19ERVZUTEIgY2FzZSBtb2RpZmllcyB0aGUNCj4gc2hhcmVkIGxvY2FsIHZhcmlhYmxlcyAnYWRk
cicgYW5kICdtYXNrJyBiZWZvcmUgZmFsbGluZyB0aHJvdWdoIHRvDQo+IENBQ0hFX1RBR19ERVZU
TEIuIFRoaXMgY2F1c2VzIGFsbCBzdWJzZXF1ZW50IENBQ0hFX1RBR19ERVZUTEIgZW50cmllcyBp
bg0KPiB0aGUgc2FtZSBsb29wIGl0ZXJhdGlvbiB0byBpbmNvcnJlY3RseSB1c2UgdGhlIGZ1bGwt
cmFuZ2UgZmx1c2ggcGFyYW1ldGVycw0KPiAoYWRkcj0wLCBtYXNrPU1BWF9BR0FXX1BGTl9XSURU
SCkgaW5zdGVhZCBvZiB0aGUgcHJlY2lzZWx5IGNhbGN1bGF0ZWQgUFNJDQo+IHJhbmdlLiBUaGlz
IGlzIG5vdCB0aGUgaW50ZW5kZWQgYmVoYXZpb3IsIGFzIHJlZ3VsYXIgREVWVExCIGVudHJpZXMg
c2hvdWxkIGFsd2F5cw0KPiBwZXJmb3JtIHRhcmdldGVkIHJhbmdlLWJhc2VkIGludmFsaWRhdGlv
bi4NCj4gDQo+IEZpeCB0aGlzIGJ5IGhhdmluZyBDQUNIRV9UQUdfTkVTVElOR19ERVZUTEIgZGly
ZWN0bHkgY2FsbA0KPiBjYWNoZV90YWdfZmx1c2hfZGV2dGxiX3BzaSgpIHdpdGggdGhlIGZ1bGwt
cmFuZ2UgY29uc3RhbnRzIGFuZCBicmVhaywgaW5zdGVhZCBvZg0KPiBtb2RpZnlpbmcgc2hhcmVk
IHZhcmlhYmxlcyBhbmQgZmFsbGluZyB0aHJvdWdoLiBUaGlzIGVuc3VyZXMNCj4gQ0FDSEVfVEFH
X0RFVlRMQiBhbHdheXMgdXNlcyB0aGUgb3JpZ2luYWwgY2FsY3VsYXRlZCBhZGRyIGFuZCBtYXNr
IGZvcg0KPiBwcmVjaXNlIHJhbmdlIGZsdXNoLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3Vhbmdo
dWkgRmVuZyA8Z3VhbmdodWlmZW5nQGxpbnV4LmFsaWJhYmEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBHdWl4aW4gTGl1IDxrYW5pZUBsaW51eC5hbGliYWJhLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
THUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2lv
bW11L2ludGVsL2NhY2hlLmMgfCA1ICsrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUv
aW50ZWwvY2FjaGUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvY2FjaGUuYyBpbmRleA0KPiBmZGM4
ODgxNzcwOWYuLjI2YTc1OGIwZjUwMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRl
bC9jYWNoZS5jDQo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvY2FjaGUuYw0KPiBAQCAtNDU0
LDkgKzQ1NCw4IEBAIHZvaWQgY2FjaGVfdGFnX2ZsdXNoX3JhbmdlKHN0cnVjdCBkbWFyX2RvbWFp
bg0KPiAqZG9tYWluLCB1bnNpZ25lZCBsb25nIHN0YXJ0LA0KPiAgCQkJICogYWZmZWN0ZWQgYnkg
YSBjaGFuZ2UgaW4gUzIuIFNvIGp1c3QgZmx1c2ggdGhlIGVudGlyZQ0KPiAgCQkJICogZGV2aWNl
IGNhY2hlLg0KPiAgCQkJICovDQo+IC0JCQlhZGRyID0gMDsNCj4gLQkJCW1hc2sgPSBNQVhfQUdB
V19QRk5fV0lEVEg7DQo+IC0JCQlmYWxsdGhyb3VnaDsNCj4gKwkJCWNhY2hlX3RhZ19mbHVzaF9k
ZXZ0bGJfcHNpKGRvbWFpbiwgdGFnLCAwLA0KPiBNQVhfQUdBV19QRk5fV0lEVEgpOw0KPiArCQkJ
YnJlYWs7DQo+ICAJCWNhc2UgQ0FDSEVfVEFHX0RFVlRMQjoNCj4gIAkJCWNhY2hlX3RhZ19mbHVz
aF9kZXZ0bGJfcHNpKGRvbWFpbiwgdGFnLCBhZGRyLCBtYXNrKTsNCj4gIAkJCWJyZWFrOw0KPiAt
LQ0KPiAyLjQzLjANCg0KVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGEgc3VidGxlIHNpZGUgZWZmZWN0
IG9uIHRoZSB0cmFjaW5nIGxvZ2ljIGxhdGVyIGluIHRoaXMgZnVuY3Rpb24uIA0KQXQgdGhlIGVu
ZCBvZiBjYWNoZV90YWdfZmx1c2hfcmFuZ2UoKSwgdHJhY2VfY2FjaGVfdGFnX2ZsdXNoX3Jhbmdl
KHRhZywgc3RhcnQsIGVuZCwgYWRkciwgbWFzaykgaXMgY2FsbGVkIHRvIGxvZyANCnRoZSBmbHVz
aCBvcGVyYXRpb24uIA0KDQpXaXRoIHRoaXMgcGF0Y2g6IGJ5cGFzc2VkIHRoZSBhc3NpZ25tZW50
IGFuZCB1c2VkIGJyZWFrLCBhZGRyIGFuZCBtYXNrIHJldGFpbiB0aGVpciBvcmlnaW5hbCByYW5n
ZSB2YWx1ZXMuIA0KVGhpcyBjYXVzZXMgdGhlIHRyYWNlcG9pbnQgdG8gbG9nIGFuIGluY29ycmVj
dCwgc21hbGxlciByYW5nZSB3aGlsZSB0aGUgYWN0dWFsIGhhcmR3YXJlIGV4ZWN1dGlvbiB3YXMg
YSBmdWxsLXJhbmdlIGZsdXNoLg0KDQpNeSBwYXRjaCBoYXMgbm90IHRoaXMgaXNzdWU6DQpodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC1pb21tdS8yMDI2MDYwNTAwMzk1MC4xNzIwLTEtbGly
b25ncWluZ0BiYWlkdS5jb20vDQoNCnRoYW5rcw0KDQpbTGksUm9uZ3FpbmddIA0KDQoNCg==
