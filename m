Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12424C433F5
	for <iommu@archiver.kernel.org>; Thu, 13 Jan 2022 11:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0E0E4099E;
	Thu, 13 Jan 2022 11:37:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PApQXjECnkro; Thu, 13 Jan 2022 11:37:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 873F04032D;
	Thu, 13 Jan 2022 11:37:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A6E5C0030;
	Thu, 13 Jan 2022 11:37:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB53AC001E;
 Thu, 13 Jan 2022 11:37:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B8B6D40924;
 Thu, 13 Jan 2022 11:37:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WpSexwudVu-s; Thu, 13 Jan 2022 11:37:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 90DD94032D;
 Thu, 13 Jan 2022 11:37:02 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 00A67B82192;
 Thu, 13 Jan 2022 11:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E819C36AE3;
 Thu, 13 Jan 2022 11:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642073818;
 bh=+YT0N1Ya5C3GpxZb3D9lx91/TA7aYugOCM+xLuWjYus=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Y8pNbom+not22khASxC0ueT85weSmm7kwqI+jqij2ZQjNxusyGBuws6c2xcGeS2aN
 9swZkNa2lHT+EqUFoHcqwscUUVPriy4Cm4fAIQjZLWNlg7hI9+AtHC/h6in4aJ2vRs
 7WBuPU+LvQc6MavLpwW30LJ5V1WHuEA17r/aBUHfdlyYbe4rxmup5KWNk0YUJhq6A4
 1fcD63FjDJCSMo+Po0f1aEVflhmsnSpMVI2j8jOkqcPkWMfP5sHyJP3P/iYTWNcU9P
 LXw/TsOnQN4ucHQJqihS6vgO2Ure2XIVDeeLBPlAh/jMjE6BsbJrJyGGEzGtqUOOm+
 bwsfmuQCDueEQ==
Date: Thu, 13 Jan 2022 13:36:50 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC PATCH v3 1/8] mm: page_alloc: avoid merging
 non-fallbackable pageblocks with others.
Message-ID: <YeAO0vtyjWWMRliF@kernel.org>
References: <20220105214756.91065-1-zi.yan@sent.com>
 <20220105214756.91065-2-zi.yan@sent.com>
 <7dc078ef-70f4-159e-b928-34f0fb0ffaea@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7dc078ef-70f4-159e-b928-34f0fb0ffaea@redhat.com>
Cc: Mel Gorman <mgorman@techsingularity.net>, Eric Ren <renzhengeek@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org, Zi Yan <ziy@nvidia.com>,
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

On Wed, Jan 12, 2022 at 11:54:49AM +0100, David Hildenbrand wrote:
> On 05.01.22 22:47, Zi Yan wrote:
> > From: Zi Yan <ziy@nvidia.com>
> > 
> > This is done in addition to MIGRATE_ISOLATE pageblock merge avoidance.
> > It prepares for the upcoming removal of the MAX_ORDER-1 alignment
> > requirement for CMA and alloc_contig_range().
> > 
> > MIGRARTE_HIGHATOMIC should not merge with other migratetypes like
> > MIGRATE_ISOLATE and MIGRARTE_CMA[1], so this commit prevents that too.
> > Also add MIGRARTE_HIGHATOMIC to fallbacks array for completeness.
> > 
> > [1] https://lore.kernel.org/linux-mm/20211130100853.GP3366@techsingularity.net/
> > 
> > Signed-off-by: Zi Yan <ziy@nvidia.com>
> > ---
> >  include/linux/mmzone.h |  6 ++++++
> >  mm/page_alloc.c        | 28 ++++++++++++++++++----------
> >  2 files changed, 24 insertions(+), 10 deletions(-)
> > 

...

> > @@ -3545,8 +3553,8 @@ int __isolate_free_page(struct page *page, unsigned int order)
> >  		struct page *endpage = page + (1 << order) - 1;
> >  		for (; page < endpage; page += pageblock_nr_pages) {
> >  			int mt = get_pageblock_migratetype(page);
> > -			if (!is_migrate_isolate(mt) && !is_migrate_cma(mt)
> > -			    && !is_migrate_highatomic(mt))
> > +			/* Only change normal pageblock */
> > +			if (migratetype_has_fallback(mt))
> >  				set_pageblock_migratetype(page,
> >  							  MIGRATE_MOVABLE);
> >  		}
> 
> That part is a nice cleanup IMHO. Although the "has fallback" part is a
> bit imprecise. "migratetype_is_mergable()" might be a bit clearer.
> ideally "migratetype_is_mergable_with_other_types()". Can we come up
> with a nice name for that?

migratetype_is_mergable() kinda implies "_with_other_types", no?

I like migratetype_is_mergable() more than _has_fallback().

My $0.02 to bikeshedding :)
 
> -- 
> Thanks,
> 
> David / dhildenb
> 
> 

-- 
Sincerely yours,
Mike.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
