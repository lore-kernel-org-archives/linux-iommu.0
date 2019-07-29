Return-Path: <SRS0=zE+z=V2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB55C7618B
	for <iommu@archiver.kernel.org>; Mon, 29 Jul 2019 18:29:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC832073F
	for <iommu@archiver.kernel.org>; Mon, 29 Jul 2019 18:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC832073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 371A91D08;
	Mon, 29 Jul 2019 18:29:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2FBCA1A23
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Jul 2019 16:16:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 82D4B5E4
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Jul 2019 16:16:26 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 288EC337;
	Mon, 29 Jul 2019 09:16:26 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D8883F694;
	Mon, 29 Jul 2019 09:16:25 -0700 (PDT)
Date: Mon, 29 Jul 2019 17:15:19 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/dma: Handle MSI mappings separately
Message-ID: <20190729171519.4dc6f0fb@donnerap.cambridge.arm.com>
In-Reply-To: <2b2595de703c60a772ebcffe248d0cf036143e6a.1564414114.git.robin.murphy@arm.com>
References: <2b2595de703c60a772ebcffe248d0cf036143e6a.1564414114.git.robin.murphy@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 29 Jul 2019 18:26:30 +0000
Cc: maz@kernel.org, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Mon, 29 Jul 2019 16:32:38 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

Hi,

> MSI pages must always be mapped into a device's *current* domain, which
> *might* be the default DMA domain, but might instead be a VFIO domain
> with its own MSI cookie. This subtlety got accidentally lost in the
> streamlining of __iommu_dma_map(), but rather than reintroduce more
> complexity and/or special-casing, it turns out neater to just split this
> path out entirely.
> 
> Since iommu_dma_get_msi_page() already duplicates much of what
> __iommu_dma_map() does, it can easily just make the allocation and
> mapping calls directly as well. That way we can further streamline the
> helper back to exclusively operating on DMA domains.
> 
> Fixes: b61d271e59d7 ("iommu/dma: Move domain lookup into __iommu_dma_{map,unmap}")
> Reported-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reported-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Thanks, that indeed fixes the pass through problem for me, the NVMe and SATA controller can now happily receive MSIs again.

Tested-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre.

> ---
>  drivers/iommu/dma-iommu.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index a7f9c3edbcb2..6441197a75ea 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -459,13 +459,11 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
>  {
>  	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>  	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> -	size_t iova_off = 0;
> +	struct iova_domain *iovad = &cookie->iovad;
> +	size_t iova_off = iova_offset(iovad, phys);
>  	dma_addr_t iova;
>  
> -	if (cookie->type == IOMMU_DMA_IOVA_COOKIE) {
> -		iova_off = iova_offset(&cookie->iovad, phys);
> -		size = iova_align(&cookie->iovad, size + iova_off);
> -	}
> +	size = iova_align(iovad, size + iova_off);
>  
>  	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
>  	if (!iova)
> @@ -1147,16 +1145,21 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>  	if (!msi_page)
>  		return NULL;
>  
> -	iova = __iommu_dma_map(dev, msi_addr, size, prot);
> -	if (iova == DMA_MAPPING_ERROR)
> +	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
> +	if (!iova)
>  		goto out_free_page;
>  
> +	if (iommu_map(domain, iova, msi_addr, size, prot))
> +		goto out_free_iova;
> +
>  	INIT_LIST_HEAD(&msi_page->list);
>  	msi_page->phys = msi_addr;
>  	msi_page->iova = iova;
>  	list_add(&msi_page->list, &cookie->msi_page_list);
>  	return msi_page;
>  
> +out_free_iova:
> +	iommu_dma_free_iova(cookie, iova, size);
>  out_free_page:
>  	kfree(msi_page);
>  	return NULL;

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
