Return-Path: <SRS0=32yV=6V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E41C38A24
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 17:44:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77FAA215A4
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 17:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGIb+LgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FAA215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4FB1487386;
	Thu,  7 May 2020 17:44:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BEBb6qvmxSgY; Thu,  7 May 2020 17:44:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9A2E88738B;
	Thu,  7 May 2020 17:44:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 798F4C0859;
	Thu,  7 May 2020 17:44:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17B34C07FF
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 17:44:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 005168738B
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 17:44:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VJygKTvQXmDE for <iommu@lists.linux-foundation.org>;
 Thu,  7 May 2020 17:44:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com
 [209.85.219.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B3D5987386
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 17:44:17 +0000 (UTC)
Received: by mail-yb1-f194.google.com with SMTP id v9so3335320ybq.13
 for <iommu@lists.linux-foundation.org>; Thu, 07 May 2020 10:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=OI2xu1NqQ4nK8CSz3pymKBNjObYJMCIvthVEflc/cxo=;
 b=QGIb+LgWoXl3cN2eJu2P4HTuxHd5qUihVbS2Mnt85s2xVStHO3/45lZo/FIosAjj/u
 gfv63P3K/P4BvbK83ulMtgc8BNVU/1+xnCdG9PSoLe/uRwRP+h4KFVJPnS9F0X9Y3loy
 DmBv141/1pv1v5UUDjUzlmHSf3h5Ryq6CueYmTSTHdomeSea+RFp7mR0Y348LbR+YawZ
 63RBNJCslCPQ60s2JdLLZzaUQOgufCLovaDjm+N53hmW9IcCr4TSsUEM2bYESboIX/NT
 Ram1BavEOssGAxrFsy2ld92UgsSgIw3F1lGKa5e207S3DbfCNTbiEi2LbXQafCozKsGw
 DFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=OI2xu1NqQ4nK8CSz3pymKBNjObYJMCIvthVEflc/cxo=;
 b=uiqw18WY0/Umfgn5aeRzlrkWbDGYIEcEq8qhS1Kgwkd76q+pv0jeWrlGJIVnbCrbXM
 /cg9zifTTcoDZSEvf8zx8rXYqTcX0qcB8paLgDi2XHQ2b//113vhJXa9f/Ywziw1mOEc
 erRxqQOvnRXoeSrr7oXg4PkPTl1ZXbCz5TMe2kqIYI+H+2kLvhSBxlW4yKfCS4VAcWiJ
 lDZD8dEDZzS1hDM+UVA/vv505hmMAOuK3T8usy1H7voaT8thWGSNbb0eOEig3LH1MPcN
 qHV0AQOxL7eknFljU/CRRK1Za2Xh8cPfEmJYvL6Ac2CXaJa9R4r/p7YdUdTKtJXZtpKk
 HHAw==
X-Gm-Message-State: AGi0Publv5cK3GoUdsj1+aJ2Uq2/Gs4ea5fbkyY0xU+qvspmP+VxNSUp
 xMJGODtzPGbM+3pDgRkldg4Nny3xsJ3+MOoeYXY=
X-Google-Smtp-Source: APiQypIdmega8gbA7LhTYV3avyaOVVUs0s/qpzhKK7HefXcH48tpjfD18HK4FHSsK6C2hfzWW/8awd8jrE1zmNoSDeQ=
X-Received: by 2002:a25:bb92:: with SMTP id y18mr25455080ybg.496.1588873455277; 
 Thu, 07 May 2020 10:44:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6900:26b:0:0:0:0 with HTTP; Thu, 7 May 2020 10:44:14
 -0700 (PDT)
In-Reply-To: <30e2a563-df52-3fc1-3d59-adc2dc75beff@arm.com>
References: <CGME20200504185042epcas5p11447ae722d33bd00c7d002a9d1b8d6c1@epcas5p1.samsung.com>
 <20200504183759.42924-1-ajaykumar.rs@samsung.com>
 <30e2a563-df52-3fc1-3d59-adc2dc75beff@arm.com>
From: Ajay kumar <ajaynumb@gmail.com>
Date: Thu, 7 May 2020 23:14:14 +0530
Message-ID: <CAEC9eQOPnWAJvAcgRdndgOkc2-KcZ7gJBo0Tb-izEpxczM+UBw@mail.gmail.com>
Subject: Re: [RFC PATCH] drivers: iommu: reset cached node if dma_mask is
 changed
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 shaik.ameer@samsung.com, Ajay Kumar <ajaykumar.rs@samsung.com>,
 Sathyam Panda <sathya.panda@samsung.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Robin,

On 5/7/20, Robin Murphy <robin.murphy@arm.com> wrote:
> On 2020-05-04 7:37 pm, Ajay Kumar wrote:
>> The current IOVA allocation code stores a cached copy of the
>> first allocated IOVA address node, and all the subsequent allocations
>> have no way to get past(higher than) the first allocated IOVA range.
>
> Strictly they do, after that first allocation gets freed, or if the
> first limit was <=32 bits and the subsequent limit >32 bits ;)
In my case, the first allocated buffer is the firmware buffer,
and its not released.

>> This causes issue when dma_mask for the master device is changed.
>> Though the DMA window is increased, the allocation code unaware of
>> the change, goes ahead allocating IOVA address lower than the
>> first allocated IOVA address.
>>
>> This patch adds a check for dma_mask change in the IOVA allocation
>> function and resets the cached IOVA node to anchor node everytime
>> the dma_mask change is observed.
>
> This isn't the right approach, since limit_pfn is by design a transient
> per-allocation thing. Devices with different limits may well be
> allocating from the same IOVA domain concurrently, which is the whole
> reason for maintaining two cached nodes to serve the expected PCI case
> of mixing 32-bit and 64-bit limits. Trying to track a per-allocation
> property on a per-domain basis is just going to thrash and massively
> hurt such cases.
Agreed. But if two or more non PCI devices share the same domain,
and though one of the devices has higher addressable limit,
the current logic forces it to take the lower window.
> A somewhat more appropriate fix to the allocation loop itself has been
> proposed here:
>
> https://lore.kernel.org/linux-iommu/1588795317-20879-1-git-send-email-vjitta@codeaurora.org/
This patch addresses my problem indirectly. Shall add my concerns there.

Ajay
>> NOTE:
>>   This patch is needed to address the issue discussed in below thread:
>>   https://www.spinics.net/lists/iommu/msg43586.html
>>
>> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
>> Signed-off-by: Sathyam Panda <sathya.panda@samsung.com>
>> ---
>>   drivers/iommu/iova.c | 17 ++++++++++++++++-
>>   include/linux/iova.h |  1 +
>>   2 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index 41c605b0058f..0e99975036ae 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -44,6 +44,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned
>> long granule,
>>   	iovad->granule = granule;
>>   	iovad->start_pfn = start_pfn;
>>   	iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
>> +	iovad->curr_limit_pfn = iovad->dma_32bit_pfn;
>>   	iovad->max32_alloc_size = iovad->dma_32bit_pfn;
>>   	iovad->flush_cb = NULL;
>>   	iovad->fq = NULL;
>> @@ -116,9 +117,20 @@ EXPORT_SYMBOL_GPL(init_iova_flush_queue);
>>   static struct rb_node *
>>   __get_cached_rbnode(struct iova_domain *iovad, unsigned long limit_pfn)
>>   {
>> -	if (limit_pfn <= iovad->dma_32bit_pfn)
>> +	if (limit_pfn <= iovad->dma_32bit_pfn) {
>> +		/* re-init cached node if DMA limit has changed */
>> +		if (limit_pfn != iovad->curr_limit_pfn) {
>> +			iovad->cached32_node = &iovad->anchor.node;
>> +			iovad->curr_limit_pfn = limit_pfn;
>> +		}
>>   		return iovad->cached32_node;
>> +	}
>>
>> +	/* re-init cached node if DMA limit has changed */
>> +	if (limit_pfn != iovad->curr_limit_pfn) {
>> +		iovad->cached_node = &iovad->anchor.node;
>> +		iovad->curr_limit_pfn = limit_pfn;
>> +	}
>>   	return iovad->cached_node;
>>   }
>>
>> @@ -190,6 +202,9 @@ static int __alloc_and_insert_iova_range(struct
>> iova_domain *iovad,
>>   	if (size_aligned)
>>   		align_mask <<= fls_long(size - 1);
>>
>> +	if (limit_pfn != iovad->curr_limit_pfn)
>> +		iovad->max32_alloc_size = iovad->dma_32bit_pfn;
>> +
>>   	/* Walk the tree backwards */
>>   	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
>>   	if (limit_pfn <= iovad->dma_32bit_pfn &&
>> diff --git a/include/linux/iova.h b/include/linux/iova.h
>> index a0637abffee8..be2220c096ef 100644
>> --- a/include/linux/iova.h
>> +++ b/include/linux/iova.h
>> @@ -73,6 +73,7 @@ struct iova_domain {
>>   	unsigned long	granule;	/* pfn granularity for this domain */
>>   	unsigned long	start_pfn;	/* Lower limit for this domain */
>>   	unsigned long	dma_32bit_pfn;
>> +	unsigned long	curr_limit_pfn;	/* Current max limit for this domain */
>>   	unsigned long	max32_alloc_size; /* Size of last failed allocation */
>>   	struct iova_fq __percpu *fq;	/* Flush Queue */
>>
>>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
