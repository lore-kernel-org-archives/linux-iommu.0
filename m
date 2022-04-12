Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3449EC433F5
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 13:33:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D2D5061043;
	Tue, 12 Apr 2022 13:33:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0M4Hr5u2p_zU; Tue, 12 Apr 2022 13:33:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9B6DA61044;
	Tue, 12 Apr 2022 13:33:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83154C002F;
	Tue, 12 Apr 2022 13:33:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 394AEC002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 13:33:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1FCBF40B05
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 13:33:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1TMGobb992qR for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 13:33:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 57B7E40AF1
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 13:33:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9264A150C;
 Tue, 12 Apr 2022 06:33:10 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D8BD3F70D;
 Tue, 12 Apr 2022 06:33:09 -0700 (PDT)
Message-ID: <e25fbb7e-a67e-5421-b7be-700fd0209b0d@arm.com>
Date: Tue, 12 Apr 2022 14:33:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dma-direct: avoid redundant memory sync for swiotlb
Content-Language: en-GB
To: Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20220412113805.3210-1-chao.gao@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220412113805.3210-1-chao.gao@intel.com>
Cc: Wang Zhaoyang1 <zhaoyang1.wang@intel.com>, Gao Liang <liang.gao@intel.com>,
 Kevin Tian <kevin.tian@intel.com>, hch@lst.de
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

On 12/04/2022 12:38 pm, Chao Gao wrote:
> When we looked into FIO performance with swiotlb enabled in VM, we found
> swiotlb_bounce() is always called one more time than expected for each DMA
> read request.
> 
> It turns out that the bounce buffer is copied to original DMA buffer twice
> after the completion of a DMA request (one is done by in
> dma_direct_sync_single_for_cpu(), the other by swiotlb_tbl_unmap_single()).
> But the content in bounce buffer actually doesn't change between the two
> rounds of copy. So, one round of copy is redundant.
> 
> Pass DMA_ATTR_SKIP_CPU_SYNC flag to swiotlb_tbl_unmap_single() to
> skip the memory copy in it.

It's still a little suboptimal and non-obvious to call into SWIOTLB 
twice though - even better might be for SWIOTLB to call 
arch_sync_dma_for_cpu() at the appropriate place internally, then put 
the dma_direct_sync in an else path here. I'm really not sure why we 
have the current disparity between map and unmap in this regard... :/

Robin.

> This fix increases FIO 64KB sequential read throughput in a guest with
> swiotlb=force by 5.6%.
> 
> Reported-by: Wang Zhaoyang1 <zhaoyang1.wang@intel.com>
> Reported-by: Gao Liang <liang.gao@intel.com>
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>   kernel/dma/direct.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index 4632b0f4f72e..8a6cd53dbe8c 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -114,6 +114,7 @@ static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
>   		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
>   
>   	if (unlikely(is_swiotlb_buffer(dev, phys)))
> -		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
> +		swiotlb_tbl_unmap_single(dev, phys, size, dir,
> +					 attrs | DMA_ATTR_SKIP_CPU_SYNC);
>   }
>   #endif /* _KERNEL_DMA_DIRECT_H */
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
