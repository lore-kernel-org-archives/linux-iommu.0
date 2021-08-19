Return-Path: <SRS0=qbNH=NK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B86C4338F
	for <iommu@archiver.kernel.org>; Thu, 19 Aug 2021 09:03:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A690B6109F
	for <iommu@archiver.kernel.org>; Thu, 19 Aug 2021 09:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A690B6109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6DF54400C3;
	Thu, 19 Aug 2021 09:03:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mcm0Y5f5tZqg; Thu, 19 Aug 2021 09:03:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 25F90400AE;
	Thu, 19 Aug 2021 09:03:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D388DC001A;
	Thu, 19 Aug 2021 09:03:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF2F6C000E
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 09:03:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9B0DE40784
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 09:03:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2j4yMDrI4t0i for <iommu@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 09:03:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id C1C4D40781
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 09:03:18 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 312251FB;
 Thu, 19 Aug 2021 02:03:18 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5C243F66F;
 Thu, 19 Aug 2021 02:03:16 -0700 (PDT)
Subject: Re: [PATCH v6 7/7] dma-iommu: account for min_align_mask
To: David Stevens <stevensd@chromium.org>, Christoph Hellwig <hch@lst.de>
References: <20210817013852.3222824-1-stevensd@google.com>
 <20210817013852.3222824-8-stevensd@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f64b1349-d271-7b57-0eea-276dda065a87@arm.com>
Date: Thu, 19 Aug 2021 10:03:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210817013852.3222824-8-stevensd@google.com>
Content-Language: en-GB
Cc: linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

On 2021-08-17 02:38, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> For devices which set min_align_mask, swiotlb preserves the offset of
> the original physical address within that mask. Since __iommu_dma_map
> accounts for non-aligned addresses, passing a non-aligned swiotlb
> address with the swiotlb aligned size results in the offset being
> accounted for twice in the size passed to iommu_map_atomic. The extra
> page exposed to DMA is also not cleaned up by __iommu_dma_unmap, since
> that function unmaps with the correct size. This causes mapping failures
> if the iova gets reused, due to collisions in the iommu page tables.
> 
> To fix this, pass the original size to __iommu_dma_map, since that
> function already handles alignment.
> 
> Additionally, when swiotlb returns non-aligned addresses, there is
> padding at the start of the bounce buffer that needs to be cleared.
> 
> Fixes: 1f221a0d0dbf ("swiotlb: respect min_align_mask")
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>   drivers/iommu/dma-iommu.c | 24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 6738420fc081..f2fb360c2907 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -788,7 +788,6 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>   	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>   	struct iova_domain *iovad = &cookie->iovad;
> -	size_t aligned_size = size;
>   	dma_addr_t iova, dma_mask = dma_get_mask(dev);
>   
>   	/*
> @@ -796,8 +795,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>   	 * page aligned, we don't need to use a bounce page.
>   	 */
>   	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | size)) {
> -		void *padding_start;
> -		size_t padding_size;
> +		void *tlb_start;
> +		size_t aligned_size, iova_off, mapping_end_off;
>   
>   		aligned_size = iova_align(iovad, size);
>   		phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
> @@ -806,23 +805,26 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>   		if (phys == DMA_MAPPING_ERROR)
>   			return DMA_MAPPING_ERROR;
>   
> -		/* Cleanup the padding area. */
> -		padding_start = phys_to_virt(phys);
> -		padding_size = aligned_size;
> +		iova_off = iova_offset(iovad, phys);
> +		tlb_start = phys_to_virt(phys - iova_off);
>   
>   		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
>   		    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)) {
> -			padding_start += size;
> -			padding_size -= size;
> +			/* Cleanup the padding area. */
> +			mapping_end_off = iova_off + size;
> +			memset(tlb_start, 0, iova_off);
> +			memset(tlb_start + mapping_end_off, 0,
> +			       aligned_size - mapping_end_off);
> +		} else {
> +			/* Nothing was sync'ed, so clear the whole buffer. */
> +			memset(tlb_start, 0, aligned_size);
>   		}
> -
> -		memset(padding_start, 0, padding_size);
>   	}
>   
>   	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>   		arch_sync_dma_for_device(phys, size, dir);
>   
> -	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
> +	iova = __iommu_dma_map(dev, phys, size, prot, dma_mask);

I still don't see how this preserves min_align_mask if it is larger than 
the IOVA granule (either way this change here does nothing since the 
first thing __iommu_dma_map() does is iova_align() the size right back 
anyway).

Robin.

>   	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
>   		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
>   	return iova;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
