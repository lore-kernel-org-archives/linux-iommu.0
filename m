Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5B1C433EF
	for <iommu@archiver.kernel.org>; Mon, 24 Jan 2022 05:37:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 584BE40918;
	Mon, 24 Jan 2022 05:37:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b0_ncKBQyL9L; Mon, 24 Jan 2022 05:37:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C64B240908;
	Mon, 24 Jan 2022 05:37:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5A5FC0039;
	Mon, 24 Jan 2022 05:37:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98D77C002F
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 05:37:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 85B4B40159
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 05:37:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xM_dqrrbl3aa for <iommu@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 05:37:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B3EE740119
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 05:37:34 +0000 (UTC)
Received: by mail-qv1-xf36.google.com with SMTP id g11so13491797qvu.3
 for <iommu@lists.linux-foundation.org>; Sun, 23 Jan 2022 21:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=enANyF9xQkci+2IYgkMWCm+5r3Jg0UEtwEQm3CmINp4=;
 b=ViYwMgY+J+GTZMRnv4xzmrn3GlqntH7w9uLqiFi4gnoOL8InvtSYvPJEKo2/Yhbixy
 7XOvJ078YQY6EaxPcoZcs8Pk7NvL5pu+1O3OyRtU5v0qLR/3fv1Ggkhoe53FdQm8EbHw
 07iXtSR4xU3fHhiCrVp+0dX0Bxc2HoMEKBuxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=enANyF9xQkci+2IYgkMWCm+5r3Jg0UEtwEQm3CmINp4=;
 b=aIwVvNUISs/KsQoSmMP6i9iq8ubgV+ty3Qu5cxDY+7/qwEZYQyZi+OBzQUDDfzn73T
 ZNNpo1OF9FJjg8agCG32HYqzR7MSGeF6uPBjb6A+Ir/Hx3ypNusrQ3eU9oLCQReq9cLf
 hXfXWrqDTKAOdk768BSyA28m+RhbHKWxi/ThkflZ820BNDa3Q4ovYs+B7W29jsqGC8kB
 im8FLKmrZDTrrRqrhUDC8rJQvM7yFh5LkJaTI+Hj/1QYR9zCEVvDew9X8HSY6L0d2MS7
 o/u1o+CSWVsVhHLexdCuEmIbZJxPa0nIzQwVs7pish/8+eDeuR22e5Y45DK98+sr/z57
 Wa7Q==
X-Gm-Message-State: AOAM533gdklQC+e0kxXebu2HYZjf/tvtVA4WERar+luWuhu2S5CHSfZ+
 ymEOpsgaRUNHD7tAQiC+e2dESzx5qq/lFA==
X-Google-Smtp-Source: ABdhPJyzFBmJe13skQdrndnc5k6bwHRw55DALR1v+60iyRf/HGmsGpOH476KPyBqLp83twOqR16Faw==
X-Received: by 2002:ad4:5bac:: with SMTP id 12mr13741540qvq.125.1643002653349; 
 Sun, 23 Jan 2022 21:37:33 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com.
 [209.85.219.170])
 by smtp.gmail.com with ESMTPSA id w20sm7564375qkp.102.2022.01.23.21.37.31
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jan 2022 21:37:31 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id l68so47004596ybl.0
 for <iommu@lists.linux-foundation.org>; Sun, 23 Jan 2022 21:37:31 -0800 (PST)
X-Received: by 2002:a25:bb45:: with SMTP id b5mr22186057ybk.174.1643002650779; 
 Sun, 23 Jan 2022 21:37:30 -0800 (PST)
MIME-Version: 1.0
References: <1423480761-33453-1-git-send-email-tfiga@chromium.org>
 <20150303133659.GD10502@8bytes.org>
 <CAAFQd5Abk6X7AVTFaNuUSiShn31pzwwTE3VjfLnE4kyziAjy2A@mail.gmail.com>
 <21bb5af8-1d59-9369-6008-2fd7e88007eb@collabora.com>
In-Reply-To: <21bb5af8-1d59-9369-6008-2fd7e88007eb@collabora.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Mon, 24 Jan 2022 14:37:19 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CnhE6KBEeG=LKKqb2Ry324Wye=CQCuLjD_2Fd5JzpgcQ@mail.gmail.com>
Message-ID: <CAAFQd5CnhE6KBEeG=LKKqb2Ry324Wye=CQCuLjD_2Fd5JzpgcQ@mail.gmail.com>
Subject: Re: [PATCH] CHROMIUM: iommu: rockchip: Make sure that page table
 state is coherent
To: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Daniel Kurtz <djkurtz@chromium.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 iommu@lists.linux-foundation.org, Collabora Kernel ML <kernel@collabora.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

Hi Dafna,

On Fri, Dec 10, 2021 at 12:18 AM Dafna Hirschfeld
<dafna.hirschfeld@collabora.com> wrote:
>
>
>
> On 23.03.15 10:38, Tomasz Figa wrote:
> > Sorry, I had to dig my way out through my backlog.
> >
> > On Tue, Mar 3, 2015 at 10:36 PM, Joerg Roedel <joro@8bytes.org> wrote:
> >> On Mon, Feb 09, 2015 at 08:19:21PM +0900, Tomasz Figa wrote:
> >>> Even though the code uses the dt_lock spin lock to serialize mapping
> >>> operation from different threads, it does not protect from IOMMU
> >>> accesses that might be already taking place and thus altering state
> >>> of the IOTLB. This means that current mapping code which first zaps
> >>> the page table and only then updates it with new mapping which is
> >>> prone to mentioned race.
> >>
> >> Could you elabortate a bit on the race and why it is sufficient to zap
> >> only the first and the last iova? From the description and the comments
> >> in the patch this is not clear to me.
> >
> > Let's start with why it's sufficient to zap only first and last iova.
> >
> > While unmapping, the driver zaps all iovas belonging to the mapping,
> > so the page tables not used by any mapping won't be cached. Now when
> > the driver creates a mapping it might end up occupying several page
> > tables. However, since the mapping area is virtually contiguous, only
> > the first and last page table can be shared with different mappings.
> > This means that only first and last iovas can be already cached. In
> > fact, we could detect if first and last page tables are shared and do
> > not zap at all, but this wouldn't really optimize too much. Why
> > invalidating one iova is enough to invalidate the whole page table is
> > unclear to me as well, but it seems to be the correct way on this
> > hardware.
>
> Hi,
> It seems to me that actually each mapping needs exactly one page.
> Since (as the inline doc in rk_iommu_map states) the pgsize_bitmap
> makes sure that iova mappings fits exactly into one page table
> since the mapping size is maximum 4M.
>
> This actually means that if rk_dte_get_page_table does not allocate a
> new page table but returns one that is already partially used from previous
> mappings then two page tables might be required, but I think the iova
> allocation somehow make sure that this will not be the case.

Yes, it was exactly for the case. Note that the zap operation is
per-IO-page and not per IOPT and there is some prefetching going on in
the TLB of this IOMMU. So neighboring mappings can interfere with each
other.

>
> If it was the case then the code would be buggy because it means
> that the loop in rk_iommu_map_iova will write behind the page table
> given in rk_dte_get_page_table (which we didn't allocate)

Sorry, I don't see how it could write behind the page table. Could you
give me an example?

>
> So I it seems to me that calling 'rk_iommu_zap_iova(rk_domain, iova, SPAGE_SIZE);'
> as done before this patch should be used, but be moved from
> rk_dte_get_page_table to where rk_iommu_zap_iova_first_last is now
>
> Thanks,
> Dafna
>
> >
> > As for the race, it's also kind of explained by the above. The already
> > running hardware can trigger page table look-ups in the IOMMU and so
> > caching of the page table between our zapping and updating its
> > contents. With this patch zapping is performed after updating the page
> > table so the race is gone.
> >
> > Best regards,
> > Tomasz
> >
> >  From mboxrd@z Thu Jan  1 00:00:00 1970
> > Return-Path: <linux-kernel-owner@vger.kernel.org>
> > Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
> >       id S1753210AbbCWM3R (ORCPT <rfc822;w@1wt.eu>);
> >       Mon, 23 Mar 2015 08:29:17 -0400
> > Received: from 8bytes.org ([81.169.241.247]:33957 "EHLO theia.8bytes.org"
> >       rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
> >       id S1752552AbbCWM3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
> >       Mon, 23 Mar 2015 08:29:12 -0400
> > Date: Mon, 23 Mar 2015 13:29:10 +0100
> > From: Joerg Roedel <joro@8bytes.org>
> > To: Tomasz Figa <tfiga@chromium.org>
> > Cc: iommu@lists.linux-foundation.org,
> >          "linux-arm-kernel@lists.infradead.org"
> >       <linux-arm-kernel@lists.infradead.org>,
> >          "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
> >          "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
> >          Heiko Stuebner <heiko@sntech.de>, Daniel Kurtz <djkurtz@chromium.org>
> > Subject: Re: [PATCH] CHROMIUM: iommu: rockchip: Make sure that page table
> >   state is coherent
> > Message-ID: <20150323122910.GO4441@8bytes.org>
> > References: <1423480761-33453-1-git-send-email-tfiga@chromium.org>
> >   <20150303133659.GD10502@8bytes.org>
> >   <CAAFQd5Abk6X7AVTFaNuUSiShn31pzwwTE3VjfLnE4kyziAjy2A@mail.gmail.com>
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=us-ascii
> > Content-Disposition: inline
> > In-Reply-To: <CAAFQd5Abk6X7AVTFaNuUSiShn31pzwwTE3VjfLnE4kyziAjy2A@mail.gmail.com>
> > User-Agent: Mutt/1.5.21 (2010-09-15)
> > Sender: linux-kernel-owner@vger.kernel.org
> > List-ID: <linux-kernel.vger.kernel.org>
> > X-Mailing-List: linux-kernel@vger.kernel.org
> >
> > Hi Tomasz,
> >
> > On Mon, Mar 23, 2015 at 05:38:45PM +0900, Tomasz Figa wrote:
> >> While unmapping, the driver zaps all iovas belonging to the mapping,
> >> so the page tables not used by any mapping won't be cached. Now when
> >> the driver creates a mapping it might end up occupying several page
> >> tables. However, since the mapping area is virtually contiguous, only
> >> the first and last page table can be shared with different mappings.
> >> This means that only first and last iovas can be already cached. In
> >> fact, we could detect if first and last page tables are shared and do
> >> not zap at all, but this wouldn't really optimize too much. Why
> >> invalidating one iova is enough to invalidate the whole page table is
> >> unclear to me as well, but it seems to be the correct way on this
> >> hardware.
> >>
> >> As for the race, it's also kind of explained by the above. The already
> >> running hardware can trigger page table look-ups in the IOMMU and so
> >> caching of the page table between our zapping and updating its
> >> contents. With this patch zapping is performed after updating the page
> >> table so the race is gone.
> >
> > Okay, this makes sense. Can you add this information to the patch
> > changelog and resend please?
> >
> > Thanks,
> >
> >       Joerg
> >
> >
> >  From mboxrd@z Thu Jan  1 00:00:00 1970
> > From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > Subject: [PATCH] CHROMIUM: iommu: rockchip: Make sure that page table state is
> >       coherent
> > Date: Mon,  9 Feb 2015 20:19:21 +0900
> > Message-ID: <1423480761-33453-1-git-send-email-tfiga@chromium.org>
> > Mime-Version: 1.0
> > Content-Type: text/plain; charset="us-ascii"
> > Content-Transfer-Encoding: 7bit
> > Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
> > List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
> >       <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
> > List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
> > List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
> > List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
> > List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
> >       <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
> > Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> > Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> > To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> > Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> > List-Id: iommu@lists.linux-foundation.org
> >
> > Even though the code uses the dt_lock spin lock to serialize mapping
> > operation from different threads, it does not protect from IOMMU
> > accesses that might be already taking place and thus altering state
> > of the IOTLB. This means that current mapping code which first zaps
> > the page table and only then updates it with new mapping which is
> > prone to mentioned race.
> >
> > In addition, current code assumes that mappings are always > 4 MiB
> > (which translates to 1024 PTEs) and so they would always occupy
> > entire page tables. This is not true for mappings created by V4L2
> > Videobuf2 DMA contig allocator.
> >
> > This patch changes the mapping code to always zap the page table
> > after it is updated, which avoids the aforementioned race and also
> > zap the last page of the mapping to make sure that stale data is
> > not cached from an already existing mapping.
> >
> > Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > Reviewed-by: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > ---
> >   drivers/iommu/rockchip-iommu.c | 23 +++++++++++++++++------
> >   1 file changed, 17 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> > index 6a8b1ec..b06fe76 100644
> > --- a/drivers/iommu/rockchip-iommu.c
> > +++ b/drivers/iommu/rockchip-iommu.c
> > @@ -544,6 +544,15 @@ static void rk_iommu_zap_iova(struct rk_iommu_domain *rk_domain,
> >       spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
> >   }
> >
> > +static void rk_iommu_zap_iova_first_last(struct rk_iommu_domain *rk_domain,
> > +                                      dma_addr_t iova, size_t size)
> > +{
> > +     rk_iommu_zap_iova(rk_domain, iova, SPAGE_SIZE);
> > +     if (size > SPAGE_SIZE)
> > +             rk_iommu_zap_iova(rk_domain, iova + size - SPAGE_SIZE,
> > +                                     SPAGE_SIZE);
> > +}
> > +
> >   static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
> >                                 dma_addr_t iova)
> >   {
> > @@ -568,12 +577,6 @@ static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
> >       rk_table_flush(page_table, NUM_PT_ENTRIES);
> >       rk_table_flush(dte_addr, 1);
> >
> > -     /*
> > -      * Zap the first iova of newly allocated page table so iommu evicts
> > -      * old cached value of new dte from the iotlb.
> > -      */
> > -     rk_iommu_zap_iova(rk_domain, iova, SPAGE_SIZE);
> > -
> >   done:
> >       pt_phys = rk_dte_pt_address(dte);
> >       return (u32 *)phys_to_virt(pt_phys);
> > @@ -623,6 +626,14 @@ static int rk_iommu_map_iova(struct rk_iommu_domain *rk_domain, u32 *pte_addr,
> >
> >       rk_table_flush(pte_addr, pte_count);
> >
> > +     /*
> > +      * Zap the first and last iova to evict from iotlb any previously
> > +      * mapped cachelines holding stale values for its dte and pte.
> > +      * We only zap the first and last iova, since only they could have
> > +      * dte or pte shared with an existing mapping.
> > +      */
> > +     rk_iommu_zap_iova_first_last(rk_domain, iova, size);
> > +
> >       return 0;
> >   unwind:
> >       /* Unmap the range of iovas that we just mapped */
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
