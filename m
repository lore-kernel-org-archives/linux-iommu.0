Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862E2C43334
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 14:49:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 13C9C40C58;
	Tue, 28 Jun 2022 14:49:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 13C9C40C58
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jXMv+sJT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mp0FpA1EFGXs; Tue, 28 Jun 2022 14:49:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ACFAA400FD;
	Tue, 28 Jun 2022 14:49:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ACFAA400FD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16013C0080;
	Tue, 28 Jun 2022 14:49:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB8DAC002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 13:11:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7807D60E64
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 13:11:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7807D60E64
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=jXMv+sJT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bRqyHcY-DaYv for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 13:11:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 867B8605AC
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 867B8605AC
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 13:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656421889; x=1687957889;
 h=date:from:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=DaNkICMn0cvyN3Nw69IWZXGw9/gClLhfsSUxhFyTR1w=;
 b=jXMv+sJTbDcBV1TcFej9Hh4S/bAIsDUywfKEn+jD538wwdXhiTmbCB15
 IC8vmCHZSIlG0VDVVZY8f5COWChAAiW9/s9PQ8oAfhNYuAHFZliCmvpJY
 06yGD3Zz2UoZwjl2XWZ9Xr1ZIt56lkTFN6nKDNph3jIKMNqf5nEnV3obe
 sg7nxD6qDsVO6n0c5o8ag6WwDOp2TEcEc306cBMr35UOhpVnzQffyI/UT
 ei6M8r934Am0jjU58F/vLBrr+tMA+6uj1dCw3nzKfetexy6V6lxco8dH7
 7gucsAXnqqcqBTDYnXI/BMefpeYfMDOqsixW6/Pi3JzwhGH1PHWkOTkZ6 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="261539975"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="261539975"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 06:11:29 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="646908165"
Received: from iannetti-mobl.ger.corp.intel.com ([10.251.216.215])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 06:11:26 -0700
Date: Tue, 28 Jun 2022 16:11:24 +0300 (EEST)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Chao Gao <chao.gao@intel.com>
Subject: Re: [PATCH v1 1/3] swiotlb: Use bitmap to track free slots
In-Reply-To: <20220628070136.419163-2-chao.gao@intel.com>
Message-ID: <ae35e2-f224-635f-442f-ce1a537374e3@linux.intel.com>
References: <20220628070136.419163-1-chao.gao@intel.com>
 <20220628070136.419163-2-chao.gao@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1081361240-1656421888=:1603"
X-Mailman-Approved-At: Tue, 28 Jun 2022 14:49:26 +0000
Cc: len.brown@intel.com, tony.luck@intel.com, rafael.j.wysocki@intel.com,
 LKML <linux-kernel@vger.kernel.org>, dave.hansen@intel.com,
 iommu@lists.linux-foundation.org, dan.j.williams@intel.com,
 reinette.chatre@intel.com, kirill.shutemov@linux.intel.com
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1081361240-1656421888=:1603
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 28 Jun 2022, Chao Gao wrote:

> Currently, each slot tracks the number of contiguous free slots starting
> from itself. It helps to quickly check if there are enough contiguous
> entries when dealing with an allocation request. But maintaining this
> information can leads to some overhead. Specifically, if a slot is
> allocated/freed, preceding slots may need to be updated as the number
> of contiguous free slots can change. This process may access memory
> scattering over multiple cachelines.
> 
> To reduce the overhead of maintaining the number of contiguous free
> entries, use a global bitmap to track free slots; each bit represents
> if a slot is available. The number of contiguous free slots can be
> calculated by counting the number of consecutive 1s in the bitmap.
> 
> Tests show that the average cost of freeing slots drops by 120 cycles
> while the average cost of allocation increases by 20 cycles. Overall,
> 100 cycles are saved from a pair of allocation and freeing.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

One nit below.

> ---
>  include/linux/swiotlb.h |  6 ++--
>  kernel/dma/swiotlb.c    | 64 ++++++++++++++++++++---------------------
>  2 files changed, 34 insertions(+), 36 deletions(-)
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 7ed35dd3de6e..c3eab237991a 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -78,8 +78,6 @@ extern enum swiotlb_force swiotlb_force;
>   *		@end. For default swiotlb, this is command line adjustable via
>   *		setup_io_tlb_npages.
>   * @used:	The number of used IO TLB block.
> - * @list:	The free list describing the number of free entries available
> - *		from each index.
>   * @index:	The index to start searching in the next round.
>   * @orig_addr:	The original address corresponding to a mapped entry.
>   * @alloc_size:	Size of the allocated buffer.
> @@ -89,6 +87,8 @@ extern enum swiotlb_force swiotlb_force;
>   * @late_alloc:	%true if allocated using the page allocator
>   * @force_bounce: %true if swiotlb bouncing is forced
>   * @for_alloc:  %true if the pool is used for memory allocation
> + * @bitmap:	The bitmap used to track free entries. 1 in bit X means the slot
> + *		indexed by X is free.
>   */
>  struct io_tlb_mem {
>  	phys_addr_t start;
> @@ -105,8 +105,8 @@ struct io_tlb_mem {
>  	struct io_tlb_slot {
>  		phys_addr_t orig_addr;
>  		size_t alloc_size;
> -		unsigned int list;
>  	} *slots;
> +	unsigned long *bitmap;
>  };
>  extern struct io_tlb_mem io_tlb_default_mem;
>  
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index cb50f8d38360..d7f68c0af7f5 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -207,7 +207,7 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
>  
>  	spin_lock_init(&mem->lock);
>  	for (i = 0; i < mem->nslabs; i++) {
> -		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
> +		__set_bit(i, mem->bitmap);
>  		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
>  		mem->slots[i].alloc_size = 0;
>  	}
> @@ -274,6 +274,11 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>  		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
>  		      __func__, alloc_size, PAGE_SIZE);
>  
> +	mem->bitmap = memblock_alloc(BITS_TO_BYTES(nslabs), SMP_CACHE_BYTES);
> +	if (!mem->bitmap)
> +		panic("%s: Failed to allocate %lu bytes align=0x%x\n",
> +		      __func__, DIV_ROUND_UP(nslabs, BITS_PER_BYTE), SMP_CACHE_BYTES);
> +
>  	swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, flags, false);
>  
>  	if (flags & SWIOTLB_VERBOSE)
> @@ -337,10 +342,13 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  			(PAGE_SIZE << order) >> 20);
>  	}
>  
> +	mem->bitmap = bitmap_zalloc(nslabs, GFP_KERNEL);
>  	mem->slots = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
>  		get_order(array_size(sizeof(*mem->slots), nslabs)));
> -	if (!mem->slots) {
> +	if (!mem->slots || !mem->bitmap) {
>  		free_pages((unsigned long)vstart, order);
> +		bitmap_free(mem->bitmap);
> +		kfree(mem->slots);
>  		return -ENOMEM;
>  	}
>  
> @@ -498,7 +506,7 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>  	unsigned int iotlb_align_mask =
>  		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
>  	unsigned int nslots = nr_slots(alloc_size), stride;
> -	unsigned int index, wrap, count = 0, i;
> +	unsigned int index, wrap, i;
>  	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
>  	unsigned long flags;
>  
> @@ -514,6 +522,9 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>  		stride = max(stride, stride << (PAGE_SHIFT - IO_TLB_SHIFT));
>  	stride = max(stride, (alloc_align_mask >> IO_TLB_SHIFT) + 1);
>  
> +	/* slots shouldn't cross one segment */
> +	max_slots = min_t(unsigned long, max_slots, IO_TLB_SEGSIZE);
> +
>  	spin_lock_irqsave(&mem->lock, flags);
>  	if (unlikely(nslots > mem->nslabs - mem->used))
>  		goto not_found;
> @@ -535,8 +546,15 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>  		if (!iommu_is_span_boundary(index, nslots,
>  					    nr_slots(tbl_dma_addr),
>  					    max_slots)) {
> -			if (mem->slots[index].list >= nslots)
> +			if (find_next_zero_bit(mem->bitmap, index + nslots, index) ==
> +					index + nslots)
>  				goto found;
> +		} else {
> +			/*
> +			 * Remaining slots between current one and the next
> +			 * bounary cannot meet our requirement.

bounary -> boundary


-- 
 i.

--8323329-1081361240-1656421888=:1603
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--8323329-1081361240-1656421888=:1603--
