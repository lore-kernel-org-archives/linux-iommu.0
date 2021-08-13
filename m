Return-Path: <SRS0=SLGw=NE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422F5C4338F
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 16:46:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2842610A4
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 16:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D2842610A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F46F80F04;
	Fri, 13 Aug 2021 16:46:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UZnOzAy7r0mh; Fri, 13 Aug 2021 16:46:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5971B80E7F;
	Fri, 13 Aug 2021 16:46:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27D58C001A;
	Fri, 13 Aug 2021 16:46:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A00B1C000E
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 16:46:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 89FE480E91
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 16:46:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0Euqhq2BBKao for <iommu@lists.linux-foundation.org>;
 Fri, 13 Aug 2021 16:46:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4805B80E7F
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 16:46:11 +0000 (UTC)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GmTv86sfxz6FBPV;
 Sat, 14 Aug 2021 00:45:24 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 13 Aug 2021 18:46:08 +0200
Received: from [10.47.94.64] (10.47.94.64) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 13 Aug
 2021 17:46:07 +0100
Subject: Re: [PATCH 1/4] iommu/arm-smmu-v3: Use command queue batching helpers
 to improve performance
To: Robin Murphy <robin.murphy@arm.com>, Zhen Lei
 <thunder.leizhen@huawei.com>, Will Deacon <will@kernel.org>, Joerg Roedel
 <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 iommu <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20210811114852.2429-1-thunder.leizhen@huawei.com>
 <20210811114852.2429-2-thunder.leizhen@huawei.com>
 <81258eb7-eb73-8a32-0983-3487daba1167@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <4e741216-d6e7-c40c-f257-242cd2fea302@huawei.com>
Date: Fri, 13 Aug 2021 17:45:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <81258eb7-eb73-8a32-0983-3487daba1167@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.94.64]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMTMvMDgvMjAyMSAxNzowMSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+Pgo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYyAKPj4gYi9kcml2
ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jCj4+IGluZGV4IDIzNWY5YmRh
ZWFmMjIzYi4uYzgxY2Q5MjkwNDdmNTczIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2Fy
bS9hcm0tc21tdS12My9hcm0tc21tdS12My5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJtL2Fy
bS1zbW11LXYzL2FybS1zbW11LXYzLmMKPj4gQEAgLTE3NDcsMTUgKzE3NDcsMTYgQEAgc3RhdGlj
IGludCBhcm1fc21tdV9hdGNfaW52X21hc3RlcihzdHJ1Y3QgCj4+IGFybV9zbW11X21hc3RlciAq
bWFzdGVyKQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAgaW50IGk7Cj4+IMKgwqDCoMKgwqAgc3RydWN0
IGFybV9zbW11X2NtZHFfZW50IGNtZDsKPj4gK8KgwqDCoCBzdHJ1Y3QgYXJtX3NtbXVfY21kcV9i
YXRjaCBjbWRzID0ge307Cj4gCj4gQlRXLCBpdCBsb29rcyBsaWtlIHRoaXMgaGFzIGNyb3NzZWQg
b3ZlciB3aXRoIEpvaG4ncyBwYXRjaCByZW1vdmluZyB0aGVzZS4KCkl0IGlzIG9ubHkgY2FsbGVk
IGZyb20gYXJtX3NtbXVfZGlzYWJsZV9hdHMoKSwgc28gbm90IGhvdC1wYXRoIGJ5IHRoZSAKbG9v
ayBmb3IgaXQuIE9yIHdobyBldmVuIGhhcyBhdHMgSFcgLi4uPwoKQnV0IGl0IHNob3VsZCBiZSBh
dCBsZWFzdCBjbGVhbmVkLXVwIGZvciBjb25zaXN0ZW5jeS4gTGVpemhlbj8KClRoYW5rcywKSm9o
bgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
