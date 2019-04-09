Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF745C282DA
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 17:59:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 886052133D
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 17:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886052133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5AB87E3C;
	Tue,  9 Apr 2019 17:59:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 67869E26
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 17:59:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id E4DA2CF
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 17:59:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7446615AB;
	Tue,  9 Apr 2019 10:59:35 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B9993F59C;
	Tue,  9 Apr 2019 10:59:33 -0700 (PDT)
Subject: Re: [PATCH 12/21] dma-iommu: factor atomic pool allocations into
	helpers
To: Christoph Hellwig <hch@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
	<20190327080448.5500-13-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com>
Date: Tue, 9 Apr 2019 18:59:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190327080448.5500-13-hch@lst.de>
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
Message-ID: <20190409175932.EmB9Hbz_paR2B99A4Xh9d_-DFjnrbYLZlNvEX8SPO-g@z>

On 27/03/2019 08:04, Christoph Hellwig wrote:
> This keeps the code together and will simplify compiling the code
> out on architectures that are always dma coherent.

And this is where things take a turn in the direction I just can't get 
on with - I'm looking at the final result and the twisty maze of little 
disjoint helpers all overlapping each other in functionality is really 
difficult to follow. And I would *much* rather have things rely on 
compile-time constant optimisation than spend the future having to fix 
the #ifdefed parts for arm64 whenever x86-centric changes fail to test them.

Conceptually, everything except the iommu_dma_alloc_remap() case is more 
or less just dma_direct_alloc() with an IOMMU mapping on top - if we 
could pass that an internal flag to say "don't fail or bounce because of 
masks" it seems like that approach could end up being quite a bit 
simpler (I did once have lofty plans to refactor the old arm64 code in 
such a way...)

Robin.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 51 +++++++++++++++++++++++++++++----------
>   1 file changed, 38 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 2013c650718a..8ec69176673d 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -673,6 +673,35 @@ static int iommu_dma_get_sgtable_remap(struct sg_table *sgt, void *cpu_addr,
>   			GFP_KERNEL);
>   }
>   
> +static void iommu_dma_free_pool(struct device *dev, size_t size,
> +		void *vaddr, dma_addr_t dma_handle)
> +{
> +	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), dma_handle, size);
> +	dma_free_from_pool(vaddr, PAGE_ALIGN(size));
> +}
> +
> +static void *iommu_dma_alloc_pool(struct device *dev, size_t size,
> +		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
> +{
> +	bool coherent = dev_is_dma_coherent(dev);
> +	struct page *page;
> +	void *vaddr;
> +
> +	vaddr = dma_alloc_from_pool(PAGE_ALIGN(size), &page, gfp);
> +	if (!vaddr)
> +		return NULL;
> +
> +	*dma_handle = __iommu_dma_map(dev, page_to_phys(page), size,
> +			dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs),
> +			iommu_get_domain_for_dev(dev));
> +	if (*dma_handle == DMA_MAPPING_ERROR) {
> +		dma_free_from_pool(vaddr, PAGE_ALIGN(size));
> +		return NULL;
> +	}
> +
> +	return vaddr;
> +}
> +
>   static void iommu_dma_sync_single_for_cpu(struct device *dev,
>   		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
>   {
> @@ -981,21 +1010,18 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
>   		 * get the virtually contiguous buffer we need by way of a
>   		 * physically contiguous allocation.
>   		 */
> -		if (coherent) {
> -			page = alloc_pages(gfp, get_order(size));
> -			addr = page ? page_address(page) : NULL;
> -		} else {
> -			addr = dma_alloc_from_pool(size, &page, gfp);
> -		}
> -		if (!addr)
> +		if (!coherent)
> +			return iommu_dma_alloc_pool(dev, iosize, handle, gfp,
> +					attrs);
> +
> +		page = alloc_pages(gfp, get_order(size));
> +		if (!page)
>   			return NULL;
>   
> +		addr = page_address(page);
>   		*handle = __iommu_dma_map_page(dev, page, 0, iosize, ioprot);
>   		if (*handle == DMA_MAPPING_ERROR) {
> -			if (coherent)
> -				__free_pages(page, get_order(size));
> -			else
> -				dma_free_from_pool(addr, size);
> +			__free_pages(page, get_order(size));
>   			addr = NULL;
>   		}
>   	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
> @@ -1049,8 +1075,7 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
>   	 * Hence how dodgy the below logic looks...
>   	 */
>   	if (dma_in_atomic_pool(cpu_addr, size)) {
> -		__iommu_dma_unmap_page(dev, handle, iosize, 0, 0);
> -		dma_free_from_pool(cpu_addr, size);
> +		iommu_dma_free_pool(dev, size, cpu_addr, handle);
>   	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
>   		struct page *page = vmalloc_to_page(cpu_addr);
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
