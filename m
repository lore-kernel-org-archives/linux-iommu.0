Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AC3CCA480
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 17:59:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 928FF4119D;
	Wed, 29 Jun 2022 17:59:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 928FF4119D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=SKmcghAf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bZvgDDJ_WxTG; Wed, 29 Jun 2022 17:59:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3DF44411AA;
	Wed, 29 Jun 2022 17:59:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3DF44411AA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C18DC0021;
	Wed, 29 Jun 2022 17:59:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AEA0C0011
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 17:59:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 66576415A3
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 17:59:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 66576415A3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wxmtRYgBF8Sw for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 17:59:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 850B341172
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 850B341172
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 17:59:09 +0000 (UTC)
Received: by mail-qv1-xf2c.google.com with SMTP id c1so25936627qvi.11
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ngWx43aEx+7T9A14R2LGOmGQG6CiD1NPE7ELlQTW2Yo=;
 b=SKmcghAf6nlxb3TYM9q+L2K6WvoAOg3jhiALBKso44zP0sXfB8bfiUedLcgKzgwJgh
 iTJCket4ICkaBkiO0QMT6a7oZweniTqMyqfh5UKIWBSdtteoys0WU0gLpwmQxcuZ4T0C
 B5EZV3F+pSyyuE/TubvDD1bjbB6DXWKJyou3V2eDANW0FMx1qb5IymBGqRBGbaBO/qpz
 ziWT+UQffo2LDKQOaJhYTyVo3/P9yrGTwX9E3INhoqRXiDqc6Jau79+OQONuVBZZne7a
 MzNQ3dTgqHtk/dbWQmfNzsZcoGEiW6sxYQ0kC+3zRe5EegJZ5dxZXRpFz6xNN0CByfx0
 8ESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ngWx43aEx+7T9A14R2LGOmGQG6CiD1NPE7ELlQTW2Yo=;
 b=ar9lj7TXI6GvrXuxcm4775j0O5r2MhQWEY1DcN6+zrulOMop2SgrBbtmMRZT14gCTX
 i9hnJalSDDFFrUYPoGzDPMHPH32Gc2OGgoJtAxNJvmL9RcQkWmSUxWfmfJ95H4wjDEu3
 lmAtdpjznvtJqZTolMhzEJ+X3VPx50gWhY4Mk48cLg57WjQgPIBtD87hn8EbaMNDhJtO
 NgsnC/jcSB7SkWe8TyYRRaZmaV10h+r08YOe6287Jjb9yCAyRugCR3mHoSAiYXwJkLB1
 j6hBwtNsYudS4O+kklqWcCeGYG7tNYYEu6qwJuHZxazzxFSuC3WlOl45BBGLOSfHea1J
 g2xw==
X-Gm-Message-State: AJIora9DTTUxmICSbytoTcEOM+yHUSbrM6fIuK3hdSuzSUCY4BiqpUyl
 VWEOQ3Jqjf/Jj5qTM127HYokaQ==
X-Google-Smtp-Source: AGRyM1tbrZ7P9r+hmIBmAW2EDXMkZbkavnNkEyNTe14M5A9CnmgPVypEPOrPgPFspFUz9zUokVYXKQ==
X-Received: by 2002:a05:6214:ac2:b0:46e:7e2a:ada with SMTP id
 g2-20020a0562140ac200b0046e7e2a0adamr8831887qvi.81.1656525547889; 
 Wed, 29 Jun 2022 10:59:07 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129]) by smtp.gmail.com with ESMTPSA id
 c13-20020a05620a164d00b006a6a4b43c01sm12832373qko.38.2022.06.29.10.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jun 2022 10:59:07 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1o6bxy-003bBJ-Q7; Wed, 29 Jun 2022 14:59:06 -0300
Date: Wed, 29 Jun 2022 14:59:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v7 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20220629175906.GU23621@ziepe.ca>
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-21-logang@deltatee.com>
 <20220629064854.GD17576@lst.de>
 <99242789-66a6-bbd2-b56a-e47891f4522e@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <99242789-66a6-bbd2-b56a-e47891f4522e@deltatee.com>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-block@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
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

On Wed, Jun 29, 2022 at 10:00:09AM -0600, Logan Gunthorpe wrote:
> 
> 
> 
> On 2022-06-29 00:48, Christoph Hellwig wrote:
> > On Wed, Jun 15, 2022 at 10:12:32AM -0600, Logan Gunthorpe wrote:
> >> A pseudo mount is used to allocate an inode for each PCI device. The
> >> inode's address_space is used in the file doing the mmap so that all
> >> VMAs are collected and can be unmapped if the PCI device is unbound.
> >> After unmapping, the VMAs are iterated through and their pages are
> >> put so the device can continue to be unbound. An active flag is used
> >> to signal to VMAs not to allocate any further P2P memory once the
> >> removal process starts. The flag is synchronized with concurrent
> >> access with an RCU lock.
> > 
> > Can't we come up with a way of doing this without all the pseudo-fs
> > garbagage?  I really hate all the overhead for that in the next
> > nvme patch as well.
> 
> I assume you still want to be able to unmap the VMAs on unbind and not
> just hang?
> 
> I'll see if I can come up with something to do the a similar thing using
> vm_private data or some such.

I've tried in the past, this is not a good idea. There is no way to
handle failures when a VMA is dup'd and if you rely on private_data
you almost certainly have to alloc here.

Then there is the issue of making the locking work on invalidation
which is crazy ugly.

> I was not a fan of the extra code for this either, but I was given to
> understand that it was the standard way to collect and cleanup VMAs.

Christoph you tried tried to clean it once globally, what happened to
that?

All that is needed here is a way to get a unique inode for the PCI
memory.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
