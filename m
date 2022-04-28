Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A1EC433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 15:50:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A9C141B76;
	Thu, 28 Apr 2022 15:50:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T6nHEfkWYP4t; Thu, 28 Apr 2022 15:50:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DE27A41B5C;
	Thu, 28 Apr 2022 15:50:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BE96C0039;
	Thu, 28 Apr 2022 15:50:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67982C002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 15:50:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4A90841B6B
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 15:50:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TVSk1bhtYULL for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 15:50:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CE50941B5C
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 15:50:30 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id s137so4309783pgs.5
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 08:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language
 :from:to:cc:references:in-reply-to:content-transfer-encoding;
 bh=Imag0hjy7QdACGCKnnCRVDWqGVDUoD+mTWN9dXIib0Q=;
 b=poCSO0UJrWfrgfI+DI+hsYCDVCTLBPeS77KfRdKeSDdwOky+s60OeFZJuAIu46aNDW
 zmeJt08N/iAu01cCgLNYfKwEJNDxQIn0qpq7DCEqhc43R3qYKIrbvhwsrisHNH8+IwOg
 lIAizxuPblVuZ2/KkdNAQgYtPp3+z6N+fsyl0s9pfssYzPDqlxcWahmpT4F2qt1xRvKD
 1wWK3pisRYWO1rvzw9WKHK598tqOlfr6CJox/NpvLNS3NDEVjlEP6WtfhUlsajPGOfM3
 hkGqWsMdXK/eBAuvCUIJe6NqOVEkl34m8p8/ATVY4/X9Q/FK4UVYsDO4o13CMyu8CXDV
 wLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:from:to:cc:references:in-reply-to
 :content-transfer-encoding;
 bh=Imag0hjy7QdACGCKnnCRVDWqGVDUoD+mTWN9dXIib0Q=;
 b=5xw75o2YYmm+iaLd+d+AfwYC3oftJRD4gAZV1Q4ajbbTZzRxYNVfkkUJBRaD2yMB63
 4B81nt82e6GY9Mct6wIvbik67Ec0KjOqz5gWLSlUNafW73gLiaEgMmy8En2kpEaRRGEO
 3nZFPL/f8Qtl9XDdSoXFhM1ZJjB3m9ILdAYnPA2Zjyue+KEvV/8zuQe7sXH5Yra+YWHC
 PGY+Amf9ge5tOfSXHnmTVym6q/Pmr1/e8xqOM5jzDLIdJi6pZuOtDx4PmrvUQxpYXTF7
 CI/8xkHVXOIOBsxigsRtdIeuh4jtzHzfRWa31Bz7ZNhoIXAGT4gnn7ZeyCzVwczrGH+7
 MdzQ==
X-Gm-Message-State: AOAM532/fgFVqWfOgBUrCSVOKE5STGyKhmJA6suepRH5d5TE5EsJGkSg
 SD+YOM46NGzg+j5k3fRVFlE=
X-Google-Smtp-Source: ABdhPJzeMEDsA7FX5zqk1r3VmwqW/qsSFKYz6yS8OxlafGK/JFcYQCczw8ejtEDPrqJZZ7pfq+8jqA==
X-Received: by 2002:a05:6a00:21c2:b0:4fe:81f:46c7 with SMTP id
 t2-20020a056a0021c200b004fe081f46c7mr35228695pfj.5.1651161030048; 
 Thu, 28 Apr 2022 08:50:30 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::597? ([2404:f801:9000:18:efec::597])
 by smtp.gmail.com with ESMTPSA id
 f127-20020a62db85000000b0050d3dd1138csm241380pfg.126.2022.04.28.08.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Apr 2022 08:50:29 -0700 (PDT)
Message-ID: <468482bc-38ad-81f3-a485-ebd557eb2083@gmail.com>
Date: Thu, 28 Apr 2022 23:50:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH 2/2] Swiotlb: Add device bounce buffer allocation
 interface
Content-Language: en-US
From: Tianyu Lan <ltykernel@gmail.com>
To: robin.murphy@arm.com, hch@infradead.org
References: <20220428141429.1637028-1-ltykernel@gmail.com>
 <20220428141429.1637028-3-ltykernel@gmail.com>
In-Reply-To: <20220428141429.1637028-3-ltykernel@gmail.com>
Cc: parri.andrea@gmail.com, thomas.lendacky@amd.com, wei.liu@kernel.org,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-hyperv@vger.kernel.org,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 kirill.shutemov@intel.com, iommu@lists.linux-foundation.org,
 michael.h.kelley@microsoft.com, hch@infradead.org, andi.kleen@intel.com,
 brijesh.singh@amd.com, vkuznets@redhat.com, kys@microsoft.com,
 robin.murphy@arm.com, hch@lst.de
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

On 4/28/2022 10:14 PM, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> In SEV/TDX Confidential VM, device DMA transaction needs use swiotlb
> bounce buffer to share data with host/hypervisor. The swiotlb spinlock
> introduces overhead among devices if they share io tlb mem. Avoid such
> issue, introduce swiotlb_device_allocate() to allocate device bounce
> buffer from default io tlb pool and set up areas according input queue
> number. Device may have multi io queues and setting up the same number
> of io tlb area may help to resolve spinlock overhead among queues.
> 
> Introduce IO TLB Block unit(2MB) concepts to allocate big bounce buffer
> from default pool for devices. IO TLB segment(256k) is too small.

Hi Christoph and Robin Murphy:

 From Christoph:
"Yeah.  We're almost done removing all knowledge of swiotlb from 
drivers, so the very last thing I want is an interface that allows a 
driver to allocate a per-device buffer."
	Please have a look at this patch. This patch is to provide a API
to device driver to allocate per-device buffer. Just providing 
per-device bounce buffer is not enough. Device still may have multi queue.
The single io tlb mem just has one spin lock in current code and this 
will introuduce overhead among queues DMA transaction. So the new API 
requests queues number as the IO TLB area number and this is why we 
still need to creat area in the IO Tlb mem.
        This new API is the one mentioned in the Christoph's comment.






> 
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>   include/linux/swiotlb.h |  33 ++++++++
>   kernel/dma/swiotlb.c    | 173 +++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 203 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 489c249da434..380bd1ce3d0f 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -31,6 +31,14 @@ struct scatterlist;
>   #define IO_TLB_SHIFT 11
>   #define IO_TLB_SIZE (1 << IO_TLB_SHIFT)
>   
> +/*
> + * IO TLB BLOCK UNIT as device bounce buffer allocation unit.
> + * This allows device allocates bounce buffer from default io
> + * tlb pool.
> + */
> +#define IO_TLB_BLOCKSIZE   (8 * IO_TLB_SEGSIZE)
> +#define IO_TLB_BLOCK_UNIT  (IO_TLB_BLOCKSIZE << IO_TLB_SHIFT)
> +
>   /* default to 64MB */
>   #define IO_TLB_DEFAULT_SIZE (64UL<<20)
>   
> @@ -72,11 +80,13 @@ extern enum swiotlb_force swiotlb_force;
>    * @index:	The slot index to start searching in this area for next round.
>    * @lock:	The lock to protect the above data structures in the map and
>    *		unmap calls.
> + * @block_index: The block index to start earching in this area for next round.
>    */
>   struct io_tlb_area {
>   	unsigned long used;
>   	unsigned int area_index;
>   	unsigned int index;
> +	unsigned int block_index;
>   	spinlock_t lock;
>   };
>   
> @@ -110,6 +120,7 @@ struct io_tlb_area {
>    * @num_areas:  The area number in the pool.
>    * @area_start: The area index to start searching in the next round.
>    * @area_nslabs: The slot number in the area.
> + * @areas_block_number: The block number in the area.
>    */
>   struct io_tlb_mem {
>   	phys_addr_t start;
> @@ -126,7 +137,14 @@ struct io_tlb_mem {
>   	unsigned int num_areas;
>   	unsigned int area_start;
>   	unsigned int area_nslabs;
> +	unsigned int area_block_number;
> +	struct io_tlb_mem *parent;
>   	struct io_tlb_area *areas;
> +	struct io_tlb_block {
> +		size_t alloc_size;
> +		unsigned long start_slot;
> +		unsigned int list;
> +	} *block;
>   	struct io_tlb_slot {
>   		phys_addr_t orig_addr;
>   		size_t alloc_size;
> @@ -155,6 +173,10 @@ unsigned int swiotlb_max_segment(void);
>   size_t swiotlb_max_mapping_size(struct device *dev);
>   bool is_swiotlb_active(struct device *dev);
>   void __init swiotlb_adjust_size(unsigned long size);
> +int swiotlb_device_allocate(struct device *dev,
> +			    unsigned int area_num,
> +			    unsigned long size);
> +void swiotlb_device_free(struct device *dev);
>   #else
>   static inline void swiotlb_init(bool addressing_limited, unsigned int flags)
>   {
> @@ -187,6 +209,17 @@ static inline bool is_swiotlb_active(struct device *dev)
>   static inline void swiotlb_adjust_size(unsigned long size)
>   {
>   }
> +
> +void swiotlb_device_free(struct device *dev)
> +{
> +}
> +
> +int swiotlb_device_allocate(struct device *dev,
> +			    unsigned int area_num,
> +			    unsigned long size)
> +{
> +	return -ENOMEM;
> +}
>   #endif /* CONFIG_SWIOTLB */
>   
>   extern void swiotlb_print_info(void);
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 00a16f540f20..7b95a140694a 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -218,7 +218,7 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
>   				    unsigned long nslabs, bool late_alloc)
>   {
>   	void *vaddr = phys_to_virt(start);
> -	unsigned long bytes = nslabs << IO_TLB_SHIFT, i, j;
> +	unsigned long bytes = nslabs << IO_TLB_SHIFT, i, j, k;
>   	unsigned int block_list;
>   
>   	mem->nslabs = nslabs;
> @@ -226,6 +226,7 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
>   	mem->end = mem->start + bytes;
>   	mem->index = 0;
>   	mem->late_alloc = late_alloc;
> +	mem->area_block_number = nslabs / (IO_TLB_BLOCKSIZE * mem->num_areas);
>   
>   	if (swiotlb_force_bounce)
>   		mem->force_bounce = true;
> @@ -233,10 +234,18 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
>   	for (i = 0, j = 0, k = 0; i < mem->nslabs; i++) {
>   		if (!(i % mem->area_nslabs)) {
>   			mem->areas[j].index = 0;
> +			mem->areas[j].block_index = 0;
>   			spin_lock_init(&mem->areas[j].lock);
> +			block_list = mem->area_block_number;
>   			j++;
>   		}
>   
> +		if (!(i % IO_TLB_BLOCKSIZE)) {
> +			mem->block[k].alloc_size = 0;
> +			mem->block[k].list = block_list--;
> +			k++;
> +		}
> +
>   		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
>   		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
>   		mem->slots[i].alloc_size = 0;
> @@ -308,6 +317,12 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>   	if (!mem->areas)
>   		panic("%s: Failed to allocate mem->areas.\n", __func__);
>   
> +	mem->block = memblock_alloc(sizeof(struct io_tlb_block) *
> +				    (default_nslabs / IO_TLB_BLOCKSIZE),
> +				     SMP_CACHE_BYTES);
> +	if (!mem->block)
> +		panic("%s: Failed to allocate mem->block.\n", __func__);
> +
>   	swiotlb_init_io_tlb_mem(mem, __pa(tlb), default_nslabs, false);
>   	mem->force_bounce = flags & SWIOTLB_FORCE;
>   
> @@ -332,7 +347,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>   	unsigned long nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
>   	unsigned long bytes;
>   	unsigned char *vstart = NULL;
> -	unsigned int order, area_order;
> +	unsigned int order, area_order, block_order;
>   	int rc = 0;
>   
>   	if (swiotlb_force_disable)
> @@ -380,6 +395,13 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>   	if (!mem->areas)
>   		goto error_area;
>   
> +	block_order = get_order(array_size(sizeof(*mem->block),
> +		nslabs / IO_TLB_BLOCKSIZE));
> +	mem->block = (struct io_tlb_block *)
> +		__get_free_pages(GFP_KERNEL | __GFP_ZERO, block_order);
> +	if (!mem->block)
> +		goto error_block;
> +
>   	mem->slots = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
>   		get_order(array_size(sizeof(*mem->slots), nslabs)));
>   	if (!mem->slots)
> @@ -392,6 +414,8 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>   	return 0;
>   
>   error_slots:
> +	free_pages((unsigned long)mem->block, block_order);
> +error_block:
>   	free_pages((unsigned long)mem->areas, area_order);
>   error_area:
>   	free_pages((unsigned long)vstart, order);
> @@ -403,7 +427,7 @@ void __init swiotlb_exit(void)
>   	struct io_tlb_mem *mem = &io_tlb_default_mem;
>   	unsigned long tbl_vaddr;
>   	size_t tbl_size, slots_size;
> -	unsigned int area_order;
> +	unsigned int area_order, block_order;
>   
>   	if (swiotlb_force_bounce)
>   		return;
> @@ -421,6 +445,9 @@ void __init swiotlb_exit(void)
>   		area_order = get_order(array_size(sizeof(*mem->areas),
>   			mem->num_areas));
>   		free_pages((unsigned long)mem->areas, area_order);
> +		block_order = get_order(array_size(sizeof(*mem->block),
> +			mem->nslabs / IO_TLB_BLOCKSIZE));
> +		free_pages((unsigned long)mem->block, block_order);
>   		free_pages(tbl_vaddr, get_order(tbl_size));
>   		free_pages((unsigned long)mem->slots, get_order(slots_size));
>   	} else {
> @@ -863,6 +890,146 @@ static int __init __maybe_unused swiotlb_create_default_debugfs(void)
>   late_initcall(swiotlb_create_default_debugfs);
>   #endif
>   
> +static void swiotlb_free_block(struct io_tlb_mem *mem,
> +			       phys_addr_t start, unsigned int block_num)
> +{
> +	unsigned int start_slot = (start - mem->start) >> IO_TLB_SHIFT;
> +	unsigned int area_index = start_slot / mem->num_areas;
> +	unsigned int block_index = start_slot / IO_TLB_BLOCKSIZE;
> +	unsigned int area_block_index = start_slot % mem->area_block_number;
> +	struct io_tlb_area *area = &mem->areas[area_index];
> +	unsigned long flags;
> +	int count, i, num;
> +
> +	spin_lock_irqsave(&area->lock, flags);
> +	if (area_block_index + block_num < mem->area_block_number)
> +		count = mem->block[block_index + block_num].list;
> +	else
> +		count = 0;
> +
> +
> +	for (i = block_index + block_num; i >= block_index; i--) {
> +		mem->block[i].list = ++count;
> +		/* Todo: recover slot->list and alloc_size here. */
> +	}
> +
> +	for (i = block_index - 1, num = block_index % mem->area_block_number;
> +	    i < num && mem->block[i].list; i--)
> +		mem->block[i].list = ++count;
> +
> +	spin_unlock_irqrestore(&area->lock, flags);
> +}
> +
> +void swiotlb_device_free(struct device *dev)
> +{
> +	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
> +	struct io_tlb_mem *parent_mem = dev->dma_io_tlb_mem->parent;
> +
> +	swiotlb_free_block(parent_mem, mem->start, mem->nslabs / IO_TLB_BLOCKSIZE);
> +}
> +
> +static struct page *swiotlb_alloc_block(struct io_tlb_mem *mem, unsigned int block_num)
> +{
> +	unsigned int area_index, block_index, nslot;
> +	phys_addr_t tlb_addr;
> +	struct io_tlb_area *area;
> +	unsigned long flags;
> +	int i, j;
> +
> +	if (!mem || !mem->block)
> +		return NULL;
> +
> +	area_index = mem->area_start;
> +	mem->area_start = (mem->area_start + 1) % mem->num_areas;
> +	area = &mem->areas[area_index];
> +
> +	spin_lock_irqsave(&area->lock, flags);
> +	block_index = area_index * mem->area_block_number + area->block_index;
> +
> +	/* Todo: Search more blocks. */
> +	if (mem->block[block_index].list < block_num) {
> +		spin_unlock_irqrestore(&area->lock, flags);
> +		return NULL;
> +	}
> +
> +	/* Update block and slot list. */
> +	for (i = block_index; i < block_index + block_num; i++) {
> +		mem->block[i].list = 0;
> +		for (j = 0; j < IO_TLB_BLOCKSIZE; j++) {
> +			nslot = i * IO_TLB_BLOCKSIZE + j;
> +			mem->slots[nslot].list = 0;
> +			mem->slots[nslot].alloc_size = IO_TLB_SIZE;
> +		}
> +	}
> +	spin_unlock_irqrestore(&area->lock, flags);
> +
> +	area->block_index += block_num;
> +	area->used += block_num * IO_TLB_BLOCKSIZE;
> +	tlb_addr = slot_addr(mem->start, block_index * IO_TLB_BLOCKSIZE);
> +	return pfn_to_page(PFN_DOWN(tlb_addr));
> +}
> +
> +/*
> + * swiotlb_device_allocate - Allocate bounce buffer fo device from
> + * default io tlb pool. The allocation size should be aligned with
> + * IO_TLB_BLOCK_UNIT.
> + */
> +int swiotlb_device_allocate(struct device *dev,
> +			    unsigned int area_num,
> +			    unsigned long size)
> +{
> +	struct io_tlb_mem *mem, *parent_mem = dev->dma_io_tlb_mem;
> +	unsigned long nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_BLOCKSIZE);
> +	struct page *page;
> +	int ret = -ENOMEM;
> +
> +	page = swiotlb_alloc_block(parent_mem, nslabs / IO_TLB_BLOCKSIZE);
> +	if (!page)
> +		return -ENOMEM;
> +
> +	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> +	if (!mem)
> +		goto error_mem;
> +
> +	mem->slots = kzalloc(array_size(sizeof(*mem->slots), nslabs),
> +			     GFP_KERNEL);
> +	if (!mem->slots)
> +		goto error_slots;
> +
> +	swiotlb_setup_areas(mem, area_num, nslabs);
> +	mem->areas = (struct io_tlb_area *)kcalloc(area_num,
> +				   sizeof(struct io_tlb_area),
> +				   GFP_KERNEL);
> +	if (!mem->areas)
> +		goto error_areas;
> +
> +	mem->block = (struct io_tlb_block *)kcalloc(nslabs / IO_TLB_BLOCKSIZE,
> +				sizeof(struct io_tlb_block),
> +				GFP_KERNEL);
> +	if (!mem->block)
> +		goto error_block;
> +
> +	swiotlb_init_io_tlb_mem(mem, page_to_phys(page), nslabs, true);
> +	mem->force_bounce = true;
> +	mem->for_alloc = true;
> +
> +	mem->vaddr = parent_mem->vaddr + page_to_phys(page) -  parent_mem->start;
> +	dev->dma_io_tlb_mem->parent = parent_mem;
> +	dev->dma_io_tlb_mem = mem;
> +	return 0;
> +
> +error_block:
> +	kfree(mem->areas);
> +error_areas:
> +	kfree(mem->slots);
> +error_slots:
> +	kfree(mem);
> +error_mem:
> +	swiotlb_device_free(dev);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(swiotlb_device_allocate);
> +
>   #ifdef CONFIG_DMA_RESTRICTED_POOL
>   
>   struct page *swiotlb_alloc(struct device *dev, size_t size)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
