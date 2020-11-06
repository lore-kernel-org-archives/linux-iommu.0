Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452ECC2D0A3
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 18:09:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1A6F20719
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 18:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="doAkeCGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A6F20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2E65282058;
	Fri,  6 Nov 2020 18:09:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bxhuaqOQFGy5; Fri,  6 Nov 2020 18:09:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DFCFF80726;
	Fri,  6 Nov 2020 18:09:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBD44C0893;
	Fri,  6 Nov 2020 18:09:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5094C0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 18:09:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CF8838753E
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 18:09:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DgKL9fg15ia0 for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 18:09:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D8038874F4
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 18:09:24 +0000 (UTC)
Received: by mail-qt1-f193.google.com with SMTP id r8so1377253qtp.13
 for <iommu@lists.linux-foundation.org>; Fri, 06 Nov 2020 10:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=CCWfhKT3ktx1Y0knQS9srJLCrgOnb432wETBQgR0zwo=;
 b=doAkeCGcQXpt2NzsJI+H159GAe+srNA7dZtr0H49NbeeYIJ6GpjmajNyfUIkqGpHMu
 ai3RLcEwPTV7f+TSNYl8TdB/e+py8oelQrW1t6LEF2AEbuiaX5ntMNXRo7pafHLNk+qa
 QhEYT0XqNOBcmdvsGARdcKLcZQ4vNiK+T3d409rehkmevDX2QeiKRii6c+D/qZ2Nh+pO
 0RwVihcCuFTu9WDbPH7A43DVXJyHPo6JqohdwYb1U85pWLDQ4z5qm6uqw+vSAoLvW1sa
 C6p622tFNp353sQHEku1KoOlamuSPHJwR2D09akhY5jCIZjnxUknFMxm2of3ziLK0Hx4
 K6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CCWfhKT3ktx1Y0knQS9srJLCrgOnb432wETBQgR0zwo=;
 b=W+wggw4a+e4TIgWOa3UCGgt5VIrq6Mbw0FbI7Grx8qnw/A9lT1Yjs2kQAEyWkIZwfp
 iJgWzOk5H8UPrpwXtyJOVxdB8NNWru7V1bJjre8mwmcVwExe56fWK5aSC3xC/Wc4Fp9c
 vsiP3xCa2HCB8J3G1GNWM1XHsmEwmbyNm98uIvybfGxtPlA7qELe8NAkDj0asdGUmBWZ
 lbxWcoBV+jeUBSh0FQhHO51C5NGjoW7Bsw9/IVyFf33cvuYwT7LQnu046B+w3DhkAxlq
 JfXmlLfPdfDJ/YBAiTAJmKy39KEbSIJgl1epdzRCtsI6LpUBI4yx+5ZAybrj7pgQJ0UM
 pdxQ==
X-Gm-Message-State: AOAM533eeB0lNtbVV6yI2ZGo9EBU52mAPsRqTjQ2QfJX0VyS/jRVIJre
 oQLrDXyN4gVn4f73Ne0F9RpnbQ==
X-Google-Smtp-Source: ABdhPJyipccSrv690eVVWi+5CEwYt+UFgZ0+2fbz5cV2OhIw8jYbnu+mxTrmBl1wmL06RVvlGefxSA==
X-Received: by 2002:aed:33c4:: with SMTP id v62mr2703105qtd.19.1604686163988; 
 Fri, 06 Nov 2020 10:09:23 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id n81sm1082262qke.99.2020.11.06.10.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 10:09:23 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1kb6As-000ztT-IG; Fri, 06 Nov 2020 14:09:22 -0400
Date: Fri, 6 Nov 2020 14:09:22 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH 14/15] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20201106180922.GV36674@ziepe.ca>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-15-logang@deltatee.com>
 <20201106172206.GS36674@ziepe.ca>
 <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
 <20201106174223.GU36674@ziepe.ca>
 <2c2d2815-165e-2ef9-60d6-3ace7ff3aaa5@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2c2d2815-165e-2ef9-60d6-3ace7ff3aaa5@deltatee.com>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ira Weiny <iweiny@intel.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
 John Hubbard <jhubbard@nvidia.com>, Dan Williams <dan.j.williams@intel.com>,
 Christoph Hellwig <hch@lst.de>
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

On Fri, Nov 06, 2020 at 10:53:45AM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2020-11-06 10:42 a.m., Jason Gunthorpe wrote:
> > On Fri, Nov 06, 2020 at 10:28:00AM -0700, Logan Gunthorpe wrote:
> >>
> >>
> >> On 2020-11-06 10:22 a.m., Jason Gunthorpe wrote:
> >>> On Fri, Nov 06, 2020 at 10:00:35AM -0700, Logan Gunthorpe wrote:
> >>>> Introduce pci_mmap_p2pmem() which is a helper to allocate and mmap
> >>>> a hunk of p2pmem into userspace.
> >>>>
> >>>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> >>>>  drivers/pci/p2pdma.c       | 104 +++++++++++++++++++++++++++++++++++++
> >>>>  include/linux/pci-p2pdma.h |   6 +++
> >>>>  2 files changed, 110 insertions(+)
> >>>>
> >>>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> >>>> index 9961e779f430..8eab53ac59ae 100644
> >>>> +++ b/drivers/pci/p2pdma.c
> >>>> @@ -16,6 +16,7 @@
> >>>>  #include <linux/genalloc.h>
> >>>>  #include <linux/memremap.h>
> >>>>  #include <linux/percpu-refcount.h>
> >>>> +#include <linux/pfn_t.h>
> >>>>  #include <linux/random.h>
> >>>>  #include <linux/seq_buf.h>
> >>>>  #include <linux/xarray.h>
> >>>> @@ -1055,3 +1056,106 @@ ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
> >>>>  	return sprintf(page, "%s\n", pci_name(p2p_dev));
> >>>>  }
> >>>>  EXPORT_SYMBOL_GPL(pci_p2pdma_enable_show);
> >>>> +
> >>>> +struct pci_p2pdma_map {
> >>>> +	struct kref ref;
> >>>> +	struct pci_dev *pdev;
> >>>> +	void *kaddr;
> >>>> +	size_t len;
> >>>> +};
> >>>
> >>> Why have this at all? Nothing uses it and no vm_operations ops are
> >>> implemented?
> >>
> >> It's necessary to free the allocated p2pmem when the mapping is torn down.
> > 
> > That's suspicious.. Once in a VMA the lifetime of the page must be
> > controlled by the page refcount, it can't be put back into the genpool
> > just because the vma was destroed.
> 
> Ah, hmm, yes. I guess the pages have to be hooked and returned to the
> genalloc through free_devmap_managed_page(). 

That sounds about right, but in this case it doesn't need the VMA
operations.

> Seems like it might be doable... but it will complicate things for
> users that don't want to use the genpool (though no such users exist
> upstream).

I would like to use this stuff in RDMA pretty much immediately and the
genpool is harmful for those cases, so please don't make decisions
that are tying thing to genpool

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
