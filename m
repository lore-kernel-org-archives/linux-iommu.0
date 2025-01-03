Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AD8BE4F
	for <iommu@lists.linux.dev>; Fri,  3 Jan 2025 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735923233; cv=none; b=Vl1g7VL7I4eqABBNsrHMCiGdBlD5HX6uVyNHBNe80/J7fKCe4n0d+7+0X/diq0hziCUkAqyXR3D3l6vcl0I4K89kL0SMNpmhbARgFRDzy/d4l2ToLhH9Z1fg8oBZb/GG7RAwmV2XGHVNUaA7gZUxAwb8+BNj/3z/XyFhTO4HJNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735923233; c=relaxed/simple;
	bh=iS7Wk4vbLG+V8AlhI9yU0qVPzxD2oiLdr8ixLq4oph0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rfhjlFVrfGiwMSwVzqamC8YSzUH83KghG5iIz7oQQ2GUPP390Q5h7Q5Y4eZLB9PqVmyQ6aFX/q+qnNS0aQcQifpBYqcJUXpgsLWcu7L9sg73GaaW72fJVZfAHKY91cJQ+iwOgPEXHhLfmXHrOzv5+sicsl3qTYBgot1I9PaSeLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Gao,Shiyuan" <gaoshiyuan@baidu.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, "joro@8bytes.org"
	<joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Gao,Shiyuan"
	<gaoshiyuan@baidu.com>
Subject: Re: [PATCH 1/1] iommu/amd: remove return value of amd_iommu_detect
Thread-Topic: [PATCH 1/1] iommu/amd: remove return value of amd_iommu_detect
Thread-Index: AQHbXgAFJdOyEZk3YUOEZe4ILiRjkw==
Date: Fri, 3 Jan 2025 16:53:31 +0000
Message-ID: <F665D3C5-52B3-48A2-A256-0676C2A3E419@baidu.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <C422072547BA624EAA5195D2A356E11F@internal.baidu.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex14_2025-01-04 00:53:32:104
X-FEAS-Client-IP: 10.127.64.37
X-FE-Last-Public-Client-IP: 100.100.100.60
X-FE-Policy-ID: 52:10:53:SYSTEM

PiA+IFRoZSByZXR1cm4gdmFsdWUgb2YgYW1kX2lvbW11X2RldGVjdCBpcyBub3QgdXNlZCwgc28g
cmVtb3ZlIGl0IGFuZA0KPiA+IGlzIGNvbnNpc3RlbnQgd2l0aCBvdGhlciBpb21tdSBkZXRlY3Qg
ZnVuY3Rpb25zLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogR2FvIFNoaXl1YW4gPGdhb3NoaXl1
YW5AYmFpZHUuY29tIDxtYWlsdG86Z2Fvc2hpeXVhbkBiYWlkdS5jb20+Pg0KPiA+IC0tLQ0KPiA+
IGRyaXZlcnMvaW9tbXUvYW1kL2luaXQuYyB8IDEwICsrKysrLS0tLS0NCj4gPiBpbmNsdWRlL2xp
bnV4L2FtZC1pb21tdS5oIHwgNCArKy0tDQo+ID4gMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlv
bnMoKyksIDcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21t
dS9hbWQvaW5pdC5jIGIvZHJpdmVycy9pb21tdS9hbWQvaW5pdC5jDQo+ID4gaW5kZXggMGUwYTUz
MTA0MmFjLi45OGE0MmYzZjllNTMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9hbWQv
aW5pdC5jDQo+ID4gKysrIGIvZHJpdmVycy9pb21tdS9hbWQvaW5pdC5jDQo+ID4gQEAgLTMzOTgs
MjUgKzMzOTgsMjUgQEAgc3RhdGljIGJvb2wgYW1kX2lvbW11X3NtZV9jaGVjayh2b2lkKQ0KPiA+
ICogSU9NTVVzDQo+ID4gKg0KPiA+ICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovDQo+ID4gLWludCBfX2lu
aXQgYW1kX2lvbW11X2RldGVjdCh2b2lkKQ0KPiA+ICt2b2lkIF9faW5pdCBhbWRfaW9tbXVfZGV0
ZWN0KHZvaWQpDQo+ID4gew0KPiA+IGludCByZXQ7DQo+ID4NCj4gPiBpZiAobm9faW9tbXUgfHwg
KGlvbW11X2RldGVjdGVkICYmICFnYXJ0X2lvbW11X2FwZXJ0dXJlKSkNCj4gPiAtIHJldHVybiAt
RU5PREVWOw0KPiA+ICsgcmV0dXJuOw0KPiA+DQo+ID4gaWYgKCFhbWRfaW9tbXVfc21lX2NoZWNr
KCkpDQo+ID4gLSByZXR1cm4gLUVOT0RFVjsNCj4gPiArIHJldHVybjsNCj4gPg0KPiA+IHJldCA9
IGlvbW11X2dvX3RvX3N0YXRlKElPTU1VX0lWUlNfREVURUNURUQpOw0KPiA+IGlmIChyZXQpDQo+
ID4gLSByZXR1cm4gcmV0Ow0KPiA+ICsgcmV0dXJuOw0KPiA+DQo+ID4gYW1kX2lvbW11X2RldGVj
dGVkID0gdHJ1ZTsNCj4gPiBpb21tdV9kZXRlY3RlZCA9IDE7DQo+ID4geDg2X2luaXQuaW9tbXUu
aW9tbXVfaW5pdCA9IGFtZF9pb21tdV9pbml0Ow0KPiA+DQo+ID4gLSByZXR1cm4gMTsNCj4gPiAr
IHJldHVybjsNCj4NCj4NCj4gVGhpcyByZXR1cm4gaXMgbm90IG5lZWRlZCBhbnkgbW9yZS4NCg0K
VGhhbmtzLCB3aWxsIHJlbW92ZSBpdC4NCg0K
