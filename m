Return-Path: <SRS0=BMGV=BC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043CFC43458
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 06:09:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBB9920825
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 06:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB9920825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A17418986F;
	Thu, 23 Jul 2020 06:09:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JdVakoYqPEDZ; Thu, 23 Jul 2020 06:09:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 200C28986C;
	Thu, 23 Jul 2020 06:09:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01A83C004E;
	Thu, 23 Jul 2020 06:09:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88366C004C
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 06:09:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 74D97848A9
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 06:09:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4MKF+wwHwegG for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jul 2020 06:09:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BE0CD891EA
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 06:09:51 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id EF38C6736F; Thu, 23 Jul 2020 08:09:47 +0200 (CEST)
Date: Thu, 23 Jul 2020 08:09:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] dma-contiguous: cleanup dma_alloc_contiguous
Message-ID: <20200723060947.GA10381@lst.de>
References: <20200722144307.30318-1-hch@lst.de>
 <20200723060047.GE5476@Asurada-Nvidia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200723060047.GE5476@Asurada-Nvidia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com,
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

On Wed, Jul 22, 2020 at 11:00:48PM -0700, Nicolin Chen wrote:
> On Wed, Jul 22, 2020 at 04:43:07PM +0200, Christoph Hellwig wrote:
> > Split out a cma_alloc_aligned helper to deal with the "interesting"
> > calling conventions for cma_alloc, which then allows to the main
> > function to be written straight forward.  This also takes advantage
> > of the fact that NULL dev arguments have been gone from the DMA API
> > for a while.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  kernel/dma/contiguous.c | 31 ++++++++++++++-----------------
> >  1 file changed, 14 insertions(+), 17 deletions(-)
> > 
> > diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> > index 15bc5026c485f2..f16b8d3f9932de 100644
> > --- a/kernel/dma/contiguous.c
> > +++ b/kernel/dma/contiguous.c
> > @@ -215,6 +215,13 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
> >  	return cma_release(dev_get_cma_area(dev), pages, count);
> >  }
> >  
> > +static struct page *cma_alloc_aligned(struct cma *cma, size_t size, gfp_t gfp)
> > +{
> > +	return cma_alloc(dma_contiguous_default_area, size >> PAGE_SHIFT,
> 
> Probably should be 'cma' here instead of 'dma_contiguous_default_area'?

Yes.  If only I could test the per-device CMAs on a normal x86 setup :)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
