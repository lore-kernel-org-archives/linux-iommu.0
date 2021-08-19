Return-Path: <SRS0=qbNH=NK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E5BC432BE
	for <iommu@archiver.kernel.org>; Thu, 19 Aug 2021 08:59:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5020F6109F
	for <iommu@archiver.kernel.org>; Thu, 19 Aug 2021 08:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5020F6109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E36480C13;
	Thu, 19 Aug 2021 08:59:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gOPrkRav3TCS; Thu, 19 Aug 2021 08:59:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F11FE80CBE;
	Thu, 19 Aug 2021 08:59:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B913DC001A;
	Thu, 19 Aug 2021 08:59:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9375FC000E
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 08:59:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7501F60640
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 08:59:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EYeP8MC4c7Nd for <iommu@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 08:59:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id C87F6605BF
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 08:59:50 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C4D01FB;
 Thu, 19 Aug 2021 01:59:50 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1444F3F40C;
 Thu, 19 Aug 2021 01:59:48 -0700 (PDT)
Subject: Re: [PATCH v6 3/7] dma-iommu: skip extra sync during unmap w/swiotlb
To: David Stevens <stevensd@chromium.org>, Christoph Hellwig <hch@lst.de>
References: <20210817013852.3222824-1-stevensd@google.com>
 <20210817013852.3222824-4-stevensd@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <c1febb7b-8a79-c94b-5358-b6fb38c5a194@arm.com>
Date: Thu, 19 Aug 2021 09:59:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210817013852.3222824-4-stevensd@google.com>
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
> Calling the iommu_dma_sync_*_for_cpu functions during unmap can cause
> two copies out of the swiotlb buffer. Do the arch sync directly in
> __iommu_dma_unmap_swiotlb instead to avoid this. This makes the call to
> iommu_dma_sync_sg_for_cpu for untrusted devices in iommu_dma_unmap_sg no
> longer necessary, so move that invocation later in the function.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: David Stevens <stevensd@chromium.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 8098ce593640..5dd2c517dbf5 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -504,6 +504,9 @@ static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
>   	if (WARN_ON(!phys))
>   		return;
>   
> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) && !dev_is_dma_coherent(dev))
> +		arch_sync_dma_for_cpu(phys, size, dir);
> +
>   	__iommu_dma_unmap(dev, dma_addr, size);
>   
>   	if (unlikely(is_swiotlb_buffer(phys)))
> @@ -853,8 +856,6 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>   static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
>   		size_t size, enum dma_data_direction dir, unsigned long attrs)
>   {
> -	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> -		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
>   	__iommu_dma_unmap_swiotlb(dev, dma_handle, size, dir, attrs);
>   }
>   
> @@ -1062,14 +1063,14 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>   	struct scatterlist *tmp;
>   	int i;
>   
> -	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> -		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
> -
>   	if (dev_is_untrusted(dev)) {
>   		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
>   		return;
>   	}
>   
> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
> +
>   	/*
>   	 * The scatterlist segments are mapped into a single
>   	 * contiguous IOVA allocation, so this is incredibly easy.
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
