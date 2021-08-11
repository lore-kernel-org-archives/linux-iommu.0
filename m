Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94979C4338F
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 18:47:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A38D36105A
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 18:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A38D36105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60C4B405BD;
	Wed, 11 Aug 2021 18:47:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nnFqEsCBOMKT; Wed, 11 Aug 2021 18:47:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C69CF405A1;
	Wed, 11 Aug 2021 18:47:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B5C3C001A;
	Wed, 11 Aug 2021 18:47:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61D01C000E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 18:47:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 43FF7606CC
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 18:47:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uK3im2v9I4HW for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 18:47:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8195C605C2
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 18:47:30 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9387D6E;
 Wed, 11 Aug 2021 11:47:29 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFD193F40C;
 Wed, 11 Aug 2021 11:47:27 -0700 (PDT)
Subject: Re: [PATCH v3 2/5] dma-iommu: fix arch_sync_dma for map
To: David Stevens <stevensd@chromium.org>, Will Deacon <will@kernel.org>
References: <20210811024247.1144246-1-stevensd@google.com>
 <20210811024247.1144246-3-stevensd@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5b4fd891-a86a-42cd-5b69-bc08d351dd3a@arm.com>
Date: Wed, 11 Aug 2021 19:47:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811024247.1144246-3-stevensd@google.com>
Content-Language: en-GB
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Tom Murphy <murphyt7@tcd.ie>
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

On 2021-08-11 03:42, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> When calling arch_sync_dma, we need to pass it the memory that's
> actually being used for dma. When using swiotlb bounce buffers, this is
> the bounce buffer. Move arch_sync_dma into the __iommu_dma_map_swiotlb
> helper, so it can use the bounce buffer address if necessary. This also
> means it is no longer necessary to call iommu_dma_sync_sg_for_device in
> iommu_dma_map_sg for untrusted devices.
> 
> Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>   drivers/iommu/dma-iommu.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 54e103b989d9..4f0cc4a0a61f 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -576,6 +576,9 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
>   		memset(padding_start, 0, padding_size);
>   	}
>   
> +	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))

Make that an "else if" - otherwise you're just reintroducing the same 
thing that the third hunk is trying to clean up.

> +		arch_sync_dma_for_device(phys, org_size, dir);
> +
>   	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
>   	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
>   		swiotlb_tbl_unmap_single(dev, phys, org_size, dir, attrs);
> @@ -848,14 +851,9 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>   {
>   	phys_addr_t phys = page_to_phys(page) + offset;
>   	bool coherent = dev_is_dma_coherent(dev);
> -	dma_addr_t dma_handle;
>   
> -	dma_handle = __iommu_dma_map_swiotlb(dev, phys, size, dma_get_mask(dev),
> +	return __iommu_dma_map_swiotlb(dev, phys, size, dma_get_mask(dev),
>   			coherent, dir, attrs);

Just fold __iommu_dma_map_swiotlb() back into here and have 
iommu_dma_map_sg_swiotlb() call iommu_dma_map_page() in the typical 
pattern of dma-direct and others. Apparently the only purpose served by 
that indirection was allowing these bugs to exist...

Robin.

> -	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> -	    dma_handle != DMA_MAPPING_ERROR)
> -		arch_sync_dma_for_device(phys, size, dir);
> -	return dma_handle;
>   }
>   
>   static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
> @@ -998,12 +996,12 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   	    iommu_deferred_attach(dev, domain))
>   		return 0;
>   
> -	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> -		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
> -
>   	if (dev_is_untrusted(dev))
>   		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
>   
> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
> +
>   	/*
>   	 * Work out how much IOVA space we need, and align the segments to
>   	 * IOVA granules for the IOMMU driver to handle. With some clever
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
