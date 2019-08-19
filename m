Return-Path: <SRS0=RhgY=WP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3745C3A5A0
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 18:39:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93BA5205C9
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 18:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BA5205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 25361E59;
	Mon, 19 Aug 2019 18:39:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 07155E19;
	Mon, 19 Aug 2019 18:39:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 808728A0;
	Mon, 19 Aug 2019 18:39:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1408360;
	Mon, 19 Aug 2019 11:39:27 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 963663F246;
	Mon, 19 Aug 2019 11:39:24 -0700 (PDT)
Subject: Re: [PATCH V5 4/5] iommu/dma-iommu: Use the dev->coherent_dma_mask
To: Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org
References: <20190815110944.3579-1-murphyt7@tcd.ie>
	<20190815110944.3579-5-murphyt7@tcd.ie>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <d3c8d4ce-8ffb-bf69-a8f3-d64108f5987a@arm.com>
Date: Mon, 19 Aug 2019 19:39:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190815110944.3579-5-murphyt7@tcd.ie>
Content-Language: en-GB
Cc: Heiko Stuebner <heiko@sntech.de>, virtualization@lists.linux-foundation.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
	Andy Gross <agross@kernel.org>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>
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
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 15/08/2019 12:09, Tom Murphy wrote:
> Use the dev->coherent_dma_mask when allocating in the dma-iommu ops api.

Oops... I suppose technically that's my latent bug, but since we've all 
missed it so far, I doubt arm64 systems ever see any devices which 
actually have different masks.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
> ---
>   drivers/iommu/dma-iommu.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 906b7fa14d3c..b9a3ab02434b 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -471,7 +471,7 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
>   }
>   
>   static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> -		size_t size, int prot)
> +		size_t size, int prot, dma_addr_t dma_mask)
>   {
>   	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> @@ -484,7 +484,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
>   
>   	size = iova_align(iovad, size + iova_off);
>   
> -	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
> +	iova = iommu_dma_alloc_iova(domain, size, dma_mask, dev);
>   	if (!iova)
>   		return DMA_MAPPING_ERROR;
>   
> @@ -735,7 +735,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>   	int prot = dma_info_to_prot(dir, coherent, attrs);
>   	dma_addr_t dma_handle;
>   
> -	dma_handle = __iommu_dma_map(dev, phys, size, prot);
> +	dma_handle = __iommu_dma_map(dev, phys, size, prot, dma_get_mask(dev));
>   	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
>   	    dma_handle != DMA_MAPPING_ERROR)
>   		arch_sync_dma_for_device(dev, phys, size, dir);
> @@ -938,7 +938,8 @@ static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
>   		size_t size, enum dma_data_direction dir, unsigned long attrs)
>   {
>   	return __iommu_dma_map(dev, phys, size,
> -			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO);
> +			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
> +			dma_get_mask(dev));
>   }
>   
>   static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
> @@ -1041,7 +1042,8 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
>   	if (!cpu_addr)
>   		return NULL;
>   
> -	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot);
> +	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot,
> +			dev->coherent_dma_mask);
>   	if (*handle == DMA_MAPPING_ERROR) {
>   		__iommu_dma_free(dev, size, cpu_addr);
>   		return NULL;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
