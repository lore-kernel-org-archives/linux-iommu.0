Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22772C433EF
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 19:20:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C034A426F8;
	Fri, 10 Dec 2021 19:20:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ihShVetRschX; Fri, 10 Dec 2021 19:20:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AA4BD426F6;
	Fri, 10 Dec 2021 19:20:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8219FC002F;
	Fri, 10 Dec 2021 19:20:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 429DDC0012
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 19:20:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2FA4A412D6
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 19:20:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hbfFiowOuBdz for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 19:20:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C99D0412C1
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 19:20:26 +0000 (UTC)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J9ggb1zQSz67MYc;
 Sat, 11 Dec 2021 03:19:07 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Fri, 10 Dec 2021 20:20:22 +0100
Received: from [10.47.93.58] (10.47.93.58) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 10 Dec
 2021 19:20:22 +0000
Subject: Re: [PATCH v2 01/11] iommu/iova: Fix race between FQ timeout and
 teardown
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
References: <cover.1639157090.git.robin.murphy@arm.com>
 <ecea6835baca75b945bd8ecfaa636ff01dabcc1d.1639157090.git.robin.murphy@arm.com>
 <03cbd9c4-0f11-895b-8eb5-1b75bb74d37c@huawei.com>
 <80145652-b9ca-57b5-ad95-ca12d6a25eea@arm.com>
Message-ID: <8c29534f-ac90-6998-afd7-37b94a3ad3c2@huawei.com>
Date: Fri, 10 Dec 2021 19:19:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <80145652-b9ca-57b5-ad95-ca12d6a25eea@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.93.58]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, willy@infradead.org,
 Xiongfeng Wang <wangxiongfeng2@huawei.com>
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
From: John Garry via iommu <iommu@lists.linux-foundation.org>
Reply-To: John Garry <john.garry@huawei.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMTAvMTIvMjAyMSAxODoxMywgUm9iaW4gTXVycGh5IHdyb3RlOgo+Pj4gcG9zc2libGUgZm9y
IHRoZSB0aW1lb3V0IHRvIGV4cGlyZSBqdXN0KmJlZm9yZSrCoCB0aGUgZGVsX3RpbWVyKCkgY2Fs
bAo+Pgo+PiBzdXBlciBuaXQ6ICJqdXN0KmJlZm9yZSrCoCB0aGUiIC0gbmVlZHMgYSB3aGl0ZXNw
YWNlIGJlZm9yZSAiYmVmb3JlIiA6KQo+IAo+IFdlaXJkLi4uIHRoZSBvcmlnaW5hbCBwYXRjaCBm
aWxlIGhlcmUgYW5kIHRoZSBjb3B5IHJlY2VpdmVkIGJ5IGxvcmUgdmlhIAo+IGxpbnV4LWlvbW11
IGxvb2sgZmluZSwgZ3JlbWxpbnMgaW4geW91ciBNVUEgb3IgZGVsaXZlcnkgcGF0aCBwZXJoYXBz
PwoKUmlnaHQsIGFwb2xvZ2llcyBmb3IgdGhhdC4gSSBkaWQgcmVjZWl2ZSBpdCBvaywgYnV0IG15
IHJlcGx5aW5nIHNlZW1lZCAKdG8gbWFuZ2xlIGl0LiBOb3Qgc3VyZSB3aHkuLgoKVGhhbmtzLApK
b2huCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
