Return-Path: <SRS0=1Id5=UF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829F5C28D1A
	for <iommu@archiver.kernel.org>; Thu,  6 Jun 2019 06:29:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64BB32070B
	for <iommu@archiver.kernel.org>; Thu,  6 Jun 2019 06:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BB32070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3D239AF7;
	Thu,  6 Jun 2019 06:29:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EA3B5AE7
	for <iommu@lists.linux-foundation.org>;
	Thu,  6 Jun 2019 06:29:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7F11E34F
	for <iommu@lists.linux-foundation.org>;
	Thu,  6 Jun 2019 06:29:07 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 9166C68B05; Thu,  6 Jun 2019 08:28:40 +0200 (CEST)
Date: Thu, 6 Jun 2019 08:28:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nicolin Chen <nicoleotsuka@gmail.com>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/dma: Apply dma_{alloc,free}_contiguous functions
Message-ID: <20190606062840.GD26745@lst.de>
References: <20190603225259.21994-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190603225259.21994-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: hch@lst.de, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

Looks fine to me.  Robin, any comments?

On Mon, Jun 03, 2019 at 03:52:59PM -0700, Nicolin Chen wrote:
> This patch replaces dma_{alloc,release}_from_contiguous() with
> dma_{alloc,free}_contiguous() to simplify those function calls.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/iommu/dma-iommu.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 0cd49c2d3770..cc3d39dbbe1a 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -951,8 +951,8 @@ static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
>  
>  	if (pages)
>  		__iommu_dma_free_pages(pages, count);
> -	if (page && !dma_release_from_contiguous(dev, page, count))
> -		__free_pages(page, get_order(alloc_size));
> +	if (page)
> +		dma_free_contiguous(dev, page, alloc_size);
>  }
>  
>  static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
> @@ -970,12 +970,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
>  	struct page *page = NULL;
>  	void *cpu_addr;
>  
> -	if (gfpflags_allow_blocking(gfp))
> -		page = dma_alloc_from_contiguous(dev, alloc_size >> PAGE_SHIFT,
> -						 get_order(alloc_size),
> -						 gfp & __GFP_NOWARN);
> -	if (!page)
> -		page = alloc_pages(gfp, get_order(alloc_size));
> +	page = dma_alloc_contiguous(dev, alloc_size, gfp);
>  	if (!page)
>  		return NULL;
>  
> @@ -997,8 +992,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
>  	memset(cpu_addr, 0, alloc_size);
>  	return cpu_addr;
>  out_free_pages:
> -	if (!dma_release_from_contiguous(dev, page, alloc_size >> PAGE_SHIFT))
> -		__free_pages(page, get_order(alloc_size));
> +	dma_free_contiguous(dev, page, alloc_size);
>  	return NULL;
>  }
>  
> -- 
> 2.17.1
---end quoted text---
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
