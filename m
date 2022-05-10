Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753DEC433F5
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 16:34:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2A66840B1F;
	Tue, 10 May 2022 16:34:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xXVzIRrf9NjP; Tue, 10 May 2022 16:34:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 081AA40239;
	Tue, 10 May 2022 16:34:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8518C0032;
	Tue, 10 May 2022 16:34:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E245CC002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 16:34:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D081640B1F
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 16:34:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 03zAwAZcfUmB for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 16:34:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id E71B040239
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 16:34:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 575CC12FC;
 Tue, 10 May 2022 09:34:10 -0700 (PDT)
Received: from [10.57.80.111] (unknown [10.57.80.111])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25D593F73D;
 Tue, 10 May 2022 09:34:06 -0700 (PDT)
Message-ID: <cd64adcd-26fc-0452-754d-7ab0f5536142@arm.com>
Date: Tue, 10 May 2022 17:33:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] swiotlb: Max mapping size takes min align mask into
 account
Content-Language: en-GB
To: Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
 hch@infradead.org, m.szyprowski@samsung.com, michael.h.kelley@microsoft.com
References: <20220510142109.777738-1-ltykernel@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220510142109.777738-1-ltykernel@gmail.com>
Cc: parri.andrea@gmail.com, thomas.lendacky@amd.com,
 linux-hyperv@vger.kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 linux-scsi@vger.kernel.org, konrad.wilk@oracle.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, hch@lst.de
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

On 2022-05-10 15:21, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> swiotlb_find_slots() skips slots according to io tlb aligned mask
> calculated from min aligned mask and original physical address
> offset. This affects max mapping size. The mapping size can't
> achieve the IO_TLB_SEGSIZE * IO_TLB_SIZE when original offset is
> non-zero. This will cause system boot up failure in Hyper-V
> Isolation VM where swiotlb force is enabled. Scsi layer use return
> value of dma_max_mapping_size() to set max segment size and it
> finally calls swiotlb_max_mapping_size(). Hyper-V storage driver
> sets min align mask to 4k - 1. Scsi layer may pass 256k length of
> request buffer with 0~4k offset and Hyper-V storage driver can't
> get swiotlb bounce buffer via DMA API. Swiotlb_find_slots() can't
> find 256k length bounce buffer with offset. Make swiotlb_max_mapping
> _size() take min align mask into account.

Hmm, this seems a bit pessimistic - the offset can vary per mapping, so 
it feels to me like it should really be the caller's responsibility to 
account for it if they're already involved enough to care about both 
constraints. But I'm not sure how practical that would be.

Robin.

> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>   kernel/dma/swiotlb.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 73a41cec9e38..0d6684ca7eab 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -743,7 +743,18 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
>   
>   size_t swiotlb_max_mapping_size(struct device *dev)
>   {
> -	return ((size_t)IO_TLB_SIZE) * IO_TLB_SEGSIZE;
> +	int min_align_mask = dma_get_min_align_mask(dev);
> +	int min_align = 0;
> +
> +	/*
> +	 * swiotlb_find_slots() skips slots according to
> +	 * min align mask. This affects max mapping size.
> +	 * Take it into acount here.
> +	 */
> +	if (min_align_mask)
> +		min_align = roundup(min_align_mask, IO_TLB_SIZE);
> +
> +	return ((size_t)IO_TLB_SIZE) * IO_TLB_SEGSIZE - min_align;
>   }
>   
>   bool is_swiotlb_active(struct device *dev)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
