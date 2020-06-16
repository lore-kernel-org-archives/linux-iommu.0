Return-Path: <SRS0=6LHv=75=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DF2C433E0
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 12:02:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFC962071A
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 12:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC962071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6676820442;
	Tue, 16 Jun 2020 12:02:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vNbl9vZgaqdO; Tue, 16 Jun 2020 12:02:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 581A520407;
	Tue, 16 Jun 2020 12:02:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40683C0888;
	Tue, 16 Jun 2020 12:02:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 307A7C016E
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 12:02:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 020B820442
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 12:02:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vwz6Y9ExVW1n for <iommu@lists.linux-foundation.org>;
 Tue, 16 Jun 2020 12:02:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id AE43B20407
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 12:02:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C45C81FB;
 Tue, 16 Jun 2020 05:02:12 -0700 (PDT)
Received: from [10.57.45.14] (unknown [10.57.45.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C22173F6CF;
 Tue, 16 Jun 2020 05:02:11 -0700 (PDT)
Subject: Re: [PATCH] dma-direct: enable mmap for !CONFIG_MMU
To: Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org
References: <20200615070542.43761-1-hch@lst.de>
From: Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <0f7dd526-653f-bbb3-f9bd-b6923ce7ba8c@arm.com>
Date: Tue, 16 Jun 2020 13:02:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200615070542.43761-1-hch@lst.de>
Content-Language: en-US
Cc: dillon min <dillon.minfei@gmail.com>
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

On 6/15/20 8:05 AM, Christoph Hellwig wrote:
> nommu configfs can trivially map the coherent allocations to user space,
> as no actual page table setup is required and the kernel and the user
> space programs share the same address space.
> 
> Fixes: 62fcee9a3bd7 ("dma-mapping: remove CONFIG_ARCH_NO_COHERENT_DMA_MMAP")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reported-by: dillon min <dillon.minfei@gmail.com>
> Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Tested-by: dillon min <dillon.minfei@gmail.com>
> ---
>  kernel/dma/Kconfig  |  1 +
>  kernel/dma/direct.c | 14 --------------
>  2 files changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index d006668c0027d2..e0dae570a51530 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -71,6 +71,7 @@ config SWIOTLB
>  # in the pagetables
>  #
>  config DMA_NONCOHERENT_MMAP
> +	default y if !MMU
>  	bool
>  
>  config DMA_REMAP
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 0a4881e59aa7d6..9ec6a5c3fc578c 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -459,7 +459,6 @@ int dma_direct_get_sgtable(struct device *dev, struct sg_table *sgt,
>  	return ret;
>  }
>  
> -#ifdef CONFIG_MMU
>  bool dma_direct_can_mmap(struct device *dev)
>  {
>  	return dev_is_dma_coherent(dev) ||
> @@ -485,19 +484,6 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
>  	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
>  			user_count << PAGE_SHIFT, vma->vm_page_prot);
>  }
> -#else /* CONFIG_MMU */
> -bool dma_direct_can_mmap(struct device *dev)
> -{
> -	return false;
> -}
> -
> -int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
> -		void *cpu_addr, dma_addr_t dma_addr, size_t size,
> -		unsigned long attrs)
> -{
> -	return -ENXIO;
> -}
> -#endif /* CONFIG_MMU */
>  
>  int dma_direct_supported(struct device *dev, u64 mask)
>  {
> 

LGTM. Should it go stable as well?

Cheers
Vladimir
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
