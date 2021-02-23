Return-Path: <SRS0=j2S/=HZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C831BC433DB
	for <iommu@archiver.kernel.org>; Tue, 23 Feb 2021 09:56:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55C7C64E31
	for <iommu@archiver.kernel.org>; Tue, 23 Feb 2021 09:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C7C64E31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0867F82FA5;
	Tue, 23 Feb 2021 09:56:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pFulxeQi7cHC; Tue, 23 Feb 2021 09:56:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1C2B82DC0;
	Tue, 23 Feb 2021 09:56:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5654C000B;
	Tue, 23 Feb 2021 09:56:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E577C0001
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 09:56:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F1FE586FD4
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 09:56:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LL-msdRjANmL for <iommu@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 09:56:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0BB3886FD2
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 09:56:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: gtucker) with ESMTPSA id 137961F453F0
Subject: Re: next/master bisection: baseline.login on r8a77960-ulcb
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Jianxiong Gao <jxgao@google.com>, Christoph Hellwig <hch@lst.de>
References: <60346234.1c69fb81.cd55e.770d@mx.google.com>
From: Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <7ac4a45f-b95e-acc0-f5bc-e4f870ac0bf1@collabora.com>
Date: Tue, 23 Feb 2021 09:56:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <60346234.1c69fb81.cd55e.770d@mx.google.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org,
 "kernelci-results@groups.io" <kernelci-results@groups.io>
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

Hi Christoph,

Please see the bisection report below about a boot failure on
r8a77960-ulcb on next-20210222.  

Reports aren't automatically sent to the public while we're
trialing new bisection features on kernelci.org but this one
looks valid.

The log shows a kernel panic, more details can be found here:

  https://kernelci.org/test/case/id/6034bde034504edc9faddd2c/

Please let us know if you need any help to debug the issue or try
a fix on this platform.

Best wishes,
Guillaume

On 23/02/2021 02:02, KernelCI bot wrote:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> next/master bisection: baseline.login on r8a77960-ulcb
> 
> Summary:
>   Start:      37dfbfbdca66 Add linux-next specific files for 20210222
>   Plain log:  https://storage.kernelci.org/next/master/next-20210222/arm64/defconfig/clang-10/lab-baylibre/baseline-r8a77960-ulcb.txt
>   HTML log:   https://storage.kernelci.org/next/master/next-20210222/arm64/defconfig/clang-10/lab-baylibre/baseline-r8a77960-ulcb.html
>   Result:     567d877f9a7d swiotlb: refactor swiotlb_tbl_map_single
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       next
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   Branch:     master
>   Target:     r8a77960-ulcb
>   CPU arch:   arm64
>   Lab:        lab-baylibre
>   Compiler:   clang-10
>   Config:     defconfig
>   Test case:  baseline.login
> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit 567d877f9a7d6bf4e4bf0ecd6de23fec8039b123
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Thu Feb 4 11:08:35 2021 +0100
> 
>     swiotlb: refactor swiotlb_tbl_map_single
>     
>     Split out a bunch of a self-contained helpers to make the function easier
>     to follow.
>     
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>     Acked-by: Jianxiong Gao <jxgao@google.com>
>     Tested-by: Jianxiong Gao <jxgao@google.com>
>     Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index b38b1553c466..381c24ef1ac1 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -468,134 +468,133 @@ static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
>  	}
>  }
>  
> -phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
> -		size_t mapping_size, size_t alloc_size,
> -		enum dma_data_direction dir, unsigned long attrs)
> -{
> -	dma_addr_t tbl_dma_addr = phys_to_dma_unencrypted(hwdev, io_tlb_start);
> -	unsigned long flags;
> -	phys_addr_t tlb_addr;
> -	unsigned int nslots, stride, index, wrap;
> -	int i;
> -	unsigned long mask;
> -	unsigned long offset_slots;
> -	unsigned long max_slots;
> -	unsigned long tmp_io_tlb_used;
> -
> -	if (no_iotlb_memory)
> -		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
> -
> -	if (mem_encrypt_active())
> -		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
> +#define slot_addr(start, idx)	((start) + ((idx) << IO_TLB_SHIFT))
>  
> -	if (mapping_size > alloc_size) {
> -		dev_warn_once(hwdev, "Invalid sizes (mapping: %zd bytes, alloc: %zd bytes)",
> -			      mapping_size, alloc_size);
> -		return (phys_addr_t)DMA_MAPPING_ERROR;
> -	}
> -
> -	mask = dma_get_seg_boundary(hwdev);
> +/*
> + * Carefully handle integer overflow which can occur when boundary_mask == ~0UL.
> + */
> +static inline unsigned long get_max_slots(unsigned long boundary_mask)
> +{
> +	if (boundary_mask == ~0UL)
> +		return 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
> +	return nr_slots(boundary_mask + 1);
> +}
>  
> -	tbl_dma_addr &= mask;
> +static unsigned int wrap_index(unsigned int index)
> +{
> +	if (index >= io_tlb_nslabs)
> +		return 0;
> +	return index;
> +}
>  
> -	offset_slots = nr_slots(tbl_dma_addr);
> +/*
> + * Find a suitable number of IO TLB entries size that will fit this request and
> + * allocate a buffer from that IO TLB pool.
> + */
> +static int find_slots(struct device *dev, size_t alloc_size)
> +{
> +	unsigned long boundary_mask = dma_get_seg_boundary(dev);
> +	dma_addr_t tbl_dma_addr =
> +		phys_to_dma_unencrypted(dev, io_tlb_start) & boundary_mask;
> +	unsigned int max_slots = get_max_slots(boundary_mask);
> +	unsigned int nslots = nr_slots(alloc_size), stride = 1;
> +	unsigned int index, wrap, count = 0, i;
> +	unsigned long flags;
>  
> -	/*
> -	 * Carefully handle integer overflow which can occur when mask == ~0UL.
> -	 */
> -	max_slots = mask + 1
> -		    ? nr_slots(mask + 1)
> -		    : 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
> +	BUG_ON(!nslots);
>  
>  	/*
>  	 * For mappings greater than or equal to a page, we limit the stride
>  	 * (and hence alignment) to a page size.
>  	 */
> -	nslots = nr_slots(alloc_size);
>  	if (alloc_size >= PAGE_SIZE)
> -		stride = (1 << (PAGE_SHIFT - IO_TLB_SHIFT));
> -	else
> -		stride = 1;
> +		stride <<= (PAGE_SHIFT - IO_TLB_SHIFT);
>  
> -	BUG_ON(!nslots);
> -
> -	/*
> -	 * Find suitable number of IO TLB entries size that will fit this
> -	 * request and allocate a buffer from that IO TLB pool.
> -	 */
>  	spin_lock_irqsave(&io_tlb_lock, flags);
> -
>  	if (unlikely(nslots > io_tlb_nslabs - io_tlb_used))
>  		goto not_found;
>  
> -	index = ALIGN(io_tlb_index, stride);
> -	if (index >= io_tlb_nslabs)
> -		index = 0;
> -	wrap = index;
> -
> +	index = wrap = wrap_index(ALIGN(io_tlb_index, stride));
>  	do {
> -		while (iommu_is_span_boundary(index, nslots, offset_slots,
> -					      max_slots)) {
> -			index += stride;
> -			if (index >= io_tlb_nslabs)
> -				index = 0;
> -			if (index == wrap)
> -				goto not_found;
> -		}
> -
>  		/*
>  		 * If we find a slot that indicates we have 'nslots' number of
>  		 * contiguous buffers, we allocate the buffers from that slot
>  		 * and mark the entries as '0' indicating unavailable.
>  		 */
> -		if (io_tlb_list[index] >= nslots) {
> -			int count = 0;
> -
> -			for (i = index; i < (int) (index + nslots); i++)
> -				io_tlb_list[i] = 0;
> -			for (i = index - 1;
> -			     io_tlb_offset(i) != IO_TLB_SEGSIZE - 1 &&
> -			     io_tlb_list[i]; i--)
> -				io_tlb_list[i] = ++count;
> -			tlb_addr = io_tlb_start + (index << IO_TLB_SHIFT);
> -
> -			/*
> -			 * Update the indices to avoid searching in the next
> -			 * round.
> -			 */
> -			io_tlb_index = ((index + nslots) < io_tlb_nslabs
> -					? (index + nslots) : 0);
> -
> -			goto found;
> +		if (!iommu_is_span_boundary(index, nslots,
> +					    nr_slots(tbl_dma_addr),
> +					    max_slots)) {
> +			if (io_tlb_list[index] >= nslots)
> +				goto found;
>  		}
> -		index += stride;
> -		if (index >= io_tlb_nslabs)
> -			index = 0;
> +		index = wrap_index(index + stride);
>  	} while (index != wrap);
>  
>  not_found:
> -	tmp_io_tlb_used = io_tlb_used;
> -
>  	spin_unlock_irqrestore(&io_tlb_lock, flags);
> -	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
> -		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
> -			 alloc_size, io_tlb_nslabs, tmp_io_tlb_used);
> -	return (phys_addr_t)DMA_MAPPING_ERROR;
> +	return -1;
> +
>  found:
> +	for (i = index; i < index + nslots; i++)
> +		io_tlb_list[i] = 0;
> +	for (i = index - 1;
> +	     io_tlb_offset(i) != IO_TLB_SEGSIZE - 1 &&
> +	     io_tlb_list[i]; i--)
> +		io_tlb_list[i] = ++count;
> +
> +	/*
> +	 * Update the indices to avoid searching in the next round.
> +	 */
> +	if (index + nslots < io_tlb_nslabs)
> +		io_tlb_index = index + nslots;
> +	else
> +		io_tlb_index = 0;
>  	io_tlb_used += nslots;
> +
>  	spin_unlock_irqrestore(&io_tlb_lock, flags);
> +	return index;
> +}
> +
> +phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
> +		size_t mapping_size, size_t alloc_size,
> +		enum dma_data_direction dir, unsigned long attrs)
> +{
> +	unsigned int index, i;
> +	phys_addr_t tlb_addr;
> +
> +	if (no_iotlb_memory)
> +		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
> +
> +	if (mem_encrypt_active())
> +		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
> +
> +	if (mapping_size > alloc_size) {
> +		dev_warn_once(dev, "Invalid sizes (mapping: %zd bytes, alloc: %zd bytes)",
> +			      mapping_size, alloc_size);
> +		return (phys_addr_t)DMA_MAPPING_ERROR;
> +	}
> +
> +	index = find_slots(dev, alloc_size);
> +	if (index == -1) {
> +		if (!(attrs & DMA_ATTR_NO_WARN))
> +			dev_warn_ratelimited(dev,
> +	"swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
> +				 alloc_size, io_tlb_nslabs, io_tlb_used);
> +		return (phys_addr_t)DMA_MAPPING_ERROR;
> +	}
>  
>  	/*
>  	 * Save away the mapping from the original address to the DMA address.
>  	 * This is needed when we sync the memory.  Then we sync the buffer if
>  	 * needed.
>  	 */
> -	for (i = 0; i < nslots; i++)
> -		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
> +	for (i = 0; i < nr_slots(alloc_size); i++)
> +		io_tlb_orig_addr[index + i] = slot_addr(orig_addr, i);
> +
> +	tlb_addr = slot_addr(io_tlb_start, index);
>  	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
>  	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
>  		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
> -
>  	return tlb_addr;
>  }
> -------------------------------------------------------------------------------
> 
> 
> Git bisection log:
> 
> -------------------------------------------------------------------------------
> git bisect start
> # good: [d99676af540c2dc829999928fb81c58c80a1dce4] Merge tag 'drm-next-2021-02-19' of git://anongit.freedesktop.org/drm/drm
> git bisect good d99676af540c2dc829999928fb81c58c80a1dce4
> # bad: [37dfbfbdca66834bc0f64ec9b35e09ac6c8898da] Add linux-next specific files for 20210222
> git bisect bad 37dfbfbdca66834bc0f64ec9b35e09ac6c8898da
> # bad: [25c1843cc6b3d64ce774ce7f1dc649ca3109a4c5] Merge remote-tracking branch 'block/for-next'
> git bisect bad 25c1843cc6b3d64ce774ce7f1dc649ca3109a4c5
> # good: [705552a85bfda7f2b0a3922b318d74fcc8368fd6] Merge remote-tracking branch 'btrfs/for-next'
> git bisect good 705552a85bfda7f2b0a3922b318d74fcc8368fd6
> # good: [eed3cd1a28b4a41ca25b8f5fbd86449be8ac3216] Merge remote-tracking branch 'v4l-dvb-next/master'
> git bisect good eed3cd1a28b4a41ca25b8f5fbd86449be8ac3216
> # bad: [366e8fe73e13244686604662ddcc70aa14a3e0e6] Merge remote-tracking branch 'rdma/for-next'
> git bisect bad 366e8fe73e13244686604662ddcc70aa14a3e0e6
> # good: [5120bf0a5fc15dec210a0fe0f39e4a256bb6e349] RDMA/rxe: Correct skb on loopback path
> git bisect good 5120bf0a5fc15dec210a0fe0f39e4a256bb6e349
> # good: [ffc46af1757e05652e17c47e4aa2a01bf5aaf3ad] Merge remote-tracking branch 'thermal/thermal/linux-next'
> git bisect good ffc46af1757e05652e17c47e4aa2a01bf5aaf3ad
> # good: [229557230c760e25b6af79709aa85d30de4c8500] RDMA/hns: Remove unused member and variable of CMDQ
> git bisect good 229557230c760e25b6af79709aa85d30de4c8500
> # good: [2b5715fc17386a6223490d5b8f08d031999b0c0b] RDMA/srp: Fix support for unpopulated and unbalanced NUMA nodes
> git bisect good 2b5715fc17386a6223490d5b8f08d031999b0c0b
> # bad: [e952d9a1bc204109a21f7dbedddedc110a33baf1] swiotlb: don't modify orig_addr in swiotlb_tbl_sync_single
> git bisect bad e952d9a1bc204109a21f7dbedddedc110a33baf1
> # good: [c7fbeca757fe74135d8b6a4c8ddaef76f5775d68] swiotlb: factor out an io_tlb_offset helper
> git bisect good c7fbeca757fe74135d8b6a4c8ddaef76f5775d68
> # good: [ca10d0f8e530600ec63c603dbace2c30927d70b7] swiotlb: clean up swiotlb_tbl_unmap_single
> git bisect good ca10d0f8e530600ec63c603dbace2c30927d70b7
> # bad: [567d877f9a7d6bf4e4bf0ecd6de23fec8039b123] swiotlb: refactor swiotlb_tbl_map_single
> git bisect bad 567d877f9a7d6bf4e4bf0ecd6de23fec8039b123
> # first bad commit: [567d877f9a7d6bf4e4bf0ecd6de23fec8039b123] swiotlb: refactor swiotlb_tbl_map_single
> -------------------------------------------------------------------------------
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#7292): https://groups.io/g/kernelci-results/message/7292
> Mute This Topic: https://groups.io/mt/80842441/924702
> Group Owner: kernelci-results+owner@groups.io
> Unsubscribe: https://groups.io/g/kernelci-results/unsub [guillaume.tucker@collabora.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
