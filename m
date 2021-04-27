Return-Path: <SRS0=GIAn=JY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B40C433B4
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 19:40:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73C01613C8
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 19:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C01613C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E40060666;
	Tue, 27 Apr 2021 19:40:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YVrcqIUmFSW0; Tue, 27 Apr 2021 19:40:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 90B9960620;
	Tue, 27 Apr 2021 19:40:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 651D5C0022;
	Tue, 27 Apr 2021 19:40:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 196A5C001C
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 19:40:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE8FE403DF
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 19:40:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IWs98Lr8FCxc for <iommu@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 19:40:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 64400401FC
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 19:40:16 +0000 (UTC)
Received: by mail-qk1-x72b.google.com with SMTP id u20so29050556qku.10
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 12:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Qjlzws9tOjfG2kgF5PSaus20BHkak4AbpiykyhDCpWc=;
 b=FgJgWNr62C5ZYe5v1vnbBayAlBas9KMfjlI+laH23uWCOINrv2HqPW9/a2+lK1+qpn
 Zdr+bMJ3dVh1M82cRSTI4JbQADrXanZ5JfGjdWIrOPB62lKoHfvu6nr6Gx+k2tmRlxI9
 VnIPeqy1NjUABHuJSDWeU4As9HayrnVGiZr56daurC5uY37+XvT8TZlGM0+FK9uB/Zvv
 YTKfdf8OvZo8ENhSomjWbrDXc8AvVOdpQ72iroWjNxj+tV6CHjB8W81hADxRNQW+tUQ7
 dB77SYRDbWj7e5FkrYJA2fixQk601M0tulsmdtPUJHEnm9ZHX5SNJW5GF5Co+YjnesqM
 4DUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Qjlzws9tOjfG2kgF5PSaus20BHkak4AbpiykyhDCpWc=;
 b=g1B4WSARyaWxw+nr9r4W+ddBfRmJ9E/GtkCkQysSGiCcxwremauVzhC3KcBiXs6qwL
 g/JpQ6uI3S3FYzrklKaiQA5YZUJZLQSNmDx4PQ+vhxXSemY9LEkXfXYJOjhvzHEVxBik
 3O67R9VDHsuVNHa4sIqc3PpUnegDDuEUXbOI3OYT/YHvbKyWLe7kAywuB1Esnm6XFRIT
 C+4nCPqadhHwuXM0/DLUCEw1Y6zLyrOVflFEhAOZcDzzQ4+DzDyzeRDXXiu0zrxh+0pK
 TBwG15m0Xs4zXH70UzcjO/Ze4Y2Dj5CxLj38BB+h8fix60eeZQ/dNEn+NgEzpemikva3
 XQkg==
X-Gm-Message-State: AOAM530+EVfd8WbY7sVkAYUGwTuv6MZWXcqDNXdxFo3PBjflRHGsCYzC
 b779n1VXmoBp6qKCaEFMCeLTlQ==
X-Google-Smtp-Source: ABdhPJzTB/kVzpwj6kXVp9NJ/SmSPf5xftMaBkmkgU98M9PRxB8v4F4XSKjG3yTN0WaJic3//dLNPQ==
X-Received: by 2002:a37:ccb:: with SMTP id 194mr7861132qkm.45.1619552415304;
 Tue, 27 Apr 2021 12:40:15 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id d3sm605486qtm.56.2021.04.27.12.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Apr 2021 12:40:14 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lbTZ7-00Dh3g-Sk; Tue, 27 Apr 2021 16:40:13 -0300
Date: Tue, 27 Apr 2021 16:40:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 09/16] dma-direct: Support PCI P2PDMA pages in dma-direct
 map_sg
Message-ID: <20210427194013.GS2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-10-logang@deltatee.com>
 <20210427193351.GR2047089@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210427193351.GR2047089@ziepe.ca>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, John Hubbard <jhubbard@nvidia.com>,
 linux-block@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
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

On Tue, Apr 27, 2021 at 04:33:51PM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 08, 2021 at 11:01:16AM -0600, Logan Gunthorpe wrote:
> > Add PCI P2PDMA support for dma_direct_map_sg() so that it can map
> > PCI P2PDMA pages directly without a hack in the callers. This allows
> > for heterogeneous SGLs that contain both P2PDMA and regular pages.
> > 
> > SGL segments that contain PCI bus addresses are marked with
> > sg_mark_pci_p2pdma() and are ignored when unmapped.
> > 
> > Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> >  kernel/dma/direct.c | 25 ++++++++++++++++++++++---
> >  1 file changed, 22 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 002268262c9a..108dfb4ecbd5 100644
> > +++ b/kernel/dma/direct.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/vmalloc.h>
> >  #include <linux/set_memory.h>
> >  #include <linux/slab.h>
> > +#include <linux/pci-p2pdma.h>
> >  #include "direct.h"
> >  
> >  /*
> > @@ -387,19 +388,37 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
> >  	struct scatterlist *sg;
> >  	int i;
> >  
> > -	for_each_sg(sgl, sg, nents, i)
> > +	for_each_sg(sgl, sg, nents, i) {
> > +		if (sg_is_pci_p2pdma(sg)) {
> > +			sg_unmark_pci_p2pdma(sg);
> 
> This doesn't seem nice, the DMA layer should only alter the DMA
> portion of the SG, not the other portions. Is it necessary?

Oh, I got it completely wrong what this is for.

This should be named sg_dma_mark_pci_p2p() and similar for other
functions to make it clear it is part of the DMA side of the SG
interface (eg it is like sg_dma_address, sg_dma_len, etc)

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
