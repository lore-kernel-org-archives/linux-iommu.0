Return-Path: <SRS0=7VEr=CT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B36C433E2
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 13:02:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B5512087C
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 13:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5512087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B19C68711C;
	Thu, 10 Sep 2020 13:02:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F81WS-oFiEf4; Thu, 10 Sep 2020 13:02:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2A47A87111;
	Thu, 10 Sep 2020 13:02:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21600C0859;
	Thu, 10 Sep 2020 13:02:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0728BC0051
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 13:02:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E215D87611
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 13:02:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rH7uJn9tBUEh for <iommu@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 13:02:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id A73BB8760F
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 13:02:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 205931063;
 Thu, 10 Sep 2020 06:02:05 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71A813F66E;
 Thu, 10 Sep 2020 06:02:03 -0700 (PDT)
Subject: Re: [PATCH 07/12] dma-direct: lift gfp_t manipulation out
 of__dma_direct_alloc_pages
To: Christoph Hellwig <hch@lst.de>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 iommu@lists.linux-foundation.org
References: <20200908164758.3177341-1-hch@lst.de>
 <20200908164758.3177341-8-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3658a0b7-c2b7-8b03-86c6-219f77799999@arm.com>
Date: Thu, 10 Sep 2020 14:02:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200908164758.3177341-8-hch@lst.de>
Content-Language: en-GB
Cc: linux-mips@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
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

On 2020-09-08 17:47, Christoph Hellwig wrote:
> Move the detailed gfp_t setup from __dma_direct_alloc_pages into the
> caller to clean things up a little.

Other than a mild nitpick that it might be nicer to spend one extra line 
to keep both gfp adjustments next to each other,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/direct.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 1d564bea58571b..12e9f5f75dfe4b 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -108,7 +108,7 @@ static inline bool dma_should_free_from_pool(struct device *dev,
>   }
>   
>   static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
> -		gfp_t gfp, unsigned long attrs)
> +		gfp_t gfp)
>   {
>   	int node = dev_to_node(dev);
>   	struct page *page = NULL;
> @@ -116,11 +116,6 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>   
>   	WARN_ON_ONCE(!PAGE_ALIGNED(size));
>   
> -	if (attrs & DMA_ATTR_NO_WARN)
> -		gfp |= __GFP_NOWARN;
> -
> -	/* we always manually zero the memory once we are done: */
> -	gfp &= ~__GFP_ZERO;
>   	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
>   					   &phys_limit);
>   	page = dma_alloc_contiguous(dev, size, gfp);
> @@ -164,6 +159,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
>   
>   	size = PAGE_ALIGN(size);
> +	if (attrs & DMA_ATTR_NO_WARN)
> +		gfp |= __GFP_NOWARN;
>   
>   	if (dma_should_alloc_from_pool(dev, gfp, attrs)) {
>   		u64 phys_mask;
> @@ -177,7 +174,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   		goto done;
>   	}
>   
> -	page = __dma_direct_alloc_pages(dev, size, gfp, attrs);
> +	/* we always manually zero the memory once we are done */
> +	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO);
>   	if (!page)
>   		return NULL;
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
