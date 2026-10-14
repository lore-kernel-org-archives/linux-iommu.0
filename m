Received: from outbound.baidu.com (mx14.baidu.com [220.181.3.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F163D7A01
	for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 06:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791958598; cv=none; b=jy95JobgtlCVmljSEjgI+LevTuGblzm+a3s0nNtKNdcMAaCfuzOEcAQupUnlmCQj6ZBcazwIhaNp6V5/mBfBMdNfWb+jm8yH+LPSj6yjJBEwK82dU5BpsOMFD7Hw8Rrgn8FMXrlsM82EV8mrat+/ZYjRsZq5EdMMBNiOxsoHzr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791958598; c=relaxed/simple;
	bh=YLSanVQ9mCCW8n/vP8NvzrZDAZE27AP8MG/A55H4EQM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i2eMLk3a1jfJyzeXKcV43Qw5hdgI5KMylKe44V3rgjl8HUYvWQDpPyyYjn/WREUTULjA6ynZGocxGdexWgCR8aCxjrJDyIOgxmtDgMTfacKgSbnX8P3zHAfsoRNOUS1v8lE2Vhuuo4GECUoHZ8vKvVuHDZgSx/l6jgUtTaLz53c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=KHVOGKTA; arc=none smtp.client-ip=220.181.3.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="KHVOGKTA"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.3.12
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBpb21tdS9hbWQ6IFJDVS1wcm90ZWN0IGlvbW11X2dh?=
 =?gb2312?B?X2xvZ19ub3RpZmllcg==?=
Thread-Topic: [PATCH] iommu/amd: RCU-protect iommu_ga_log_notifier
Thread-Index: AQHdS/CJ6R9FuVCvj06ptfGQFjiYz7b8roAw
Date: Wed, 14 Oct 2026 06:14:12 +0000
Message-ID: <204090a962c24642ab3d94aadaadc851@baidu.com>
References: <20260924064709.2194-1-lirongqing@baidu.com>
In-Reply-To: <20260924064709.2194-1-lirongqing@baidu.com>
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
	s=selector1; t=1791958456;
	bh=YLSanVQ9mCCW8n/vP8NvzrZDAZE27AP8MG/A55H4EQM=;
	h=From:To:Subject:Date:Message-ID:Content-Type;
	b=KHVOGKTApZhH28YyWkScNK0LIh7q/yme16S6/pwcm3uqzJapIsx5sobPqbJhc2lKC
	 7pMiAxq7Ya/Vr7X4yyYUirYMHM9QpGsuQ8lMfEss/ccWahgvlxZ3FlCy+itc4MOLcy
	 Ndc1Q0NsAQ7q1pZGiXUdMMmsCbJSvi00itugJiJUQQo+XzSvB6Po/+dJetJqIFEBaK
	 4ktoB8ZNEUhcpBQsJcsKBodfl4G+mlE93LH+aejsXnvzKs8966KCIKpgZCqcl4LhrC
	 faITkvdPyeRTlw8tDD8itYAEOKVvp/EcTqTi1eyR9W8f+eV0Q6ykblBw1OFtq//mUg
	 kV1RMkBO0+tcQ==

PiBGcm9tOiBMaSBSb25nUWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+IA0KPiBpb21tdV9w
b2xsX2dhX2xvZygpIGFjY2Vzc2VzIGlvbW11X2dhX2xvZ19ub3RpZmllciB3aXRob3V0IGFuIFJD
VQ0KPiByZWFkLXNpZGUgY3JpdGljYWwgc2VjdGlvbiwgc28gc3luY2hyb25pemVfcmN1KCkgaW4g
dGhlIHVucmVnaXN0ZXIgcGF0aCBkb2VzIG5vdA0KPiB3YWl0IGZvciBhbiBpbi1mbGlnaHQgbm90
aWZpZXIgY2FsbGJhY2suDQo+IA0KPiBVc2UgcmN1X2Fzc2lnbl9wb2ludGVyKCkgd2hlbiB1cGRh
dGluZyB0aGUgbm90aWZpZXIgYW5kDQo+IHJjdV9kZXJlZmVyZW5jZSgpIHVuZGVyIHNjb3BlZF9n
dWFyZChyY3UpIHdoZW4gaW52b2tpbmcgaXQuIExvYWQgdGhlDQo+IHBvaW50ZXIgb25jZSB0byBj
bG9zZSB0aGUgcmFjZSB3aXRoIHVucmVnaXN0ZXIuDQo+IA0KPiBLZWVwIHRoZSBSQ1UgcmVhZC1z
aWRlIGNyaXRpY2FsIHNlY3Rpb24gbWluaW1hbDogb25seSB0aGUgcG9pbnRlciBsb2FkIGFuZA0K
PiB0aGUgaW5kaXJlY3Qgbm90aWZpZXIgY2FsbCBzdGF5IGluc2lkZSBzY29wZWRfZ3VhcmQocmN1
KS4gTW92ZSBwcl9kZWJ1ZyBhbmQNCj4gcHJfZXJyIG91dHNpZGUgdGhlIHNlY3Rpb24gc28gdGhh
dCBsb2dnaW5nIGRvZXMgbm90IGV4dGVuZCB0aGUgd2luZG93IHRoYXQNCj4gc3luY2hyb25pemVf
cmN1KCkgbXVzdCB3YWl0IGZvci4NCj4gDQoNClBpbmcNCg0KdGhhbmtzDQoNCltMaSxSb25ncWlu
Z10gDQoNCg0KPiBTaWduZWQtb2ZmLWJ5OiBMaSBSb25nUWluZyA8bGlyb25ncWluZ0BiYWlkdS5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9pb21tdS9hbWQvaW9tbXUuYyB8IDMwICsrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyks
IDExIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvYW1kL2lv
bW11LmMgYi9kcml2ZXJzL2lvbW11L2FtZC9pb21tdS5jDQo+IGluZGV4IGEwNmNkNjEuLmEzMTQ2
NGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvYW1kL2lvbW11LmMNCj4gKysrIGIvZHJp
dmVycy9pb21tdS9hbWQvaW9tbXUuYw0KPiBAQCAtMTA1NCwxMSArMTA1NCwxMSBAQCBzdGF0aWMg
dm9pZCBpb21tdV9wb2xsX2V2ZW50cyhzdHJ1Y3QNCj4gYW1kX2lvbW11ICppb21tdSkgIH0NCj4g
DQo+ICAjaWZkZWYgQ09ORklHX0lSUV9SRU1BUA0KPiAtc3RhdGljIGludCAoKmlvbW11X2dhX2xv
Z19ub3RpZmllcikodTMyKTsNCj4gK3N0YXRpYyBpbnQgKF9fcmN1ICppb21tdV9nYV9sb2dfbm90
aWZpZXIpKHUzMiBnYV90YWcpOw0KPiANCj4gIGludCBhbWRfaW9tbXVfcmVnaXN0ZXJfZ2FfbG9n
X25vdGlmaWVyKGludCAoKm5vdGlmaWVyKSh1MzIpKSAgew0KPiAtCWlvbW11X2dhX2xvZ19ub3Rp
ZmllciA9IG5vdGlmaWVyOw0KPiArCXJjdV9hc3NpZ25fcG9pbnRlcihpb21tdV9nYV9sb2dfbm90
aWZpZXIsIG5vdGlmaWVyKTsNCj4gDQo+ICAJLyoNCj4gIAkgKiBFbnN1cmUgYWxsIGluLWZsaWdo
dCBJUlEgaGFuZGxlcnMgcnVuIHRvIGNvbXBsZXRpb24gYmVmb3JlIHJldHVybmluZw0KPiBAQCAt
MTA5NCwxNyArMTA5NCwyNSBAQCBzdGF0aWMgdm9pZCBpb21tdV9wb2xsX2dhX2xvZyhzdHJ1Y3QN
Cj4gYW1kX2lvbW11ICppb21tdSkNCj4gDQo+ICAJCS8qIEhhbmRsZSBHQSBlbnRyeSAqLw0KPiAg
CQlzd2l0Y2ggKEdBX1JFUV9UWVBFKGxvZ19lbnRyeSkpIHsNCj4gLQkJY2FzZSBHQV9HVUVTVF9O
UjoNCj4gLQkJCWlmICghaW9tbXVfZ2FfbG9nX25vdGlmaWVyKQ0KPiAtCQkJCWJyZWFrOw0KPiAt
DQo+IC0JCQlwcl9kZWJ1ZygiJXM6IGRldmlkPSUjeCwgZ2FfdGFnPSUjeFxuIiwNCj4gLQkJCQkg
X19mdW5jX18sIEdBX0RFVklEKGxvZ19lbnRyeSksDQo+IC0JCQkJIEdBX1RBRyhsb2dfZW50cnkp
KTsNCj4gKwkJY2FzZSBHQV9HVUVTVF9OUjogew0KPiArCQkJaW50ICgqbm90aWZpZXIpKHUzMiBn
YV90YWcpOw0KPiArCQkJaW50IHJldCA9IDA7DQo+ICsNCj4gKwkJCXNjb3BlZF9ndWFyZChyY3Up
IHsNCj4gKwkJCQlub3RpZmllciA9IHJjdV9kZXJlZmVyZW5jZShpb21tdV9nYV9sb2dfbm90aWZp
ZXIpOw0KPiArCQkJCWlmIChub3RpZmllcikNCj4gKwkJCQkJcmV0ID0gbm90aWZpZXIoR0FfVEFH
KGxvZ19lbnRyeSkpOw0KPiArCQkJfQ0KPiANCj4gLQkJCWlmIChpb21tdV9nYV9sb2dfbm90aWZp
ZXIoR0FfVEFHKGxvZ19lbnRyeSkpICE9IDApDQo+IC0JCQkJcHJfZXJyKCJHQSBsb2cgbm90aWZp
ZXIgZmFpbGVkLlxuIik7DQo+ICsJCQlpZiAobm90aWZpZXIpIHsNCj4gKwkJCQlwcl9kZWJ1Zygi
JXM6IGRldmlkPSUjeCwgZ2FfdGFnPSUjeFxuIiwNCj4gKwkJCQkJIF9fZnVuY19fLCBHQV9ERVZJ
RChsb2dfZW50cnkpLA0KPiArCQkJCQkgR0FfVEFHKGxvZ19lbnRyeSkpOw0KPiArCQkJCWlmIChy
ZXQpDQo+ICsJCQkJCXByX2VycigiR0EgbG9nIG5vdGlmaWVyIGZhaWxlZC5cbiIpOw0KPiArCQkJ
fQ0KPiAgCQkJYnJlYWs7DQo+ICsJCX0NCj4gIAkJZGVmYXVsdDoNCj4gIAkJCWJyZWFrOw0KPiAg
CQl9DQo+IC0tDQo+IDIuOS40DQoNCg==
