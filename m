Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232CAC433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Jun 2022 17:39:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0AB060E13;
	Wed,  8 Jun 2022 17:39:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h0cJiSlUjghv; Wed,  8 Jun 2022 17:39:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 964D660C01;
	Wed,  8 Jun 2022 17:39:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7137FC0032;
	Wed,  8 Jun 2022 17:39:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3102BC002D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 17:39:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1C794409C8
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 17:39:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4udOJ60DV84c for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 17:39:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 343DF40002
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 17:39:16 +0000 (UTC)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJDqk4F4Cz6884T;
 Thu,  9 Jun 2022 01:34:26 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 19:39:12 +0200
Received: from [10.47.90.54] (10.47.90.54) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 8 Jun
 2022 18:39:11 +0100
Message-ID: <ffc15010-3283-7761-c534-7b226f46d79a@huawei.com>
Date: Wed, 8 Jun 2022 18:39:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 2/4] dma-iommu: Add iommu_dma_opt_mapping_size()
To: Bart Van Assche <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>, 
 <joro@8bytes.org>, <will@kernel.org>, <jejb@linux.ibm.com>,
 <martin.petersen@oracle.com>, <hch@lst.de>, <m.szyprowski@samsung.com>,
 <robin.murphy@arm.com>
References: <1654507822-168026-1-git-send-email-john.garry@huawei.com>
 <1654507822-168026-3-git-send-email-john.garry@huawei.com>
 <d7a72f92-15c9-1d58-c711-83c47444094e@acm.org>
In-Reply-To: <d7a72f92-15c9-1d58-c711-83c47444094e@acm.org>
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

T24gMDgvMDYvMjAyMiAxODoyNiwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOgo+IE9uIDYvNi8yMiAw
MjozMCwgSm9obiBHYXJyeSB2aWEgaW9tbXUgd3JvdGU6Cj4+ICt1bnNpZ25lZCBsb25nIGlvdmFf
cmNhY2hlX3JhbmdlKHZvaWQpCj4+ICt7Cj4+ICvCoMKgwqAgcmV0dXJuIFBBR0VfU0laRSA8PCAo
SU9WQV9SQU5HRV9DQUNIRV9NQVhfU0laRSAtIDEpOwo+PiArfQo+IAo+IE15IHVuZGVyc3RhbmRp
bmcgaXMgdGhhdCBpb3ZhIGNhY2hlIGVudHJpZXMgbWF5IGJlIHNtYWxsZXIgdGhhbiAKPiBJT1ZB
X1JBTkdFX0NBQ0hFX01BWF9TSVpFIGFuZCBoZW5jZSB0aGF0IGV2ZW4gaWYgY29kZSB0aGF0IHVz
ZXMgdGhlIERNQSAKPiBtYXBwaW5nIEFQSSByZXNwZWN0cyB0aGlzIGxpbWl0IHRoYXQgYSBjYWNo
ZSBtaXNzIGNhbiBzdGlsbCBoYXBwZW4uCgpTdXJlLCBhIGNhY2hlIG1pc3MgbWF5IHN0aWxsIGhh
cHBlbiAtIGhvd2V2ZXIgb25jZSB3ZSBoYXZlIHN0cmVzc2VkIHRoZSAKc3lzdGVtIGZvciBhIHdo
aWxlIHRoZW4gdGhlIHJjYWNoZXMgZmlsbCB1cCBhbmQgZG9uJ3QgZmFpbCBvZnRlbiwgb3IgCm9m
dGVuIGVub3VnaCB0byBiZSBub3RpY2VhYmxlIGNvbXBhcmVkIHRvIG5vdCBoYXZpbmcgYSBjYWNo
ZWQgSU9WQXMgYXQgYWxsLgoKVGhhbmtzLApqb2huCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
