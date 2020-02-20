Return-Path: <SRS0=unsG=4I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFE3C11D14
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 17:21:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DCFC207FD
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 17:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCFC207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0283E8746D;
	Thu, 20 Feb 2020 17:21:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nWC--0LhvADW; Thu, 20 Feb 2020 17:21:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B5ABA87475;
	Thu, 20 Feb 2020 17:21:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8D2FC1D84;
	Thu, 20 Feb 2020 17:21:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A964BC013E
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 17:21:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 91C9B85FC7
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 17:21:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MWjTGIsjj03p for <iommu@lists.linux-foundation.org>;
 Thu, 20 Feb 2020 17:21:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5F90C85FC6
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 17:21:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A769931B;
 Thu, 20 Feb 2020 09:21:38 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3533A3F68F;
 Thu, 20 Feb 2020 09:21:37 -0800 (PST)
Subject: Re: [PATCH 1/2] dma-mapping: support setting memory uncached in place
To: Christoph Hellwig <hch@lst.de>, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>
References: <20200220170139.387354-1-hch@lst.de>
 <20200220170139.387354-2-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <502fa745-ddad-f91b-52bc-52edecf8fdbc@arm.com>
Date: Thu, 20 Feb 2020 17:21:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200220170139.387354-2-hch@lst.de>
Content-Language: en-GB
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 openrisc@lists.librecores.org, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

On 20/02/2020 5:01 pm, Christoph Hellwig wrote:
> We currently only support remapping memory as uncached through vmap
> or a magic uncached segment provided by some architectures.  But there
> is a simpler and much better way available on some architectures where
> we can just remap the memory in place.  The advantages are:
> 
>   1) no aliasing is possible, which prevents speculating into the
>      cached alias
>   2) there is no need to allocate new ptes and thus no need for a special
>      pre-allocated pool of memory that can be used with GFP_ATOMIC DMA
>      allocations
> 
> The downside is that architectures must provide a way to set arbitrary
> pages uncached in the kernel mapping, which might not be possible on
> architecture that have a special implicit kernel mapping, and requires
> splitting of huge page kernel mappings where they exist.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/dma-noncoherent.h |  3 +++
>   kernel/dma/Kconfig              |  8 ++++++++
>   kernel/dma/direct.c             | 28 ++++++++++++++++++----------
>   3 files changed, 29 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
> index ca9b5770caee..0820ec58f119 100644
> --- a/include/linux/dma-noncoherent.h
> +++ b/include/linux/dma-noncoherent.h
> @@ -111,4 +111,7 @@ static inline void arch_dma_prep_coherent(struct page *page, size_t size)
>   void *uncached_kernel_address(void *addr);
>   void *cached_kernel_address(void *addr);
>   
> +int arch_dma_set_uncached(void *cpu_addr, size_t size);
> +void arch_dma_clear_uncached(void *cpu_addr, size_t size);
> +
>   #endif /* _LINUX_DMA_NONCOHERENT_H */
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index 4c103a24e380..7bc0b77f1243 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -83,6 +83,14 @@ config DMA_DIRECT_REMAP
>   	bool
>   	select DMA_REMAP
>   
> +#
> +# Should be selected if the architecture can remap memory from the page
> +# allocator and CMA as uncached and provides the arch_dma_set_uncached and
> +# arch_dma_clear_uncached helpers
> +#
> +config ARCH_HAS_DMA_SET_UNCACHED
> +	bool
> +
>   config DMA_CMA
>   	bool "DMA Contiguous Memory Allocator"
>   	depends on HAVE_DMA_CONTIGUOUS && CMA
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 6af7ae83c4ad..73fe65a4cbc0 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -169,11 +169,8 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>   		ret = dma_common_contiguous_remap(page, PAGE_ALIGN(size),
>   				dma_pgprot(dev, PAGE_KERNEL, attrs),
>   				__builtin_return_address(0));
> -		if (!ret) {
> -			dma_free_contiguous(dev, page, size);
> -			return ret;
> -		}
> -
> +		if (!ret)
> +			goto out_free_pages;
>   		memset(ret, 0, size);
>   		goto done;
>   	}
> @@ -186,8 +183,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>   		 * so log an error and fail.
>   		 */
>   		dev_info(dev, "Rejecting highmem page from CMA.\n");
> -		dma_free_contiguous(dev, page, size);
> -		return NULL;
> +		goto out_free_pages;
>   	}
>   
>   	ret = page_address(page);
> @@ -196,10 +192,15 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>   
>   	memset(ret, 0, size);
>   
> -	if (IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
> -	    dma_alloc_need_uncached(dev, attrs)) {
> +	if (dma_alloc_need_uncached(dev, attrs)) {
>   		arch_dma_prep_coherent(page, size);
> -		ret = uncached_kernel_address(ret);
> +
> +		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED)) {
> +			if (!arch_dma_set_uncached(ret, size))
> +				goto out_free_pages;
> +		} else if (IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT)) {
> +			ret = uncached_kernel_address(ret);

Hmm, would we actually need to keep ARCH_HAS_UNCACHED_SEGMENT? If 
arch_dma_set_uncached() returned void*/ERR_PTR instead, then it could 
work for both cases (with arch_dma_clear_uncached() being a no-op for 
segments).

Robin.

> +		}
>   	}
>   done:
>   	if (force_dma_unencrypted(dev))
> @@ -207,6 +208,9 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>   	else
>   		*dma_handle = phys_to_dma(dev, page_to_phys(page));
>   	return ret;
> +out_free_pages:
> +	dma_free_contiguous(dev, page, size);
> +	return NULL;
>   }
>   
>   void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
> @@ -230,6 +234,8 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
>   
>   	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr))
>   		vunmap(cpu_addr);
> +	else if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED))
> +		arch_dma_clear_uncached(cpu_addr, size);
>   
>   	dma_free_contiguous(dev, dma_direct_to_page(dev, dma_addr), size);
>   }
> @@ -238,6 +244,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>   {
>   	if (!IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
> +	    !IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
>   	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
>   	    dma_alloc_need_uncached(dev, attrs))
>   		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
> @@ -248,6 +255,7 @@ void dma_direct_free(struct device *dev, size_t size,
>   		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
>   {
>   	if (!IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
> +	    !IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
>   	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
>   	    dma_alloc_need_uncached(dev, attrs))
>   		arch_dma_free(dev, size, cpu_addr, dma_addr, attrs);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
