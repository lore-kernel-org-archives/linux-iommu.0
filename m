Return-Path: <SRS0=aVDl=HK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BBBC433E0
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 16:31:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC89264E92
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 16:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC89264E92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 91AD920119;
	Mon,  8 Feb 2021 16:31:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kHwK+oqcNG3F; Mon,  8 Feb 2021 16:31:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 16E4420337;
	Mon,  8 Feb 2021 16:31:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 084EDC0891;
	Mon,  8 Feb 2021 16:31:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A42E5C013A
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 16:31:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 878EC20337
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 16:31:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aGX87jA0nKTE for <iommu@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 16:31:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by silver.osuosl.org (Postfix) with ESMTPS id 314C320119
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 16:31:15 +0000 (UTC)
IronPort-SDR: iDYYxhpCSM9slsuqEOug5OuPql63MZDvwI9N2uadHKG+emBUESk+jCB+TIczFuqZ13Zlo7QIBK
 pZN2YuzEjSOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="180961905"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; d="scan'208";a="180961905"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 08:30:50 -0800
IronPort-SDR: 8i4vN7cHtGmxFxqlQtWG8JmDoVMk+L7DpLAWuf9/p1Vo9HDd/nPHZeMM7DpX2E/L/Br0bHGXsN
 HW9Bxh8z05XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; d="scan'208";a="435683959"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga001.jf.intel.com with ESMTP; 08 Feb 2021 08:30:50 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 08:30:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 08:30:48 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.002;
 Mon, 8 Feb 2021 08:30:48 -0800
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "kw@linux.com" <kw@linux.com>
Subject: Re: [PATCH v3 2/2] PCI: vmd: Disable MSI-X remapping when possible
Thread-Topic: [PATCH v3 2/2] PCI: vmd: Disable MSI-X remapping when possible
Thread-Index: AQHW/DkUNvX+5gOMpEiNiIzEbeMxXqpOxWOAgAA3ygA=
Date: Mon, 8 Feb 2021 16:30:48 +0000
Message-ID: <37b6f55d6fad77d7536890a540ecf5369f8de0a9.camel@intel.com>
References: <20210206033502.103964-1-jonathan.derrick@intel.com>
 <20210206033502.103964-3-jonathan.derrick@intel.com>
 <YCE4a4swLUTw6j9Y@rocinante>
In-Reply-To: <YCE4a4swLUTw6j9Y@rocinante>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.200.100]
Content-ID: <AD7512E5603F2F4FBC75F2218B96054A@intel.com>
MIME-Version: 1.0
Cc: "Patel, Nirmal" <nirmal.patel@intel.com>,
 "jroedel@suse.de" <jroedel@suse.de>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Karkra, 
 Kapil" <kapil.karkra@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "helgaas@kernel.org" <helgaas@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgS3J6eXN6dG9mLA0KDQpPbiBNb24sIDIwMjEtMDItMDggYXQgMTQ6MTEgKzAxMDAsIEtyenlz
enRvZiBXaWxjennFhHNraSB3cm90ZToNCj4gSGkgSm9uLA0KPiANCj4gVGhhbmsgeW91IGZvciBh
bGwgdGhlIHdvcmsgaGVyZSENCj4gDQo+IEp1c3QgYSBudW1iZXIgb2Ygc3VnZ2VzdGlvbnMsIG1h
aW5seSBuaXRwaWNrcywgc28gZmVlbCBmcmVlIHRvIGlnbm9yZQ0KPiB0aGVzZSwgb2YgY291cnNl
Lg0KPiANCj4gWy4uLl0NCj4gPiArI2RlZmluZSBWTUNGR19NU0lfUk1QX0RJUwkweDINCj4gWy4u
Ll0NCj4gDQo+IFdoYXQgYWJvdXQgY2FsbGluZyB0aGlzIFZNQ09ORklHX01TSV9SRU1BUCBzbyB0
aGF0IGlzIG1vcmUNCj4gc2VsZi1leHBsYW5hdG9yeSAoaXQgYWxzbyBzaGFyZXMgc29tZSBzaW1p
bGFyaXR5IHdpdGggdGhlDQo+IFBDSV9SRUdfVk1DT05GSUcgZGVmaW50aXRpb24pLg0KPiANCj4g
Wy4uLl0NCj4gPiArCVZNRF9GRUFUX0JZUEFTU19NU0lfUkVNQVAJCT0gKDEgPDwgNCksDQo+IFsu
Li5dDQo+IA0KPiBGb2xsb3dpbmcgb24gdGhlIG5hbWluZyB0aGF0IGluY2x1ZGVkICJIQVMiIHRv
IGluZGljYXRlIGEgZmVhdHVyZSAob3INCj4gc3VwcG9ydCBmb3IgdGhlcmVvZiksIHBlcmhhcHMg
d2UgY291bGQgbmFtZSB0aGlzIGFzLCBmb3IgZXhhbXBsZToNCj4gDQo+IAlWTURfRkVBVF9DQU5f
QllQQVNTX01TSV9SRU1BUA0KPiANCj4gV2hhdCBkbyB5b3UgdGhpbms/DQpTdXJlDQoNCj4gDQo+
IFsuLi5dIA0KPiA+ICtzdGF0aWMgdm9pZCB2bWRfZW5hYmxlX21zaV9yZW1hcHBpbmcoc3RydWN0
IHZtZF9kZXYgKnZtZCwgYm9vbCBlbmFibGUpDQo+ID4gK3sNCj4gPiArCXUxNiByZWc7DQo+ID4g
Kw0KPiA+ICsJcGNpX3JlYWRfY29uZmlnX3dvcmQodm1kLT5kZXYsIFBDSV9SRUdfVk1DT05GSUcs
ICZyZWcpOw0KPiA+ICsJcmVnID0gZW5hYmxlID8gKHJlZyAmIH5WTUNGR19NU0lfUk1QX0RJUykg
OiAocmVnIHwgVk1DRkdfTVNJX1JNUF9ESVMpOw0KPiA+ICsJcGNpX3dyaXRlX2NvbmZpZ193b3Jk
KHZtZC0+ZGV2LCBQQ0lfUkVHX1ZNQ09ORklHLCByZWcpOw0KPiA+ICt9DQo+IA0KPiBJIHdvbmRl
ciBpZiBjYWxsaW5nIHRoaXMgZnVuY3Rpb24gdm1kX3NldF9tc2lfcmVtYXBwaW5nKCkgd291bGQg
YmUgbW9yZQ0KPiBhbGlnbmVkIHdpdGggd2hhdCBpdCBkb2VzLCBzaW5jZSBpdCB0dXJucyB0aGUg
TVNJIHJlbWFwcGluZyBzdXBwb3J0IG9uDQo+IGFuZCBvZmYsIHNvIHRvIHNwZWFrLCBhcyBuZWVk
ZWQuICBEbyB5b3UgdGhpbmsgdGhpcyB3b3VsZCBiZSBPSyB0byBkbz8NCj4gDQpZZXMgdGhhdCBt
YWtlcyBzZW5zZQ0KDQo+IFsuLi5dDQo+ID4gKwkJLyoNCj4gPiArCQkgKiBPdmVycmlkZSB0aGUg
aXJxIGRvbWFpbiBidXMgdG9rZW4gc28gdGhlIGRvbWFpbiBjYW4gYmUNCj4gPiArCQkgKiBkaXN0
aW5ndWlzaGVkIGZyb20gYSByZWd1bGFyIFBDSS9NU0kgZG9tYWluLg0KPiA+ICsJCSAqLw0KPiAN
Cj4gSXQgd291bGQgYmUgIklSUSIgaGVyZS4NCj4gDQpObyBwcm9ibGVtIQ0KDQoNCj4gUmV2aWV3
ZWQtYnk6IEtyenlzenRvZiBXaWxjennFhHNraSA8a3dAbGludXguY29tPg0KPiANClRoYW5rcyEN
Cg0KPiBLcnp5c3p0b2YNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
