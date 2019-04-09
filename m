Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C1BC10F0E
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 15:49:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E652084C
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 15:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E652084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C0DDCE23;
	Tue,  9 Apr 2019 15:49:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A981E9EE
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 15:49:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 21262F4
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 15:49:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDD3815AB;
	Tue,  9 Apr 2019 08:49:32 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85F423F68F;
	Tue,  9 Apr 2019 08:49:31 -0700 (PDT)
Subject: Re: [PATCH 09/21] dma-iommu: refactor iommu_dma_get_sgtable
To: Christoph Hellwig <hch@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
	<20190327080448.5500-10-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a42133a5-c88b-76c7-80fa-671cfbdd9759@arm.com>
Date: Tue, 9 Apr 2019 16:49:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190327080448.5500-10-hch@lst.de>
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
Message-ID: <20190409154930.bu64LsZbfm-XA561MSvhXjKh0yLLxUyXOMjvGR4g6bo@z>

On 27/03/2019 08:04, Christoph Hellwig wrote:
> Move the vm_area handling into a new iommu_dma_get_sgtable_remap helper.
> 
> Inline __iommu_dma_get_sgtable_page into the main function to simplify
> the code flow a bit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 54 +++++++++++++++++----------------------
>   1 file changed, 24 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 43bd3c7e0f6b..57f2d8621112 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -625,6 +625,18 @@ static int iommu_dma_mmap_remap(void *cpu_addr, size_t size,
>   	return ret;
>   }
>   
> +static int iommu_dma_get_sgtable_remap(struct sg_table *sgt, void *cpu_addr,
> +		size_t size)
> +{
> +	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> +	struct vm_struct *area = find_vm_area(cpu_addr);
> +
> +	if (WARN_ON(!area || !area->pages))
> +		return -ENXIO;
> +	return sg_alloc_table_from_pages(sgt, area->pages, count, 0, size,
> +			GFP_KERNEL);
> +}
> +

Is this complex enough to deserve being broken out? Really I'd prefer to 
keep get_sgtable() as small and consolidated as possible so that it's 
that much easier to delete in future :)

I guess there is a certain symmetry with mmap(), so if that's the angle 
you're dead set on, could we at least keep this guy down where 
__iommu_dma_get_sgtable_page() was?

Robin.

>   static void iommu_dma_sync_single_for_cpu(struct device *dev,
>   		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
>   {
> @@ -1084,42 +1096,24 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   			vma_pages(vma) << PAGE_SHIFT, vma->vm_page_prot);
>   }
>   
> -static int __iommu_dma_get_sgtable_page(struct sg_table *sgt, struct page *page,
> -		size_t size)
> -{
> -	int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> -
> -	if (!ret)
> -		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
> -	return ret;
> -}
> -
>   static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
>   		void *cpu_addr, dma_addr_t dma_addr, size_t size,
>   		unsigned long attrs)
>   {
> -	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	struct vm_struct *area = find_vm_area(cpu_addr);
> -
> -	if (!is_vmalloc_addr(cpu_addr)) {
> -		struct page *page = virt_to_page(cpu_addr);
> -		return __iommu_dma_get_sgtable_page(sgt, page, size);
> -	}
> -
> -	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
> -		/*
> -		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
> -		 * hence in the vmalloc space.
> -		 */
> -		struct page *page = vmalloc_to_page(cpu_addr);
> -		return __iommu_dma_get_sgtable_page(sgt, page, size);
> -	}
> +	struct page *page;
> +	int ret;
>   
> -	if (WARN_ON(!area || !area->pages))
> -		return -ENXIO;
> +	if (is_vmalloc_addr(cpu_addr)) {
> +		if (!(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
> +			return iommu_dma_get_sgtable_remap(sgt, cpu_addr, size);
> +		page = vmalloc_to_page(cpu_addr);
> +	} else
> +		page = virt_to_page(cpu_addr);
>   
> -	return sg_alloc_table_from_pages(sgt, area->pages, count, 0, size,
> -					 GFP_KERNEL);
> +	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> +	if (!ret)
> +		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
> +	return ret;
>   }
>   
>   static const struct dma_map_ops iommu_dma_ops = {
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
