Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9FAC433ED
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 06:36:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD40761364
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 06:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD40761364
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9566C6071E;
	Tue, 11 May 2021 06:36:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BmxFtgYbqvXS; Tue, 11 May 2021 06:36:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E7F06071C;
	Tue, 11 May 2021 06:36:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17819C000D;
	Tue, 11 May 2021 06:36:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C70AC0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 06:36:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1C15F401EE
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 06:36:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bHdDXjjb4kEa for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 06:36:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B2FF640173
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 06:36:02 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8C47567373; Tue, 11 May 2021 08:35:58 +0200 (CEST)
Date: Tue, 11 May 2021 08:35:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: Regression when booting 5.15 as dom0 on arm64 (WAS: Re:
 [linux-linus test] 161829: regressions - FAIL)
Message-ID: <20210511063558.GA7605@lst.de>
References: <osstest-161829-mainreport@xen.org>
 <4ea1e89f-a7a0-7664-470c-b3cf773a1031@xen.org> <20210510084057.GA933@lst.de>
 <alpine.DEB.2.21.2105101818260.5018@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2105101818260.5018@sstabellini-ThinkPad-T480s>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: f.fainelli@gmail.com, Julien Grall <julien@xen.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 osstest service owner <osstest-admin@xenproject.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Christoph Hellwig <hch@lst.de>
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

On Mon, May 10, 2021 at 06:46:34PM -0700, Stefano Stabellini wrote:
> On Mon, 10 May 2021, Christoph Hellwig wrote:
> > On Sat, May 08, 2021 at 12:32:37AM +0100, Julien Grall wrote:
> > > The pointer dereferenced seems to suggest that the swiotlb hasn't been 
> > > allocated. From what I can tell, this may be because swiotlb_force is set 
> > > to SWIOTLB_NO_FORCE, we will still enable the swiotlb when running on top 
> > > of Xen.
> > >
> > > I am not entirely sure what would be the correct fix. Any opinions?
> > 
> > Can you try something like the patch below (not even compile tested, but
> > the intent should be obvious?
> > 
> > 
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 16a2b2b1c54d..7671bc153fb1 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -44,6 +44,8 @@
> >  #include <asm/tlb.h>
> >  #include <asm/alternative.h>
> >  
> > +#include <xen/arm/swiotlb-xen.h>
> > +
> >  /*
> >   * We need to be able to catch inadvertent references to memstart_addr
> >   * that occur (potentially in generic code) before arm64_memblock_init()
> > @@ -482,7 +484,7 @@ void __init mem_init(void)
> >  	if (swiotlb_force == SWIOTLB_FORCE ||
> >  	    max_pfn > PFN_DOWN(arm64_dma_phys_limit))
> >  		swiotlb_init(1);
> > -	else
> > +	else if (!IS_ENABLED(CONFIG_XEN) || !xen_swiotlb_detect())
> >  		swiotlb_force = SWIOTLB_NO_FORCE;
> >  
> >  	set_max_mapnr(max_pfn - PHYS_PFN_OFFSET);
> 
> The "IS_ENABLED(CONFIG_XEN)" is not needed as the check is already part
> of xen_swiotlb_detect().

As far as I can tell the x86 version of xen_swiotlb_detect has a
!CONFIG_XEN stub.  The arm/arm64 version in uncoditionally declared, but
the implementation only compiled when Xen support is enabled.

> 
> 
> But let me ask another question first. Do you think it makes sense to have:
> 
> 	if (swiotlb_force == SWIOTLB_NO_FORCE)
> 		return 0;
> 
> at the beginning of swiotlb_late_init_with_tbl? I am asking because
> swiotlb_late_init_with_tbl is meant for special late initializations,
> right? It shouldn't really matter the presence or absence of
> SWIOTLB_NO_FORCE in regards to swiotlb_late_init_with_tbl. Also the
> commit message for "swiotlb: Make SWIOTLB_NO_FORCE perform no
> allocation" says that "If a platform was somehow setting
> swiotlb_no_force and a later call to swiotlb_init() was to be made we
> would still be proceeding with allocating the default SWIOTLB size
> (64MB)." Our case here is very similar, right? So the allocation should
> proceed?

Well, right now SWIOTLB_NO_FORCE is checked in dma_direct_map_page.
We need to clean all this up a bit, especially with the work to support
multiple swiotlb buffers, but I think for now this is the best we can
do.

> Which brings me to a separate unrelated issue, still affecting the path
> xen_swiotlb_init -> swiotlb_late_init_with_tbl. If swiotlb_init(1) is
> called by mem_init then swiotlb_late_init_with_tbl will fail due to the
> check:
> 
>     /* protect against double initialization */
>     if (WARN_ON_ONCE(io_tlb_default_mem))
>         return -ENOMEM;
> 
> xen_swiotlb_init is meant to ask Xen to make a bunch of pages physically
> contiguous. Then, it initializes the swiotlb buffer based on those
> pages. So it is a problem that swiotlb_late_init_with_tbl refuses to
> continue. However, in practice it is not a problem today because on ARM
> we don't actually make any special requests to Xen to make the pages
> physically contiguous (yet). See the empty implementation of
> arch/arm/xen/mm.c:xen_create_contiguous_region. I don't know about x86.
> 
> So maybe we should instead do something like the appended?

So I'd like to change the core swiotlb initialization to just use
a callback into the arch/xen code to make the pages contigous and
kill all that code duplication.  Together with the multiple swiotlb
buffer work I'd rather avoid churn that goes into a different direction
if possible.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
