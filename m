Return-Path: <SRS0=UphA=BH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA2FC433DF
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 09:13:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8492120786
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 09:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8492120786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 670CC8459A;
	Tue, 28 Jul 2020 09:13:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GkwSXJoOr3hM; Tue, 28 Jul 2020 09:13:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D0FA98452F;
	Tue, 28 Jul 2020 09:13:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6B2BC004F;
	Tue, 28 Jul 2020 09:13:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9ED6C004D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 09:13:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9676F87EC7
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 09:13:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zsWeNpMHT2pu for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jul 2020 09:13:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 08CFE87EBE
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 09:13:40 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id CE5F668B05; Tue, 28 Jul 2020 11:13:35 +0200 (CEST)
Date: Tue, 28 Jul 2020 11:13:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
Message-ID: <20200728091335.GA23744@lst.de>
References: <011994f8a717a00dcd9ed7682a1ddeb421c2c43f.camel@suse.de>
 <CAMi1Hd0=ZsGhTkSy221EP9Vb3GMOcS0UMczX2u5X9qK37_ea1A@mail.gmail.com>
 <01831596e4a2a6c9c066138b23bd30435f8e5569.camel@suse.de>
 <CAMi1Hd3C6kh5E49EgytBAQ_2AE_jvnp+eSNsxBYaux+exSvdbg@mail.gmail.com>
 <6db722947546221ed99d3f473f78e1a6de65d7d6.camel@suse.de>
 <CAMi1Hd0Xz6kOJFpA5PEpi6RDDGOcz0RmQ7tTOkuXq4QneOO_vQ@mail.gmail.com>
 <0dc1e922bf87fa73790e7471b3974528dd261486.camel@suse.de>
 <CAMi1Hd3O2HHBsnt=sac7FdcW0-3=4S3g_F9f__2h5gTsudfirA@mail.gmail.com>
 <20200724134114.GA3152@lst.de>
 <a9b811a84ac21c13693e6ffefd2914b911542e18.camel@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a9b811a84ac21c13693e6ffefd2914b911542e18.camel@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Amit Pundir <amit.pundir@linaro.org>, lkml <linux-kernel@vger.kernel.org>,
 jeremy.linton@arm.com, Sumit Semwal <sumit.semwal@linaro.org>,
 iommu@lists.linux-foundation.org, John Stultz <john.stultz@linaro.org>,
 linux-rpi-kernel@lists.infradead.org, David Rientjes <rientjes@google.com>,
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

On Mon, Jul 27, 2020 at 07:56:56PM +0200, Nicolas Saenz Julienne wrote:
> Hi Christoph,
> thanks for having a look at this!
> 
> On Fri, 2020-07-24 at 15:41 +0200, Christoph Hellwig wrote:
> > Yes, the iommu is an interesting case, and the current code is
> > wrong for that.
> 
> Care to expand on this? I do get that checking dma_coherent_ok() on memory
> that'll later on be mapped into an iommu is kind of silly, although I think
> harmless in Amir's specific case, since devices have wide enough dma-ranges. Is
> there more to it?

I think the problem is that it can lead to not finding suitable memory.

> 
> > Can you try the patch below?  It contains a modified version of Nicolas'
> > patch to try CMA again for the expansion and a new (for now hackish) way to
> > not apply the addressability check for dma-iommu allocations.
> > 
> > diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> > index 6bc74a2d51273e..ec5e525d2b9309 100644
> > --- a/kernel/dma/pool.c
> > +++ b/kernel/dma/pool.c
> > @@ -3,7 +3,9 @@
> >   * Copyright (C) 2012 ARM Ltd.
> >   * Copyright (C) 2020 Google LLC
> >   */
> > +#include <linux/cma.h>
> >  #include <linux/debugfs.h>
> > +#include <linux/dma-contiguous.h>
> >  #include <linux/dma-direct.h>
> >  #include <linux/dma-noncoherent.h>
> >  #include <linux/init.h>
> > @@ -55,6 +57,31 @@ static void dma_atomic_pool_size_add(gfp_t gfp, size_t
> > size)
> >  		pool_size_kernel += size;
> >  }
> >  
> > +static bool cma_in_zone(gfp_t gfp)
> > +{
> > +	phys_addr_t end;
> > +	unsigned long size;
> > +	struct cma *cma;
> > +
> > +	cma = dev_get_cma_area(NULL);
> > +	if (!cma)
> > +		return false;
> > +
> > +	size = cma_get_size(cma);
> > +	if (!size)
> > +		return false;
> > +	end = cma_get_base(cma) - memblock_start_of_DRAM() + size - 1;
> > +
> > +	/* CMA can't cross zone boundaries, see cma_activate_area() */
> > +	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA) &&
> > +	    end <= DMA_BIT_MASK(zone_dma_bits))
> > +		return true;
> > +	if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32) &&
> > +	    end <= DMA_BIT_MASK(32))
> > +		return true;
> > +	return true;
> 
> IIUC this will always return true given a CMA is present. Which reverts to the
> previous behaviour (previous as in breaking some rpi4 setups), isn't it?

Was that really what broke the PI?  I'll try to get the split out series
today, which might have a few more tweaks, and then we'll need to test it
both on these rpi4 setups and Amits phone.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
