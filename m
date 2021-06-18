Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131B8C49361
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 07:37:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A905A613BA
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 07:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A905A613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A00E82BED;
	Fri, 18 Jun 2021 07:37:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 97g67-BFtsm8; Fri, 18 Jun 2021 07:37:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 70093828F5;
	Fri, 18 Jun 2021 07:37:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29682C000D;
	Fri, 18 Jun 2021 07:37:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CDFEC000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 07:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 431BB40412
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 07:37:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D68QkauLZbMH for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 07:37:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D9118403F2
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 07:37:25 +0000 (UTC)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G5r5Q1d3Jz6GB6f;
 Fri, 18 Jun 2021 15:24:10 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 09:37:22 +0200
Received: from [10.47.95.81] (10.47.95.81) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 18 Jun
 2021 08:37:21 +0100
Subject: Re: [PATCH v13 4/6] iommu/vt-d: Add support for IOMMU default DMA
 mode build options
To: Lu Baolu <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <will@kernel.org>, 
 <dwmw2@infradead.org>, <robin.murphy@arm.com>, <corbet@lwn.net>
References: <1623841437-211832-1-git-send-email-john.garry@huawei.com>
 <1623841437-211832-5-git-send-email-john.garry@huawei.com>
 <46dbce5c-1c2b-60d4-df56-d2b95a959425@linux.intel.com>
 <f3fe6c4b-f360-ab7b-7ad2-ced63269499d@huawei.com>
 <d53a6472-4628-313e-30a5-f76e016c9cb9@linux.intel.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <b654480e-d5ac-9e4c-1074-1158cccc5806@huawei.com>
Date: Fri, 18 Jun 2021 08:31:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <d53a6472-4628-313e-30a5-f76e016c9cb9@linux.intel.com>
Content-Language: en-US
X-Originating-IP: [10.47.95.81]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com, iommu@lists.linux-foundation.org
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

T24gMTgvMDYvMjAyMSAwMjo0NiwgTHUgQmFvbHUgd3JvdGU6CgpIaSBiYW9sdSwKCj4+IEkgbmVl
ZCB0byBjaGFuZ2UgdGhhdC4gSG93IGFib3V0IHRoaXM6Cj4+Cj4+IGJvb2wgcHJpbnRfd2Fybmlu
ZyA9IGZhbHNlOwo+Pgo+PiBmb3JfZWFjaF9hY3RpdmVfaW9tbXUoaW9tbXUsIGRyaGQpIHsKPj4g
wqDCoMKgwqDCoC8qCj4+IMKgwqDCoMKgwqAgKiBUaGUgZmx1c2ggcXVldWUgaW1wbGVtZW50YXRp
b24gZG9lcyBub3QgcGVyZm9ybQo+PiDCoMKgwqDCoMKgICogcGFnZS1zZWxlY3RpdmUgaW52YWxp
ZGF0aW9ucyB0aGF0IGFyZSByZXF1aXJlZCBmb3IgZWZmaWNpZW50Cj4+IMKgwqDCoMKgwqAgKiBU
TEIgZmx1c2hlcyBpbiB2aXJ0dWFsIGVudmlyb25tZW50cy7CoCBUaGUgYmVuZWZpdCBvZiBiYXRj
aGluZwo+PiDCoMKgwqDCoMKgICogaXMgbGlrZWx5IHRvIGJlIG11Y2ggbG93ZXIgdGhhbiB0aGUg
b3ZlcmhlYWQgb2Ygc3luY2hyb25pemluZwo+PiDCoMKgwqDCoMKgICogdGhlIHZpcnR1YWwgYW5k
IHBoeXNpY2FsIElPTU1VIHBhZ2UtdGFibGVzLgo+PiDCoMKgwqDCoMKgICovCj4+IMKgwqDCoMKg
wqBpZiAoIXByaW50X3dhcm5pbmcgJiYgY2FwX2NhY2hpbmdfbW9kZShpb21tdS0+Y2FwKSkgewo+
PiDCoMKgwqDCoMKgwqDCoMKgIHByX3dhcm4oIklPTU1VIGJhdGNoaW5nIGRpc2FsbG93ZWQgZHVl
IHRvIHZpcnR1YWxpemF0aW9uXG4iKTsKPj4gwqDCoMKgwqDCoMKgwqDCoCBpb21tdV9zZXRfZG1h
X3N0cmljdCh0cnVlKTsKPj4gwqDCoMKgwqDCoMKgwqDCoCBwcmludF93YXJuaW5nID0gdHJ1ZTsK
Pj4gwqDCoMKgwqDCoH0KPj4gwqDCoMKgwqDCoC4uLgo+PiB9Cj4+Cj4+IG9yIHVzZSBwcl93YXJu
X29uY2UoKS4KPiAKPiAgRnJvbSBteSBwLm8udiwgcHJfeHh4eF9vbmNlKCkgaXMgYmV0dGVyLgo+
IAo+IEhvdyBhYm91dCB1c2luZyBhIHByX2luZm9fb25jZSgpPyBJIGRvbid0IHRoaW5rIGl0J3Mg
YSB3YXJuaW5nLCBpdCdzCj4ganVzdCBhIHBvbGljeSBjaG9pY2UgaW4gVk0gZW52aXJvbm1lbnQu
CgpvaywgSSBjYW4gZ28gd2l0aCB0aGF0LCB3aGljaCBSb2JpbiBtb3N0bHkgYWdyZWVzIHdpdGgu
CgpUaGFua3MsCkpvaG4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
