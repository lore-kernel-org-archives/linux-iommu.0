Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2F6C43334
	for <iommu@archiver.kernel.org>; Wed,  8 Jun 2022 17:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7289D409C8;
	Wed,  8 Jun 2022 17:50:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gJQIKakK5CUY; Wed,  8 Jun 2022 17:50:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6687B40002;
	Wed,  8 Jun 2022 17:50:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30698C0032;
	Wed,  8 Jun 2022 17:50:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED56FC002D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 17:50:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C623260EA1
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 17:50:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b1kcQUinumSs for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 17:50:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A448D60E13
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 17:50:34 +0000 (UTC)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJF8r2xCyz67VbM;
 Thu,  9 Jun 2022 01:49:16 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 19:50:31 +0200
Received: from [10.47.90.54] (10.47.90.54) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 8 Jun
 2022 18:50:30 +0100
Message-ID: <31417477-953d-283e-808e-cf8701e820a8@huawei.com>
Date: Wed, 8 Jun 2022 18:50:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 3/4] scsi: core: Cap shost max_sectors according to DMA
 optimum mapping limits
To: Bart Van Assche <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>, 
 <joro@8bytes.org>, <will@kernel.org>, <jejb@linux.ibm.com>,
 <martin.petersen@oracle.com>, <hch@lst.de>, <m.szyprowski@samsung.com>,
 <robin.murphy@arm.com>
References: <1654507822-168026-1-git-send-email-john.garry@huawei.com>
 <1654507822-168026-4-git-send-email-john.garry@huawei.com>
 <fe365aa8-00d5-153d-ceb2-f887a71a6927@acm.org>
In-Reply-To: <fe365aa8-00d5-153d-ceb2-f887a71a6927@acm.org>
X-Originating-IP: [10.47.90.54]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linux-scsi@vger.kernel.org, linux-doc@vger.kernel.org,
 liyihang6@hisilicon.com, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org
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

T24gMDgvMDYvMjAyMiAxODozMywgQmFydCBWYW4gQXNzY2hlIHdyb3RlOgo+IE9uIDYvNi8yMiAw
MjozMCwgSm9obiBHYXJyeSB3cm90ZToKPj4gK8KgwqDCoCBpZiAoZG1hX2Rldi0+ZG1hX21hc2sp
IHsKPj4gK8KgwqDCoMKgwqDCoMKgIHNob3N0LT5tYXhfc2VjdG9ycyA9IG1pbl90KHVuc2lnbmVk
IGludCwgc2hvc3QtPm1heF9zZWN0b3JzLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGRtYV9vcHRfbWFwcGluZ19zaXplKGRtYV9kZXYpID4+IFNFQ1RPUl9TSElGVCk7Cj4+ICvC
oMKgwqAgfQo+IAo+IFNpbmNlIElPVkFfUkFOR0VfQ0FDSEVfTUFYX1NJWkUgPSA2IHRoaXMgbGlt
aXRzIG1heF9zZWN0b3JzIHRvIDIqKjYgKiAKPiBQQUdFX1NJWkUgb3IgMjU2IEtpQiBpZiB0aGUg
cGFnZSBzaXplIGlzIDQgS2lCLgoKSXQncyBhY3R1YWxseSAxMjhLIGZvciA0SyBwYWdlIHNpemUs
IGFzIGFueSBJT1ZBIHNpemUgaXMgcm91bmR1cCB0byAKcG93ZXItb2YtMiB3aGVuIHRlc3Rpbmcg
aWYgd2UgbWF5IGNhY2hlIGl0LCB3aGljaCBtZWFucyBhbnl0aGluZyA+MTI4SyAKd291bGQgcm91
bmR1cCB0byAyNTZLIGFuZCBjYW5ub3QgYmUgY2FjaGVkLgoKPiBJIHRoaW5rIHRoYXQncyB0b28g
Cj4gc21hbGwuIFNvbWUgKFNSUCkgc3RvcmFnZSBhcnJheXMgcmVxdWlyZSBtdWNoIGxhcmdlciB0
cmFuc2ZlcnMgdG8gCj4gYWNoaWV2ZSBvcHRpbWFsIHBlcmZvcm1hbmNlLgoKSGF2ZSB5b3UgdHJp
ZWQgdGhpcyBhY2hpZXZlIHRoaXMgb3B0aW1hbCBwZXJmb3JtYW5jZSB3aXRoIGFuIElPTU1VIGVu
YWJsZWQ/CgpQbGVhc2Ugbm90ZSB0aGF0IHRoaXMgbGltaXQgb25seSBhcHBsaWVzIGlmIHdlIGhh
dmUgYW4gSU9NTVUgZW5hYmxlZCBmb3IgCnRoZSBzY3NpIGhvc3QgZG1hIGRldmljZS4gT3RoZXJ3
aXNlIHdlIGFyZSBsaW1pdGVkIGJ5IGRtYSBkaXJlY3Qgb3IgCnN3aW90bGIgbWF4IG1hcHBpbmcg
c2l6ZSwgYXMgYmVmb3JlLgoKVGhhbmtzLApKb2huCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
