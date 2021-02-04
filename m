Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85052C433DB
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 23:13:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D421264FA1
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 23:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D421264FA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 86CDF2E0BD;
	Thu,  4 Feb 2021 23:13:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MtyhMnYhdb1n; Thu,  4 Feb 2021 23:13:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 959DF2E06F;
	Thu,  4 Feb 2021 23:13:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C6D3C07FD;
	Thu,  4 Feb 2021 23:13:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23047C013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 23:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 11CFE8692E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 23:13:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dk35cqXLLBzu for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 23:13:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0C28B86925
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 23:13:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 386BFD6E;
 Thu,  4 Feb 2021 15:13:49 -0800 (PST)
Received: from [10.57.49.26] (unknown [10.57.49.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D7ED3F719;
 Thu,  4 Feb 2021 15:13:47 -0800 (PST)
Subject: Re: [PATCH 7/8] swiotlb: respect min_align_mask
To: Christoph Hellwig <hch@lst.de>, jxgao@google.com,
 gregkh@linuxfoundation.org
References: <20210204193035.2606838-1-hch@lst.de>
 <20210204193035.2606838-8-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <2e51481c-1591-034c-3476-1a1f8891506a@arm.com>
Date: Thu, 4 Feb 2021 23:13:45 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210204193035.2606838-8-hch@lst.de>
Content-Language: en-GB
Cc: saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 linux-nvme@lists.infradead.org, kbusch@kernel.org,
 iommu@lists.linux-foundation.org
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

On 2021-02-04 19:30, Christoph Hellwig wrote:
> Respect the min_align_mask in struct device_dma_parameters in swiotlb.
> 
> There are two parts to it:
>   1) for the lower bits of the alignment inside the io tlb slot, just
>      extent the size of the allocation and leave the start of the slot
>       empty
>   2) for the high bits ensure we find a slot that matches the high bits
>      of the alignment to avoid wasting too much memory
> 
> Based on an earlier patch from Jianxiong Gao <jxgao@google.com>.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/swiotlb.c | 49 +++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 6a2439826a1ba4..ab3192142b9906 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -468,6 +468,18 @@ static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
>   	}
>   }
>   
> +/*
> + * Return the offset into a iotlb slot required to keep the device happy.
> + */
> +static unsigned int swiotlb_align_offset(struct device *dev, u64 addr)
> +{
> +	unsigned min_align_mask = dma_get_min_align_mask(dev);
> +
> +	if (!min_align_mask)
> +		return 0;

I doubt that's beneficial - even if the compiler can convert it into a 
csel, it'll then be doing unnecessary work to throw away a 
cheaply-calculated 0 in favour of hard-coded 0 in the one case it matters ;)

> +	return addr & min_align_mask & ((1 << IO_TLB_SHIFT) - 1);

(BTW, for readability throughout, "#define IO_TLB_SIZE (1 << 
IO_TLB_SHIFT)" sure wouldn't go amiss...)

> +}
> +
>   /*
>    * Carefully handle integer overflow which can occur when boundary_mask == ~0UL.
>    */
> @@ -478,6 +490,16 @@ static inline unsigned long get_max_slots(unsigned long boundary_mask)
>   	return nr_slots(boundary_mask + 1);
>   }
>   
> +static inline bool check_alignment(phys_addr_t orig_addr,
> +		dma_addr_t tbl_dma_addr, unsigned int index,
> +		unsigned int min_align_mask)
> +{
> +	if (!min_align_mask)
> +		return true;

Ditto - even the 5 or so operations this might skip is unlikely to 
outweigh a branch on anything that matters, and again csel would be a 
net loss since x & 0 == y & 0 is still the correct answer.

> +	return ((tbl_dma_addr + (index << IO_TLB_SHIFT)) & min_align_mask) ==
> +		(orig_addr & min_align_mask);
> +}
> +
>   static unsigned int wrap_index(unsigned int index)
>   {
>   	if (index >= io_tlb_nslabs)
> @@ -489,9 +511,11 @@ static unsigned int wrap_index(unsigned int index)
>    * Find a suitable number of IO TLB entries size that will fit this request and
>    * allocate a buffer from that IO TLB pool.
>    */
> -static int find_slots(struct device *dev, size_t alloc_size,
> -		dma_addr_t tbl_dma_addr)
> +static int find_slots(struct device *dev, phys_addr_t orig_addr,
> +		size_t alloc_size, dma_addr_t tbl_dma_addr)
>   {
> +	unsigned int min_align_mask = dma_get_min_align_mask(dev) &
> +			~((1 << IO_TLB_SHIFT) - 1);
>   	unsigned int max_slots = get_max_slots(dma_get_seg_boundary(dev));
>   	unsigned int nslots = nr_slots(alloc_size), stride = 1;
>   	unsigned int index, wrap, count = 0, i;
> @@ -503,7 +527,9 @@ static int find_slots(struct device *dev, size_t alloc_size,
>   	 * For mappings greater than or equal to a page, we limit the stride
>   	 * (and hence alignment) to a page size.
>   	 */
> -	if (alloc_size >= PAGE_SIZE)
> +	if (min_align_mask)
> +		stride = (min_align_mask + 1) >> IO_TLB_SHIFT;

So this can't underflow because "min_align_mask" is actually just the 
high-order bits representing the number of iotlb slots needed to meet 
the requirement, right? (It took a good 5 minutes to realise this wasn't 
doing what I initially thought it did...)

In that case, a) could the local var be called something like 
iotlb_align_mask to clarify that it's *not* just a copy of the device's 
min_align_mask, and b) maybe just have an unconditional initialisation 
that works either way:

	stride = (min_align_mask >> IO_TLB_SHIFT) + 1;

In fact with that, I think could just mask orig_addr with ~IO_TLB_SIZE 
in the call to check_alignment() below, or shift everything down by 
IO_TLB_SHIFT in check_alignment() itself, instead of mangling 
min_align_mask at all (I'm assuming we do need to ignore the low-order 
bits of orig_addr at this point).

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
