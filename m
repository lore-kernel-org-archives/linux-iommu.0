Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4A1C433EF
	for <iommu@archiver.kernel.org>; Thu,  2 Jun 2022 17:28:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D2CE83E6C;
	Thu,  2 Jun 2022 17:28:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vci9y-AlEL34; Thu,  2 Jun 2022 17:28:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4590582BC4;
	Thu,  2 Jun 2022 17:28:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2904FC0032;
	Thu,  2 Jun 2022 17:28:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 079CDC002D
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 17:28:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DBBAA419AA
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 17:28:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RkTgiUy_A5v7 for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 17:28:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E2915418ED
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 17:28:13 +0000 (UTC)
Received: by mail-qk1-x72f.google.com with SMTP id x75so735444qkb.12
 for <iommu@lists.linux-foundation.org>; Thu, 02 Jun 2022 10:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=GuOinXdzP0oJ6BfwGVGRF9opnqUN4LYO3Y/RmknOScs=;
 b=nERzx0gJZv2PpNEuSU7ZGuwa6QR4KAFkZQcX+7G15YcgRySvW6qb9+1khratoVExRd
 E2cV1E+y5eNUdrv7iEhYvw6adm9tR0J0w0Y5RG/qlzn3N/ExPpw5VFSVcBiyiAfseShj
 RtXbQnx/36eWCdWlBGeV1GIY74fg8syx0d0tBb6JCdM+OFqTrueuf3t4tmn+ivjrfwFi
 G+YqxQ/XoZIxp/zm5ZUgHxZvv3ENrre3J5G2iipdg5D6ioSBpapAVxA8rxNBc3hfH6JN
 xgR8Rb7bKKjuhDjx6rhbKloVBy4fbfQj9wlUkZziCVhgTTnOfjGMKfLsZNNy+YXFPJkc
 II8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GuOinXdzP0oJ6BfwGVGRF9opnqUN4LYO3Y/RmknOScs=;
 b=bSh98Ey3mZ0d0vTuyL8e+bUljFxYPJCe9oL0sU+ABPtV8kn2Te4b14b3boHe+ywqBt
 Aj6cOgwbUD3UTqqJ8hUmR73FM9H9kw29Xe/O5BKEyd6sEWvYGduwEQl7u4e/yo/hHKpQ
 qVbKpo4QfZ/IzU1hc4Xq6R2IMiESKnHXVNDIeWngyqmbqQbK4eQYaiJCgv5vGN0PSEpu
 7ZjvBO3ldwB1rJkxBFypxnHnRpWxbYQMRo9x8RV0wZYouA5RUW4URD0J/c7Bb3Umw+PG
 vQbUvxHJ4DFSOd+YZsNrA0AKr7fUaS2PHaaQ+Adm15g8gTfkLExSE+RiIKpTPu6/w4iu
 utAQ==
X-Gm-Message-State: AOAM531fLwGd/aY61MB18PAP2Tdsa93DR1hUwZVvWPO6DSbQY7c4Z8vi
 iG/QNmah78x4bPoWaunMPfDdHA==
X-Google-Smtp-Source: ABdhPJxtqXs49dqqYwrrFL2D/sBWEpVH5naaCbeJ3Pryu+awdiRfY3cTorJuf9ghsWhGGy5AkAoh5A==
X-Received: by 2002:a05:620a:f0d:b0:67e:1c14:bc5e with SMTP id
 v13-20020a05620a0f0d00b0067e1c14bc5emr3899163qkl.502.1654190892765; 
 Thu, 02 Jun 2022 10:28:12 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129]) by smtp.gmail.com with ESMTPSA id
 q188-20020ae9dcc5000000b0069fc13ce1f2sm3649937qkf.35.2022.06.02.10.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jun 2022 10:28:12 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1nwocF-00GUaJ-Fg; Thu, 02 Jun 2022 14:28:11 -0300
Date: Thu, 2 Jun 2022 14:28:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v6 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20220602172811.GN2960187@ziepe.ca>
References: <20220407154717.7695-1-logang@deltatee.com>
 <20220407154717.7695-21-logang@deltatee.com>
 <20220527125501.GD2960187@ziepe.ca>
 <a2590e27-41e8-59dc-3576-b5b8d716a198@deltatee.com>
 <20220527190307.GG2960187@ziepe.ca>
 <d336cfe8-2451-04c3-a2ce-0e8e47afd1e3@deltatee.com>
 <20220602000038.GK2960187@ziepe.ca>
 <400baba7-1cd6-09d4-4de9-2a73f08afc79@deltatee.com>
 <20220602163059.GL2960187@ziepe.ca>
 <51cc6645-2504-6d01-5626-238ed6ffff04@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51cc6645-2504-6d01-5626-238ed6ffff04@deltatee.com>
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

On Thu, Jun 02, 2022 at 10:49:15AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2022-06-02 10:30, Jason Gunthorpe wrote:
> > On Thu, Jun 02, 2022 at 10:16:10AM -0600, Logan Gunthorpe wrote:
> > 
> >>> Just stuff the pages into the mmap, and your driver unprobe will
> >>> automatically block until all the mmaps are closed - no different than
> >>> having an open file descriptor or something.
> >>
> >> Oh is that what we want?
> > 
> > Yes, it is the typical case - eg if you have a sysfs file open unbind
> > hangs indefinitely. Many drivers can't unbind while they have open file
> > descriptors/etc.
> > 
> > A couple drivers go out of their way to allow unbinding while a live
> > userspace exists but this can get complicated. Usually there should be
> > a good reason.
> > 
> > The module will already be refcounted anyhow because the mmap points
> > to a char file which holds a module reference - meaning a simple rmmod
> > of the driver shouldn't work already..
> 
> Also, I just tried it... If I open a sysfs file for an nvme device (ie.
> /sys/class/nvme/nvme4/cntlid) and unbind the device, it does not block.
> A subsequent read on that file descriptor returns ENODEV. Which is what
> I would have expected.

Oh interesting, this has been changed since years ago when I last
looked, the kernfs_get_active() is now more narrowed than it once
was. So manybe sysfs isn't the same concern it used to be!

Thanks,
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
