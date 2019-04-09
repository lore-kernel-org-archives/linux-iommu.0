Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5624C10F0E
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 15:54:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A0532084C
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 15:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0532084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6C2E5FD0;
	Tue,  9 Apr 2019 15:54:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F0B40FCC
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 15:54:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 6FE0A76D
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 15:54:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34DDC15AB;
	Tue,  9 Apr 2019 08:54:34 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C84473F68F;
	Tue,  9 Apr 2019 08:54:32 -0700 (PDT)
Subject: Re: [PATCH 10/21] dma-iommu: move __iommu_dma_map
To: Christoph Hellwig <hch@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
	<20190327080448.5500-11-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b67950f5-dc3d-af5c-f4ff-d8943e5a5532@arm.com>
Date: Tue, 9 Apr 2019 16:54:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190327080448.5500-11-hch@lst.de>
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
Message-ID: <20190409155431.KZRq9EPzPLhhSVMPy1ZcsK1jA3hpiIBrN9wYtManbQk@z>

On 27/03/2019 08:04, Christoph Hellwig wrote:
> Moving this function up to its unmap counterpart helps to keep related
> code together for the following changes.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 46 +++++++++++++++++++--------------------
>   1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 57f2d8621112..4d46beeea5b7 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -435,6 +435,29 @@ static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr,
>   	iommu_dma_free_iova(cookie, dma_addr, size);
>   }
>   
> +static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> +		size_t size, int prot, struct iommu_domain *domain)
> +{
> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> +	size_t iova_off = 0;
> +	dma_addr_t iova;
> +
> +	if (cookie->type == IOMMU_DMA_IOVA_COOKIE) {
> +		iova_off = iova_offset(&cookie->iovad, phys);
> +		size = iova_align(&cookie->iovad, size + iova_off);
> +	}
> +
> +	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
> +	if (!iova)
> +		return DMA_MAPPING_ERROR;
> +
> +	if (iommu_map(domain, iova, phys - iova_off, size, prot)) {
> +		iommu_dma_free_iova(cookie, iova, size);
> +		return DMA_MAPPING_ERROR;
> +	}
> +	return iova + iova_off;
> +}
> +
>   static void __iommu_dma_free_pages(struct page **pages, int count)
>   {
>   	while (count--)
> @@ -689,29 +712,6 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
>   		arch_sync_dma_for_device(dev, sg_phys(sg), sg->length, dir);
>   }
>   
> -static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> -		size_t size, int prot, struct iommu_domain *domain)
> -{
> -	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> -	size_t iova_off = 0;
> -	dma_addr_t iova;
> -
> -	if (cookie->type == IOMMU_DMA_IOVA_COOKIE) {
> -		iova_off = iova_offset(&cookie->iovad, phys);
> -		size = iova_align(&cookie->iovad, size + iova_off);
> -	}
> -
> -	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
> -	if (!iova)
> -		return DMA_MAPPING_ERROR;
> -
> -	if (iommu_map(domain, iova, phys - iova_off, size, prot)) {
> -		iommu_dma_free_iova(cookie, iova, size);
> -		return DMA_MAPPING_ERROR;
> -	}
> -	return iova + iova_off;
> -}
> -
>   static dma_addr_t __iommu_dma_map_page(struct device *dev, struct page *page,
>   		unsigned long offset, size_t size, int prot)
>   {
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
