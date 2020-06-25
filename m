Return-Path: <SRS0=A59K=AG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E7EC433E2
	for <iommu@archiver.kernel.org>; Thu, 25 Jun 2020 11:10:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E68D4206FA
	for <iommu@archiver.kernel.org>; Thu, 25 Jun 2020 11:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68D4206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D1796862EC;
	Thu, 25 Jun 2020 11:10:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZfchxDtaieXJ; Thu, 25 Jun 2020 11:10:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 91AEF8614A;
	Thu, 25 Jun 2020 11:10:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AB8BC0863;
	Thu, 25 Jun 2020 11:10:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70E2CC016F
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 11:10:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 63FFE87620
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 11:10:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vUuFFfR6RmFz for <iommu@lists.linux-foundation.org>;
 Thu, 25 Jun 2020 11:10:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id AE7E28759A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 11:10:44 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFF861FB;
 Thu, 25 Jun 2020 04:10:43 -0700 (PDT)
Received: from [10.57.13.97] (unknown [10.57.13.97])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF0DF3F73C;
 Thu, 25 Jun 2020 04:10:40 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] dma-direct: provide the ability to reserve
 per-numa CMA
To: Barry Song <song.bao.hua@hisilicon.com>, hch@lst.de,
 m.szyprowski@samsung.com, will@kernel.org, ganapatrao.kulkarni@cavium.com,
 catalin.marinas@arm.com
References: <20200625074330.13668-1-song.bao.hua@hisilicon.com>
 <20200625074330.13668-2-song.bao.hua@hisilicon.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <11672f20-6011-1a70-8def-fc662f52d50f@arm.com>
Date: Thu, 25 Jun 2020 12:10:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625074330.13668-2-song.bao.hua@hisilicon.com>
Content-Language: en-GB
Cc: Steve Capper <steve.capper@arm.com>, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
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

On 2020-06-25 08:43, Barry Song wrote:
> This is useful for at least two scenarios:
> 1. ARM64 smmu will get memory from local numa node, it can save its
> command queues and page tables locally. Tests show it can decrease
> dma_unmap latency at lot. For example, without this patch, smmu on
> node2 will get memory from node0 by calling dma_alloc_coherent(),
> typically, it has to wait for more than 560ns for the completion of
> CMD_SYNC in an empty command queue; with this patch, it needs 240ns
> only.
> 2. when we set iommu passthrough, drivers will get memory from CMA,
> local memory means much less latency.
> 
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Steve Capper <steve.capper@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>   include/linux/dma-contiguous.h |  4 ++
>   kernel/dma/Kconfig             | 10 ++++
>   kernel/dma/contiguous.c        | 99 ++++++++++++++++++++++++++++++----
>   3 files changed, 104 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
> index 03f8e98e3bcc..278a80a40456 100644
> --- a/include/linux/dma-contiguous.h
> +++ b/include/linux/dma-contiguous.h
> @@ -79,6 +79,8 @@ static inline void dma_contiguous_set_default(struct cma *cma)
>   
>   void dma_contiguous_reserve(phys_addr_t addr_limit);
>   
> +void dma_pernuma_cma_reserve(void);
> +
>   int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
>   				       phys_addr_t limit, struct cma **res_cma,
>   				       bool fixed);
> @@ -128,6 +130,8 @@ static inline void dma_contiguous_set_default(struct cma *cma) { }
>   
>   static inline void dma_contiguous_reserve(phys_addr_t limit) { }
>   
> +static inline void dma_pernuma_cma_reserve(void) { }
> +
>   static inline int dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
>   				       phys_addr_t limit, struct cma **res_cma,
>   				       bool fixed)
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index d006668c0027..aeb976b1d21c 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -104,6 +104,16 @@ config DMA_CMA
>   if  DMA_CMA
>   comment "Default contiguous memory area size:"
>   
> +config CMA_PERNUMA_SIZE_MBYTES
> +	int "Size in Mega Bytes for per-numa CMA areas"
> +	depends on NUMA
> +	default 16 if ARM64
> +	default 0
> +	help
> +	  Defines the size (in MiB) of the per-numa memory area for Contiguous
> +	  Memory Allocator. Every numa node will get a separate CMA with this
> +	  size. If the size of 0 is selected, per-numa CMA is disabled.
> +

I think this needs to be cleverer than just a static config option. 
Pretty much everything else CMA-related is runtime-configurable to some 
degree, and doing any per-node setup when booting on a single-node 
system would be wasted effort.

Since this is conceptually very similar to the existing hugetlb_cma 
implementation I'm also wondering about inconsistency with respect to 
specifying per-node vs. total sizes.

Another thought, though, is that systems large enough to have multiple 
NUMA nodes tend not to be short on memory, so it might not be 
unreasonable to base this all on whatever size the default area is 
given, and simply have a binary on/off switch to control the per-node 
aspect.

>   config CMA_SIZE_MBYTES
>   	int "Size in Mega Bytes"
>   	depends on !CMA_SIZE_SEL_PERCENTAGE
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 15bc5026c485..bcbd53aead93 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -30,7 +30,14 @@
>   #define CMA_SIZE_MBYTES 0
>   #endif
>   
> +#ifdef CONFIG_CMA_PERNUMA_SIZE_MBYTES
> +#define CMA_SIZE_PERNUMA_MBYTES CONFIG_CMA_PERNUMA_SIZE_MBYTES
> +#else
> +#define CMA_SIZE_PERNUMA_MBYTES 0
> +#endif
> +
>   struct cma *dma_contiguous_default_area;
> +static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
>   
>   /*
>    * Default global CMA area size can be defined in kernel's .config.
> @@ -44,6 +51,8 @@ struct cma *dma_contiguous_default_area;
>    */
>   static const phys_addr_t size_bytes __initconst =
>   	(phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
> +static const phys_addr_t pernuma_size_bytes __initconst =
> +	(phys_addr_t)CMA_SIZE_PERNUMA_MBYTES * SZ_1M;
>   static phys_addr_t  size_cmdline __initdata = -1;
>   static phys_addr_t base_cmdline __initdata;
>   static phys_addr_t limit_cmdline __initdata;
> @@ -96,6 +105,33 @@ static inline __maybe_unused phys_addr_t cma_early_percent_memory(void)
>   
>   #endif
>   
> +void __init dma_pernuma_cma_reserve(void)
> +{
> +	int nid;
> +
> +	if (!pernuma_size_bytes || nr_online_nodes <= 1)
> +		return;
> +
> +	for_each_node_state(nid, N_ONLINE) {

Do we need/want notifiers to handle currently-offline nodes coming 
online later (I'm not sure off-hand how NUMA interacts with stuff like 
"maxcpus=n")?

> +		int ret;
> +		char name[20];
> +
> +		snprintf(name, sizeof(name), "pernuma%d", nid);
> +		ret = cma_declare_contiguous_nid(0, pernuma_size_bytes, 0, 0,
> +						 0, false, name,
> +						 &dma_contiguous_pernuma_area[nid],
> +						 nid);
> +		if (ret) {
> +			pr_warn("%s: reservation failed: err %d, node %d", __func__,
> +				ret, nid);
> +			continue;
> +		}
> +
> +		pr_debug("%s: reserved %llu MiB on node %d\n", __func__,
> +			(unsigned long long)pernuma_size_bytes / SZ_1M, nid);
> +	}
> +}
> +
>   /**
>    * dma_contiguous_reserve() - reserve area(s) for contiguous memory handling
>    * @limit: End address of the reserved memory (optional, 0 for any).
> @@ -222,22 +258,31 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
>    * @gfp:   Allocation flags.
>    *
>    * This function allocates contiguous memory buffer for specified device. It
> - * tries to use device specific contiguous memory area if available, or the
> - * default global one.
> + * tries to use device specific contiguous memory area if available, or it
> + * tries to use per-numa cma, if the allocation fails, it will fallback to
> + * try default global one.
>    *
> - * Note that it byapss one-page size of allocations from the global area as
> - * the addresses within one page are always contiguous, so there is no need
> - * to waste CMA pages for that kind; it also helps reduce fragmentations.
> + * Note that it bypass one-page size of allocations from the per-numa and
> + * global area as the addresses within one page are always contiguous, so
> + * there is no need to waste CMA pages for that kind; it also helps reduce
> + * fragmentations.
>    */
>   struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
>   {
>   	size_t count = size >> PAGE_SHIFT;
>   	struct page *page = NULL;
>   	struct cma *cma = NULL;
> +	int nid = dev ? dev_to_node(dev) : NUMA_NO_NODE;

dev should never be NULL here (the existing check below could be cleaned 
up if we're refactoring anyway).

> +	bool alloc_from_pernuma = false;
>   
>   	if (dev && dev->cma_area)
>   		cma = dev->cma_area;
> -	else if (count > 1)
> +	else if ((nid != NUMA_NO_NODE) && dma_contiguous_pernuma_area[nid]
> +		&& !(gfp & (GFP_DMA | GFP_DMA32))
> +		&& (count > 1)) {
> +		cma = dma_contiguous_pernuma_area[nid];
> +		alloc_from_pernuma = true;
> +	} else if (count > 1)

Well this is a big ugly mess... I'd suggest restructuring the whole 
function to bail out immediately if (count == 1 && !dev->cma_area), then 
try the per-device, per-node and default areas in turn until something 
works.

>   		cma = dma_contiguous_default_area;
>   
>   	/* CMA can be used only in the context which permits sleeping */
> @@ -246,6 +291,11 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
>   		size_t cma_align = min_t(size_t, align, CONFIG_CMA_ALIGNMENT);
>   
>   		page = cma_alloc(cma, count, cma_align, gfp & __GFP_NOWARN);
> +
> +		/* fall back to default cma if failed in per-numa cma */
> +		if (!page && alloc_from_pernuma)
> +			page = cma_alloc(dma_contiguous_default_area, count,
> +				cma_align, gfp & __GFP_NOWARN);
>   	}
>   
>   	return page;
> @@ -264,9 +314,40 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
>    */
>   void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
>   {
> -	if (!cma_release(dev_get_cma_area(dev), page,
> -			 PAGE_ALIGN(size) >> PAGE_SHIFT))
> -		__free_pages(page, get_order(size));
> +	/* if dev has its own cma, free page from there */
> +	if (dev && dev->cma_area) {

Again, no new redundant NULL checks please.

> +		if (cma_release(dev->cma_area, page, PAGE_ALIGN(size) >> PAGE_SHIFT))
> +			return;
> +	} else {
> +		/*
> +		 * otherwise, page is from either per-numa cma or default cma
> +		 */
> +		int nid = dev ? dev_to_node(dev) : NUMA_NO_NODE;
> +
> +		if (nid != NUMA_NO_NODE) {
> +			int i;
> +
> +			/*
> +			 * Literally we only need to call cma_release() on pernuma cma of
> +			 * node nid, howerver, a corner case is that users might write
> +			 * /sys/devices/pci-x/numa_node to change node to workaround firmware
> +			 * bug, so it might allocate memory from nodeA CMA, but free from nodeB
> +			 * CMA.
> +			 */

Why bother with this dance at all? You have the page, so you can't not 
know where it is. Just use page_to_nid() like hugetlb_cma does.

Robin.

> +			for (i = 0; i < MAX_NUMNODES; i++) {
> +				if (cma_release(dma_contiguous_pernuma_area[i], page,
> +							PAGE_ALIGN(size) >> PAGE_SHIFT))
> +					return;
> +			}
> +		}
> +
> +		if (cma_release(dma_contiguous_default_area, page,
> +					PAGE_ALIGN(size) >> PAGE_SHIFT))
> +			return;
> +	}
> +
> +	/* not in any cma, free from buddy */
> +	__free_pages(page, get_order(size));
>   }
>   
>   /*
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
