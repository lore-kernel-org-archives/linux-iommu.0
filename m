Return-Path: <SRS0=E2BV=SR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF1CC10F0E
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 22:55:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 996872183F
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 22:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSgkCO7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996872183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5EA0FCAF;
	Mon, 15 Apr 2019 22:55:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 23AD3CA8
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 22:55:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A78C62C3
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 22:55:37 +0000 (UTC)
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 1030F2087C;
	Mon, 15 Apr 2019 22:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555368937;
	bh=wd++nzgpTjuECfi4PcRnKRD0dHn5ZSS5FTtK6yRHUTc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=MSgkCO7Fbs2eWk0sONlRkgV5068QHb+BsUWwrH7fZDmNPN7+PfbEuijU7R8Akj5Lg
	Vp8TnFBotGATv3q/KG/ewBmw6DtDDFkgBlyppAXPWjl6q/6oWOMgV/eWPgImxEmyO3
	AtYLBpPyrHlqmnG1RWcLK58cheDsd5b0crlScxmE=
Date: Mon, 15 Apr 2019 15:55:36 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/4] swiotlb-xen: use ->map_page to implement ->map_sg
In-Reply-To: <20190411072000.4306-3-hch@lst.de>
Message-ID: <alpine.DEB.2.10.1904151541370.29275@sstabellini-ThinkPad-X260>
References: <20190411072000.4306-1-hch@lst.de>
	<20190411072000.4306-3-hch@lst.de>
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
Message-ID: <20190415225536.daiNZycurRKfGx6VpT9qm_ZS_YItulZzT0w2F5F2Grc@z>

On Thu, 11 Apr 2019, Christoph Hellwig wrote:
> We can simply loop over the segments and map them, removing lots of
> duplicate code.

Right, the only difference is the additional dma_capable check which is
good to have.

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/xen/swiotlb-xen.c | 68 ++++++---------------------------------
>  1 file changed, 10 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index d4bc3aabd44d..97a55c225593 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -517,24 +517,8 @@ xen_swiotlb_unmap_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
>  
>  }
>  
> -/*
> - * Map a set of buffers described by scatterlist in streaming mode for DMA.
> - * This is the scatter-gather version of the above xen_swiotlb_map_page
> - * interface.  Here the scatter gather list elements are each tagged with the
> - * appropriate dma address and length.  They are obtained via
> - * sg_dma_{address,length}(SG).
> - *
> - * NOTE: An implementation may be able to use a smaller number of
> - *       DMA address/length pairs than there are SG table elements.
> - *       (for example via virtual mapping capabilities)
> - *       The routine returns the number of addr/length pairs actually
> - *       used, at most nents.
> - *
> - * Device ownership issues as mentioned above for xen_swiotlb_map_page are the
> - * same here.
> - */
>  static int
> -xen_swiotlb_map_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
> +xen_swiotlb_map_sg(struct device *dev, struct scatterlist *sgl, int nelems,
>  		enum dma_data_direction dir, unsigned long attrs)
>  {
>  	struct scatterlist *sg;
> @@ -543,50 +527,18 @@ xen_swiotlb_map_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
>  	BUG_ON(dir == DMA_NONE);
>  
>  	for_each_sg(sgl, sg, nelems, i) {
> -		phys_addr_t paddr = sg_phys(sg);
> -		dma_addr_t dev_addr = xen_phys_to_bus(paddr);
> -
> -		if (swiotlb_force == SWIOTLB_FORCE ||
> -		    xen_arch_need_swiotlb(hwdev, paddr, dev_addr) ||
> -		    !dma_capable(hwdev, dev_addr, sg->length) ||
> -		    range_straddles_page_boundary(paddr, sg->length)) {
> -			phys_addr_t map = swiotlb_tbl_map_single(hwdev,
> -								 start_dma_addr,
> -								 sg_phys(sg),
> -								 sg->length,
> -								 dir, attrs);
> -			if (map == DMA_MAPPING_ERROR) {
> -				dev_warn(hwdev, "swiotlb buffer is full\n");
> -				/* Don't panic here, we expect map_sg users
> -				   to do proper error handling. */
> -				attrs |= DMA_ATTR_SKIP_CPU_SYNC;
> -				xen_swiotlb_unmap_sg(hwdev, sgl, i, dir, attrs);
> -				sg_dma_len(sgl) = 0;
> -				return 0;
> -			}
> -			dev_addr = xen_phys_to_bus(map);
> -			xen_dma_map_page(hwdev, pfn_to_page(map >> PAGE_SHIFT),
> -						dev_addr,
> -						map & ~PAGE_MASK,
> -						sg->length,
> -						dir,
> -						attrs);
> -			sg->dma_address = dev_addr;
> -		} else {
> -			/* we are not interested in the dma_addr returned by
> -			 * xen_dma_map_page, only in the potential cache flushes executed
> -			 * by the function. */
> -			xen_dma_map_page(hwdev, pfn_to_page(paddr >> PAGE_SHIFT),
> -						dev_addr,
> -						paddr & ~PAGE_MASK,
> -						sg->length,
> -						dir,
> -						attrs);
> -			sg->dma_address = dev_addr;
> -		}
> +		sg->dma_address = xen_swiotlb_map_page(dev, sg_page(sg),
> +				sg->offset, sg->length, dir, attrs);
> +		if (sg->dma_address == DMA_MAPPING_ERROR)
> +			goto out_unmap;
>  		sg_dma_len(sg) = sg->length;
>  	}
> +
>  	return nelems;
> +out_unmap:
> +	xen_swiotlb_unmap_sg(dev, sgl, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
> +	sg_dma_len(sgl) = 0;
> +	return 0;
>  }
>  
>  /*
> -- 
> 2.20.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
