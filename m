Return-Path: <SRS0=32yV=6V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADADBC4724C
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 13:37:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7507520643
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 13:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7507520643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 345858715D;
	Thu,  7 May 2020 13:37:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iHZ2hrOxMiFC; Thu,  7 May 2020 13:37:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5345E864F2;
	Thu,  7 May 2020 13:37:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3560CC0865;
	Thu,  7 May 2020 13:37:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42E38C07FF
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 13:37:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3F425889C8
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 13:37:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eZ7FIrQdXGl4 for <iommu@lists.linux-foundation.org>;
 Thu,  7 May 2020 13:37:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 23432888B3
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 13:37:19 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 636BDD6E;
 Thu,  7 May 2020 06:37:18 -0700 (PDT)
Received: from [10.57.36.85] (unknown [10.57.36.85])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61E633F68F;
 Thu,  7 May 2020 06:37:17 -0700 (PDT)
Subject: Re: [RFC PATCH] drivers: iommu: reset cached node if dma_mask is
 changed
To: Ajay Kumar <ajaykumar.rs@samsung.com>, iommu@lists.linux-foundation.org,
 linux-mm@kvack.org
References: <CGME20200504185042epcas5p11447ae722d33bd00c7d002a9d1b8d6c1@epcas5p1.samsung.com>
 <20200504183759.42924-1-ajaykumar.rs@samsung.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <30e2a563-df52-3fc1-3d59-adc2dc75beff@arm.com>
Date: Thu, 7 May 2020 14:37:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504183759.42924-1-ajaykumar.rs@samsung.com>
Content-Language: en-GB
Cc: shaik.ameer@samsung.com, Sathyam Panda <sathya.panda@samsung.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020-05-04 7:37 pm, Ajay Kumar wrote:
> The current IOVA allocation code stores a cached copy of the
> first allocated IOVA address node, and all the subsequent allocations
> have no way to get past(higher than) the first allocated IOVA range.

Strictly they do, after that first allocation gets freed, or if the 
first limit was <=32 bits and the subsequent limit >32 bits ;)

> This causes issue when dma_mask for the master device is changed.
> Though the DMA window is increased, the allocation code unaware of
> the change, goes ahead allocating IOVA address lower than the
> first allocated IOVA address.
> 
> This patch adds a check for dma_mask change in the IOVA allocation
> function and resets the cached IOVA node to anchor node everytime
> the dma_mask change is observed.

This isn't the right approach, since limit_pfn is by design a transient 
per-allocation thing. Devices with different limits may well be 
allocating from the same IOVA domain concurrently, which is the whole 
reason for maintaining two cached nodes to serve the expected PCI case 
of mixing 32-bit and 64-bit limits. Trying to track a per-allocation 
property on a per-domain basis is just going to thrash and massively 
hurt such cases.

A somewhat more appropriate fix to the allocation loop itself has been 
proposed here:

https://lore.kernel.org/linux-iommu/1588795317-20879-1-git-send-email-vjitta@codeaurora.org/

Robin.

> NOTE:
>   This patch is needed to address the issue discussed in below thread:
>   https://www.spinics.net/lists/iommu/msg43586.html
> 
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> Signed-off-by: Sathyam Panda <sathya.panda@samsung.com>
> ---
>   drivers/iommu/iova.c | 17 ++++++++++++++++-
>   include/linux/iova.h |  1 +
>   2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 41c605b0058f..0e99975036ae 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -44,6 +44,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>   	iovad->granule = granule;
>   	iovad->start_pfn = start_pfn;
>   	iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
> +	iovad->curr_limit_pfn = iovad->dma_32bit_pfn;
>   	iovad->max32_alloc_size = iovad->dma_32bit_pfn;
>   	iovad->flush_cb = NULL;
>   	iovad->fq = NULL;
> @@ -116,9 +117,20 @@ EXPORT_SYMBOL_GPL(init_iova_flush_queue);
>   static struct rb_node *
>   __get_cached_rbnode(struct iova_domain *iovad, unsigned long limit_pfn)
>   {
> -	if (limit_pfn <= iovad->dma_32bit_pfn)
> +	if (limit_pfn <= iovad->dma_32bit_pfn) {
> +		/* re-init cached node if DMA limit has changed */
> +		if (limit_pfn != iovad->curr_limit_pfn) {
> +			iovad->cached32_node = &iovad->anchor.node;
> +			iovad->curr_limit_pfn = limit_pfn;
> +		}
>   		return iovad->cached32_node;
> +	}
>   
> +	/* re-init cached node if DMA limit has changed */
> +	if (limit_pfn != iovad->curr_limit_pfn) {
> +		iovad->cached_node = &iovad->anchor.node;
> +		iovad->curr_limit_pfn = limit_pfn;
> +	}
>   	return iovad->cached_node;
>   }
>   
> @@ -190,6 +202,9 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>   	if (size_aligned)
>   		align_mask <<= fls_long(size - 1);
>   
> +	if (limit_pfn != iovad->curr_limit_pfn)
> +		iovad->max32_alloc_size = iovad->dma_32bit_pfn;
> +
>   	/* Walk the tree backwards */
>   	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
>   	if (limit_pfn <= iovad->dma_32bit_pfn &&
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index a0637abffee8..be2220c096ef 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -73,6 +73,7 @@ struct iova_domain {
>   	unsigned long	granule;	/* pfn granularity for this domain */
>   	unsigned long	start_pfn;	/* Lower limit for this domain */
>   	unsigned long	dma_32bit_pfn;
> +	unsigned long	curr_limit_pfn;	/* Current max limit for this domain */
>   	unsigned long	max32_alloc_size; /* Size of last failed allocation */
>   	struct iova_fq __percpu *fq;	/* Flush Queue */
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
