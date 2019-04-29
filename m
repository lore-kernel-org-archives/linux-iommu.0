Return-Path: <SRS0=wClR=S7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268A3C43219
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 14:07:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE00D2063F
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 14:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE00D2063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id ACED31E09;
	Mon, 29 Apr 2019 14:07:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8A9971DEF
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 14:04:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 15DC3711
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 14:04:12 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1D4CA78;
	Mon, 29 Apr 2019 07:04:11 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BC9D3F5C1;
	Mon, 29 Apr 2019 07:04:10 -0700 (PDT)
Subject: Re: [PATCH 22/26] iommu/dma: Refactor iommu_dma_mmap
To: Christoph Hellwig <hch@lst.de>
References: <20190422175942.18788-1-hch@lst.de>
	<20190422175942.18788-23-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a185d782-acf4-2a29-a84f-d912de13c09c@arm.com>
Date: Mon, 29 Apr 2019 15:04:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422175942.18788-23-hch@lst.de>
Content-Language: en-GB
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190429140408.v7eFNtfoOoRey1wEC7m1JSZu8annC3Gf4ssewFIkOeE@z>

On 22/04/2019 18:59, Christoph Hellwig wrote:
> Inline __iommu_dma_mmap_pfn into the main function, and use the
> fact that __iommu_dma_get_pages return NULL for remapped contigous
> allocations to simplify the code flow a bit.

...and later we can squash __iommu_dma_mmap() once the dust settles on 
vm_map_pages() - seems good to me.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 36 +++++++++++-------------------------
>   1 file changed, 11 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 138b85e675c8..8fc6098c1eeb 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1025,21 +1025,12 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
>   	return cpu_addr;
>   }
>   
> -static int __iommu_dma_mmap_pfn(struct vm_area_struct *vma,
> -			      unsigned long pfn, size_t size)
> -{
> -	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
> -			       vma->vm_end - vma->vm_start,
> -			       vma->vm_page_prot);
> -}
> -
>   static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   		void *cpu_addr, dma_addr_t dma_addr, size_t size,
>   		unsigned long attrs)
>   {
>   	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	unsigned long off = vma->vm_pgoff;
> -	struct page **pages;
> +	unsigned long pfn, off = vma->vm_pgoff;
>   	int ret;
>   
>   	vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
> @@ -1050,24 +1041,19 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   	if (off >= nr_pages || vma_pages(vma) > nr_pages - off)
>   		return -ENXIO;
>   
> -	if (!is_vmalloc_addr(cpu_addr)) {
> -		unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
> -		return __iommu_dma_mmap_pfn(vma, pfn, size);
> -	}
> +	if (is_vmalloc_addr(cpu_addr)) {
> +		struct page **pages = __iommu_dma_get_pages(cpu_addr);
>   
> -	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
> -		/*
> -		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
> -		 * hence in the vmalloc space.
> -		 */
> -		unsigned long pfn = vmalloc_to_pfn(cpu_addr);
> -		return __iommu_dma_mmap_pfn(vma, pfn, size);
> +		if (pages)
> +			return __iommu_dma_mmap(pages, size, vma);
> +		pfn = vmalloc_to_pfn(cpu_addr);
> +	} else {
> +		pfn = page_to_pfn(virt_to_page(cpu_addr));
>   	}
>   
> -	pages = __iommu_dma_get_pages(cpu_addr);
> -	if (WARN_ON_ONCE(!pages))
> -		return -ENXIO;
> -	return __iommu_dma_mmap(pages, size, vma);
> +	return remap_pfn_range(vma, vma->vm_start, pfn + off,
> +			       vma->vm_end - vma->vm_start,
> +			       vma->vm_page_prot);
>   }
>   
>   static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
