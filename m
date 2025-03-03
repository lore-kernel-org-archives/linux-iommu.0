Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BEA1EFFB9
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991753; cv=none; b=aWhjwuxqw4epwVFhRRM8gMVCU8nfXcjqAatDR9MHgeZFLlZqeCBAdvK9kM6fgxeO8OmoLHfnRaBIfPeLMsdMTnujSt9cM6bblDWO3QZuLD1dqOKyHqICXStyDeyU62lMGgCveIgnIFR2hjcHd30CiqOAvfy2u3Uq/Si5dwwRD6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991753; c=relaxed/simple;
	bh=HnzYFezVB5tVeSDfNBT9n44hastY2MKg1+ROV6aoAxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PBvCr72IKplKIJHowsmE+bs5+hYJR/Q0UhmwtLBO7YYbAVvqoURCBODiTyr+DvcTG00V7bxoNY8paaHFJAsYyIDsxxitIz5LnHDLD8mk30iZZqgGfcVgj6E3IUySBYTe3t6nJVo47Se21jTRVzWz0DMaY9Xes3ZPKyoS8ZUa75s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z5sqx1jRcz6K98L;
	Mon,  3 Mar 2025 16:46:53 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D8B6140442;
	Mon,  3 Mar 2025 16:49:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Mar 2025 09:49:02 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Mon, 3 Mar 2025 09:49:02 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, =?utf-8?B?TWlrb8WCYWogTGVuY3pld3NraQ==?=
	<miko.lenczewski@arm.com>
CC: "ryan.roberts@arm.com" <ryan.roberts@arm.com>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "yang@os.amperecomputing.com"
	<yang@os.amperecomputing.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "oliver.upton@linux.dev"
	<oliver.upton@linux.dev>, "james.morse@arm.com" <james.morse@arm.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "maz@kernel.org" <maz@kernel.org>,
	"david@redhat.com" <david@redhat.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"mshavit@google.com" <mshavit@google.com>, "jsnitsel@redhat.com"
	<jsnitsel@redhat.com>, "smostafa@google.com" <smostafa@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
Subject: RE: [PATCH v2 4/4] iommu/arm: Add BBM Level 2 smmu feature
Thread-Topic: [PATCH v2 4/4] iommu/arm: Add BBM Level 2 smmu feature
Thread-Index: AQHbig5Aoe4VsuxA9kWqieCP4z67+bNdChiAgAQQylA=
Date: Mon, 3 Mar 2025 08:49:02 +0000
Message-ID: <b23aa37f8e864dea82a6143bece912d6@huawei.com>
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-6-miko.lenczewski@arm.com>
 <20250228193221.GM5011@ziepe.ca>
In-Reply-To: <20250228193221.GM5011@ziepe.ca>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gR3VudGhvcnBl
IDxqZ2dAemllcGUuY2E+DQo+IFNlbnQ6IEZyaWRheSwgRmVicnVhcnkgMjgsIDIwMjUgNzozMiBQ
TQ0KPiBUbzogTWlrb8WCYWogTGVuY3pld3NraSA8bWlrby5sZW5jemV3c2tpQGFybS5jb20+OyBT
aGFtZWVyYWxpIEtvbG90aHVtDQo+IFRob2RpIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1
YXdlaS5jb20+DQo+IENjOiByeWFuLnJvYmVydHNAYXJtLmNvbTsgc3V6dWtpLnBvdWxvc2VAYXJt
LmNvbTsNCj4geWFuZ0Bvcy5hbXBlcmVjb21wdXRpbmcuY29tOyBjYXRhbGluLm1hcmluYXNAYXJt
LmNvbTsNCj4gd2lsbEBrZXJuZWwub3JnOyBqb3JvQDhieXRlcy5vcmc7IGplYW4tcGhpbGlwcGVA
bGluYXJvLm9yZzsNCj4gbWFyay5ydXRsYW5kQGFybS5jb207IGpvZXkuZ291bHlAYXJtLmNvbTsg
b2xpdmVyLnVwdG9uQGxpbnV4LmRldjsNCj4gamFtZXMubW9yc2VAYXJtLmNvbTsgYnJvb25pZUBr
ZXJuZWwub3JnOyBtYXpAa2VybmVsLm9yZzsNCj4gZGF2aWRAcmVkaGF0LmNvbTsgYWtwbUBsaW51
eC1mb3VuZGF0aW9uLm9yZzsgbmljb2xpbmNAbnZpZGlhLmNvbTsNCj4gbXNoYXZpdEBnb29nbGUu
Y29tOyBqc25pdHNlbEByZWRoYXQuY29tOyBzbW9zdGFmYUBnb29nbGUuY29tOyBsaW51eC0NCj4g
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOw0KPiBpb21tdUBsaXN0cy5saW51eC5kZXYNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA0
LzRdIGlvbW11L2FybTogQWRkIEJCTSBMZXZlbCAyIHNtbXUgZmVhdHVyZQ0KPiANCj4gT24gRnJp
LCBGZWIgMjgsIDIwMjUgYXQgMDY6MjQ6MDRQTSArMDAwMCwgTWlrb8WCYWogTGVuY3pld3NraSB3
cm90ZToNCj4gPiBGb3Igc3VwcG9ydGluZyBCQk0gTGV2ZWwgMiBmb3IgdXNlcnNwYWNlIG1hcHBp
bmdzLCB3ZSB3YW50IHRvIGVuc3VyZQ0KPiA+IHRoYXQgdGhlIHNtbXUgYWxzbyBzdXBwb3J0cyBp
dHMgb3duIHZlcnNpb24gb2YgQkJNIExldmVsIDIuIEx1Y2tpbHksIHRoZQ0KPiA+IHNtbXUgc3Bl
YyAoSUhJIDAwNzBHIDMuMjEuMS4zKSBpcyBzdHJpY3RlciB0aGFuIHRoZSBhYXJjaDY0IHNwZWMg
KERESQ0KPiA+IDA0ODdLLmEgRDguMTYuMiksIHNvIGFscmVhZHkgZ3VhcmFudGVlcyB0aGF0IG5v
IGFib3J0cyBhcmUgcmFpc2VkIHdoZW4NCj4gPiBCQk0gbGV2ZWwgMiBpcyBjbGFpbWVkLg0KPiA+
DQo+ID4gQWRkIHRoZSBmZWF0dXJlIGFuZCB0ZXN0aW5nIGZvciBpdCB1bmRlciBhcm1fc21tdV9z
dmFfc3VwcG9ydGVkKCkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaWtvxYJhaiBMZW5jemV3
c2tpIDxtaWtvLmxlbmN6ZXdza2lAYXJtLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9r
ZXJuZWwvY3B1ZmVhdHVyZS5jICAgICAgICAgICAgICAgICAgfCA3ICsrKy0tLS0NCj4gPiAgZHJp
dmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMtc3ZhLmMgfCAzICsrKw0KPiA+
ICBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jICAgICB8IDMgKysr
DQo+ID4gIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmggICAgIHwg
NCArKysrDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkNCj4gDQo+IFRoaXMgcGF0Y2ggbG9va3MgZ29vZCwgZm9yIHdoYXQgaXQgZG9lcy4gSG93
ZXZlciBmb3IgYmlzZWN0aW9uIHNhZmV0eQ0KPiBpdCBzaG91bGQgYmUgZWFybGllciwgYmVmb3Jl
IHRoZSBwYXRjaGVzIHRoYXQgY2hhbmdlIHRoZSBwYWdlIHRhYmxlDQo+IGFsZ29yaXRobXMgdG8g
YmUgdW5zYWZlIGZvciB0aGUgU01NVS4NCj4gDQo+IEhvd2V2ZXIsIEkndmUgaGVhcmQgcGVvcGxl
IHRhbGtpbmcgYWJvdXQgc2hpcHBpbmcgY2hpcHMgdGhhdCBoYXZlIENQVXMNCj4gd2l0aCBCQk1M
MiBidXQgU01NVXMgd2l0aG91dC4NCj4gDQo+IE9uIHN1Y2ggYSBzeXN0ZW0gaXQgc2VlbXMgbGlr
ZSB5b3VyIHNlcmllcyB3b3VsZCBicmVhayBwcmV2aW91c2x5DQo+IHdvcmtpbmcgU1ZBIHN1cHBv
cnQgYmVjYXVzZSB0aGlzIHBhdGNoIHdpbGwgZW5kIHVwIGRpc2FibGluZyBpdD8NCj4gDQo+IFRo
b3VnaCBJIHNlZSB5b3VyIE1JRFJfUkVWIGxpc3QgaXMgbGltaXRlZCwgc28gcGVyaGFwcyB0aGF0
IHdvcnJ5DQo+IGRvZXNuJ3QgZWZmZWN0IGFueSByZWFsIGNoaXBzIG1hZGUgd2l0aCB0aG9zZSBm
YW1pbGllcz8gSSBhbSB0cnlpbmcgdG8NCj4gY2hlY2sgc29tZSBOVklESUEgcHJvZHVjdHMgYWdh
aW5zdCB0aGlzIGxpc3QuLg0KDQpXZSBkbyBoYXZlIGltcGxlbWVudGF0aW9ucyB0aGF0IHN1cHBv
cnQgQ1BVcyB3aXRoIEJCTE0yIHdpdGggVExCDQpjb25mbGljdCBhYm9ydHMgYW5kIFNNTVV2MyB3
aXRoIEJCTUwyLiAgU28gZG9uJ3QgdGhpbmsgdGhvc2UgcGxhdGZvcm1zDQpiZSBhZmZlY3RlZCBi
eSB0aGlzLiAgV2lsbCBjaGVjayB3aXRoIG91ciBoYXJkd2FyZSBmb2xrcyBpZiB0aGVyZSBpcw0K
YW55dGhpbmcgdGhhdCB3aWxsIGJlIGFmZmVjdGVkIGJ5IHRoaXMuDQoNCkFsc28gd2UgIGhhdmUg
cGxhbnMgdG8gdHJ5IHRvIHVzZSBTTU1VdjMgQkJNTDIgZHVyaW5nIFZNIGxpdmUgbWlncmF0aW9u
DQp0byBzcGxpdCBibG9jayBwYWdlcyB0byA0Sy4gSSBndWVzcywgaW4gdGhhdCBjYXNlIHdlIGNh
biBlbmFibGUgU01NVSBCQk1MMg0KaW5kZXBlbmRlbnQgb2YgQ1BVIHNpZGUuIA0KDQpUaGFua3Ms
DQpTaGFtZWVyDQo=
