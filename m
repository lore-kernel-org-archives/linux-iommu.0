Return-Path: <SRS0=vqUx=OG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F31C433F5
	for <iommu@archiver.kernel.org>; Thu, 16 Sep 2021 15:50:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2586860F51
	for <iommu@archiver.kernel.org>; Thu, 16 Sep 2021 15:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2586860F51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darnok.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E12B7415D2;
	Thu, 16 Sep 2021 15:50:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gLlyc67FJ3B5; Thu, 16 Sep 2021 15:50:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 90DAD415B7;
	Thu, 16 Sep 2021 15:50:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79BB1C0011;
	Thu, 16 Sep 2021 15:50:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44D5BC000D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 15:50:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5E96C83F2F
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 15:49:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uc3gLQhOrybD for <iommu@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 15:49:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E007D8367B
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 15:49:42 +0000 (UTC)
Received: by mail-qt1-x833.google.com with SMTP id g11so5943306qtk.5
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=UmS/7tV9mt9x6zEOIU7L7BJNgTTpfIT11ZHesMF3Uxs=;
 b=VnsxMBo5W1r+RnEuA2XS+T6edK1ir3f0GNnWWcuDNvMYC+a40qiQKcaMrnb5Eog9oz
 AqfrZlLqZRIEQ8+pA3RpJMi8M9WkaxFtBZA4JJszqbkVktr0plxMFL/fbRs7hPRRtFsr
 3azasOy5lKJAn0Q/2xP+5x5a3O06EdYJcD4xA0ThGkhDEdCsJmzKMUMk/bfqVi2QHLnQ
 3qdK13cetht8BRr08JHGxOMHMxiBt6WBrVkKkg6PWRcgXtQ3/c4opfgE3e9JN6kyN9jv
 PPWght6KkSJ5bX3Nv5UIDIrGpOb+HmcZL6vw4P5ML+f42dp1LcYhVoHW0pYzc1MohOgH
 hwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=UmS/7tV9mt9x6zEOIU7L7BJNgTTpfIT11ZHesMF3Uxs=;
 b=RwgaccjSDgT0Z9VV8vxsu8I4YP8f7Szu79eW64fkMJwwmPebY63X0k9rGaottwBRj1
 csmBrLVusmAPcNcANdjOMgvzhkRjiAjwBDTVwJqZF+qfFIxb4r9YD1FiOjI8DYl8id7C
 mNOBkRXbflq8o4VakycQc8O9CiL49mSG/WxqYh5WVK8aN/r1uuguwkpMAgKerd2JwYJD
 p0SL9t9i7ohsZfwSGuqJwAwLVL3uoTVz8k0OdLB89NtcnM/P8B5a+Fo4Jd3ceaiKqodc
 JGQSAQzKO/21sDWLAMKrCW2CjxF0z/AxfKTNpTThJjLF2WY+eOk6YWHBGxhoN91UWdwf
 UI0A==
X-Gm-Message-State: AOAM531CN6tVPP1jJwDaENFEJRJsv9J+uXTVlyPO/j6otG7zrUgiZj6W
 /7nyzFmyw+Xx6JdQCig39bc=
X-Google-Smtp-Source: ABdhPJw/FmtRxcXZPesSFTgpwLllyv4s21ndAh2wcqxpR8ITYxPurtNxyk7YxSkLrYduA1RBwF9JDw==
X-Received: by 2002:ac8:45cf:: with SMTP id e15mr5715442qto.322.1631807381704; 
 Thu, 16 Sep 2021 08:49:41 -0700 (PDT)
Received: from localhost.localdomain ([130.44.160.152])
 by smtp.gmail.com with ESMTPSA id c4sm2839903qkf.122.2021.09.16.08.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Sep 2021 08:49:41 -0700 (PDT)
Date: Thu, 16 Sep 2021 11:49:39 -0400
From: Konrad Rzeszutek Wilk <konrad@darnok.org>
To: Chao Gao <chao.gao@intel.com>
Subject: Re: [PATCH] swiotlb: allocate memory in a cache-friendly way
Message-ID: <YUNnkxiVnHUszg7G@localhost.localdomain>
References: <20210901042135.103981-1-chao.gao@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210901042135.103981-1-chao.gao@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Sep 01, 2021 at 12:21:35PM +0800, Chao Gao wrote:
> Currently, swiotlb uses a global index to indicate the starting point
> of next search. The index increases from 0 to the number of slots - 1
> and then wraps around. It is straightforward but not cache-friendly
> because the "oldest" slot in swiotlb tends to be used first.
> 
> Freed slots are probably accessed right before being freed, especially
> in VM's case (device backends access them in DMA_TO_DEVICE mode; guest
> accesses them in other DMA modes). Thus those just freed slots may
> reside in cache. Then reusing those just freed slots can reduce cache
> misses.
> 
> To that end, maintain a free list for free slots and insert freed slots
> from the head and searching for free slots always starts from the head.
> 
> With this optimization, network throughput of sending data from host to
> guest, measured by iperf3, increases by 7%.

Wow, that is pretty awesome!

Are there any other benchmarks that you ran that showed a negative
performance?

Thank you.
> 
> A bad side effect of this patch is we cannot use a large stride to skip
> unaligned slots when there is an alignment requirement. Currently, a
> large stride is used when a) device has an alignment requirement, stride
> is calculated according to the requirement; b) the requested size is
> larger than PAGE_SIZE. For x86 with 4KB page size, stride is set to 2.
> 
> For case a), few devices have an alignment requirement; the impact is
> limited. For case b) this patch probably leads to one (or more if page size
> is larger than 4K) additional lookup; but as the "io_tlb_slot" struct of
> free slots are also accessed when freeing slots, they probably resides in
> CPU cache as well and then the overhead is almost negligible.
> 
> Suggested-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> ---
>  include/linux/swiotlb.h | 15 ++++++++------
>  kernel/dma/swiotlb.c    | 43 +++++++++++------------------------------
>  2 files changed, 20 insertions(+), 38 deletions(-)
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index b0cb2a9973f4..8cafafd218af 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -63,6 +63,13 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
>  #ifdef CONFIG_SWIOTLB
>  extern enum swiotlb_force swiotlb_force;
>  
> +struct io_tlb_slot {
> +	phys_addr_t orig_addr;
> +	size_t alloc_size;
> +	unsigned int list;
> +	struct list_head node;
> +};
> +
>  /**
>   * struct io_tlb_mem - IO TLB Memory Pool Descriptor
>   *
> @@ -93,17 +100,13 @@ struct io_tlb_mem {
>  	phys_addr_t end;
>  	unsigned long nslabs;
>  	unsigned long used;
> -	unsigned int index;
> +	struct list_head free_slots;
>  	spinlock_t lock;
>  	struct dentry *debugfs;
>  	bool late_alloc;
>  	bool force_bounce;
>  	bool for_alloc;
> -	struct io_tlb_slot {
> -		phys_addr_t orig_addr;
> -		size_t alloc_size;
> -		unsigned int list;
> -	} *slots;
> +	struct io_tlb_slot *slots;
>  };
>  extern struct io_tlb_mem io_tlb_default_mem;
>  
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 87c40517e822..12b5b8471e54 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -184,7 +184,7 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
>  	mem->nslabs = nslabs;
>  	mem->start = start;
>  	mem->end = mem->start + bytes;
> -	mem->index = 0;
> +	INIT_LIST_HEAD(&mem->free_slots);
>  	mem->late_alloc = late_alloc;
>  
>  	if (swiotlb_force == SWIOTLB_FORCE)
> @@ -195,6 +195,7 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
>  		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
>  		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
>  		mem->slots[i].alloc_size = 0;
> +		list_add_tail(&mem->slots[i].node, &mem->free_slots);
>  	}
>  	memset(vaddr, 0, bytes);
>  }
> @@ -447,13 +448,6 @@ static inline unsigned long get_max_slots(unsigned long boundary_mask)
>  	return nr_slots(boundary_mask + 1);
>  }
>  
> -static unsigned int wrap_index(struct io_tlb_mem *mem, unsigned int index)
> -{
> -	if (index >= mem->nslabs)
> -		return 0;
> -	return index;
> -}
> -
>  /*
>   * Find a suitable number of IO TLB entries size that will fit this request and
>   * allocate a buffer from that IO TLB pool.
> @@ -462,38 +456,29 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>  			      size_t alloc_size)
>  {
>  	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
> +	struct io_tlb_slot *slot, *tmp;
>  	unsigned long boundary_mask = dma_get_seg_boundary(dev);
>  	dma_addr_t tbl_dma_addr =
>  		phys_to_dma_unencrypted(dev, mem->start) & boundary_mask;
>  	unsigned long max_slots = get_max_slots(boundary_mask);
>  	unsigned int iotlb_align_mask =
>  		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
> -	unsigned int nslots = nr_slots(alloc_size), stride;
> -	unsigned int index, wrap, count = 0, i;
> +	unsigned int nslots = nr_slots(alloc_size);
> +	unsigned int index, count = 0, i;
>  	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
>  	unsigned long flags;
>  
>  	BUG_ON(!nslots);
>  
> -	/*
> -	 * For mappings with an alignment requirement don't bother looping to
> -	 * unaligned slots once we found an aligned one.  For allocations of
> -	 * PAGE_SIZE or larger only look for page aligned allocations.
> -	 */
> -	stride = (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
> -	if (alloc_size >= PAGE_SIZE)
> -		stride = max(stride, stride << (PAGE_SHIFT - IO_TLB_SHIFT));
> -
>  	spin_lock_irqsave(&mem->lock, flags);
>  	if (unlikely(nslots > mem->nslabs - mem->used))
>  		goto not_found;
>  
> -	index = wrap = wrap_index(mem, ALIGN(mem->index, stride));
> -	do {
> +	list_for_each_entry_safe(slot, tmp, &mem->free_slots, node) {
> +		index = slot - mem->slots;
>  		if (orig_addr &&
>  		    (slot_addr(tbl_dma_addr, index) & iotlb_align_mask) !=
>  			    (orig_addr & iotlb_align_mask)) {
> -			index = wrap_index(mem, index + 1);
>  			continue;
>  		}
>  
> @@ -505,11 +490,10 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>  		if (!iommu_is_span_boundary(index, nslots,
>  					    nr_slots(tbl_dma_addr),
>  					    max_slots)) {
> -			if (mem->slots[index].list >= nslots)
> +			if (slot->list >= nslots)
>  				goto found;
>  		}
> -		index = wrap_index(mem, index + stride);
> -	} while (index != wrap);
> +	}
>  
>  not_found:
>  	spin_unlock_irqrestore(&mem->lock, flags);
> @@ -520,19 +504,13 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>  		mem->slots[i].list = 0;
>  		mem->slots[i].alloc_size =
>  			alloc_size - (offset + ((i - index) << IO_TLB_SHIFT));
> +		list_del(&mem->slots[i].node);
>  	}
>  	for (i = index - 1;
>  	     io_tlb_offset(i) != IO_TLB_SEGSIZE - 1 &&
>  	     mem->slots[i].list; i--)
>  		mem->slots[i].list = ++count;
>  
> -	/*
> -	 * Update the indices to avoid searching in the next round.
> -	 */
> -	if (index + nslots < mem->nslabs)
> -		mem->index = index + nslots;
> -	else
> -		mem->index = 0;
>  	mem->used += nslots;
>  
>  	spin_unlock_irqrestore(&mem->lock, flags);
> @@ -613,6 +591,7 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
>  		mem->slots[i].list = ++count;
>  		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
>  		mem->slots[i].alloc_size = 0;
> +		list_add(&mem->slots[i].node, &mem->free_slots);
>  	}
>  
>  	/*
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
