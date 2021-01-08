Return-Path: <SRS0=te8u=GL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693BBC433E6
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 10:08:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E927C236F9
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 10:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E927C236F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 74FA087575;
	Fri,  8 Jan 2021 10:08:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rW-r9XWEOsEs; Fri,  8 Jan 2021 10:08:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7AD4487536;
	Fri,  8 Jan 2021 10:08:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F248C0891;
	Fri,  8 Jan 2021 10:08:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5290FC013A
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 10:08:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D679A2E11F
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 10:08:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1G8yr+23fv8y for <iommu@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 10:08:25 +0000 (UTC)
X-Greylist: delayed 00:05:47 by SQLgrey-1.7.6
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by silver.osuosl.org (Postfix) with ESMTPS id 1964E2E11E
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 10:08:25 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id u25so896562lfc.2
 for <iommu@lists.linux-foundation.org>; Fri, 08 Jan 2021 02:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e8wcnpRjmLqWWPjOlKuS2zxtj825HdJfa315uuBxu+E=;
 b=gwT5kI9b3q1yJSSsmO/r1XGlJqaVWHsjszygBZhjqC7h5N6orJ9UZkWUXXLGVsDCdt
 +tUUsJ/rk4gTyjSeuaNo4p41y92lWxoM0ax4HUNKFNs/mTUR5aZErWWuL2rwygC+0SUL
 uaC5iKH2mNmV2MD9P1s6rwULoDm5+wGLeM9Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e8wcnpRjmLqWWPjOlKuS2zxtj825HdJfa315uuBxu+E=;
 b=tZ2cUpI9CtseDVNih670ZN20wEqyXog0Sn2bqd13MV9l9NSz0NypHWTK7tfEz86h2A
 T9SG62Pb7x0e62ybmGs0m6dLtV8FETMU6E2Cy4ABKoJeOrF88p5ZC23BTwHu+pvqNMzP
 h5sQvRO/ya+R/qutjvBh327pII3T+dkU0IyQjmBPzvFSNoCsvDylxtTFmMiD1qQFI17y
 CjhlNyPe4ldtqTn4kzG2ap6fuipQVdg2DrwoGkBk50TEJjh5hvvOIaLYGBoYthzgvKWU
 Yb95XfLa0AuXLApXWtctMzWui4fDnsjqdFmNBaja/H76Ok0Wgg85hNZ92NQ4lqC9ytsX
 BDSA==
X-Gm-Message-State: AOAM532Jxrqe2J9ipHdVu3AfuerLa3Cm6MIAOJSqupg/zsU7O3UUuqUN
 UlmwopNsbsr4l4BEpRRmXLuGHpQXFhobTA==
X-Google-Smtp-Source: ABdhPJyMGg7HzL6BNQs5vH4BLLNxR9IpM7WBNODEPjbvAUPrSaqNq+5IYk1blKB/FYG0HiLgKw+RcA==
X-Received: by 2002:a19:8210:: with SMTP id e16mr1216945lfd.69.1610100155809; 
 Fri, 08 Jan 2021 02:02:35 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com.
 [209.85.167.45])
 by smtp.gmail.com with ESMTPSA id u4sm727437lfl.274.2021.01.08.02.02.35
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Jan 2021 02:02:35 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id o17so21635404lfg.4
 for <iommu@lists.linux-foundation.org>; Fri, 08 Jan 2021 02:02:35 -0800 (PST)
X-Received: by 2002:adf:bb0e:: with SMTP id r14mr2875978wrg.159.1610099783056; 
 Fri, 08 Jan 2021 01:56:23 -0800 (PST)
MIME-Version: 1.0
References: <20201216103607.23050-1-yong.wu@mediatek.com>
 <20201216103607.23050-7-yong.wu@mediatek.com>
 <X+MGKBYKdmPNz7VL@chromium.org> <1de76b46-d9c1-4011-c087-1df236f442c3@arm.com>
In-Reply-To: <1de76b46-d9c1-4011-c087-1df236f442c3@arm.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Fri, 8 Jan 2021 18:56:11 +0900
X-Gmail-Original-Message-ID: <CAAFQd5C72ejEEioM=fTeE2=36DgRbDR1cCuWqn-7xnWRVzYPGw@mail.gmail.com>
Message-ID: <CAAFQd5C72ejEEioM=fTeE2=36DgRbDR1cCuWqn-7xnWRVzYPGw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] iommu/mediatek: Gather iova in iommu_unmap to
 achieve tlb sync once
To: Robin Murphy <robin.murphy@arm.com>
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream <srv_heupstream@mediatek.com>, kernel-team@android.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, chao.hao@mediatek.com,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Greg Kroah-Hartman <gregkh@google.com>, Will Deacon <will@kernel.org>
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

On Wed, Dec 23, 2020 at 8:00 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-12-23 08:56, Tomasz Figa wrote:
> > On Wed, Dec 16, 2020 at 06:36:06PM +0800, Yong Wu wrote:
> >> In current iommu_unmap, this code is:
> >>
> >>      iommu_iotlb_gather_init(&iotlb_gather);
> >>      ret = __iommu_unmap(domain, iova, size, &iotlb_gather);
> >>      iommu_iotlb_sync(domain, &iotlb_gather);
> >>
> >> We could gather the whole iova range in __iommu_unmap, and then do tlb
> >> synchronization in the iommu_iotlb_sync.
> >>
> >> This patch implement this, Gather the range in mtk_iommu_unmap.
> >> then iommu_iotlb_sync call tlb synchronization for the gathered iova range.
> >> we don't call iommu_iotlb_gather_add_page since our tlb synchronization
> >> could be regardless of granule size.
> >>
> >> In this way, gather->start is impossible ULONG_MAX, remove the checking.
> >>
> >> This patch aims to do tlb synchronization *once* in the iommu_unmap.
> >>
> >> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> >> ---
> >>   drivers/iommu/mtk_iommu.c | 8 +++++---
> >>   1 file changed, 5 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> >> index db7d43adb06b..89cec51405cd 100644
> >> --- a/drivers/iommu/mtk_iommu.c
> >> +++ b/drivers/iommu/mtk_iommu.c
> >> @@ -506,7 +506,12 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
> >>                            struct iommu_iotlb_gather *gather)
> >>   {
> >>      struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> >> +    unsigned long long end = iova + size;
> >>
> >> +    if (gather->start > iova)
> >> +            gather->start = iova;
> >> +    if (gather->end < end)
> >> +            gather->end = end;
> >
> > I don't know how common the case is, but what happens if
> > gather->start...gather->end is a disjoint range from iova...end? E.g.
> >
> >   | gather      | ..XXX... | iova |
> >   |             |          |      |
> >   gather->start |          iova   |
> >                 gather->end       end
> >
> > We would also end up invalidating the TLB for the XXX area, which could
> > affect the performance.
>
> Take a closer look at iommu_unmap() - the gather data is scoped to each
> individual call, so that can't possibly happen.
>
> > Also, why is the existing code in __arm_v7s_unmap() not enough? It seems
> > to call io_pgtable_tlb_add_page() already, so it should be batching the
> > flushes.
>
> Because if we leave io-pgtable in charge of maintenance it will also
> inject additional invalidations and syncs for the sake of strictly
> correct walk cache maintenance. Apparently we can get away without that
> on this hardware, so the fundamental purpose of this series is to
> sidestep it.
>
> It's proven to be cleaner overall to devolve this kind of "non-standard"
> TLB maintenance back to drivers rather than try to cram yet more
> special-case complexity into io-pgtable itself. I'm planning to clean up
> the remains of the TLBI_ON_MAP quirk entirely after this.
>
> Robin.
>
> >>      return dom->iop->unmap(dom->iop, iova, size, gather);
> >>   }
> >>
> >> @@ -523,9 +528,6 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
> >>      struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> >>      size_t length = gather->end - gather->start;
> >>
> >> -    if (gather->start == ULONG_MAX)
> >> -            return;
> >> -
> >>      mtk_iommu_tlb_flush_range_sync(gather->start, length, gather->pgsize,
> >>                                     dom->data);
> >>   }
> >> --
> >> 2.18.0
> >>
> >> _______________________________________________
> >> iommu mailing list
> >> iommu@lists.linux-foundation.org
> >> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
