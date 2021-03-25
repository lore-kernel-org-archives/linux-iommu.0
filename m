Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25318C433C1
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 15:55:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4904C61A1A
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 15:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4904C61A1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02C9D40406;
	Thu, 25 Mar 2021 15:55:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SH-5f4VRY48g; Thu, 25 Mar 2021 15:55:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94F8B40359;
	Thu, 25 Mar 2021 15:55:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78488C000D;
	Thu, 25 Mar 2021 15:55:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1553BC000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 15:55:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E2B69401CF
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 15:55:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MxxsXRWXhpug for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 15:55:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0008B401B5
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 15:55:02 +0000 (UTC)
Received: from DGGEML402-HUB.china.huawei.com (unknown [172.30.72.53])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4F5qP32fMvz5hBt;
 Thu, 25 Mar 2021 23:52:23 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 DGGEML402-HUB.china.huawei.com (10.3.17.38) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 25 Mar 2021 23:54:55 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 25 Mar 2021 23:54:54 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2106.013; Thu, 25 Mar 2021 15:54:52 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Jon Nettleton <jon@solid-run.com>, "erik.kaneda@intel.com"
 <erik.kaneda@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: RE: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
Thread-Topic: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
Thread-Index: AQHWvm1dfTBTih8pMEKAOph+J6BTAKqQitWggAQXOICAAP9lgA==
Date: Thu, 25 Mar 2021 15:54:51 +0000
Message-ID: <acfab98e75434a59910cf56336c54ba2@huawei.com>
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
 <20201119121150.3316-2-shameerali.kolothum.thodi@huawei.com>
 <b7a2424941214b33803e34ba3e532440@huawei.com>
 <CABdtJHtZPyWpXN9JZbgdu=HswreTc2o2pRhrwHFzQJqz-kFSBw@mail.gmail.com>
In-Reply-To: <CABdtJHtZPyWpXN9JZbgdu=HswreTc2o2pRhrwHFzQJqz-kFSBw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.26.249]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: Linuxarm <linuxarm@huawei.com>,
 "robert.moore@intel.com" <robert.moore@intel.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 wanghuiqiang <wanghuiqiang@huawei.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 "steven.price@arm.com" <steven.price@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "devel@acpica.org" <devel@acpica.org>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uIE5ldHRsZXRvbiBb
bWFpbHRvOmpvbkBzb2xpZC1ydW4uY29tXQ0KPiBTZW50OiAyNSBNYXJjaCAyMDIxIDA4OjQwDQo+
IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2Rp
QGh1YXdlaS5jb20+DQo+IENjOiBlcmlrLmthbmVkYUBpbnRlbC5jb207IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOw0KPiBkZXZlbEBhY3BpY2Eub3JnOyBMb3Jl
bnpvIFBpZXJhbGlzaSA8bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT47DQo+IHJvYmVydC5tb29y
ZUBpbnRlbC5jb207IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsNCj4gc3RldmVuLnBy
aWNlQGFybS5jb207IEd1b2hhbmp1biAoSGFuanVuIEd1bykgPGd1b2hhbmp1bkBodWF3ZWkuY29t
PjsNCj4gU2FtaS5NdWphd2FyQGFybS5jb207IHJvYmluLm11cnBoeUBhcm0uY29tOyB3YW5naHVp
cWlhbmcNCj4gPHdhbmdodWlxaWFuZ0BodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyBQ
QVRDSCB2MiAxLzhdIEFDUElDQTogSU9SVDogVXBkYXRlIGZvciByZXZpc2lvbiBFDQoNClsuLi5d
DQoNCj4gV2VsbCBpdCB3YXMgYSByZWxlYXNlZCByZXZpc2lvbiwgYWx0aG91Z2ggaXQgd2FzIGZv
dW5kIHRvIGhhdmUgaXNzdWVzLg0KPiBDdXJyZW50bHkNCj4gSG9uZXlDb21iIFN5c3RlbXMgUmVh
ZHkgY2VydGlmaWVkIGZpcm13YXJlIGRvZXMgaW5jbHVkZSBzdXBwb3J0IGZvciB0aGlzDQo+IHRh
YmxlLA0KPiBhbHRob3VnaCBpbmNvbXBsZXRlLiAgV2l0aG91dCBhZ3JlZW1lbnQgb24gbWFpbmxp
bmUgc3VwcG9ydCBJIGFtIGZpbmUgdG8NCj4gdXBkYXRlDQo+IHRvIHRoZSBsYXRlc3Qgc3BlYyBi
dW1wLg0KDQpPay4gU29ycnkgZGlkbuKAmXQga25vdyB0aGF0IHlvdSBhbHJlYWR5IGhhZCBhIGZp
cm13YXJlIHdpdGggdGhhdCByZXZpc2lvbi4NClRoYW5rcyBmb3IgYWdyZWVpbmcgdG8gdXBkYXRl
IHRvIGxhdGVzdC4NCg0KPiA+DQo+ID4gU28gY291bGQgeW91IHBsZWFzZSByZXZlcnQgdGhlIG1l
cmdlIGFuZCBJIGFtIHBsYW5uaW5nIHRvIHdvcmsgb24gdGhlIEUuYg0KPiBzb29uLg0KPiA+IFBs
ZWFzZSBsZXQgbWUga25vdyBpZiBJIG5lZWQgdG8gZXhwbGljaXRseSBzZW5kIGEgcmV2ZXJ0IHB1
bGwgcmVxdWVzdCBvciBub3QuDQo+IA0KPiBDYW4geW91IHBsZWFzZSBDQy4gbWUgb24geW91ciBu
ZXh0IHJlbGVhc2UuICBJIHdhcyBwbGFubmluZyBvbiBzcGVuZGluZyB0aW1lDQo+IG9uIHRoaXMg
cmVnYXJkbGVzcy4gIEkgYWxyZWFkeSBoYXZlIGEgcGF0Y2hzZXQgZm9yIHRoZSBmc2wtbWMtYnVz
IGRyaXZlciB0aGF0DQo+IG5lZWRzIHRvIGNoYW5nZSBpbiBvcmRlciB0byBmdW5jdGlvbiBwcm9w
ZXJseSB3aXRoIFJNUiBzdXBwb3J0Lg0KDQpTdXJlLiBXaWxsIENDIHlvdS4NCg0KSGkgQWxsLA0K
DQpJIGhhdmUgc2VuZCBwdWxsIHJlcXVlc3RzIHRvIGFjcGljYSBnaXQgZm9yIHJldmVydGluZyBy
ZXYgRSBhbmQgdG8gdXBkYXRlIGl0IHdpdGggRS5iLA0KDQpodHRwczovL2dpdGh1Yi5jb20vYWNw
aWNhL2FjcGljYS9wdWxsLzY4Mg0KDQpQbGVhc2UgdGFrZSBhIGxvb2sgYW5kIGxldCBtZSBrbm93
Lg0KDQpUaGFua3MsDQpTaGFtZWVyDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW9tbXU=
