Return-Path: <SRS0=1bbG=JU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A30C433B4
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 13:46:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D24D611BD
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 13:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D24D611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 016B984410;
	Fri, 23 Apr 2021 13:46:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WwKpC60hwfQu; Fri, 23 Apr 2021 13:46:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id D44A9843DB;
	Fri, 23 Apr 2021 13:46:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B99ACC000F;
	Fri, 23 Apr 2021 13:46:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA3E1C000B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 13:46:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B04E840F57
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 13:46:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wz7i6yBKxLJ1 for <iommu@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 13:46:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5F8A840F51
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 13:46:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E1CE1063;
 Fri, 23 Apr 2021 06:46:34 -0700 (PDT)
Received: from [10.57.62.63] (unknown [10.57.62.63])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 903A33F73B;
 Fri, 23 Apr 2021 06:46:27 -0700 (PDT)
Subject: Re: [PATCH v5 14/16] dma-direct: Allocate memory from restricted DMA
 pool if available
To: Claire Chang <tientzu@chromium.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, boris.ostrovsky@oracle.com,
 jgross@suse.com, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210422081508.3942748-1-tientzu@chromium.org>
 <20210422081508.3942748-15-tientzu@chromium.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <70b895c2-4a39-bbbd-a719-5c8b6b922026@arm.com>
Date: Fri, 23 Apr 2021 14:46:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210422081508.3942748-15-tientzu@chromium.org>
Content-Language: en-GB
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, benh@kernel.crashing.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
 mingo@kernel.org, jxgao@google.com, sstabellini@kernel.org,
 Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 daniel@ffwll.ch, airlied@linux.ie, maarten.lankhorst@linux.intel.com,
 jani.nikula@linux.intel.com, Nicolas Boichat <drinkcat@chromium.org>,
 rodrigo.vivi@intel.com, bhelgaas@google.com,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 nouveau@lists.freedesktop.org, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, linuxppc-dev@lists.ozlabs.org,
 bauerman@linux.ibm.com
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

On 2021-04-22 09:15, Claire Chang wrote:
> The restricted DMA pool is preferred if available.
> 
> The restricted DMA pools provide a basic level of protection against the
> DMA overwriting buffer contents at unexpected times. However, to protect
> against general data leakage and system memory corruption, the system
> needs to provide a way to lock down the memory access, e.g., MPU.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>   kernel/dma/direct.c | 35 ++++++++++++++++++++++++++---------
>   1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 7a27f0510fcc..29523d2a9845 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -78,6 +78,10 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
>   static void __dma_direct_free_pages(struct device *dev, struct page *page,
>   				    size_t size)
>   {
> +#ifdef CONFIG_DMA_RESTRICTED_POOL
> +	if (swiotlb_free(dev, page, size))
> +		return;
> +#endif
>   	dma_free_contiguous(dev, page, size);
>   }
>   
> @@ -92,7 +96,17 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>   
>   	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
>   					   &phys_limit);
> -	page = dma_alloc_contiguous(dev, size, gfp);
> +
> +#ifdef CONFIG_DMA_RESTRICTED_POOL
> +	page = swiotlb_alloc(dev, size);
> +	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
> +		__dma_direct_free_pages(dev, page, size);
> +		page = NULL;
> +	}
> +#endif
> +
> +	if (!page)
> +		page = dma_alloc_contiguous(dev, size, gfp);
>   	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
>   		dma_free_contiguous(dev, page, size);
>   		page = NULL;
> @@ -148,7 +162,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   		gfp |= __GFP_NOWARN;
>   
>   	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> -	    !force_dma_unencrypted(dev)) {
> +	    !force_dma_unencrypted(dev) && !is_dev_swiotlb_force(dev)) {
>   		page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO);
>   		if (!page)
>   			return NULL;
> @@ -161,8 +175,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   	}
>   
>   	if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
> -	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> -	    !dev_is_dma_coherent(dev))
> +	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) && !dev_is_dma_coherent(dev) &&
> +	    !is_dev_swiotlb_force(dev))
>   		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
>   
>   	/*
> @@ -172,7 +186,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
>   	    !gfpflags_allow_blocking(gfp) &&
>   	    (force_dma_unencrypted(dev) ||
> -	     (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) && !dev_is_dma_coherent(dev))))
> +	     (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> +	      !dev_is_dma_coherent(dev))) &&
> +	    !is_dev_swiotlb_force(dev))
>   		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>   
>   	/* we always manually zero the memory once we are done */
> @@ -253,15 +269,15 @@ void dma_direct_free(struct device *dev, size_t size,
>   	unsigned int page_order = get_order(size);
>   
>   	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> -	    !force_dma_unencrypted(dev)) {
> +	    !force_dma_unencrypted(dev) && !is_dev_swiotlb_force(dev)) {
>   		/* cpu_addr is a struct page cookie, not a kernel address */
>   		dma_free_contiguous(dev, cpu_addr, size);
>   		return;
>   	}
>   
>   	if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
> -	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> -	    !dev_is_dma_coherent(dev)) {
> +	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) && !dev_is_dma_coherent(dev) &&
> +	    !is_dev_swiotlb_force(dev)) {
>   		arch_dma_free(dev, size, cpu_addr, dma_addr, attrs);
>   		return;
>   	}
> @@ -289,7 +305,8 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>   	void *ret;
>   
>   	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
> -	    force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp))
> +	    force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
> +	    !is_dev_swiotlb_force(dev))
>   		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);

Wait, this seems broken for non-coherent devices - in that case we need 
to return a non-cacheable address, but we can't simply fall through into 
the remapping path below in GFP_ATOMIC context. That's why we need the 
atomic pool concept in the first place :/

Unless I've overlooked something, we're still using the regular 
cacheable linear map address of the dma_io_tlb_mem buffer, no?

Robin.

>   
>   	page = __dma_direct_alloc_pages(dev, size, gfp);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
