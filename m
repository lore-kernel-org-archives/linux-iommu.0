Return-Path: <SRS0=75oM=PX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DC3C433F5
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 12:37:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84AA611C3
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 12:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E84AA611C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C89AC817C0;
	Thu,  4 Nov 2021 12:37:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uUqn38luBXiy; Thu,  4 Nov 2021 12:37:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 98812817C3;
	Thu,  4 Nov 2021 12:37:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75153C0019;
	Thu,  4 Nov 2021 12:37:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2828C000E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:37:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A124C40591
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:37:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id glIBMB8yScqQ for <iommu@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 12:37:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id EE1DA40571
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:37:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9417E139F;
 Thu,  4 Nov 2021 05:37:15 -0700 (PDT)
Received: from [10.57.80.217] (unknown [10.57.80.217])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BEDB3F7D7;
 Thu,  4 Nov 2021 05:37:14 -0700 (PDT)
Message-ID: <26c3eef9-f602-5b10-6873-f7b912b300f0@arm.com>
Date: Thu, 4 Nov 2021 12:37:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 09/10] dma-direct: factor the swiotlb code out of
 __dma_direct_alloc_pages
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20211021090611.488281-1-hch@lst.de>
 <20211021090611.488281-10-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211021090611.488281-10-hch@lst.de>
Cc: David Rientjes <rientjes@google.com>
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

On 2021-10-21 10:06, Christoph Hellwig wrote:
> Add a new helper to deal with the swiotlb case.  This keeps the code
> nicely boundled and removes the not required call to
> dma_direct_optimal_gfp_mask for the swiotlb case.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/direct.c | 24 +++++++++++++++---------
>   1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index f4ac2e1cdf469..f2ec40f5733fc 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -97,6 +97,18 @@ static void __dma_direct_free_pages(struct device *dev, struct page *page,
>   	dma_free_contiguous(dev, page, size);
>   }
>   
> +static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size)
> +{
> +	struct page *page = swiotlb_alloc(dev, size);
> +
> +	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
> +		swiotlb_free(dev, page, size);
> +		return NULL;
> +	}
> +
> +	return page;
> +}
> +
>   static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>   		gfp_t gfp)
>   {
> @@ -106,17 +118,11 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>   
>   	WARN_ON_ONCE(!PAGE_ALIGNED(size));
>   
> +	if (is_swiotlb_for_alloc(dev))
> +		return dma_direct_alloc_swiotlb(dev, size);
> +
>   	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
>   					   &phys_limit);
> -	if (is_swiotlb_for_alloc(dev)) {
> -		page = swiotlb_alloc(dev, size);
> -		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
> -			__dma_direct_free_pages(dev, page, size);
> -			return NULL;
> -		}
> -		return page;
> -	}
> -
>   	page = dma_alloc_contiguous(dev, size, gfp);
>   	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
>   		dma_free_contiguous(dev, page, size);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
