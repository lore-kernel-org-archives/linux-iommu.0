Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2623FC4338F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 05:26:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F63060F58
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 05:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8F63060F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B9344038A;
	Thu,  5 Aug 2021 05:26:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2W9VDEtPDpbD; Thu,  5 Aug 2021 05:26:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2CCB740266;
	Thu,  5 Aug 2021 05:26:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09371C0010;
	Thu,  5 Aug 2021 05:26:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3F7FC000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 05:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A8C35402EA
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 05:26:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NbHw7FyS-NWd for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 05:26:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E75B140266
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 05:26:22 +0000 (UTC)
Received: by mail-qv1-xf29.google.com with SMTP id s11so2366554qvz.7
 for <iommu@lists.linux-foundation.org>; Wed, 04 Aug 2021 22:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SAWYlvs5XtqLwUaEqS2qwqUPDupygtRRMcwg/DOIhsg=;
 b=nPobvWYZhXvZVrEvTwMU2dN2uActZpK/cmTowjhr6t4tZ/uQJTV2sYljb33SV3+52s
 RaEEuEtlXJg0GNli7EjvCKg1OdX457q6ggegb6fm0jHB0hquE0l21h7u4prEoW3YJUIZ
 +vSH8yX8Y0CNRYy1NI4biFTXdCLBLa5M10cBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SAWYlvs5XtqLwUaEqS2qwqUPDupygtRRMcwg/DOIhsg=;
 b=SjZqpR73+Hq7FaJeDbhxqod8tGXONvvHXLFYNP4OFp0yiZcqqSVCKUrgJRfhYtgVRp
 vPmIiFBZv4H9871GNy1dNKmQHn7c5s2IXMp97UO77U+PWDuGj4RR+Mut3F8aHKhxtYcl
 ZJJ0WFFh0f9xSOp8ktBy6kmo/AqI8xbPKAfkopjBnMDZeMKQXu4JyEh84u5sFKx98Sbf
 wsOB1ieY4yTB9ooim2552nkF0D9WDzmlsSYYZnLge128nvuUjrKsaPby0taKQ+LR1oFJ
 y1MxKxYny/b8rYU5HIHr2FZt75b4g8ImcPvlxEoMEHpeArA/5NXrEOhs6wjehCIsyMig
 9v8Q==
X-Gm-Message-State: AOAM532V+m6C2MSB6bVqoJzUO7zYFlAqUOlzojIpVpLOKlpQ4hIpc6xg
 usYvpyzBTPtIfBM/2hOe634lnuqc8cWO+YOlVoYOTA==
X-Google-Smtp-Source: ABdhPJwliKWoxLiTKjhaiCktAIkaJ/XWbOQ6RdbyHxj8/NjoJYsYviXy+qLt7OPWwt6dfpKxWyMiB9EhxZZyd+mymtc=
X-Received: by 2002:a05:6214:e4e:: with SMTP id
 o14mr3391377qvc.55.1628141181770; 
 Wed, 04 Aug 2021 22:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210709033502.3545820-1-stevensd@google.com>
 <20210709033502.3545820-4-stevensd@google.com>
 <20210802135446.GE28547@willie-the-truck>
In-Reply-To: <20210802135446.GE28547@willie-the-truck>
From: David Stevens <stevensd@chromium.org>
Date: Thu, 5 Aug 2021 14:26:10 +0900
Message-ID: <CAD=HUj4+62dYZTWfbPjh8eLRY6FQak8nBS8OD85t0xk_+JvDpA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dma-iommu: pass SKIP_CPU_SYNC to swiotlb unmap
To: Will Deacon <will@kernel.org>
Cc: open list <linux-kernel@vger.kernel.org>, Tom Murphy <murphyt7@tcd.ie>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

On Mon, Aug 2, 2021 at 10:54 PM Will Deacon <will@kernel.org> wrote:
>
> On Fri, Jul 09, 2021 at 12:35:01PM +0900, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> >
> > If SKIP_CPU_SYNC isn't already set, then iommu_dma_unmap_(page|sg) has
> > already called iommu_dma_sync_(single|sg)_for_cpu, so there is no need
> > to copy from the bounce buffer again.
> >
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > ---
> >  drivers/iommu/dma-iommu.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index e79e274d2dc5..0a9a9a343e64 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -505,7 +505,8 @@ static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
> >       __iommu_dma_unmap(dev, dma_addr, size);
> >
> >       if (unlikely(is_swiotlb_buffer(phys)))
> > -             swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
> > +             swiotlb_tbl_unmap_single(dev, phys, size, dir,
> > +                                      attrs | DMA_ATTR_SKIP_CPU_SYNC);
> >  }
>
> I think it would be cleaner to drop DMA_ATTR_SKIP_CPU_SYNC in the callers
> once they've called iommu_dma_sync_*_for_cpu().

Dropping that flag in iommu_dma_unmap_* would result in always copying
from the swiotlb here, which is the opposite direction of what this
patch is trying to do.

This change is aiming to address the case where DMA_ATTR_SKIP_CPU_SYNC
isn't passed to dma_unmap_*. In that case, there are calls to
swiotlb_sync_single_for_cpu from iommu_dma_sync_*_for_cpu, and calls
to swiotlb_tlb_unmap_single here. That means we copy from the swiotlb
twice. Adding the DMA_ATTR_SKIP_CPU_SYNC flag here skips the second
copy.

-David

> Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
