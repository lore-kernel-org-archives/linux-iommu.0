Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4A7C4320A
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 03:40:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 823F160F38
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 03:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 823F160F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BF3882CD3;
	Thu,  5 Aug 2021 03:40:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kNivrB25Uu7j; Thu,  5 Aug 2021 03:40:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1E97082C33;
	Thu,  5 Aug 2021 03:40:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F01CEC0010;
	Thu,  5 Aug 2021 03:40:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3768CC000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 03:40:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 20B0060618
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 03:40:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Iyk83Mbk-lKR for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 03:40:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1107B605C8
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 03:40:52 +0000 (UTC)
Received: by mail-qt1-x836.google.com with SMTP id m11so2975928qtx.7
 for <iommu@lists.linux-foundation.org>; Wed, 04 Aug 2021 20:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yBtiUC/DqJCFyQ7ZmzGjMneaNful/xPGIES5YDgZBg0=;
 b=kihQiWwbBwUWEV5CjWsqhY6HExovObfvVrQkYJIjNnQPi1ZuACiFo6ZnS2VMCy1FTs
 /M++ELHrNNxsI0eky/SnDkGuprUiBEAUhu4fS+oGq9TBaJiPHV8FU1BSrCUSJYYbDgJe
 augwd8ykKjzAUTFUIIsV0T6bgk6mh7tiYSYdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yBtiUC/DqJCFyQ7ZmzGjMneaNful/xPGIES5YDgZBg0=;
 b=pAsE8H9TJuNB4Lg3NQ9cHNtvC/ZVqlexHVZ2JP/APaYqVK+TsOPFYX8FCs7r7gKl0d
 QhhGQ+py4U8sxYCdsQcqiJYeDVzu+rhHyOOIrx0YoCeWA7cAqvvz49CrjVFIkmZodwb3
 i/VjjzfDBHuM1PXmpBt3ErIi1PVdOQegVMIhS3ggBiwHiwaGtFNtVsZ2JaAn15EgMz4A
 kZAVPugJniAxoC/ItcHtoNFtXlZG58fM8Ixgb94MmJApLYwKW/ah3Kesbp+2FXwIjsvH
 ETk08dNVIzIbTGD8R+mgV3aqQiEnoban8e09kZDu3uiebjZkzSgV2BhEx4S+Zyt+3+LH
 RrQQ==
X-Gm-Message-State: AOAM533WwUeG4ZPGBcz57ZsedltkrV2GDfU4/qen9qUr7BOC7UaQ5Mpe
 Is2htoHDhityFcNksReAl7HjYlL5r+kWu22pdaRNew==
X-Google-Smtp-Source: ABdhPJxe+N69yLZ01P7SKYrFtU+HLW34drGDN+erTrJ2h39C/3stVphQDQjtsWq75Gl0wDxTucOTk5Pd3fRtIaKwUU8=
X-Received: by 2002:a05:622a:209:: with SMTP id
 b9mr2775066qtx.136.1628134851882; 
 Wed, 04 Aug 2021 20:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210709033502.3545820-1-stevensd@google.com>
 <20210709033502.3545820-2-stevensd@google.com>
 <20210802133037.GB28547@willie-the-truck>
In-Reply-To: <20210802133037.GB28547@willie-the-truck>
From: David Stevens <stevensd@chromium.org>
Date: Thu, 5 Aug 2021 12:40:40 +0900
Message-ID: <CAD=HUj6BoCZ31Dd-jeWKKbmt-jSWXiS2ZLwrFg40FFdPm0y7cA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dma-iommu: fix sync_sg with swiotlb
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

On Mon, Aug 2, 2021 at 10:30 PM Will Deacon <will@kernel.org> wrote:
>
> On Fri, Jul 09, 2021 at 12:34:59PM +0900, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> >
> > The is_swiotlb_buffer function takes the physical address of the swiotlb
> > buffer, not the physical address of the original buffer. The sglist
> > contains the physical addresses of the original buffer, so for the
> > sync_sg functions to work properly when a bounce buffer might have been
> > used, we need to use iommu_iova_to_phys to look up the physical address.
> > This is what sync_single does, so call that function on each sglist
> > segment.
> >
> > The previous code mostly worked because swiotlb does the transfer on map
> > and unmap. However, any callers which use DMA_ATTR_SKIP_CPU_SYNC with
> > sglists or which call sync_sg would not have had anything copied to the
> > bounce buffer.
> >
> > Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > ---
> >  drivers/iommu/dma-iommu.c | 26 +++++++++++++-------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 7bcdd1205535..eac65302439e 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -811,14 +811,14 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
> >       if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
> >               return;
> >
> > -     for_each_sg(sgl, sg, nelems, i) {
> > -             if (!dev_is_dma_coherent(dev))
> > -                     arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
> > -
> > -             if (is_swiotlb_buffer(sg_phys(sg)))
> > +     if (dev_is_untrusted(dev))
> > +             for_each_sg(sgl, sg, nelems, i)
> > +                     iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
> > +                                                   sg->length, dir);
> > +     else
> > +             for_each_sg(sgl, sg, nelems, i)
> >                       swiotlb_sync_single_for_cpu(dev, sg_phys(sg),
> >                                                   sg->length, dir);
>
> Doesn't this skip arch_sync_dma_for_cpu() for non-coherent trusted devices?

Whoops, this was supposed to be a call to arch_sync_dma_for_cpu, not
to swiotlb_sync_single_for_cpu. Similar to the sync_sg_for_device
case.

> Why not skip the extra dev_is_untrusted(dev) call here and just call
> iommu_dma_sync_single_for_cpu() for each entry regardless?

iommu_dma_sync_single_for_cpu calls iommu_iova_to_phys to translate
the dma_addr_t to a phys_addr_t. Since the physical address is readily
available, I think it's better to avoid that extra work.

> Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
