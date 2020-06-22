Return-Path: <SRS0=gLCG=AD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59731C433E0
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 12:46:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2960820732
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 12:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2960820732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C631022713;
	Mon, 22 Jun 2020 12:46:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pg-S5RTmQ9CX; Mon, 22 Jun 2020 12:46:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5400C20533;
	Mon, 22 Jun 2020 12:46:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 491FBC088F;
	Mon, 22 Jun 2020 12:46:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BC0FC016F
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 12:46:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2D3BF226CF
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 12:46:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HIbEfo-rjig5 for <iommu@lists.linux-foundation.org>;
 Mon, 22 Jun 2020 12:46:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 8720820533
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 12:46:50 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 907AA36B; Mon, 22 Jun 2020 14:46:48 +0200 (CEST)
Date: Mon, 22 Jun 2020 14:46:47 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: kernel BUG at mm/huge_memory.c:2613!
Message-ID: <20200622124646.GI3701@8bytes.org>
References: <20200619001938.GA135965@carbon.dhcp.thefacebook.com>
 <CAHbLzkrDcn-GQOrAM=m7+2g5_J6obsz4K50Oqb-1RD5p1iWTPQ@mail.gmail.com>
 <20200619011449.GC135965@carbon.dhcp.thefacebook.com>
 <20200619024026.GB21081@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200619024026.GB21081@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Yang Shi <shy828301@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Michal Hocko <mhocko@kernel.org>, Linux MM <linux-mm@kvack.org>,
 iommu@lists.linux-foundation.org, Wei Yang <richardw.yang@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 Roman Gushchin <guro@fb.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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

+ Robin

Robin, any idea on this?

On Thu, Jun 18, 2020 at 10:40:26PM -0400, Andrea Arcangeli wrote:
> Hello,
> 
> On Thu, Jun 18, 2020 at 06:14:49PM -0700, Roman Gushchin wrote:
> > I agree. The whole
> > 
> > 	page = alloc_pages_node(nid, alloc_flags, order);
> > 	if (!page)
> > 		continue;
> > 	if (!order)
> > 		break;
> > 	if (!PageCompound(page)) {
> > 		split_page(page, order);
> > 		break;
> > 	} else if (!split_huge_page(page)) {
> > 		break;
> > 	}
> > 
> > looks very suspicious to me.
> > My wild guess is that gfp flags changed somewhere above, so we hit
> > the branch which was never hit before.
> 
> Right to be suspicious about the above: split_huge_page on a regular
> page allocated by a driver was never meant to work.
> 
> The PageLocked BUG_ON is just a symptom of a bigger issue, basically
> split_huge_page it may survive, but it'll stay compound and in turn it
> must be freed as compound.
> 
> The respective free method doesn't even contemplate freeing compound
> pages, the only way the free method can survive, is by removing
> __GFP_COMP forcefully in the allocation that was perhaps set here
> (there are that many __GFP_COMP in that directory):
> 
> static void snd_malloc_dev_pages(struct snd_dma_buffer *dmab, size_t size)
> {
> 	gfp_t gfp_flags;
> 
> 	gfp_flags = GFP_KERNEL
> 		| __GFP_COMP	/* compound page lets parts be mapped */
> 
> And I'm not sure what the comment means here, compound or non compound
> doesn't make a difference when you map it, it's not a THP, the
> mappings must be handled manually so nothing should check PG_compound
> anyway in the mapping code.
> 
> Something like this may improve things, it's an untested quick hack,
> but this assumes it's always a bug to setup a compound page for these
> DMA allocations and given the API it's probably a correct
> assumption.. Compound is slower, unless you need it, you can avoid it
> and then split_page will give contiguous memory page granular. Ideally
> the code shouldn't call split_page at all and it should free it all at
> once by keeping track of the order and by returning the order to the
> caller, something the API can't do right now as it returns a plain
> array that can only represent individual small pages.
> 
> Once this is resolved, you may want to check your config, iommu passthrough
> sounds more optimal for a soundcard.
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index f68a62c3c32b..3dfbc010fa83 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -499,6 +499,10 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
>  
>  	/* IOMMU can map any pages, so himem can also be used here */
>  	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
> +	if (unlikely(gfp & __GFP_COMP)) {
> +		WARN();
> +		gfp &= ~__GFP_COMP;
> +	}
>  
>  	while (count) {
>  		struct page *page = NULL;
> @@ -522,13 +526,8 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
>  				continue;
>  			if (!order)
>  				break;
> -			if (!PageCompound(page)) {
> -				split_page(page, order);
> -				break;
> -			} else if (!split_huge_page(page)) {
> -				break;
> -			}
> -			__free_pages(page, order);
> +			split_page(page, order);
> +			break;
>  		}
>  		if (!page) {
>  			__iommu_dma_free_pages(pages, i);
> diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
> index 6850d13aa98c..378f5a36ec5f 100644
> --- a/sound/core/memalloc.c
> +++ b/sound/core/memalloc.c
> @@ -28,7 +28,6 @@ static void snd_malloc_dev_pages(struct snd_dma_buffer *dmab, size_t size)
>  	gfp_t gfp_flags;
>  
>  	gfp_flags = GFP_KERNEL
> -		| __GFP_COMP	/* compound page lets parts be mapped */
>  		| __GFP_NORETRY /* don't trigger OOM-killer */
>  		| __GFP_NOWARN; /* no stack trace print - this call is non-critical */
>  	dmab->area = dma_alloc_coherent(dmab->dev.dev, size, &dmab->addr,
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
