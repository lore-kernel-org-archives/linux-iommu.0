Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A91DC4708F
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 04:36:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DECC61364
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 04:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DECC61364
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DFB0A83C6D;
	Tue,  1 Jun 2021 04:36:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id stxG1udkLCT2; Tue,  1 Jun 2021 04:36:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD88783C68;
	Tue,  1 Jun 2021 04:36:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B46DAC000E;
	Tue,  1 Jun 2021 04:36:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03C20C0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 04:36:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D87F240440
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 04:36:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3dXzUl3oiyrO for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 04:36:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EFD6540449
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 04:36:20 +0000 (UTC)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FvK472ZK2z19S5s;
 Tue,  1 Jun 2021 12:31:35 +0800 (CST)
Received: from dggpemm500022.china.huawei.com (7.185.36.162) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 12:36:16 +0800
Received: from [10.174.185.220] (10.174.185.220) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 12:36:15 +0800
Subject: Re: [RFC PATCH v3 8/8] vfio: Add nested IOPF support
To: Lu Baolu <baolu.lu@linux.intel.com>, Alex Williamson
 <alex.williamson@redhat.com>
References: <20210409034420.1799-1-lushenming@huawei.com>
 <20210409034420.1799-9-lushenming@huawei.com>
 <20210518125808.345b812c.alex.williamson@redhat.com>
 <ea8c92a8-6e51-8be6-de19-d5e6f1d5527f@huawei.com>
 <83747758-ceb6-b498-8d95-609fdd0d763b@huawei.com>
 <20210524161129.085503ad@x1.home.shazbot.org>
 <90b00e7d-7934-ee79-7643-e2949e2d3af4@huawei.com>
 <9daf8877-a538-2d19-f548-b00ea6f127df@linux.intel.com>
From: Shenming Lu <lushenming@huawei.com>
Message-ID: <8b6e5abd-d965-2331-7af3-08bef399af0f@huawei.com>
Date: Tue, 1 Jun 2021 12:36:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <9daf8877-a538-2d19-f548-b00ea6f127df@linux.intel.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.220]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, linux-api@vger.kernel.org,
 wanghaibin.wang@huawei.com, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

T24gMjAyMS81LzI3IDE5OjE4LCBMdSBCYW9sdSB3cm90ZToKPiBIaSBTaGVubWluZyBhbmQgQWxl
eCwKPiAKPiBPbiA1LzI3LzIxIDc6MDMgUE0sIFNoZW5taW5nIEx1IHdyb3RlOgo+Pj4gSSBoYXZl
bid0IGZ1bGx5IHJlYWQgYWxsIHRoZSByZWZlcmVuY2VzLCBidXQgd2hvIGltcG9zZXMgdGhlIGZh
Y3QgdGhhdAo+Pj4gdGhlcmUncyBvbmx5IG9uZSBmYXVsdCBoYW5kbGVyIHBlciBkZXZpY2U/wqAg
SWYgdHlwZTEgY291bGQgcmVnaXN0ZXIgb25lCj4+PiBoYW5kbGVyIGFuZCB0aGUgdmZpby1wY2kg
YnVzIGRyaXZlciBhbm90aGVyIGZvciB0aGUgb3RoZXIgbGV2ZWwsIHdvdWxkCj4+PiB3ZSBuZWVk
IHRoaXMgcGF0aCB0aHJvdWdoIHZmaW8tY29yZT8KPj4gSWYgd2UgY291bGQgcmVnaXN0ZXIgbW9y
ZSB0aGFuIG9uZSBoYW5kbGVyIHBlciBkZXZpY2UsIHRoaW5ncyB3b3VsZCBiZWNvbWUKPj4gbXVj
aCBtb3JlIHNpbXBsZSwgYW5kIHRoZSBwYXRoIHRocm91Z2ggdmZpby1jb3JlIHdvdWxkIG5vdCBi
ZSBuZWVkZWQuCj4+Cj4+IEhpIEJhb2x1LAo+PiBJcyB0aGVyZSBhbnkgcmVzdHJpY3Rpb24gZm9y
IGhhdmluZyBtb3JlIHRoYW4gb25lIGhhbmRsZXIgcGVyIGRldmljZT8KPj4KPiAKPiBDdXJyZW50
bHksIGVhY2ggZGV2aWNlIGNvdWxkIG9ubHkgaGF2ZSBvbmUgZmF1bHQgaGFuZGxlci4gQnV0IG9u
ZSBkZXZpY2UKPiBtaWdodCBjb25zdW1lIG11bHRpcGxlIHBhZ2UgdGFibGVzLiBGcm9tIHRoaXMg
cG9pbnQgb2YgdmlldywgaXQncyBtb3JlCj4gcmVhc29uYWJsZSB0byBoYXZlIG9uZSBoYW5kbGVy
IHBlciBwYWdlIHRhYmxlLgoKU291bmRzIGdvb2QgdG8gbWUuIEkgaGF2ZSBwb2ludGVkIGl0IG91
dCBpbiB0aGUgSU9BU0lEIHVBUEkgcHJvcG9zYWwuIDotKQoKVGhhbmtzLApTaGVubWluZwoKPiAK
PiBCZXN0IHJlZ2FyZHMsCj4gYmFvbHUKPiAuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
