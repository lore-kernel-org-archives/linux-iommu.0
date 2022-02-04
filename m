Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEF2C433EF
	for <iommu@archiver.kernel.org>; Fri,  4 Feb 2022 13:57:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D3508404F3;
	Fri,  4 Feb 2022 13:57:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YjczQivWe5Hi; Fri,  4 Feb 2022 13:57:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 23EE5403AA;
	Fri,  4 Feb 2022 13:57:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE3E9C0011;
	Fri,  4 Feb 2022 13:57:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D36BBC000B;
 Fri,  4 Feb 2022 13:56:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B3DF860D63;
 Fri,  4 Feb 2022 13:56:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="JO/7l+c1";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="MUNrpRSB"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TaojCUA8AMac; Fri,  4 Feb 2022 13:56:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6B27E60BAF;
 Fri,  4 Feb 2022 13:56:58 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7486C210FF;
 Fri,  4 Feb 2022 13:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643983015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gGlRq3+CNTWfW49gGBzQLhF40kVTe7aTlQ7x7spjq8U=;
 b=JO/7l+c1xHeI4exZG42xeX15TbqNl1uXCvW5lzCmIEbwm2lTb0G2bcBFDVsaxos8NZ2NqM
 VHzJillMKNZWh/+5wd+Rgk4C1NBdlRCtqEdgz98vQnRZS9dJjoEzksgj+x/dkoqLxqWhaT
 3EE0G0Bp5Dt86XVhELp2m3Bu3PUrSoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643983015;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gGlRq3+CNTWfW49gGBzQLhF40kVTe7aTlQ7x7spjq8U=;
 b=MUNrpRSBuyViOD2u/bAKGDP7r5uJgCcXQXn8MBPrWRQ4md5s2dLna6QTC/YYP11aAdMoiU
 ofAFCLWfH4FWueDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 85A7113B04;
 Fri,  4 Feb 2022 13:56:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nEA4HaYw/WEffwAAMHmgww
 (envelope-from <osalvador@suse.de>); Fri, 04 Feb 2022 13:56:54 +0000
Date: Fri, 4 Feb 2022 14:56:52 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v4 4/7] mm: make alloc_contig_range work at pageblock
 granularity
Message-ID: <Yf0wpFmtckRRzLFg@localhost.localdomain>
References: <20220119190623.1029355-1-zi.yan@sent.com>
 <20220119190623.1029355-5-zi.yan@sent.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220119190623.1029355-5-zi.yan@sent.com>
Cc: Mel Gorman <mgorman@techsingularity.net>,
 David Hildenbrand <david@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Eric Ren <renzhengeek@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Vlastimil Babka <vbabka@suse.cz>
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

On Wed, Jan 19, 2022 at 02:06:20PM -0500, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> alloc_contig_range() worked at MAX_ORDER-1 granularity to avoid merging
> pageblocks with different migratetypes. It might unnecessarily convert
> extra pageblocks at the beginning and at the end of the range. Change
> alloc_contig_range() to work at pageblock granularity.
> 
> It is done by restoring pageblock types and split >pageblock_order free
> pages after isolating at MAX_ORDER-1 granularity and migrating pages
> away at pageblock granularity. The reason for this process is that
> during isolation, some pages, either free or in-use, might have >pageblock
> sizes and isolating part of them can cause free accounting issues.
> Restoring the migratetypes of the pageblocks not in the interesting
> range later is much easier.

Hi Zi Yan,

Due to time constraints I only glanced over, so some comments below
about stuff that caught my eye:

> +static inline void split_free_page_into_pageblocks(struct page *free_page,
> +				int order, struct zone *zone)
> +{
> +	unsigned long pfn;
> +
> +	spin_lock(&zone->lock);
> +	del_page_from_free_list(free_page, zone, order);
> +	for (pfn = page_to_pfn(free_page);
> +	     pfn < page_to_pfn(free_page) + (1UL << order);

It migt make sense to have a end_pfn variable so that does not have to
be constantly evaluated. Or maybe the compiler is clever enough to only
evualuate it once.

> +	     pfn += pageblock_nr_pages) {
> +		int mt = get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
> +
> +		__free_one_page(pfn_to_page(pfn), pfn, zone, pageblock_order,
> +				mt, FPI_NONE);
> +	}
> +	spin_unlock(&zone->lock);

It is possible that free_page's order is already pageblock_order, so I
would add a one-liner upfront to catch that case and return, otherwise
we do the delete_from_freelist-and-free_it_again dance.

> +	/* Save the migratepages of the pageblocks before start and after end */
> +	num_pageblock_to_save = (alloc_start - isolate_start) / pageblock_nr_pages
> +				+ (isolate_end - alloc_end) / pageblock_nr_pages;
> +	saved_mt =
> +		kmalloc_array(num_pageblock_to_save,
> +			      sizeof(unsigned char), GFP_KERNEL);
> +	if (!saved_mt)
> +		return -ENOMEM;
> +
> +	num = save_migratetypes(saved_mt, isolate_start, alloc_start);
> +
> +	num = save_migratetypes(&saved_mt[num], alloc_end, isolate_end);

I really hope we can put all this magic within start_isolate_page_range,
and the counterparts in undo_isolate_page_range.

Also, I kinda dislike the &saved_mt thing. I thought about some other
approaches but nothing that wasn't too specific for this case, and I
guess we want that function to be as generic as possible.

> +	/*
> +	 * Split free page spanning [alloc_end, isolate_end) and put the
> +	 * pageblocks in the right migratetype list
> +	 */
> +	for (outer_end = alloc_end; outer_end < isolate_end;) {
> +		unsigned long begin_pfn = outer_end;
> +
> +		order = 0;
> +		while (!PageBuddy(pfn_to_page(outer_end))) {
> +			if (++order >= MAX_ORDER) {
> +				outer_end = begin_pfn;
> +				break;
> +			}
> +			outer_end &= ~0UL << order;
> +		}
> +
> +		if (outer_end != begin_pfn) {
> +			order = buddy_order(pfn_to_page(outer_end));
> +
> +			/*
> +			 * split the free page has start page and put the pageblocks
> +			 * in the right migratetype list
> +			 */
> +			VM_BUG_ON(outer_end + (1UL << order) <= begin_pfn);

How could this possibily happen?

> +			{
> +				struct page *free_page = pfn_to_page(outer_end);
> +
> +				split_free_page_into_pageblocks(free_page, order, cc.zone);
> +			}
> +			outer_end += 1UL << order;
> +		} else
> +			outer_end = begin_pfn + 1;
>  	}

I think there are cases could optimize for. If the page has already been
split in pageblock by the outer_start loop, we could skip this outer_end
logic altogether.

E.g: An order-10 page is split in two pageblocks. There's nothing else
to be done, right? We could skip this. 


-- 
Oscar Salvador
SUSE Labs
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
