Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68A1C55178
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 17:42:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EBC1217A0
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 17:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MOCiBjSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EBC1217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CD9F586A57;
	Fri,  6 Nov 2020 17:42:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qyLn4J7EM1tI; Fri,  6 Nov 2020 17:42:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 63D9A86972;
	Fri,  6 Nov 2020 17:42:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47264C088B;
	Fri,  6 Nov 2020 17:42:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDFE2C0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 17:42:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CA4E52E0E7
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 17:42:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bjx+YF6373mJ for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 17:42:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 by silver.osuosl.org (Postfix) with ESMTPS id F06092045A
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 17:42:25 +0000 (UTC)
Received: by mail-qk1-f193.google.com with SMTP id t191so629699qka.4
 for <iommu@lists.linux-foundation.org>; Fri, 06 Nov 2020 09:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3buLvlWL+9G09nyEaJ7/3CqkDjgWFOdmZgEsg7qS7YA=;
 b=MOCiBjSN2a1hPwUL+FJFYuzQlwO8wmt6NgCt9FaTyLzUmSuNFZ8pJFJjnpYDGgsQ26
 a8j6AjUBHGPJgl1+H9vdmuYPkKU68pFmYfvE9HQawmCY4vIz+ZApkGBVOkd9dWhh0DXa
 q56QEyRr53QyWSixEoTgaJPahFsdyxl3XbdZlglN7e+iI0rw/ar1o9FTO4zJteIHNrs9
 fCSMQ6f2iYfcLKZJGeHkqKVzX2CdNVjmmqzCZDSDIw8FQ5JzVVCMMhMKmUFdxYZt2g0v
 2SDXecJEMacL6cL9Se7kxpJ/LhH+/YR2QfiDFmQPiXf/MhTYpep4QtUSKXYnfiMtIam2
 37AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3buLvlWL+9G09nyEaJ7/3CqkDjgWFOdmZgEsg7qS7YA=;
 b=OB1m9pZB6/zW2n9mBFEVHpiToaaKfl2I+lA9GGe42xNKLvBihM6GkLD/JqY0JC1Mez
 wWIIiFnHAZc3GtmYsXGZkeYjkLZWW8FAAOnF69UQyRq9RW1/krXMjNYujm4gM7/7bTnS
 txoTI3ULyeYFZml4VxK8bozOX9ku1eWtBuLfZkA4xMZND7/nurWBOjGpaBwyo9ljeTf+
 jerb7qvSY2dC6WLnHzjDbCxAHNB8C2xzRDtJKH74RTD+pkM2uTAi0GCgMe8XUBvmgP8z
 l6vwJc8xHNpwUBRqKUMCvcN34iXkSyx+OwOZcX/2nGnpxnQR1CMzfoYOQBedjMv0IeFb
 fX2w==
X-Gm-Message-State: AOAM5318eIV8tsy7OF8Qr9a8M3lPx4bmVY98HWO6rtJFO66jX+2nwV1K
 UmoO4MuHtxQr7fW/D1hCT9ZTLg==
X-Google-Smtp-Source: ABdhPJyPUMTPAlvbc5F9DgPZcTHH53XJriCxbWePpFu8+RK+GJP/zdnWVlnoJA0LQqWFmkayCjYz/g==
X-Received: by 2002:a37:9441:: with SMTP id w62mr2652751qkd.474.1604684545012; 
 Fri, 06 Nov 2020 09:42:25 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id t65sm1006283qkc.52.2020.11.06.09.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 09:42:24 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1kb5kl-000zVc-Ja; Fri, 06 Nov 2020 13:42:23 -0400
Date: Fri, 6 Nov 2020 13:42:23 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH 14/15] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20201106174223.GU36674@ziepe.ca>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-15-logang@deltatee.com>
 <20201106172206.GS36674@ziepe.ca>
 <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
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

On Fri, Nov 06, 2020 at 10:28:00AM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2020-11-06 10:22 a.m., Jason Gunthorpe wrote:
> > On Fri, Nov 06, 2020 at 10:00:35AM -0700, Logan Gunthorpe wrote:
> >> Introduce pci_mmap_p2pmem() which is a helper to allocate and mmap
> >> a hunk of p2pmem into userspace.
> >>
> >> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> >>  drivers/pci/p2pdma.c       | 104 +++++++++++++++++++++++++++++++++++++
> >>  include/linux/pci-p2pdma.h |   6 +++
> >>  2 files changed, 110 insertions(+)
> >>
> >> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> >> index 9961e779f430..8eab53ac59ae 100644
> >> +++ b/drivers/pci/p2pdma.c
> >> @@ -16,6 +16,7 @@
> >>  #include <linux/genalloc.h>
> >>  #include <linux/memremap.h>
> >>  #include <linux/percpu-refcount.h>
> >> +#include <linux/pfn_t.h>
> >>  #include <linux/random.h>
> >>  #include <linux/seq_buf.h>
> >>  #include <linux/xarray.h>
> >> @@ -1055,3 +1056,106 @@ ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
> >>  	return sprintf(page, "%s\n", pci_name(p2p_dev));
> >>  }
> >>  EXPORT_SYMBOL_GPL(pci_p2pdma_enable_show);
> >> +
> >> +struct pci_p2pdma_map {
> >> +	struct kref ref;
> >> +	struct pci_dev *pdev;
> >> +	void *kaddr;
> >> +	size_t len;
> >> +};
> > 
> > Why have this at all? Nothing uses it and no vm_operations ops are
> > implemented?
> 
> It's necessary to free the allocated p2pmem when the mapping is torn down.

That's suspicious.. Once in a VMA the lifetime of the page must be
controlled by the page refcount, it can't be put back into the genpool
just because the vma was destroed.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
