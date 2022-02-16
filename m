Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F7DC433FE
	for <iommu@archiver.kernel.org>; Wed, 16 Feb 2022 11:13:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08252415E0;
	Wed, 16 Feb 2022 11:13:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I7-lkHPhHORi; Wed, 16 Feb 2022 11:13:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C1AA8415CA;
	Wed, 16 Feb 2022 11:13:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9954AC001A;
	Wed, 16 Feb 2022 11:13:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 342C8C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 11:13:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 13E90415D2
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 11:13:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xMd9wkpcUdsX for <iommu@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 11:13:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 321F1415CA
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 11:13:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CBBDD6E;
 Wed, 16 Feb 2022 03:13:35 -0800 (PST)
Received: from [10.57.70.89] (unknown [10.57.70.89])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A7FF3F66F;
 Wed, 16 Feb 2022 03:13:33 -0800 (PST)
Message-ID: <39ed2187-2345-297d-2dd3-0b0974ce8b31@arm.com>
Date: Wed, 16 Feb 2022 11:13:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] dma-contiguous: Prioritize restricted DMA pool over
 shared DMA pool
Content-Language: en-GB
To: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
References: <20220215224344.1779145-1-f.fainelli@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220215224344.1779145-1-f.fainelli@gmail.com>
Cc: robh@kernel.org, opendmb@gmail.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 jim2101024@gmail.com, bcm-kernel-feedback-list@broadcom.com,
 tientzu@chromium.org, will@kernel.org, Christoph Hellwig <hch@lst.de>
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

On 2022-02-15 22:43, Florian Fainelli wrote:
> Some platforms might define the same memory region to be suitable for
> used by a kernel supporting CONFIG_DMA_RESTRICTED_POOL while maintaining
> compatibility with older kernels that do not support that. This is
> achieved by declaring the node this way;

Those platforms are doing something inexplicably wrong, then.

"restricted-dma-pool" says that DMA for the device has to be bounced 
through a dedicated pool because it can't be trusted with visibility of 
regular OS memory. "reusable" tells the OS that it's safe to use the 
pool as regular OS memory while it's idle. Do you see how those concepts 
are fundamentally incompatible?

Linux is right to reject contradictory information rather than attempt 
to guess at what might be safe or not.

Furthermore, down at the practical level, a SWIOTLB pool is used for 
bouncing streaming DMA API mappings, while a coherent/CMA pool is used 
for coherent DMA API allocations; they are not functionally 
interchangeable either. If a device depends on coherent allocations 
rather than streaming DMA, it should still have a coherent pool even 
under a physical memory protection scheme, and if it needs both 
streaming DMA and coherent buffers then it can have both types of pool - 
the bindings explicitly call that out. It's true that SWIOTLB pools can 
act as an emergency fallback for small allocations for I/O-coherent 
devices, but that's not really intended to be relied upon heavily.

So no, I do not see anything wrong with the current handling of 
nonsensical DTs here, sorry.

Robin.

> 	cma@40000000 {
> 		compatible = "restricted-dma-pool", "shared-dma-pool";
> 		reusable;
> 		...
> 	};
> 
> A newer kernel would leverage the 'restricted-dma-pool' compatible
> string for that reserved region, while an older kernel would use the
> 'shared-dma-pool' compatibility string.
> 
> Due to the link ordering between files under kernel/dma/ however,
> contiguous.c would try to claim the region and we would never get a
> chance for swiotlb.c to claim that reserved memory region.
> 
> To that extent, update kernel/dma/contiguous.c in order to check
> specifically for the 'restricted-dma-pool' compatibility string when
> CONFIG_DMA_RESTRICTED_POOL is enabled and give up that region such that
> kernel/dma/swiotlb.c has a chance to claim it.
> 
> Similarly, kernel/dma/swiotlb.c is updated to remove the check for the
> 'reusable' property because that check is not useful. When a region is
> defined with a compatible string set to 'restricted-dma-pool', no code
> under kernel/dma/{contiguous,coherent}.c will match that region since
> there is no 'shared-dma-pool' compatible string. If a
> region is defined with a compatible string set as above with both
> 'restricted-dma-pool" *and* 'shared-dma-pool' however, checking for
> 'reusable' will prevent kernel/dma/swiotlb.c from claiming the region
> while it is still perfectly suitable since contiguous.c gave it up.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>   kernel/dma/contiguous.c | 7 +++++++
>   kernel/dma/swiotlb.c    | 3 +--
>   2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 3d63d91cba5c..3c418af6d306 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -416,6 +416,13 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
>   	    of_get_flat_dt_prop(node, "no-map", NULL))
>   		return -EINVAL;
>   
> +#ifdef CONFIG_DMA_RESTRICTED_POOL
> +	if (of_flat_dt_is_compatible(node, "restricted-dma-pool")) {
> +		pr_warn("Giving up %pa for restricted DMA pool\n", &rmem->base);
> +		return -ENOENT;
> +	}
> +#endif
> +
>   	if ((rmem->base & mask) || (rmem->size & mask)) {
>   		pr_err("Reserved memory: incorrect alignment of CMA region\n");
>   		return -EINVAL;
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index f1e7ea160b43..9d6e4ae74d04 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -883,8 +883,7 @@ static int __init rmem_swiotlb_setup(struct reserved_mem *rmem)
>   {
>   	unsigned long node = rmem->fdt_node;
>   
> -	if (of_get_flat_dt_prop(node, "reusable", NULL) ||
> -	    of_get_flat_dt_prop(node, "linux,cma-default", NULL) ||
> +	if (of_get_flat_dt_prop(node, "linux,cma-default", NULL) ||
>   	    of_get_flat_dt_prop(node, "linux,dma-default", NULL) ||
>   	    of_get_flat_dt_prop(node, "no-map", NULL))
>   		return -EINVAL;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
