Return-Path: <SRS0=GrUw=AH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B91C433DF
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 10:06:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34629206C0
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 10:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34629206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DB6FE23067;
	Fri, 26 Jun 2020 10:06:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BvTZnUjlwtgo; Fri, 26 Jun 2020 10:06:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 793A6227E1;
	Fri, 26 Jun 2020 10:06:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FD2EC088C;
	Fri, 26 Jun 2020 10:06:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FAABC016F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 10:06:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6463687D33
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 10:06:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3uUc04xULowb for <iommu@lists.linux-foundation.org>;
 Fri, 26 Jun 2020 10:06:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5B40887D6A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 10:06:49 +0000 (UTC)
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id 040B89BFDCAC94704736;
 Fri, 26 Jun 2020 11:06:46 +0100 (IST)
Received: from [127.0.0.1] (10.47.7.19) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 26 Jun
 2020 11:06:44 +0100
Subject: Re: [PATCH 4/4] iommu/arm-smmu-v3: Remove cmpxchg() in
 arm_smmu_cmdq_issue_cmdlist()
To: Rikard Falkeborn <rikard.falkeborn@gmail.com>
References: <1592846920-45338-5-git-send-email-john.garry@huawei.com>
 <202006230905.3HpPgtSC%lkp@intel.com>
 <5ba2e240-b324-d316-c00c-38c03ee49baa@huawei.com>
 <CADRDgG4=uD3Ni6r7D3kHdSo=ketaXKGririHfFvPYq4qz8KjfQ@mail.gmail.com>
 <ee2d7a1e-3e22-f25a-ced9-82ccced28f8c@huawei.com>
 <CADRDgG5pOstGK=fm8s3Be_v8+vc-EyRYmpiMsTCeK-rMk2ZRQQ@mail.gmail.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <4f87e2e4-ec7d-49d1-037c-158e94f25ab6@huawei.com>
Date: Fri, 26 Jun 2020 11:05:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CADRDgG5pOstGK=fm8s3Be_v8+vc-EyRYmpiMsTCeK-rMk2ZRQQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.47.7.19]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: "trivial@kernel.org" <trivial@kernel.org>,
 kernel test robot <lkp@intel.com>, will@kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linuxarm <linuxarm@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "maz@kernel.org" <maz@kernel.org>,
 "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMjMvMDYvMjAyMCAxNDo1NSwgUmlrYXJkIEZhbGtlYm9ybiB3cm90ZToKPiBEZW4gdGlzIDIz
IGp1bmkgMjAyMCAxMjoyMUpvaG4gR2FycnkgPGpvaG4uZ2FycnlAaHVhd2VpLmNvbSAKPiA8bWFp
bHRvOmpvaG4uZ2FycnlAaHVhd2VpLmNvbT4+IHNrcmV2Ogo+IAo+ICAgICBPbiAyMy8wNi8yMDIw
IDEwOjM1LCBSaWthcmQgRmFsa2Vib3JuIHdyb3RlOgo+ICAgICAgPgo+ICAgICAgPsKgIMKgIMKg
SSdkIHNheSB0aGF0IEdFTk1BU0tfSU5QVVRfQ0hFQ0soKSBzaG91bGQgYmUgYWJsZSB0byBoYW5k
bGUgYQo+ICAgICBsPTAgYW5kCj4gICAgICA+wqAgwqAgwqBoPXVuc2lnbmVkIHZhbHVlLCBzbyBJ
IGRvdWJ0IHRoaXMgd2Fybi4KPiAgICAgID4KPiAgICAgID7CoCDCoCDCoFVzaW5nIEdFTk1BU0so
KGludCljbWRxLT5xLmxscS5tYXhfbl9zaGlmdCwgMCkgcmVzb2x2ZXMgaXQsCj4gICAgIGJ1dCBp
dAo+ICAgICAgPsKgIMKgIMKgbG9va3MKPiAgICAgID7CoCDCoCDCoGxpa2UgR0VOTUFTS19JTlBV
VF9DSEVDSygpIGNvdWxkIGJlIGltcHJvdmVkLgo+ICAgICAgPgo+ICAgICAgPgo+ICAgICAgPiBJ
bmRlZWQgaXQgY291bGQsIGl0IGlzIGZpeGVkIGluIC1uZXh0Lgo+IAo+ICAgICBvaywgdGhhbmtz
IGZvciB0aGUgcG9pbnRlciwgYnV0IEkgc3RpbGwgc2VlIHRoaXMgb24gdG9kYXkncyAtbmV4dCB3
aXRoCj4gICAgIHRoaXMgcGF0Y2g6Cj4gCj4gICAgIG1ha2UgVz0xIGRyaXZlcnMvaW9tbXUvYXJt
LXNtbXUtdjMubwo+IAo+IAo+IE9oLCBvayB0aGFua3MgZm9yIHJlcG9ydGluZy4gSSBndWVzcyBk
aWZmZXJlbnQgZ2NjIHZlcnNpb25zIGhhdmUgCj4gZGlmZmVyZW50IGJlaGF2aW91ci4gSSBndWVz
cyB3ZSdsbCBoYXZlIHRvIGNoYW5nZSB0aGUgY29tcGFyaXNvbiB0byAKPiAoISgoaCkgPT0gKGwp
IHx8IChoKSA+IChsKSkpIGluc3RlYWQgKG5vdCBzdXJlIEkgZ290IGFsbCBwYXJlbnRoZXNpcyBh
bmQgCj4gbG9naWMgY29ycmVjdCBidXQgeW91IGdldCB0aGUgaWRlYSkuCj4gCgpZZWFoLCBzbyB0
aGlzIGxvb2tzIHRvIGZpeCBpdDoKCi0tLSBhL2luY2x1ZGUvbGludXgvYml0cy5oCisrKyBiL2lu
Y2x1ZGUvbGludXgvYml0cy5oCkBAIC0yMyw3ICsyMyw4IEBACiNpbmNsdWRlIDxsaW51eC9idWls
ZF9idWcuaD4KI2RlZmluZSBHRU5NQVNLX0lOUFVUX0NIRUNLKGgsIGwpIFwKICAgICAgICAoQlVJ
TERfQlVHX09OX1pFUk8oX19idWlsdGluX2Nob29zZV9leHByKCBcCi0gICAgICAgICAgICAgICBf
X2J1aWx0aW5fY29uc3RhbnRfcCgobCkgPiAoaCkpLCAobCkgPiAoaCksIDApKSkKKyAgICAgICAg
ICAgICAgIF9fYnVpbHRpbl9jb25zdGFudF9wKCEoKGgpID09IChsKSB8fChoKSA+IChsKSkpLCAh
KChoKSAKPT0gKGwpIHx8KGgpID4gKGwpKSwgMCkpKQorCgpXZSBtYXkgYmUgYWJsZSB0byBqdXN0
IHVzZSAoaCkgPT0gKGwpIGFzIHRoZSBjb25zdCBleHByIHRvIG1ha2UgaXQgbW9yZSAKY29uY2lz
ZSwgYnV0IHRoYXQgbWF5IGJlIGNvbmZ1c2luZy4KCkkgb25seSB0ZXN0ZWQgd2l0aCBteSB0b29s
Y2hhaW4gYmFzZWQgb24gNy41LjAKClRoYW5rcywKSm9obgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2lvbW11
