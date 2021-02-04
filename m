Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC21C433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 22:12:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3D6C64E42
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 22:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D6C64E42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 73F288726D;
	Thu,  4 Feb 2021 22:12:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EOyKpEfFlLds; Thu,  4 Feb 2021 22:12:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 27B008718C;
	Thu,  4 Feb 2021 22:12:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10CB8C0174;
	Thu,  4 Feb 2021 22:12:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 879C6C013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 22:12:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6EAB686D2F
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 22:12:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q3HLuzrb0LaB for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 22:12:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4FA2A86D09
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 22:12:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55BF613A1;
 Thu,  4 Feb 2021 14:12:34 -0800 (PST)
Received: from [10.57.49.26] (unknown [10.57.49.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CD0F3F718;
 Thu,  4 Feb 2021 14:12:32 -0800 (PST)
Subject: Re: [PATCH 5/8] swiotlb: refactor swiotlb_tbl_map_single
To: Christoph Hellwig <hch@lst.de>, jxgao@google.com,
 gregkh@linuxfoundation.org
References: <20210204193035.2606838-1-hch@lst.de>
 <20210204193035.2606838-6-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f60ddc1b-94c3-32a1-06eb-b2187d56d797@arm.com>
Date: Thu, 4 Feb 2021 22:12:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210204193035.2606838-6-hch@lst.de>
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
> Split out a bunch of a self-contained helpers to make the function easier
> to follow.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/swiotlb.c | 177 +++++++++++++++++++++----------------------
>   1 file changed, 87 insertions(+), 90 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 79d5b236f25f10..e78615e3be2906 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -468,134 +468,131 @@ static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
>   	}
>   }
>   
> -phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
> -		size_t mapping_size, size_t alloc_size,
> -		enum dma_data_direction dir, unsigned long attrs)
> +/*
> + * Carefully handle integer overflow which can occur when boundary_mask == ~0UL.
> + */
> +static inline unsigned long get_max_slots(unsigned long boundary_mask)
>   {
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
> -
> -	if (mapping_size > alloc_size) {
> -		dev_warn_once(hwdev, "Invalid sizes (mapping: %zd bytes, alloc: %zd bytes)",
> -			      mapping_size, alloc_size);
> -		return (phys_addr_t)DMA_MAPPING_ERROR;
> -	}
> -
> -	mask = dma_get_seg_boundary(hwdev);
> +	if (boundary_mask + 1 == ~0UL)

Either "mask == ~0UL" or "mask + 1 == 0", surely?

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
> +static int find_slots(struct device *dev, size_t alloc_size,
> +		dma_addr_t tbl_dma_addr)
> +{
> +	unsigned int max_slots = get_max_slots(dma_get_seg_boundary(dev));
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

...since the condition here is effectively the latter.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
