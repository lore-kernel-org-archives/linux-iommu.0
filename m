Return-Path: <SRS0=a8KZ=BG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63E9C433E1
	for <iommu@archiver.kernel.org>; Mon, 27 Jul 2020 06:59:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 679172072E
	for <iommu@archiver.kernel.org>; Mon, 27 Jul 2020 06:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679172072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 357B187D8E;
	Mon, 27 Jul 2020 06:59:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jXYqEftTy8IN; Mon, 27 Jul 2020 06:59:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2459787D46;
	Mon, 27 Jul 2020 06:59:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16165C0050;
	Mon, 27 Jul 2020 06:59:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E609DC004D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 06:59:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E217985569
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 06:59:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U4t6-bM_chAM for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jul 2020 06:59:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CB16085198
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 06:59:24 +0000 (UTC)
Received: from dggemi402-hub.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 80A3C1A93159A35AFE0F;
 Mon, 27 Jul 2020 14:59:16 +0800 (CST)
Received: from DGGEMI423-HUB.china.huawei.com (10.1.199.152) by
 dggemi402-hub.china.huawei.com (10.3.17.135) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 27 Jul 2020 14:59:16 +0800
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.120]) by
 dggemi423-hub.china.huawei.com ([10.1.199.152]) with mapi id 14.03.0487.000;
 Mon, 27 Jul 2020 14:59:14 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Christoph Hellwig <hch@lst.de>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v2] dma-contiguous: cleanup dma_alloc_contiguous
Thread-Topic: [PATCH v2] dma-contiguous: cleanup dma_alloc_contiguous
Thread-Index: AQHWYOkRNc9I/S2jokCHOrZKsDC4takbA7lw
Date: Mon, 27 Jul 2020 06:59:13 +0000
Message-ID: <B926444035E5E2439431908E3842AFD25BE501@DGGEMI525-MBS.china.huawei.com>
References: <20200723120133.94105-1-hch@lst.de>
In-Reply-To: <20200723120133.94105-1-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.157]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "robin.murphy@arm.com" <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



> -----Original Message-----
> From: iommu [mailto:iommu-bounces@lists.linux-foundation.org] On Behalf
> Of Christoph Hellwig
> Sent: Friday, July 24, 2020 12:02 AM
> To: iommu@lists.linux-foundation.org
> Cc: robin.murphy@arm.com
> Subject: [PATCH v2] dma-contiguous: cleanup dma_alloc_contiguous
> 
> Split out a cma_alloc_aligned helper to deal with the "interesting"
> calling conventions for cma_alloc, which then allows to the main function to
> be written straight forward.  This also takes advantage of the fact that NULL
> dev arguments have been gone from the DMA API for a while.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>

And I have rebased per-numa CMA patchset on top of this one.
https://lore.kernel.org/linux-arm-kernel/20200723131344.41472-1-song.bao.hua@hisilicon.com/

> ---
> 
> Changes since v1:
>  - actually pass on the select struct cma
>  - clean up cma_alloc_aligned a bit
> 
>  kernel/dma/contiguous.c | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c index
> 15bc5026c485f2..cff7e60968b9e1 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -215,6 +215,13 @@ bool dma_release_from_contiguous(struct device
> *dev, struct page *pages,
>  	return cma_release(dev_get_cma_area(dev), pages, count);  }
> 
> +static struct page *cma_alloc_aligned(struct cma *cma, size_t size,
> +gfp_t gfp) {
> +	unsigned int align = min(get_order(size), CONFIG_CMA_ALIGNMENT);
> +
> +	return cma_alloc(cma, size >> PAGE_SHIFT, align, gfp & __GFP_NOWARN);
> +}
> +
>  /**
>   * dma_alloc_contiguous() - allocate contiguous pages
>   * @dev:   Pointer to device for which the allocation is performed.
> @@ -231,24 +238,14 @@ bool dma_release_from_contiguous(struct device
> *dev, struct page *pages,
>   */
>  struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
> {
> -	size_t count = size >> PAGE_SHIFT;
> -	struct page *page = NULL;
> -	struct cma *cma = NULL;
> -
> -	if (dev && dev->cma_area)
> -		cma = dev->cma_area;
> -	else if (count > 1)
> -		cma = dma_contiguous_default_area;
> -
>  	/* CMA can be used only in the context which permits sleeping */
> -	if (cma && gfpflags_allow_blocking(gfp)) {
> -		size_t align = get_order(size);
> -		size_t cma_align = min_t(size_t, align, CONFIG_CMA_ALIGNMENT);
> -
> -		page = cma_alloc(cma, count, cma_align, gfp & __GFP_NOWARN);
> -	}
> -
> -	return page;
> +	if (!gfpflags_allow_blocking(gfp))
> +		return NULL;
> +	if (dev->cma_area)
> +		return cma_alloc_aligned(dev->cma_area, size, gfp);
> +	if (size <= PAGE_SIZE || !dma_contiguous_default_area)
> +		return NULL;
> +	return cma_alloc_aligned(dma_contiguous_default_area, size, gfp);
>  }
> 
>  /**
> --
> 2.27.0
Thanks
Barry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
