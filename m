Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B34C433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 21:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCDE780BCA;
	Wed,  8 Dec 2021 21:58:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vSb8oV5SHW6s; Wed,  8 Dec 2021 21:58:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9110680BC5;
	Wed,  8 Dec 2021 21:58:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76678C002F;
	Wed,  8 Dec 2021 21:58:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D59DEC0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 21:58:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BEB1340632
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 21:58:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yBe_sqkSzo9q for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 21:58:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DF66340482
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 21:58:35 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="235472517"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; d="scan'208";a="235472517"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2021 13:55:29 -0800
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; d="scan'208";a="461879525"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2021 13:55:28 -0800
Date: Wed, 8 Dec 2021 13:59:45 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 4/4] dmaengine: idxd: Use DMA API for in-kernel DMA with
 PASID
Message-ID: <20211208135945.6d0a3b69@jacob-builder>
In-Reply-To: <20211208203022.GF6385@nvidia.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <20211208131358.GR6385@nvidia.com>
 <20211208115516.1d36fed9@jacob-builder>
 <20211208203022.GF6385@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Kumar, Sanjay
 K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, Barry Song <21cnbao@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, "Zanussi,
 Tom" <tom.zanussi@intel.com>
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

Hi Jason,

On Wed, 8 Dec 2021 16:30:22 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Dec 08, 2021 at 11:55:16AM -0800, Jacob Pan wrote:
> > Hi Jason,
> > 
> > On Wed, 8 Dec 2021 09:13:58 -0400, Jason Gunthorpe <jgg@nvidia.com>
> > wrote: 
> > > > This patch utilizes iommu_enable_pasid_dma() to enable DSA to
> > > > perform DMA requests with PASID under the same mapping managed by
> > > > DMA mapping API. In addition, SVA-related bits for kernel DMA are
> > > > removed. As a result, DSA users shall use DMA mapping API to obtain
> > > > DMA handles instead of using kernel virtual addresses.    
> > > 
> > > Er, shouldn't this be adding dma_map/etc type calls?
> > > 
> > > You can't really say a driver is using the DMA API without actually
> > > calling the DMA API..  
> > The IDXD driver is not aware of addressing mode, it is up to the user of
> > dmaengine API to prepare the buffer mappings. Here we only set up the
> > PASID such that it can be picked up during DMA work submission. I
> > tested with /drivers/dma/dmatest.c which does dma_map_page(),
> > map_single etc. also tested with other pieces under development.  
> 
> Ignoring the work, doesn't IDXD prepare the DMA queues itself, don't
> those need the DMA API?
> 
Do you mean wq completion record address? It is already using DMA API.
	wq->compls = dma_alloc_coherent(dev, wq->compls_size,
&wq->compls_addr, GFP_KERNEL);
	desc->compl_dma = wq->compls_addr + idxd->data->compl_size * i;

> I'm still very confused how this can radically change from using kSVA
> to DMA API and NOT introduce some more changes than this. They are not
I am guessing the confusion comes from that fact the user of kSVA is not
merged. We were in the process of upstreaming then abandon it. Perhaps that
is why you don't see removing kSVA code?

> the same thing, they do not use the same IOVA's. Did you test this
> with bypass mode off?
Yes with dmatest. IOVA is the default, I separated out the SATC patch which
will put internal accelerators in bypass mode. It can also be verified by
iommu debugfs dump of DMA PASID (2) and PASID 0 (RIDPASID) are pointing to
he same default domain. e.g
PASID   PASID_table_entry
0       0x0000000119ed7004:0x0000000000800002:0x000000000000004d
1       0x0000000000000001:0x0000000000800001:0x000000000000010d
2       0x0000000119ed7004:0x0000000000800002:0x000000000000004d


> 
> Jason


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
