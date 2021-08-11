Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED5CC4338F
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 19:02:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D358A610A2
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 19:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D358A610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 968C5405CE;
	Wed, 11 Aug 2021 19:02:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6vz_Zh7GhZB6; Wed, 11 Aug 2021 19:02:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5D899405CB;
	Wed, 11 Aug 2021 19:02:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A386C001A;
	Wed, 11 Aug 2021 19:02:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CA8FC000E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 19:02:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EFB41405CD
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 19:02:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z3YtrhxL1Tfj for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 19:02:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 11440405CB
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 19:02:22 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 805DED6E;
 Wed, 11 Aug 2021 12:02:21 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3480B3F40C;
 Wed, 11 Aug 2021 12:02:20 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] dma-iommu: Check CONFIG_SWIOTLB more broadly
To: David Stevens <stevensd@chromium.org>, Will Deacon <will@kernel.org>
References: <20210811024247.1144246-1-stevensd@google.com>
 <20210811024247.1144246-5-stevensd@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <681553ad-df37-a469-8cbd-51e321e5b087@arm.com>
Date: Wed, 11 Aug 2021 20:02:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811024247.1144246-5-stevensd@google.com>
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
> Introduce a new dev_use_swiotlb function to guard swiotlb code, instead
> of overloading dev_is_untrusted. This allows CONFIG_SWIOTLB to be
> checked more broadly, so the swiotlb related code can be removed more
> aggressively.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>   drivers/iommu/dma-iommu.c | 24 ++++++++++++++----------
>   1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index be0214b1455c..89b689bf801f 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -317,6 +317,11 @@ static bool dev_is_untrusted(struct device *dev)
>   	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
>   }
>   
> +static bool dev_use_swiotlb(struct device *dev)
> +{
> +	return IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev);
> +}
> +
>   /**
>    * iommu_dma_init_domain - Initialise a DMA mapping domain
>    * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
> @@ -553,8 +558,7 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
>   	 * If both the physical buffer start address and size are
>   	 * page aligned, we don't need to use a bounce page.
>   	 */
> -	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) &&
> -	    iova_offset(iovad, phys | org_size)) {
> +	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | org_size)) {
>   		aligned_size = iova_align(iovad, org_size);
>   		phys = swiotlb_tbl_map_single(dev, phys, org_size,
>   					      aligned_size, dir, attrs);
> @@ -779,7 +783,7 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
>   {
>   	phys_addr_t phys;
>   
> -	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
> +	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
>   		return;
>   
>   	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
> @@ -795,7 +799,7 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
>   {
>   	phys_addr_t phys;
>   
> -	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
> +	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
>   		return;
>   
>   	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
> @@ -813,10 +817,10 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
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
> @@ -832,10 +836,10 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
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
>   			iommu_dma_sync_single_for_device(dev,
>   							 sg_dma_address(sg),
> @@ -999,7 +1003,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   	    iommu_deferred_attach(dev, domain))
>   		return 0;
>   
> -	if (dev_is_untrusted(dev))
> +	if (dev_use_swiotlb(dev))
>   		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
>   
>   	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
> @@ -1078,7 +1082,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>   		attrs |= DMA_ATTR_SKIP_CPU_SYNC;
>   	}
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
