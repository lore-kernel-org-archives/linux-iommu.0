Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F87C433EF
	for <iommu@archiver.kernel.org>; Thu, 24 Feb 2022 13:58:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA7E2416D0;
	Thu, 24 Feb 2022 13:58:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lm1EskRAxPns; Thu, 24 Feb 2022 13:58:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 96AE04089A;
	Thu, 24 Feb 2022 13:58:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DF59C0035;
	Thu, 24 Feb 2022 13:58:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81704C0011
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 13:40:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61D25416D0
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 13:40:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1f9qd8B0N6Bf for <iommu@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 13:40:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6A8B341687
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 13:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645710001; x=1677246001;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=eE+AHaeX8gqlL4SXf4lazvI3uw60slvmNHnGSKkztuY=;
 b=FBEKTSOyzLymUaENwog2rkicyBMhX69iwa8RGrLtP/2/FhREf5qIEilN
 pEom5/xpwn1REPy28URsX38mlcly0qIEz8EtSdHYSry8KxMyn/FrW2ZUF
 KpJ1mL545tvnIZw/ZQw+bHV2SGWtAW/j60qomoEL/Q+RaAdU+m9IWLHMg
 0MZbFlepGyTK4gUxKye4T1/DATtDavZ/hUQq9Mq9wV+o0U2ojhgEA6yoT
 kISg/HtCR/ygBusaXrQOYBJzPiXP0PxbVZS9E35VZIsGKTZ6oaw0vG0mE
 1HjMLJK3NG90s3hT4pYEv/NyNrSdeUTvbgsZEK0nxrAaoE/fRn5OI3xmX Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="251968284"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; d="scan'208";a="251968284"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2022 05:40:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; d="scan'208";a="607421547"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by fmsmga004.fm.intel.com with ESMTP; 24 Feb 2022 05:40:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 05:40:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 24 Feb 2022 05:39:59 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.020;
 Thu, 24 Feb 2022 05:39:59 -0800
From: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
To: "Surendrakumar Upadhyay, TejaskumarX"
 <tejaskumarx.surendrakumar.upadhyay@intel.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH] iommu/vt-d: Add RPLS to quirk list to skip TE disabling
Thread-Topic: [PATCH] iommu/vt-d: Add RPLS to quirk list to skip TE disabling
Thread-Index: AQHYKICtFQkFA46yO0OFPY9iSTfQxqyit6oAgACFdoA=
Date: Thu, 24 Feb 2022 13:39:59 +0000
Message-ID: <2eb4e522d6294a6ade91b89ea1c5cc7c8dac1e51.camel@intel.com>
References: <20220223062957.31797-1-tejaskumarx.surendrakumar.upadhyay@intel.com>
 <8dcb852f-ef40-5b93-3713-a2d701d90320@linux.intel.com>
In-Reply-To: <8dcb852f-ef40-5b93-3713-a2d701d90320@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-2.fc34) 
x-originating-ip: [10.1.200.100]
Content-ID: <2BA4D9D90750824C9BFC5E6B93D1ADA9@intel.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 24 Feb 2022 13:58:22 +0000
Cc: "Talla, RavitejaX Goud" <ravitejax.goud.talla@intel.com>
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

T24gVGh1LCAyMDIyLTAyLTI0IGF0IDEzOjQyICswODAwLCBMdSBCYW9sdSB3cm90ZToNCj4gT24g
Mi8yMy8yMiAyOjI5IFBNLCBUZWphcyBVcGFkaHlheSB3cm90ZToNCj4gPiBUaGUgVlQtZCBzcGVj
IHJlcXVpcmVzICgxMC40LjQgR2xvYmFsIENvbW1hbmQgUmVnaXN0ZXIsIFRFDQo+ID4gZmllbGQp
IHRoYXQ6DQo+ID4gDQo+ID4gSGFyZHdhcmUgaW1wbGVtZW50YXRpb25zIHN1cHBvcnRpbmcgRE1B
IGRyYWluaW5nIG11c3QgZHJhaW4NCj4gPiBhbnkgaW4tZmxpZ2h0IERNQSByZWFkL3dyaXRlIHJl
cXVlc3RzIHF1ZXVlZCB3aXRoaW4gdGhlDQo+ID4gUm9vdC1Db21wbGV4IGJlZm9yZSBjb21wbGV0
aW5nIHRoZSB0cmFuc2xhdGlvbiBlbmFibGUNCj4gPiBjb21tYW5kIGFuZCByZWZsZWN0aW5nIHRo
ZSBzdGF0dXMgb2YgdGhlIGNvbW1hbmQgdGhyb3VnaA0KPiA+IHRoZSBURVMgZmllbGQgaW4gdGhl
IEdsb2JhbCBTdGF0dXMgcmVnaXN0ZXIuDQo+ID4gDQo+ID4gVW5mb3J0dW5hdGVseSwgc29tZSBp
bnRlZ3JhdGVkIGdyYXBoaWMgZGV2aWNlcyBmYWlsIHRvIGRvDQo+ID4gc28gYWZ0ZXIgc29tZSBr
aW5kIG9mIHBvd2VyIHN0YXRlIHRyYW5zaXRpb24uIEFzIHRoZQ0KPiA+IHJlc3VsdCwgdGhlIHN5
c3RlbSBtaWdodCBzdHVjayBpbiBpb21tdV9kaXNhYmxlX3RyYW5zbGF0aQ0KPiA+IG9uKCksIHdh
aXRpbmcgZm9yIHRoZSBjb21wbGV0aW9uIG9mIFRFIHRyYW5zaXRpb24uDQo+ID4gDQo+ID4gVGhp
cyBhZGRzIFJQTFMgdG8gYSBxdWlyayBsaXN0IGZvciB0aG9zZSBkZXZpY2VzIGFuZCBza2lwcw0K
PiA+IFRFIGRpc2FibGluZyBpZiB0aGUgcXVyaWsgaGl0cy4NCj4gPiANCj4gPiBGaXhlczogaHR0
cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9pbnRlbC8tL2lzc3Vlcy80ODk4DQo+ID4g
Rml4ZXM6IExDSy0xMDc4OQ0KPiANCj4gUmVtb3ZlIHRoaXMgcGxlYXNlLg0KDQpnb29kIGNhdGNo
LiBXcm9uZyB1c2Ugb2YgRml4ZXMgdGFnLg0KIkZpeGVzOiIgc2hvdWxkIG9ubHkgYmUgdXNlZCBm
b3IgcGF0Y2hlcyBmaXhpbmcgb3RoZXIgcGF0Y2hlcyBhbmQNCm1lbnRpb25pbmcgdGhlIGNvbW1p
dCBpZC4NCg0KQmFvbHUsDQpjb3VsZCB5b3UgbWluZCBpZiB3ZSB1c2UNCg0KQ2xvc2VzOiBodHRw
czovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2ludGVsLy0vaXNzdWVzLzQ4OTgNCg0Kb3Ig
bWF5YmUNCg0KUmVmZXJlbmNlczogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9p
bnRlbC8tL2lzc3Vlcy80ODk4DQoNClRoaXMgbGFzdCBvbmUgc2VlbXMgdG8gYmUgdGhlIG9uZSB1
c2UgaW4gZHJpdmVycy9pb21tdQ0KYW5kIHRoZSBDbG9zZXMgaXMgd2hhdCB3ZSB1c2UgaW4gZHJt
LWludGVsLCBoZW5jZSB0aGUgb25lIHVzZWQNCndpdGggZ2l0bGFiLmZyZWVkZXNrdG9wIGxpbmtz
IGluIGdlbmVyYWwuDQoNCj4gDQo+ID4gVGVzdGVkLWJ5OiBSYXZpdGVqYSBHb3VkIFRhbGxhIDxy
YXZpdGVqYXguZ291ZC50YWxsYUBpbnRlbC5jb20+DQo+ID4gQ2M6IFJvZHJpZ28gVml2aSA8cm9k
cmlnby52aXZpQGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUZWphcyBVcGFkaHlheQ0K
PiA+IDx0ZWphc2t1bWFyeC5zdXJlbmRyYWt1bWFyLnVwYWRoeWF5QGludGVsLmNvbT4NCg0KeW91
IGNhbiBrZWVwIG15IHJ2LWINCg0KPiA+IC0tLQ0KPiA+IMKgIGRyaXZlcnMvaW9tbXUvaW50ZWwv
aW9tbXUuYyB8IDIgKy0NCj4gPiDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9p
b21tdS5jDQo+ID4gYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMNCj4gPiBpbmRleCA5MmZl
YTNmYmJiMTEuLmJlOTQ4NzUxNjYxNyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L2lu
dGVsL2lvbW11LmMNCj4gPiArKysgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMNCj4gPiBA
QCAtNTc0Myw3ICs1NzQzLDcgQEAgc3RhdGljIHZvaWQgcXVpcmtfaWdmeF9za2lwX3RlX2Rpc2Fi
bGUoc3RydWN0DQo+ID4gcGNpX2RldiAqZGV2KQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqB2ZXIgPSAo
ZGV2LT5kZXZpY2UgPj4gOCkgJiAweGZmOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqBpZiAodmVyICE9
IDB4NDUgJiYgdmVyICE9IDB4NDYgJiYgdmVyICE9IDB4NGMgJiYNCj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHZlciAhPSAweDRlICYmIHZlciAhPSAweDhhICYmIHZlciAhPSAweDk4ICYmDQo+
ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgIHZlciAhPSAweDlhKQ0KPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoCB2ZXIgIT0gMHg5YSAmJiB2ZXIgIT0gMHhhNykNCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJldHVybjsNCj4gPiDCoCANCj4gPiDCoMKgwqDCoMKgwqDCoMKgaWYg
KHJpc2t5X2RldmljZShkZXYpKQ0KPiANCj4gVGhpcyBpcyBhIHF1aXJrIGZvciBpbnRlZ3JhdGVk
IGdyYXBoaWMgZGV2aWNlLiBSb2RyaWdvLCBkb2VzIHRoaXMNCj4gaGFyZHdhcmUgbmVlZHMgdGhp
cyBxdWlyayBhcyB3ZWxsPw0KDQpZZXMsIDB4YTcqIGFyZSBSUEwtUyB0aGF0IGFyZSBpbnRlZ3Jh
dGVkIGFuZCB2ZXJ5IHNpbWlsYXIgdG8gMHg0NioNCihBREwtUykNCg0KSSB3b3VsZCBwcmVmZXIg
dG8gaGF2ZSBhIG1vcmUgZXhwYW5kZWQgbGlzdCBpbnN0ZWFkIG9mIGdyb3VwIG9yIGF0DQpsZWFz
dCBzb21lIGRlZmluZXMgd2l0aCB0aGUgcGxhdGZvcm0gbmFtZXMuDQoNClRoYW5rcywNClJvZHJp
Z28uDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gYmFvbHUNCg0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
