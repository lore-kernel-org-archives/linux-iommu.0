Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475C1C55178
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 17:22:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D2802151B
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 17:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Z5hliPe4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2802151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E36B72E0E7;
	Fri,  6 Nov 2020 17:22:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 67jqsJtp0OUJ; Fri,  6 Nov 2020 17:22:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4535220337;
	Fri,  6 Nov 2020 17:22:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 365D0C088B;
	Fri,  6 Nov 2020 17:22:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52912C0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 17:22:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 39DCA86A0F
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 17:22:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qYum4GGGnCXs for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 17:22:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2D09185161
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 17:22:09 +0000 (UTC)
Received: by mail-qt1-f195.google.com with SMTP id v11so890776qtq.12
 for <iommu@lists.linux-foundation.org>; Fri, 06 Nov 2020 09:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Y11rYbDMlG4Jq6y1mMF8XHIQBRgQTi4LgEIfp1+Fy2I=;
 b=Z5hliPe42ZhsJgIpO8yM/A/BmnWabQMZyxH3x1SujgBdxmpQeo1iLC7dJllfTWrgs+
 ckOwCsKncKsZUSkDwm+CRG+PtHOhk6vGyhb3vaWmExO06uZRfYDDy4x0lNtyZAxfIGSF
 TzNe/ATxzOTxeiv/h6NniXGC8bMAeaQsSamd0SJaMbdJqgcKE7FX8hgittLCSxWN+Hk0
 aEVb3jWNuQ84GZTQ7t0z2P0KnBO9475+HL13KJpZeDMWi657ip/5nImwsscD/jRB/6+1
 tzYyPHfeLOmV9kq1MtWUFMAFC/4Mt9DF6Qfy0pjFFXFFgIEb7ZfC/ufepIEP0MSbyLqW
 1mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Y11rYbDMlG4Jq6y1mMF8XHIQBRgQTi4LgEIfp1+Fy2I=;
 b=OGlYqyFeM4t+bG8dsXzXZdPllQpSL2Y+qaMPPv4vKAJH86ifczwNm6kZFvMg2LP3Su
 6SMm4KVne3QcyGyC8vDltSvVVO0kM4tFtmq/Vbi7VBatPQRiih3J9z4tyVLlNDN2rXZ6
 W8ZrMyOm1h1XUBqCf90QD5/MFdDRB7XNgcz/uyqquDg81c0w8wT+leBcMRIOW/LP2D0R
 KIC/6eIayNPCo3eK1nlptV+SisSW6W45Kae4WZ6D6IdQNbW9CgyB1II637euzTNCf9KR
 0Z7p0V//0qnF8wQ0rb3F3Z6f5XnqX9VwL/BZ17qP6ccYsu1Hx0XK/cpEyTzYCz5BKAxF
 DsZg==
X-Gm-Message-State: AOAM530a/7JaQBB2lG9w183JVgzr8snwL1Mae+xdU52hZddZdkotmhs2
 6D1OfqtVEKfOJTuq6E0scqsaOQ==
X-Google-Smtp-Source: ABdhPJyiYapImJ+Y336x/nMMBsQzuXDQ9V5MrPZLPGSARv/D7dBPhFBvVcl8QNPKfF7/i3znPagsCA==
X-Received: by 2002:ac8:4d4d:: with SMTP id x13mr2465811qtv.72.1604683328177; 
 Fri, 06 Nov 2020 09:22:08 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id w45sm942700qtw.96.2020.11.06.09.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 09:22:07 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1kb5R8-000z7J-TY; Fri, 06 Nov 2020 13:22:06 -0400
Date: Fri, 6 Nov 2020 13:22:06 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH 14/15] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20201106172206.GS36674@ziepe.ca>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-15-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201106170036.18713-15-logang@deltatee.com>
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

On Fri, Nov 06, 2020 at 10:00:35AM -0700, Logan Gunthorpe wrote:
> Introduce pci_mmap_p2pmem() which is a helper to allocate and mmap
> a hunk of p2pmem into userspace.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  drivers/pci/p2pdma.c       | 104 +++++++++++++++++++++++++++++++++++++
>  include/linux/pci-p2pdma.h |   6 +++
>  2 files changed, 110 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 9961e779f430..8eab53ac59ae 100644
> +++ b/drivers/pci/p2pdma.c
> @@ -16,6 +16,7 @@
>  #include <linux/genalloc.h>
>  #include <linux/memremap.h>
>  #include <linux/percpu-refcount.h>
> +#include <linux/pfn_t.h>
>  #include <linux/random.h>
>  #include <linux/seq_buf.h>
>  #include <linux/xarray.h>
> @@ -1055,3 +1056,106 @@ ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
>  	return sprintf(page, "%s\n", pci_name(p2p_dev));
>  }
>  EXPORT_SYMBOL_GPL(pci_p2pdma_enable_show);
> +
> +struct pci_p2pdma_map {
> +	struct kref ref;
> +	struct pci_dev *pdev;
> +	void *kaddr;
> +	size_t len;
> +};

Why have this at all? Nothing uses it and no vm_operations ops are
implemented?

This is very inflexable, it would be better if this is designed like
io_remap_pfn where it just preps and fills the VMA, doesn't take
ownership of the entire VMA

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
