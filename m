Return-Path: <SRS0=03l9=BB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6F3C433E1
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 14:29:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B6E320781
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 14:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6E320781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6082481FB3;
	Wed, 22 Jul 2020 14:29:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ATrjc81FGXom; Wed, 22 Jul 2020 14:29:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 33F1F87DC5;
	Wed, 22 Jul 2020 14:29:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20603C004E;
	Wed, 22 Jul 2020 14:29:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8ADAC004C
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 14:29:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C715788603
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 14:29:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ODMHzml1HyK1 for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jul 2020 14:29:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 95AE0885F1
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 14:29:48 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id B599868B05; Wed, 22 Jul 2020 16:29:43 +0200 (CEST)
Date: Wed, 22 Jul 2020 16:29:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v3 1/2] dma-direct: provide the ability to reserve
 per-numa CMA
Message-ID: <20200722142943.GB17658@lst.de>
References: <20200628111251.19108-1-song.bao.hua@hisilicon.com>
 <20200628111251.19108-2-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200628111251.19108-2-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: catalin.marinas@arm.com, Steve Capper <steve.capper@arm.com>,
 robin.murphy@arm.com, linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, ganapatrao.kulkarni@cavium.com,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>,
 will@kernel.org, hch@lst.de, linux-arm-kernel@lists.infradead.org
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

On Sun, Jun 28, 2020 at 11:12:50PM +1200, Barry Song wrote:
>  struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
>  {
>  	size_t count = size >> PAGE_SHIFT;
>  	struct page *page = NULL;
>  	struct cma *cma = NULL;
> +	int nid = dev ? dev_to_node(dev) : NUMA_NO_NODE;
> +	bool alloc_from_pernuma = false;
> +
> +	if ((count <= 1) && !(dev && dev->cma_area))
> +		return NULL;
>  
>  	if (dev && dev->cma_area)
>  		cma = dev->cma_area;
> -	else if (count > 1)
> +	else if ((nid != NUMA_NO_NODE) && dma_contiguous_pernuma_area[nid]
> +		&& !(gfp & (GFP_DMA | GFP_DMA32))) {
> +		cma = dma_contiguous_pernuma_area[nid];
> +		alloc_from_pernuma = true;
> +	} else {
>  		cma = dma_contiguous_default_area;
> +	}

I find the function rather confusing now.  What about something
like (this relies on the fact that dev should never be NULL in the
DMA API)

struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
{
	size_t cma_align = min_t(size_t, get_order(size), CONFIG_CMA_ALIGNMENT);
 	size_t count = size >> PAGE_SHIFT;

	if (gfpflags_allow_blocking(gfp))
		return NULL;
	gfp &= __GFP_NOWARN;

	if (dev->cma_area)
		return cma_alloc(dev->cma_area, count, cma_align, gfp);
	if (count <= 1)
		return NULL;

	if (IS_ENABLED(CONFIG_PERNODE_CMA) && !(gfp & (GFP_DMA | GFP_DMA32)) {
		int nid = dev_to_node(dev);
 		struct cma *cma = dma_contiguous_pernuma_area[nid];
		struct page *page;

		if (cma) {
			page = cma_alloc(cma, count, cma_align, gfp);
			if (page)
				return page;
		}
	}

	return cma_alloc(dma_contiguous_default_area, count, cma_align, gfp);
}

> +		/*
> +		 * otherwise, page is from either per-numa cma or default cma
> +		 */
> +		int nid = page_to_nid(page);
> +
> +		if (nid != NUMA_NO_NODE) {
> +			if (cma_release(dma_contiguous_pernuma_area[nid], page,
> +						PAGE_ALIGN(size) >> PAGE_SHIFT))
> +				return;
> +		}
> +
> +		if (cma_release(dma_contiguous_default_area, page,

How can page_to_nid ever return NUMA_NO_NODE?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
