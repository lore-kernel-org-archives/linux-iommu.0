Return-Path: <SRS0=RnLw=MA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A168FC07E96
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 17:49:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5332A616EB
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 17:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5332A616EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A4A583C34;
	Thu,  8 Jul 2021 17:49:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CjXC7GNhGCee; Thu,  8 Jul 2021 17:49:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E11D183BB9;
	Thu,  8 Jul 2021 17:49:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C33D9C001C;
	Thu,  8 Jul 2021 17:49:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 812FFC000E
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 17:49:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 62DF283C34
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 17:49:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ccOpc4nK2OvZ for <iommu@lists.linux-foundation.org>;
 Thu,  8 Jul 2021 17:49:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 446AF83BB9
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 17:49:07 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F741ED1;
 Thu,  8 Jul 2021 10:49:06 -0700 (PDT)
Received: from [10.57.35.192] (unknown [10.57.35.192])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54A7F3F66F;
 Thu,  8 Jul 2021 10:49:05 -0700 (PDT)
Subject: Re: [PATCH 2/2] dma-iommu: Check CONFIG_SWIOTLB more broadly
To: David Stevens <stevensd@chromium.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
References: <20210702053742.842850-1-stevensd@google.com>
 <20210702053742.842850-2-stevensd@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <aa5271cc-b555-50eb-7a45-b9bbec92d97c@arm.com>
Date: Thu, 8 Jul 2021 18:49:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210702053742.842850-2-stevensd@google.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
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

On 2021-07-02 06:37, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Add check for CONFIG_SWIOTLB to dev_is_untrusted, so that swiotlb
> related code can be removed more aggressively.

Seems logical, and I think the new name is secretly the best part since 
it clarifies the intent of 90% of the callers. However...

> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>   drivers/iommu/dma-iommu.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 24d1042cd052..614f0dd86b08 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -310,9 +310,10 @@ static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
>   	domain->ops->flush_iotlb_all(domain);
>   }
>   
> -static bool dev_is_untrusted(struct device *dev)
> +static bool dev_use_swiotlb(struct device *dev)
>   {
> -	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
> +	return IS_ENABLED(CONFIG_SWIOTLB) &&
> +	       dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
>   }
>   
>   /**
> @@ -368,7 +369,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>   
>   	init_iova_domain(iovad, 1UL << order, base_pfn);
>   
> -	if (!cookie->fq_domain && (!dev || !dev_is_untrusted(dev)) &&
> +	if (!cookie->fq_domain && (!dev || !dev_use_swiotlb(dev)) &&

...this one is unrelated to SWIOTLB. Even when we can't use bouncing to 
fully mitigate untrusted devices, it still makes sense to impose strict 
invalidation on them. Maybe we can keep dev_is_untrusted() and define 
dev_use_swiotlb() in terms of it?

Robin.

>   	    domain->ops->flush_iotlb_all && !iommu_get_dma_strict(domain)) {
>   		if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
>   					  iommu_dma_entry_dtor))
> @@ -553,8 +554,7 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
>   	 * If both the physical buffer start address and size are
>   	 * page aligned, we don't need to use a bounce page.
>   	 */
> -	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) &&
> -	    iova_offset(iovad, phys | org_size)) {
> +	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | org_size)) {
>   		aligned_size = iova_align(iovad, org_size);
>   		phys = swiotlb_tbl_map_single(dev, phys, org_size,
>   					      aligned_size, dir,
> @@ -779,7 +779,7 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
>   {
>   	phys_addr_t phys;
>   
> -	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
> +	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
>   		return;
>   
>   	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
> @@ -794,7 +794,7 @@ static void __iommu_dma_sync_single_for_device(struct device *dev,
>   		dma_addr_t dma_handle, size_t size,
>   		enum dma_data_direction dir, phys_addr_t phys)
>   {
> -	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
> +	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
>   		return;
>   
>   	if (phys == 0)
> @@ -821,10 +821,10 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
>   	struct scatterlist *sg;
>   	int i;
>   
> -	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
> +	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
>   		return;
>   
> -	if (dev_is_untrusted(dev))
> +	if (dev_use_swiotlb(dev))
>   		for_each_sg(sgl, sg, nelems, i)
>   			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
>   						      sg->length, dir);
> @@ -840,10 +840,10 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
>   	struct scatterlist *sg;
>   	int i;
>   
> -	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
> +	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
>   		return;
>   
> -	if (dev_is_untrusted(dev))
> +	if (dev_use_swiotlb(dev))
>   		for_each_sg(sgl, sg, nelems, i)
>   			__iommu_dma_sync_single_for_device(dev,
>   							   sg_dma_address(sg),
> @@ -1010,7 +1010,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   	    iommu_deferred_attach(dev, domain))
>   		return 0;
>   
> -	if (dev_is_untrusted(dev)) {
> +	if (dev_use_swiotlb(dev)) {
>   		early_mapped = iommu_dma_map_sg_swiotlb(dev, sg, nents,
>   							dir, attrs);
>   		if (!early_mapped)
> @@ -1092,7 +1092,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>   	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>   		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
>   
> -	if (dev_is_untrusted(dev)) {
> +	if (dev_use_swiotlb(dev)) {
>   		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
>   		return;
>   	}
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
