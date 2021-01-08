Return-Path: <SRS0=te8u=GL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D5FC433E0
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 10:01:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D232368A
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 10:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D232368A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 54EC6875A9;
	Fri,  8 Jan 2021 10:01:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AWgwxC1S9K1J; Fri,  8 Jan 2021 10:01:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 96E9687560;
	Fri,  8 Jan 2021 10:01:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68D0AC088B;
	Fri,  8 Jan 2021 10:01:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19604C013A
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 10:01:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F217787327
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 10:01:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HuoKHnuBWBqI for <iommu@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 10:01:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EB78987321
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 10:01:00 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id v26so1657657eds.13
 for <iommu@lists.linux-foundation.org>; Fri, 08 Jan 2021 02:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IK+44CzzfVfOGuAwRFDtWTWEbsmnaUyfEbndc+LLII0=;
 b=g5gIR+DZeDOkUgh3bwbifA/QvR8Xca1KXNdDaE6fShDjJgoMxK33BxMUJ56GfRGQUu
 0RBWDEtQW/NL3kY1bH/fXuGS2/yEn8TdrlH9B+UIBprw0cgqUonLVtCVSQrCRz4P6+XY
 pDUnYebAcRC+MTAkyoyGQBgZxuGydzUdulvgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IK+44CzzfVfOGuAwRFDtWTWEbsmnaUyfEbndc+LLII0=;
 b=LF4wSTmdJGvWab2q061Fe0iIMYgRb5HNYioQGNm9UoS49Ia1E4xmNUGtGWbgYpy5uA
 tjCIH1RM67cjiuB6HjvMjls+1qFqERfwgF6x1uy+MzotiAcXpfILDwo2c4MXZonFTASw
 pC83GJ+TSqJDRZkR3cHdmu6uHPadk4+i/fMkM+igU8U/TWFy5yfPHv/44pDNK9c7yLno
 Hgk8ZtNLdevQDhGoNwAJl7rC6RnO5DYP8eJrQG1TbY8qd868F4ztwQuWWoT0QR190RhF
 OYvLMQRiOC+U0B6Y1QEiIxA7elVVQ9XGv+j+pHaR+vdx8HuhAstdjW/gZyrLcFFJA+1i
 nA1g==
X-Gm-Message-State: AOAM530/kdfG+xBCLItxyT+jMvmBrT5K6GZf57f8TKEL0maYqMuYs4se
 HTMxZV9INxRf9dN3IjCZvJRAJIkRUQm9sA==
X-Google-Smtp-Source: ABdhPJx3K5Lxw737cbeKKIyd/tqhxWA5aIEXHYHyYy+3eWBe6uGDvBhHEGuln4gOQN0pIyut0vBGuA==
X-Received: by 2002:a50:cdc8:: with SMTP id h8mr4810226edj.293.1610100059206; 
 Fri, 08 Jan 2021 02:00:59 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com.
 [209.85.128.50])
 by smtp.gmail.com with ESMTPSA id i15sm3366610ejj.28.2021.01.08.02.00.58
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Jan 2021 02:00:59 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id g185so7892636wmf.3
 for <iommu@lists.linux-foundation.org>; Fri, 08 Jan 2021 02:00:58 -0800 (PST)
X-Received: by 2002:a7b:c92b:: with SMTP id h11mr2296894wml.99.1610099693765; 
 Fri, 08 Jan 2021 01:54:53 -0800 (PST)
MIME-Version: 1.0
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <X+MBcmzQn9iQWlVZ@chromium.org>
 <1609239977.26323.292.camel@mhfsdcap03>
In-Reply-To: <1609239977.26323.292.camel@mhfsdcap03>
From: Tomasz Figa <tfiga@chromium.org>
Date: Fri, 8 Jan 2021 18:54:41 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Cz5X5_pm3Vef0HcuARXrZPx9FGxeuxtQeqe9vmWcxZzQ@mail.gmail.com>
Message-ID: <CAAFQd5Cz5X5_pm3Vef0HcuARXrZPx9FGxeuxtQeqe9vmWcxZzQ@mail.gmail.com>
Subject: Re: [PATCH v5 18/27] iommu/mediatek: Add power-domain operation
To: Yong Wu <yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, linux-devicetree <devicetree@vger.kernel.org>,
 Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream <srv_heupstream@mediatek.com>, Will Deacon <will@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Evan Green <evgreen@chromium.org>, chao.hao@mediatek.com,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>
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

On Tue, Dec 29, 2020 at 8:06 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Wed, 2020-12-23 at 17:36 +0900, Tomasz Figa wrote:
> > On Wed, Dec 09, 2020 at 04:00:53PM +0800, Yong Wu wrote:
> > > In the previous SoC, the M4U HW is in the EMI power domain which is
> > > always on. the latest M4U is in the display power domain which may be
> > > turned on/off, thus we have to add pm_runtime interface for it.
> > >
> > > When the engine work, the engine always enable the power and clocks for
> > > smi-larb/smi-common, then the M4U's power will always be powered on
> > > automatically via the device link with smi-common.
> > >
> > > Note: we don't enable the M4U power in iommu_map/unmap for tlb flush.
> > > If its power already is on, of course it is ok. if the power is off,
> > > the main tlb will be reset while M4U power on, thus the tlb flush while
> > > m4u power off is unnecessary, just skip it.
> > >
> > > There will be one case that pm runctime status is not expected when tlb
> > > flush. After boot, the display may call dma_alloc_attrs before it call
> > > pm_runtime_get(disp-dev), then the m4u's pm status is not active inside
> > > the dma_alloc_attrs. Since it only happens after boot, the tlb is clean
> > > at that time, I also think this is ok.
> > >
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > >  drivers/iommu/mtk_iommu.c | 41 +++++++++++++++++++++++++++++++++------
> > >  1 file changed, 35 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > > index 6fe3ee2b2bf5..0e9c03cbab32 100644
> > > --- a/drivers/iommu/mtk_iommu.c
> > > +++ b/drivers/iommu/mtk_iommu.c
> > > @@ -184,6 +184,8 @@ static void mtk_iommu_tlb_flush_all(void *cookie)
> > >     struct mtk_iommu_data *data = cookie;
> > >
> > >     for_each_m4u(data) {
> > > +           if (!pm_runtime_active(data->dev))
> > > +                   continue;
> >
> > Is it guaranteed that the status is active in the check above, but then
> > the process is preempted and it goes down here?
> >
> > Shouldn't we do something like below?
> >
> >         ret = pm_runtime_get_if_active();
> >         if (!ret)
> >                 continue;
> >         if (ret < 0)
> >                 // handle error
> >
> >         // Flush
> >
> >         pm_runtime_put();
>
> Make sense. Thanks. There is a comment in arm_smmu.c "avoid touching
> dev->power.lock in fastpaths". To avoid this here too(we have many SoC
> don't have power-domain). then the code will be like:
>
>         bool has_pm = !!data->dev->pm_domain;
>
>         if (has_pm) {
>                 if (pm_runtime_get_if_in_use(data->dev) <= 0)
>                         continue;
>         }
>
>         xxxx
>
>         if (has_pm)
>                 pm_runtime_put(data->dev);

Looks good to me, thanks.

> >
> > Similar comment to the other places being changed by this patch.
> >
> > >             writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
> > >                            data->base + data->plat_data->inv_sel_reg);
> > >             writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
> > > @@ -200,6 +202,10 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
> > >     u32 tmp;
> > >
> > >     for_each_m4u(data) {
> > > +           /* skip tlb flush when pm is not active. */
> > > +           if (!pm_runtime_active(data->dev))
> > > +                   continue;
> > > +
> > >             spin_lock_irqsave(&data->tlb_lock, flags);
> > >             writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
> > >                            data->base + data->plat_data->inv_sel_reg);
> [snip]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
