Return-Path: <SRS0=75oM=PX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CD1C433EF
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 12:37:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA9E611EF
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 12:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7CA9E611EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59806404C3;
	Thu,  4 Nov 2021 12:37:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8uqSX0SPOy-b; Thu,  4 Nov 2021 12:36:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4108E40571;
	Thu,  4 Nov 2021 12:36:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FD46C0019;
	Thu,  4 Nov 2021 12:36:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83AA5C000E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:36:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 65BA2605A4
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:36:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z9p2gBHq8rEw for <iommu@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 12:36:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id BD3276086E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:36:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3935A113E;
 Thu,  4 Nov 2021 05:36:55 -0700 (PDT)
Received: from [10.57.80.217] (unknown [10.57.80.217])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A29513F7D7;
 Thu,  4 Nov 2021 05:36:54 -0700 (PDT)
Message-ID: <afd0a660-4b4f-23e4-ceaa-78ea2873ca8b@arm.com>
Date: Thu, 4 Nov 2021 12:36:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 07/10] dma-direct: warn if there is no pool for force
 unencrypted allocations
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20211021090611.488281-1-hch@lst.de>
 <20211021090611.488281-8-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211021090611.488281-8-hch@lst.de>
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
> Instead of blindly running into a blocking operation for a non-blocking gfp,
> return NULL and spew an error.  Note that Kconfig prevents this for all
> currently relevant platforms, and this is just a debug check.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/direct.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index d66f37f34ba71..680fe10410645 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -154,6 +154,9 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
>   	u64 phys_mask;
>   	void *ret;
>   
> +	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_DMA_COHERENT_POOL)))
> +		return NULL;
> +
>   	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
>   					   &phys_mask);
>   	page = dma_alloc_from_pool(dev, size, &ret, gfp, dma_coherent_ok);
> @@ -234,8 +237,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   	 * Decrypting memory may block, so allocate the memory from the atomic
>   	 * pools if we can't block.
>   	 */
> -	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
> -	    force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
> +	if (force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
>   	    !is_swiotlb_for_alloc(dev))
>   		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>   
> @@ -353,8 +355,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>   	struct page *page;
>   	void *ret;
>   
> -	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
> -	    force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
> +	if (force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
>   	    !is_swiotlb_for_alloc(dev))
>   		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
