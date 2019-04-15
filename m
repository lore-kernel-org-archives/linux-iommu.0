Return-Path: <SRS0=E2BV=SR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4254FC10F0E
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 22:56:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF7B2087C
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 22:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0HoMyMV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF7B2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D5E21CB2;
	Mon, 15 Apr 2019 22:56:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EA9C5CA8
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 22:56:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 94AF72C3
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 22:56:34 +0000 (UTC)
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 0AF8A20854;
	Mon, 15 Apr 2019 22:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555368994;
	bh=XrduhxDk0GZhoKcVedRr22IomCdKDgmMJ1c4H6c4fpk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=0HoMyMV66QqD4oh3Es6vlTNRMjrwtkgcL60uHd6U2u+eGxEpX+dauMeEOFDy8Qzeq
	x/86DJgDzmIWrwi6rO3BHMyO0UjqBIkSYzrt990IX/C3MbBw2LHlnQrL9s9ExrGIot
	tLbtSg22Uhe1+5HfJUP4UIKaZort7E+kkoDpDJPc=
Date: Mon, 15 Apr 2019 15:56:33 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/4] swiotlb-xen: ensure we have a single callsite for
	xen_dma_map_page
In-Reply-To: <20190411072000.4306-5-hch@lst.de>
Message-ID: <alpine.DEB.2.10.1904151552250.29275@sstabellini-ThinkPad-X260>
References: <20190411072000.4306-1-hch@lst.de>
	<20190411072000.4306-5-hch@lst.de>
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
Message-ID: <20190415225633.4k96ucuY1Yn1SHiQIMO4Q-R4bRb2EmBCsN7WGyRURXE@z>

On Thu, 11 Apr 2019, Christoph Hellwig wrote:
> Refactor the code a bit to make further changes easier.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

> ---
>  drivers/xen/swiotlb-xen.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 9a951504dc12..5dcb06fe9667 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -391,13 +391,8 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
>  	if (dma_capable(dev, dev_addr, size) &&
>  	    !range_straddles_page_boundary(phys, size) &&
>  		!xen_arch_need_swiotlb(dev, phys, dev_addr) &&
> -		(swiotlb_force != SWIOTLB_FORCE)) {
> -		/* we are not interested in the dma_addr returned by
> -		 * xen_dma_map_page, only in the potential cache flushes executed
> -		 * by the function. */
> -		xen_dma_map_page(dev, page, dev_addr, offset, size, dir, attrs);
> -		return dev_addr;
> -	}
> +		swiotlb_force != SWIOTLB_FORCE)
> +		goto done;
>  
>  	/*
>  	 * Oh well, have to allocate and map a bounce buffer.
> @@ -410,19 +405,25 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
>  		return DMA_MAPPING_ERROR;
>  
>  	dev_addr = xen_phys_to_bus(map);
> -	xen_dma_map_page(dev, pfn_to_page(map >> PAGE_SHIFT),
> -					dev_addr, map & ~PAGE_MASK, size, dir, attrs);
>  
>  	/*
>  	 * Ensure that the address returned is DMA'ble
>  	 */
> -	if (dma_capable(dev, dev_addr, size))
> -		return dev_addr;
> -
> -	attrs |= DMA_ATTR_SKIP_CPU_SYNC;
> -	swiotlb_tbl_unmap_single(dev, map, size, dir, attrs);
> +	if (unlikely(!dma_capable(dev, dev_addr, size))) {
> +		swiotlb_tbl_unmap_single(dev, map, size, dir,
> +				attrs | DMA_ATTR_SKIP_CPU_SYNC);
> +		return DMA_MAPPING_ERROR;
> +	}
>  
> -	return DMA_MAPPING_ERROR;
> +	page = pfn_to_page(map >> PAGE_SHIFT);
> +	offset = map & ~PAGE_MASK;
> +done:
> +	/*
> +	 * we are not interested in the dma_addr returned by xen_dma_map_page,
> +	 * only in the potential cache flushes executed by the function.
> +	 */
> +	xen_dma_map_page(dev, page, dev_addr, offset, size, dir, attrs);
> +	return dev_addr;
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
