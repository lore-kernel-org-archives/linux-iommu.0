Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C052DC433FE
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 14:26:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 749F060E90;
	Fri, 29 Apr 2022 14:26:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s285FHc6aV3T; Fri, 29 Apr 2022 14:26:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0257260AEC;
	Fri, 29 Apr 2022 14:26:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD345C0039;
	Fri, 29 Apr 2022 14:26:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0A69C002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 14:26:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D719F60DF0
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 14:26:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bkCqsZH369fj for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 14:26:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 11A0E60AEC
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 14:26:00 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 j8-20020a17090a060800b001cd4fb60dccso7439922pjj.2
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 07:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language
 :from:to:cc:references:organization:in-reply-to
 :content-transfer-encoding;
 bh=XJdlUsUfqr6vxkPKuGRk9hrtLAlMOAFa8tdCT2FkzTU=;
 b=eszp6sR0PjzzLhwJT5W3nCqjKctaT8ylnNZcxmuYI0hKQmfI3WXSZbl62ALdaR76np
 oIOTXMjy8cf3rJpDXryOD119ShbM42uhbM9eLALBsIkWyCCoXW8TPOmrKue6j/0xQLPR
 oa+R5AomZGGINa9FISFtIVAUePioIE+YmvyJxygRuAXhGs+YbGXwQ2mbT2YDL9wEpkoh
 ImXmZf9WK+iVpobBcSMDaEk9xW8f1wMi4X7mVeMc3CM9b4qPt/XUjbR2kYTjnuGNt3gT
 FWWLQ6EfQKXRJ9oLNurPJIciH9FrhvNPl+MzrQELCgsmLW8Ad7D3HpsmkuXNsWXy8ioh
 cDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:from:to:cc:references:organization:in-reply-to
 :content-transfer-encoding;
 bh=XJdlUsUfqr6vxkPKuGRk9hrtLAlMOAFa8tdCT2FkzTU=;
 b=77gEUOub/ixq1oPnXMRYoxtG8pEH/NEUwBzxUvqt3Y3Pp90XlUWX4g9BR/iXHhdMGA
 1cL8ZaR3yuVG4WVo3S0J0/RCS/SOY7gIYp/58axC8o4euDDBKO21+soK23C4FuaWS5PL
 T9joSApCMB+kxGrOuJZFpj11+GgUJq1NMMrTCn0IO+ti0TJOmzYNXWx44SJWhpbZk9ir
 RWueZhMyn63huuG8ZFryGH8dSr9vxFHa91IRsKw5c0/E+yYWPhDk+H0vGwj7LKfmqr9A
 Vw7BG6VTJ2GunhCsa/PCIG4bFiUlkjZJx604obDYA4KMM0Ru7rjS+L7oA2IZPCg/j3GW
 +B6g==
X-Gm-Message-State: AOAM531yrsXb0IEo3oPaoPRfSxohhytxMwmFZUqX/GiF0yTKarYAwrRE
 7x1ILURQ20EH+5mYE9UqJvc=
X-Google-Smtp-Source: ABdhPJxWn/FK4fFSMV41dEGN/94EH8xCM2oBufHBUGl4zEaQ5ZNq36ReAdYyVyZDmSOJlfacrgyP2Q==
X-Received: by 2002:a17:90b:4a4c:b0:1d9:4c8e:8d3d with SMTP id
 lb12-20020a17090b4a4c00b001d94c8e8d3dmr4137374pjb.215.1651242360250; 
 Fri, 29 Apr 2022 07:26:00 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::597? ([2404:f801:9000:18:efec::597])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a17090aec0e00b001d8ace370cbsm14422673pjy.54.2022.04.29.07.25.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Apr 2022 07:25:59 -0700 (PDT)
Message-ID: <c0e70b17-cdf1-4fd8-f807-e4b9ccad44fd@gmail.com>
Date: Fri, 29 Apr 2022 22:25:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH] swiotlb: Add Child IO TLB mem support
Content-Language: en-US
From: Tianyu Lan <ltykernel@gmail.com>
To: hch@infradead.org, robin.murphy@arm.com
References: <e7b644f0-6c90-fe99-792d-75c38505dc54@arm.com>
 <20220429142147.1725184-1-ltykernel@gmail.com>
Organization: Microsft
In-Reply-To: <20220429142147.1725184-1-ltykernel@gmail.com>
Cc: parri.andrea@gmail.com, thomas.lendacky@amd.com, wei.liu@kernel.org,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-hyperv@vger.kernel.org,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 kirill.shutemov@intel.com, iommu@lists.linux-foundation.org,
 michael.h.kelley@microsoft.com, andi.kleen@intel.com, brijesh.singh@amd.com,
 vkuznets@redhat.com, kys@microsoft.com, hch@lst.de
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

On 4/29/2022 10:21 PM, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> Traditionally swiotlb was not performance critical because it was only
> used for slow devices. But in some setups, like TDX/SEV confidential
> guests, all IO has to go through swiotlb. Currently swiotlb only has a
> single lock. Under high IO load with multiple CPUs this can lead to
> significant lock contention on the swiotlb lock.
> 
> This patch adds child IO TLB mem support to resolve spinlock overhead
> among device's queues. Each device may allocate IO tlb mem and setup
> child IO TLB mem according to queue number. Swiotlb code allocates
> bounce buffer among child IO tlb mem iterately.
> 

Hi Robin and Christoph:
       According to Robin idea. I draft this patch. Please have a look 
and check whether it's right diection.

Thanks.

> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>   include/linux/swiotlb.h |  7 +++
>   kernel/dma/swiotlb.c    | 96 ++++++++++++++++++++++++++++++++++++-----
>   2 files changed, 93 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 7ed35dd3de6e..4a3f6a7b4b7e 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -89,6 +89,9 @@ extern enum swiotlb_force swiotlb_force;
>    * @late_alloc:	%true if allocated using the page allocator
>    * @force_bounce: %true if swiotlb bouncing is forced
>    * @for_alloc:  %true if the pool is used for memory allocation
> + * @child_nslot:The number of IO TLB slot in the child IO TLB mem.
> + * @num_child:  The child io tlb mem number in the pool.
> + * @child_start:The child index to start searching in the next round.
>    */
>   struct io_tlb_mem {
>   	phys_addr_t start;
> @@ -102,6 +105,10 @@ struct io_tlb_mem {
>   	bool late_alloc;
>   	bool force_bounce;
>   	bool for_alloc;
> +	unsigned int num_child;
> +	unsigned int child_nslot;
> +	unsigned int child_start;
> +	struct io_tlb_mem *child;
>   	struct io_tlb_slot {
>   		phys_addr_t orig_addr;
>   		size_t alloc_size;
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index e2ef0864eb1e..382fa2288645 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -207,6 +207,25 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
>   		mem->force_bounce = true;
>   
>   	spin_lock_init(&mem->lock);
> +
> +	if (mem->num_child) {
> +		mem->child_nslot = nslabs / mem->num_child;
> +		mem->child_start = 0;
> +
> +		/*
> +		 * Initialize child IO TLB mem, divide IO TLB pool
> +		 * into child number. Reuse parent mem->slot in the
> +		 * child mem->slot.
> +		 */
> +		for (i = 0; i < mem->num_child; i++) {
> +			mem->num_child = 0;
> +			mem->child[i].slots = mem->slots + i * mem->child_nslot;
> +			swiotlb_init_io_tlb_mem(&mem->child[i],
> +				start + ((i * mem->child_nslot) << IO_TLB_SHIFT),
> +				mem->child_nslot, late_alloc);
> +		}
> +	}
> +
>   	for (i = 0; i < mem->nslabs; i++) {
>   		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
>   		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
> @@ -336,16 +355,18 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>   
>   	mem->slots = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
>   		get_order(array_size(sizeof(*mem->slots), nslabs)));
> -	if (!mem->slots) {
> -		free_pages((unsigned long)vstart, order);
> -		return -ENOMEM;
> -	}
> +	if (!mem->slots)
> +		goto error_slots;
>   
>   	set_memory_decrypted((unsigned long)vstart, bytes >> PAGE_SHIFT);
>   	swiotlb_init_io_tlb_mem(mem, virt_to_phys(vstart), nslabs, true);
>   
>   	swiotlb_print_info();
>   	return 0;
> +
> +error_slots:
> +	free_pages((unsigned long)vstart, order);
> +	return -ENOMEM;
>   }
>   
>   void __init swiotlb_exit(void)
> @@ -483,10 +504,11 @@ static unsigned int wrap_index(struct io_tlb_mem *mem, unsigned int index)
>    * Find a suitable number of IO TLB entries size that will fit this request and
>    * allocate a buffer from that IO TLB pool.
>    */
> -static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
> -			      size_t alloc_size, unsigned int alloc_align_mask)
> +static int swiotlb_do_find_slots(struct io_tlb_mem *mem,
> +				 struct device *dev, phys_addr_t orig_addr,
> +				 size_t alloc_size,
> +				 unsigned int alloc_align_mask)
>   {
> -	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
>   	unsigned long boundary_mask = dma_get_seg_boundary(dev);
>   	dma_addr_t tbl_dma_addr =
>   		phys_to_dma_unencrypted(dev, mem->start) & boundary_mask;
> @@ -565,6 +587,46 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>   	return index;
>   }
>   
> +static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
> +			      size_t alloc_size, unsigned int alloc_align_mask)
> +{
> +	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
> +	struct io_tlb_mem *child_mem = mem;
> +	int start = 0, i = 0, index;
> +
> +	if (mem->num_child) {
> +		i = start = mem->child_start;
> +		mem->child_start = (mem->child_start + 1) % mem->num_child;
> +		child_mem = mem->child;
> +	}
> +
> +	do {
> +		index = swiotlb_do_find_slots(child_mem + i, dev, orig_addr,
> +					      alloc_size, alloc_align_mask);
> +		if (index >= 0)
> +			return i * mem->child_nslot + index;
> +		if (++i >= mem->num_child)
> +			i = 0;
> +	} while (i != start);
> +
> +	return -1;
> +}
> +
> +static unsigned long mem_used(struct io_tlb_mem *mem)
> +{
> +	int i;
> +	unsigned long used = 0;
> +
> +	if (mem->num_child) {
> +		for (i = 0; i < mem->num_child; i++)
> +			used += mem->child[i].used;
> +	} else {
> +		used = mem->used;
> +	}
> +
> +	return used;
> +}
> +
>   phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>   		size_t mapping_size, size_t alloc_size,
>   		unsigned int alloc_align_mask, enum dma_data_direction dir,
> @@ -594,7 +656,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>   		if (!(attrs & DMA_ATTR_NO_WARN))
>   			dev_warn_ratelimited(dev,
>   	"swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
> -				 alloc_size, mem->nslabs, mem->used);
> +				     alloc_size, mem->nslabs, mem_used(mem));
>   		return (phys_addr_t)DMA_MAPPING_ERROR;
>   	}
>   
> @@ -617,9 +679,9 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>   	return tlb_addr;
>   }
>   
> -static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
> +static void swiotlb_do_release_slots(struct io_tlb_mem *mem,
> +				     struct device *dev, phys_addr_t tlb_addr)
>   {
> -	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
>   	unsigned long flags;
>   	unsigned int offset = swiotlb_align_offset(dev, tlb_addr);
>   	int index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
> @@ -660,6 +722,20 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
>   	spin_unlock_irqrestore(&mem->lock, flags);
>   }
>   
> +static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
> +{
> +	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
> +	int index, offset;
> +
> +	if (mem->num_child) {
> +		offset = swiotlb_align_offset(dev, tlb_addr);	
> +		index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
> +		mem = &mem->child[index / mem->child_nslot];
> +	}
> +
> +	swiotlb_do_release_slots(mem, dev, tlb_addr);
> +}
> +
>   /*
>    * tlb_addr is the physical address of the bounce buffer to unmap.
>    */
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
