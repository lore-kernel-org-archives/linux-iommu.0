Return-Path: <SRS0=tZpB=NH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6FAC4338F
	for <iommu@archiver.kernel.org>; Mon, 16 Aug 2021 02:15:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE7961440
	for <iommu@archiver.kernel.org>; Mon, 16 Aug 2021 02:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6DE7961440
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29558402C8;
	Mon, 16 Aug 2021 02:15:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t-_JL-Le6Yev; Mon, 16 Aug 2021 02:15:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EE28B402BD;
	Mon, 16 Aug 2021 02:15:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2CBFC001A;
	Mon, 16 Aug 2021 02:15:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4FBBC000E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 02:15:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C0DA3402BD
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 02:15:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8_tCkLBEdIf5 for <iommu@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 02:15:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6B741402B1
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 02:15:42 +0000 (UTC)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GnyS54R7Pz85jp;
 Mon, 16 Aug 2021 10:15:33 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 10:15:38 +0800
Received: from [10.174.178.242] (10.174.178.242) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 10:15:38 +0800
Subject: Re: [PATCH 1/4] iommu/arm-smmu-v3: Use command queue batching helpers
 to improve performance
To: John Garry <john.garry@huawei.com>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20210811114852.2429-1-thunder.leizhen@huawei.com>
 <20210811114852.2429-2-thunder.leizhen@huawei.com>
 <81258eb7-eb73-8a32-0983-3487daba1167@arm.com>
 <4e741216-d6e7-c40c-f257-242cd2fea302@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5482d2e5-24db-6139-a8a8-74be1282e2ec@huawei.com>
Date: Mon, 16 Aug 2021 10:15:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4e741216-d6e7-c40c-f257-242cd2fea302@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.178.242]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
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

CgpPbiAyMDIxLzgvMTQgMDo0NSwgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAxMy8wOC8yMDIxIDE3
OjAxLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9t
bXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMgYi9kcml2ZXJzL2lvbW11L2FybS9hcm0t
c21tdS12My9hcm0tc21tdS12My5jCj4+PiBpbmRleCAyMzVmOWJkYWVhZjIyM2IuLmM4MWNkOTI5
MDQ3ZjU3MyAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2Fy
bS1zbW11LXYzLmMKPj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1z
bW11LXYzLmMKPj4+IEBAIC0xNzQ3LDE1ICsxNzQ3LDE2IEBAIHN0YXRpYyBpbnQgYXJtX3NtbXVf
YXRjX2ludl9tYXN0ZXIoc3RydWN0IGFybV9zbW11X21hc3RlciAqbWFzdGVyKQo+Pj4gwqAgewo+
Pj4gwqDCoMKgwqDCoCBpbnQgaTsKPj4+IMKgwqDCoMKgwqAgc3RydWN0IGFybV9zbW11X2NtZHFf
ZW50IGNtZDsKPj4+ICvCoMKgwqAgc3RydWN0IGFybV9zbW11X2NtZHFfYmF0Y2ggY21kcyA9IHt9
Owo+Pgo+PiBCVFcsIGl0IGxvb2tzIGxpa2UgdGhpcyBoYXMgY3Jvc3NlZCBvdmVyIHdpdGggSm9o
bidzIHBhdGNoIHJlbW92aW5nIHRoZXNlLgo+IAo+IEl0IGlzIG9ubHkgY2FsbGVkIGZyb20gYXJt
X3NtbXVfZGlzYWJsZV9hdHMoKSwgc28gbm90IGhvdC1wYXRoIGJ5IHRoZSBsb29rIGZvciBpdC4g
T3Igd2hvIGV2ZW4gaGFzIGF0cyBIVyAuLi4/Cj4gCj4gQnV0IGl0IHNob3VsZCBiZSBhdCBsZWFz
dCBjbGVhbmVkLXVwIGZvciBjb25zaXN0ZW5jeS4gTGVpemhlbj8KCk9rYXksIEknbGwgcmV2aXNl
IGl0LiBCdXQgV2lsbCBhbHJlYWR5IHRvb2sgaXQuIFNvIEknbSBub3Qgc3VyZSB3aGV0aGVyIHRv
IHNlbmQgdjIgb3IgYSBzZXBhcmF0ZSBwYXRjaC4KCj4gCj4gVGhhbmtzLAo+IEpvaG4KPiAuCj4g
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
