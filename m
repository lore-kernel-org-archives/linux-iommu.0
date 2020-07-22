Return-Path: <SRS0=03l9=BB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687EDC433E1
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 21:42:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B332071A
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 21:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B332071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0F1E38879E;
	Wed, 22 Jul 2020 21:42:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IQeRgmXSZ3QZ; Wed, 22 Jul 2020 21:42:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AA825865D5;
	Wed, 22 Jul 2020 21:42:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 942F8C004D;
	Wed, 22 Jul 2020 21:42:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35BC1C004C
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 21:42:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2A6A486D33
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 21:42:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VOQ8Gb1HYh-4 for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jul 2020 21:42:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 66F5286D2C
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 21:42:04 +0000 (UTC)
Received: from dggemi404-hub.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id E8611F4957C3AE51D4A3;
 Thu, 23 Jul 2020 05:42:00 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.52]) by
 dggemi404-hub.china.huawei.com ([10.3.17.142]) with mapi id 14.03.0487.000;
 Thu, 23 Jul 2020 05:41:50 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH v3 1/2] dma-direct: provide the ability to reserve
 per-numa CMA
Thread-Topic: [PATCH v3 1/2] dma-direct: provide the ability to reserve
 per-numa CMA
Thread-Index: AQHWTT1ZxTwLmOgUCE+K/2/rfDv6P6kTSH2AgAD8G8A=
Date: Wed, 22 Jul 2020 21:41:50 +0000
Message-ID: <B926444035E5E2439431908E3842AFD25A1606@DGGEMI525-MBS.china.huawei.com>
References: <20200628111251.19108-1-song.bao.hua@hisilicon.com>
 <20200628111251.19108-2-song.bao.hua@hisilicon.com>
 <20200722142943.GB17658@lst.de>
In-Reply-To: <20200722142943.GB17658@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.4]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 Steve Capper <steve.capper@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, Linuxarm <linuxarm@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 "ganapatrao.kulkarni@cavium.com" <ganapatrao.kulkarni@cavium.com>,
 huangdaode <huangdaode@huawei.com>, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@linux.ibm.com>, "will@kernel.org" <will@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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
> From: Christoph Hellwig [mailto:hch@lst.de]
> Sent: Thursday, July 23, 2020 2:30 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: hch@lst.de; m.szyprowski@samsung.com; robin.murphy@arm.com;
> will@kernel.org; ganapatrao.kulkarni@cavium.com;
> catalin.marinas@arm.com; iommu@lists.linux-foundation.org; Linuxarm
> <linuxarm@huawei.com>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; Jonathan Cameron
> <jonathan.cameron@huawei.com>; Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de>; Steve Capper <steve.capper@arm.com>; Andrew
> Morton <akpm@linux-foundation.org>; Mike Rapoport <rppt@linux.ibm.com>
> Subject: Re: [PATCH v3 1/2] dma-direct: provide the ability to reserve
> per-numa CMA
> 
+cc Prime and Daode who are interested in this patchset.

> On Sun, Jun 28, 2020 at 11:12:50PM +1200, Barry Song wrote:
> >  struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t
> gfp)
> >  {
> >  	size_t count = size >> PAGE_SHIFT;
> >  	struct page *page = NULL;
> >  	struct cma *cma = NULL;
> > +	int nid = dev ? dev_to_node(dev) : NUMA_NO_NODE;
> > +	bool alloc_from_pernuma = false;
> > +
> > +	if ((count <= 1) && !(dev && dev->cma_area))
> > +		return NULL;
> >
> >  	if (dev && dev->cma_area)
> >  		cma = dev->cma_area;
> > -	else if (count > 1)
> > +	else if ((nid != NUMA_NO_NODE) &&
> dma_contiguous_pernuma_area[nid]
> > +		&& !(gfp & (GFP_DMA | GFP_DMA32))) {
> > +		cma = dma_contiguous_pernuma_area[nid];
> > +		alloc_from_pernuma = true;
> > +	} else {
> >  		cma = dma_contiguous_default_area;
> > +	}
> 
> I find the function rather confusing now.  What about something
> like (this relies on the fact that dev should never be NULL in the
> DMA API)
> 
> struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
> {
> 	size_t cma_align = min_t(size_t, get_order(size),
> CONFIG_CMA_ALIGNMENT);
>  	size_t count = size >> PAGE_SHIFT;
> 
> 	if (gfpflags_allow_blocking(gfp))
> 		return NULL;
> 	gfp &= __GFP_NOWARN;
> 
> 	if (dev->cma_area)

I got a kernel robot warning which said dev should be checked before being accessed
when I did a similar change in v1. Probably it was an invalid warning if dev should
never be null.

> 		return cma_alloc(dev->cma_area, count, cma_align, gfp);
> 	if (count <= 1)
> 		return NULL;
> 
> 	if (IS_ENABLED(CONFIG_PERNODE_CMA) && !(gfp & (GFP_DMA |
> GFP_DMA32)) {
> 		int nid = dev_to_node(dev);
>  		struct cma *cma = dma_contiguous_pernuma_area[nid];
> 		struct page *page;
> 
> 		if (cma) {
> 			page = cma_alloc(cma, count, cma_align, gfp);
> 			if (page)
> 				return page;
> 		}
> 	}
> 
> 	return cma_alloc(dma_contiguous_default_area, count, cma_align, gfp);
> }

Yes, it looks much better.

> 
> > +		/*
> > +		 * otherwise, page is from either per-numa cma or default cma
> > +		 */
> > +		int nid = page_to_nid(page);
> > +
> > +		if (nid != NUMA_NO_NODE) {
> > +			if (cma_release(dma_contiguous_pernuma_area[nid], page,
> > +						PAGE_ALIGN(size) >> PAGE_SHIFT))
> > +				return;
> > +		}
> > +
> > +		if (cma_release(dma_contiguous_default_area, page,
> 
> How can page_to_nid ever return NUMA_NO_NODE?

I thought page_to_nid would return NUMA_NO_NODE if CONFIG_NUMA is
not enabled. Probably I was wrong. Will get it fixed in v4.

Thanks
Barry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
