Return-Path: <SRS0=wlUX=KJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949D8C433B4
	for <iommu@archiver.kernel.org>; Fri, 14 May 2021 13:57:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2098F6145D
	for <iommu@archiver.kernel.org>; Fri, 14 May 2021 13:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2098F6145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3906404E2;
	Fri, 14 May 2021 13:57:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UFpOqJM2EUwd; Fri, 14 May 2021 13:57:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79A2F4049D;
	Fri, 14 May 2021 13:57:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B548C000D;
	Fri, 14 May 2021 13:57:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEE5AC0001
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 13:57:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C6F6A83C82
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 13:57:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3GlHQWGiM5YO for <iommu@lists.linux-foundation.org>;
 Fri, 14 May 2021 13:57:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 36CD383C7B
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 13:57:17 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 176846736F; Fri, 14 May 2021 15:57:13 +0200 (CEST)
Date: Fri, 14 May 2021 15:57:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v2 15/22] dma-direct: Support PCI P2PDMA pages in
 dma-direct map_sg
Message-ID: <20210514135712.GD4715@lst.de>
References: <20210513223203.5542-1-logang@deltatee.com>
 <20210513223203.5542-16-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210513223203.5542-16-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
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

> +	for_each_sg(sgl, sg, nents, i) {
> +		if (sg_is_dma_pci_p2pdma(sg)) {
> +			sg_dma_unmark_pci_p2pdma(sg);
> +		} else  {

Double space here.  We also don't really need the curly braces to start
with.

> +	struct pci_p2pdma_map_state p2pdma_state = {};
> +	enum pci_p2pdma_map_type map;
>  	struct scatterlist *sg;
> +	int i, ret;
>  
>  	for_each_sg(sgl, sg, nents, i) {
> +		if (is_pci_p2pdma_page(sg_page(sg))) {
> +			map = pci_p2pdma_map_segment(&p2pdma_state, dev, sg);
> +			switch (map) {

Why not just:

			switch (pci_p2pdma_map_segment(&p2pdma_state, dev,
					sg)) {

(even better with a shorter name for p2pdma_state so that it all fits on
a single line)?

> +			case PCI_P2PDMA_MAP_BUS_ADDR:
> +				continue;
> +			case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +				/*
> +				 * Mapping through host bridge should be
> +				 * mapped normally, thus we do nothing
> +				 * and continue below.
> +				 */

I have a bit of a hard time parsing this comment.

> +		if (sg->dma_address == DMA_MAPPING_ERROR) {
> +			ret = -EINVAL;
>  			goto out_unmap;
> +		}
>  		sg_dma_len(sg) = sg->length;
>  	}
>  
> @@ -411,7 +443,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>  
>  out_unmap:
>  	dma_direct_unmap_sg(dev, sgl, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
> -	return -EINVAL;
> +	return ret;

Maybe just initialize ret to -EINVAL at declaration time to simplify this
a bit?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
