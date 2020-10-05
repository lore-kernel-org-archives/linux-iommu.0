Return-Path: <SRS0=BXsX=DM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4B7C4363A
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 08:26:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43DD920795
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 08:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DD920795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E75598532B;
	Mon,  5 Oct 2020 08:26:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ld8wjnrhJ6-l; Mon,  5 Oct 2020 08:26:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E8EBE852F8;
	Mon,  5 Oct 2020 08:26:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8BB4C016F;
	Mon,  5 Oct 2020 08:26:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8B06C0051
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 08:26:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 959992041B
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 08:26:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hlNoyH7LhXji for <iommu@lists.linux-foundation.org>;
 Mon,  5 Oct 2020 08:26:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by silver.osuosl.org (Postfix) with ESMTPS id ED6B3203FF
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 08:26:33 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5D8DD67373; Mon,  5 Oct 2020 10:26:29 +0200 (CEST)
Date: Mon, 5 Oct 2020 10:26:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH 8/8] WIP: add a dma_alloc_contiguous API
Message-ID: <20201005082629.GA13850@lst.de>
References: <20200930160917.1234225-1-hch@lst.de>
 <20200930160917.1234225-9-hch@lst.de> <20201002175040.GA1131147@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201002175040.GA1131147@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-media@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Fri, Oct 02, 2020 at 05:50:40PM +0000, Tomasz Figa wrote:
> Hi Christoph,
> 
> On Wed, Sep 30, 2020 at 06:09:17PM +0200, Christoph Hellwig wrote:
> > Add a new API that returns a virtually non-contigous array of pages
> > and dma address.  This API is only implemented for dma-iommu and will
> > not be implemented for non-iommu DMA API instances that have to allocate
> > contiguous memory.  It is up to the caller to check if the API is
> > available.
> 
> Would you mind scheding some more light on what made the previous attempt
> not work well? I liked the previous API because it was more consistent with
> the regular dma_alloc_coherent().

The problem is that with a dma_alloc_noncoherent that can return pages
not in the kernel mapping we can't just use virt_to_page to fill in
scatterlists or mmap the buffer to userspace, but would need new helpers
and another two methods.

> >  - no kernel mapping or only temporary kernel mappings are required.
> >    That is as a better replacement for DMA_ATTR_NO_KERNEL_MAPPING
> >  - a kernel mapping is required for cached and DMA mapped pages, but
> >    the driver also needs the pages to e.g. map them to userspace.
> >    In that sense it is a replacement for some aspects of the recently
> >    removed and never fully implemented DMA_ATTR_NON_CONSISTENT
> 
> What's the expected allocation and mapping flow with the latter? Would that be
> 
> pages = dma_alloc_noncoherent(...)
> vaddr = vmap(pages, ...);
> 
> ?

Yes.  Witht the vmap step optional for replacements of
DMA_ATTR_NO_KERNEL_MAPPING, which is another nightmare to deal with.

> Would one just use the usual dma_sync_for_{cpu,device}() for cache
> invallidate/clean, while keeping the mapping in place?

Yes.  And make sure the API isn't implemented when VIVT caches are
used, but that isn't really different from the current interface.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
