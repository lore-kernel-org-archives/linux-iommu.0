Return-Path: <SRS0=E2BV=SR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88DDC10F0E
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 22:55:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A93F8218D3
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 22:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="trpeIGud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93F8218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 907F7CB0;
	Mon, 15 Apr 2019 22:55:49 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D72D8CA8
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 22:55:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 66BA42C3
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 22:55:48 +0000 (UTC)
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id CB16920880;
	Mon, 15 Apr 2019 22:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555368948;
	bh=OdWFFiLRGzhag05Q6ByU37PRLbrpqsr/paAaUKY4yCo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=trpeIGudVrlUEb2/II5rhXZOF6cOjtZwJFwS3dnkb/IRqeIUu1wjE7/YOpO8zPgpg
	WY1VncChQ85Ayb3Hsdeynq+xogmkF73yJuQDS/OUz3MOWHpRPJfl/6efi/jjwwksf4
	Y2pOeUMiaemaYf+mDaXaFBBii38sGaIFmrpITqo0=
Date: Mon, 15 Apr 2019 15:55:47 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/4] swiotlb-xen: simplify the DMA sync method
	implementations
In-Reply-To: <20190411072000.4306-4-hch@lst.de>
Message-ID: <alpine.DEB.2.10.1904151544070.29275@sstabellini-ThinkPad-X260>
References: <20190411072000.4306-1-hch@lst.de>
	<20190411072000.4306-4-hch@lst.de>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190415225547.7C3hHzyjIoxjiYgELo_TmKbLqnH2IeTApUT7zMT-IR4@z>

On Thu, 11 Apr 2019, Christoph Hellwig wrote:
> Get rid of the grand multiplexer and implement the sync_single_for_cpu
> and sync_single_for_device methods directly, and then loop over them
> for the scatterlist based variants.
> 
> Note that this also loses a few comments related to highlevel DMA API
> concepts, which have nothing to do with the swiotlb-xen implementation
> details.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

> ---
>  drivers/xen/swiotlb-xen.c | 84 +++++++++++++--------------------------
>  1 file changed, 28 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 97a55c225593..9a951504dc12 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -455,48 +455,28 @@ static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
>  	xen_unmap_single(hwdev, dev_addr, size, dir, attrs);
>  }
>  
> -/*
> - * Make physical memory consistent for a single streaming mode DMA translation
> - * after a transfer.
> - *
> - * If you perform a xen_swiotlb_map_page() but wish to interrogate the buffer
> - * using the cpu, yet do not wish to teardown the dma mapping, you must
> - * call this function before doing so.  At the next point you give the dma
> - * address back to the card, you must first perform a
> - * xen_swiotlb_dma_sync_for_device, and then the device again owns the buffer
> - */
>  static void
> -xen_swiotlb_sync_single(struct device *hwdev, dma_addr_t dev_addr,
> -			size_t size, enum dma_data_direction dir,
> -			enum dma_sync_target target)
> +xen_swiotlb_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr,
> +		size_t size, enum dma_data_direction dir)
>  {
> -	phys_addr_t paddr = xen_bus_to_phys(dev_addr);
> +	phys_addr_t paddr = xen_bus_to_phys(dma_addr);
>  
> -	BUG_ON(dir == DMA_NONE);
> -
> -	if (target == SYNC_FOR_CPU)
> -		xen_dma_sync_single_for_cpu(hwdev, dev_addr, size, dir);
> +	xen_dma_sync_single_for_cpu(dev, dma_addr, size, dir);
>  
> -	/* NOTE: We use dev_addr here, not paddr! */
> -	if (is_xen_swiotlb_buffer(dev_addr))
> -		swiotlb_tbl_sync_single(hwdev, paddr, size, dir, target);
> -
> -	if (target == SYNC_FOR_DEVICE)
> -		xen_dma_sync_single_for_device(hwdev, dev_addr, size, dir);
> +	if (is_xen_swiotlb_buffer(dma_addr))
> +		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_CPU);
>  }
>  
> -void
> -xen_swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
> -				size_t size, enum dma_data_direction dir)
> +static void
> +xen_swiotlb_sync_single_for_device(struct device *dev, dma_addr_t dma_addr,
> +		size_t size, enum dma_data_direction dir)
>  {
> -	xen_swiotlb_sync_single(hwdev, dev_addr, size, dir, SYNC_FOR_CPU);
> -}
> +	phys_addr_t paddr = xen_bus_to_phys(dma_addr);
>  
> -void
> -xen_swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
> -				   size_t size, enum dma_data_direction dir)
> -{
> -	xen_swiotlb_sync_single(hwdev, dev_addr, size, dir, SYNC_FOR_DEVICE);
> +	if (is_xen_swiotlb_buffer(dma_addr))
> +		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_DEVICE);
> +
> +	xen_dma_sync_single_for_device(dev, dma_addr, size, dir);
>  }
>  
>  /*
> @@ -541,38 +521,30 @@ xen_swiotlb_map_sg(struct device *dev, struct scatterlist *sgl, int nelems,
>  	return 0;
>  }
>  
> -/*
> - * Make physical memory consistent for a set of streaming mode DMA translations
> - * after a transfer.
> - *
> - * The same as swiotlb_sync_single_* but for a scatter-gather list, same rules
> - * and usage.
> - */
>  static void
> -xen_swiotlb_sync_sg(struct device *hwdev, struct scatterlist *sgl,
> -		    int nelems, enum dma_data_direction dir,
> -		    enum dma_sync_target target)
> +xen_swiotlb_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
> +			    int nelems, enum dma_data_direction dir)
>  {
>  	struct scatterlist *sg;
>  	int i;
>  
> -	for_each_sg(sgl, sg, nelems, i)
> -		xen_swiotlb_sync_single(hwdev, sg->dma_address,
> -					sg_dma_len(sg), dir, target);
> -}
> -
> -static void
> -xen_swiotlb_sync_sg_for_cpu(struct device *hwdev, struct scatterlist *sg,
> -			    int nelems, enum dma_data_direction dir)
> -{
> -	xen_swiotlb_sync_sg(hwdev, sg, nelems, dir, SYNC_FOR_CPU);
> +	for_each_sg(sgl, sg, nelems, i) {
> +		xen_swiotlb_sync_single_for_cpu(dev, sg->dma_address,
> +				sg->length, dir);
> +	}
>  }
>  
>  static void
> -xen_swiotlb_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
> +xen_swiotlb_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
>  			       int nelems, enum dma_data_direction dir)
>  {
> -	xen_swiotlb_sync_sg(hwdev, sg, nelems, dir, SYNC_FOR_DEVICE);
> +	struct scatterlist *sg;
> +	int i;
> +
> +	for_each_sg(sgl, sg, nelems, i) {
> +		xen_swiotlb_sync_single_for_device(dev, sg->dma_address,
> +				sg->length, dir);
> +	}
>  }
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
