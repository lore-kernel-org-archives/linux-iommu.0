Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CBFC4332F
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 18:00:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9EA0284B61;
	Fri, 10 Dec 2021 18:00:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 72p-EK8L_CA1; Fri, 10 Dec 2021 18:00:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1E90784B4A;
	Fri, 10 Dec 2021 18:00:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEA49C002F;
	Fri, 10 Dec 2021 18:00:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E67BDC0012;
 Fri, 10 Dec 2021 18:00:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C90C441294;
 Fri, 10 Dec 2021 18:00:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vn-w4wBJhk01; Fri, 10 Dec 2021 18:00:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3D3694126F;
 Fri, 10 Dec 2021 18:00:00 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id x15so33220357edv.1;
 Fri, 10 Dec 2021 10:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q4cSh71dzUGeiXZRE4QW36EmwcI8AZrCxMvROIrZS14=;
 b=hZuwqUyMx6p4vq+XxIbn+14N9qyb4VjVKFc+XlT24PuxI8wuTRByd6L5UShZbYCPn6
 hFJEMkb+ZcKlIYkUV0tDiyObLesBR7irNUCiCMAa2lVRi3CC57aTV1alPZFU5Ysazrph
 YFhWPMKpxva8rtigETs3FTPO6R5mZn5VOWtBPJXZadHgtSqBE5wuIb/YuK6Qz1CH7KoK
 hnKUK9t4YQwu/yKgZT3oT89+N75FsEO9VhEY0F2y2bLckImDe4uov8SNI0AQgrJ3ZD5d
 S7s4cNZ1Mv66posmbYafTGVHKgSQlseJKI92d9yXya7GxXHGbGAnv0tL4KEZr7IYPLWc
 FeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q4cSh71dzUGeiXZRE4QW36EmwcI8AZrCxMvROIrZS14=;
 b=R6ahTbsUOjL9X7+XF8gQW+Jl26jGagAmbRrUG+zqrobh/GQZBLqj/Z0dP1YoTmjopu
 dRJNvDD+NZjLFS4SLuZA8JgkfQo1cGwXSQ5TpoRgPBANh2OehJNVvTVERJgEBHokpxyL
 CufcHGnWM1wkWsOF/FlWgs0gV5hL2pZLaE6ILZEiAR244/FYwNCD/zMmFBPdXXTAWU2d
 g9jeBrQZXH+WxMxf8+2Okl9V4EGx7LO9Pt+wxxuOKrXPV92J1UYdGBBfN/1AqST0n8m9
 aYy3ryAeFIEMHlz2T/u2PyfXPHKl8G3VNuOAjWhdVXHNnDu9JhKpjXOHPID+AaO793sZ
 uDfQ==
X-Gm-Message-State: AOAM533MxVmxj6/vQ7JY9o2p+eslAj+8fcru0AxYsXKvxLUmwXFyT6dI
 Esu87iHe+jtn7/CkE9OqJNwAybNYer3tuk1hQA4=
X-Google-Smtp-Source: ABdhPJyMR1vnybSwdT0dzOqAU1cPEp/zYKbnjixRaU/JBnWxGfH4bMnkNn+t2j/Uf7ySIMQBrI/ELelqVgOUVCZ6KxY=
X-Received: by 2002:a50:e003:: with SMTP id e3mr40230046edl.374.1639159198508; 
 Fri, 10 Dec 2021 09:59:58 -0800 (PST)
MIME-Version: 1.0
References: <20211209230414.2766515-1-zi.yan@sent.com>
 <20211209230414.2766515-4-zi.yan@sent.com>
 <84807a03-f7d1-83cb-16df-bacc58de4529@gmail.com>
 <971750C3-DAEC-4EE8-B838-2DD3CBC29781@nvidia.com>
In-Reply-To: <971750C3-DAEC-4EE8-B838-2DD3CBC29781@nvidia.com>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 10 Dec 2021 09:59:46 -0800
Message-ID: <CAHbLzkr627vwDovZ23Ofje1vfu+m6BbYWs=tvptNpQwf1ramyQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/7] mm: migrate: allocate the right size of non
 hugetlb or THP compound pages.
To: Zi Yan <ziy@nvidia.com>
Cc: Mel Gorman <mgorman@techsingularity.net>,
 David Hildenbrand <david@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Linux MM <linux-mm@kvack.org>,
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

On Fri, Dec 10, 2021 at 8:08 AM Zi Yan <ziy@nvidia.com> wrote:
>
> On 10 Dec 2021, at 2:53, Eric Ren wrote:
>
> > Hi,
> >
> > On 2021/12/10 07:04, Zi Yan wrote:
> >> From: Zi Yan <ziy@nvidia.com>
> >>
> >> alloc_migration_target() is used by alloc_contig_range() and non-LRU
> >> movable compound pages can be migrated. Current code does not allocate the
> >> right page size for such pages. Check THP precisely using
> >> is_transparent_huge() and add allocation support for non-LRU compound
> >> pages.
> > Could you elaborate on why the current code doesn't get the right size?  how this patch fixes it.
>
> The current code only check PageHuge() and PageTransHuge(). Non-LRU compound
> pages will be regarded as PageTransHuge() and an order-9 page is always allocated
> regardless of the actual page order. This patch makes the exact check for
> THPs using is_transparent_huge() instead of PageTransHuge() and checks PageCompound()
> after PageHuge() and is_transparent_huge() for non-LRU compound pages.
>
> >
> > The description sounds like it's an existing bug, if so, the patch subject should be changed to
> > "Fixes ..."?
>
> I have not seen any related bug report.
>
> >
> >>
> >> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >> ---
> >>   mm/migrate.c | 8 ++++++--
> >>   1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/mm/migrate.c b/mm/migrate.c
> >> index d487a399253b..2ce3c771b1de 100644
> >> --- a/mm/migrate.c
> >> +++ b/mm/migrate.c
> >> @@ -1563,7 +1563,7 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
> >>              return alloc_huge_page_nodemask(h, nid, mtc->nmask, gfp_mask);
> >>      }
> >>  -   if (PageTransHuge(page)) {
> >> +    if (is_transparent_hugepage(page)) {
> >>              /*
> >>               * clear __GFP_RECLAIM to make the migration callback
> >>               * consistent with regular THP allocations.
> >> @@ -1572,13 +1572,17 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
> > if (PageTransHuge(page)) {  // just give more code context
> > ...
> >>              gfp_mask |= GFP_TRANSHUGE;
> >>              order = HPAGE_PMD_ORDER;
> > order assigned here
> >>      }
> >> +    if (PageCompound(page)) {
> >> +            gfp_mask |= __GFP_COMP;
> >> +            order = compound_order(page);
> > re-assinged again as THP is a compound page?
>
> Ah, you are right. Will use else if instead. Thanks.

You don't have to use else if, you could just do:

if (PageCompound(page)) {
    gfp_mask |= __GFP_COMP;
    order = compound_order(page);
}

if (is_transparent_hugepage(page)) {
    /* Manipulate THP specific gfp mask */
    ....
}


>
> > Thanks,
> > Eric
> >> +    }
> >>      zidx = zone_idx(page_zone(page));
> >>      if (is_highmem_idx(zidx) || zidx == ZONE_MOVABLE)
> >>              gfp_mask |= __GFP_HIGHMEM;
> >>      new_page = __alloc_pages(gfp_mask, order, nid, mtc->nmask);
> >>  -   if (new_page && PageTransHuge(new_page))
> >> +    if (new_page && is_transparent_hugepage(page))
> >>              prep_transhuge_page(new_page);
> >>      return new_page;
>
>
> --
> Best Regards,
> Yan, Zi
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
