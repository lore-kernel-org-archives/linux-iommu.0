Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F786C433EF
	for <iommu@archiver.kernel.org>; Thu, 25 Nov 2021 07:36:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29B00608DD;
	Thu, 25 Nov 2021 07:36:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ApNzGVEG4Zxe; Thu, 25 Nov 2021 07:36:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E6B1C608CD;
	Thu, 25 Nov 2021 07:36:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B176CC002F;
	Thu, 25 Nov 2021 07:36:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CB5EC000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Nov 2021 07:36:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 074FD608CD
 for <iommu@lists.linux-foundation.org>; Thu, 25 Nov 2021 07:36:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qg811MKYsTaB for <iommu@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:35:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DFB546086D
 for <iommu@lists.linux-foundation.org>; Thu, 25 Nov 2021 07:35:58 +0000 (UTC)
Received: by mail-qt1-x833.google.com with SMTP id m25so5292128qtq.13
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 23:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KNC33UOfOEobGSH4D2BAGe1O2xKscv36EvgOg4IHB58=;
 b=Rpw/69UAWSNd8StTv2nscHlaIMcTUiobMTp+ftwkGCsaQtyLxOr7gGSWKoYZgshUWk
 ewf72wr6GPbS5wtHpXlTgrhNhl+T97U/m5QPSD6tac5ZJR/aUUYbszs5FGZgW4ncfiBa
 +MrtrH9UwcSQcT3C6GtR9iK8GlmmoOJ45yoDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KNC33UOfOEobGSH4D2BAGe1O2xKscv36EvgOg4IHB58=;
 b=ZvQI8Ga3u+ak/V/+UacKHduMtsd9qdVg2X52DElneLi7wyDEALsbmrpoWJdAsLllIi
 GWTkjADZfaMfoJh1lpaoaQTyUR4KG6pjGQ+Xi/qZcEivwNCGtPl2ODRJTWZB1ijskW0I
 AAyQGDcKREj+GCym8rm0orBXqkz7LmaKsaNPMVLTizRI7abJW+yQ06ph/AD9fT4tRp0y
 RLbq8rYtcyKOroVCqBjJcILn1IIVpv0c2Lv47YLA1WLHZHmJsPRxwb/g/jhCKRkPN3JM
 ZXnjqnRDeU1O/kbHl5qxP6PEZO3K/jVc8x7mB13JmwjN/qztoFEY8dpQhNFW9rICXPJS
 dFjQ==
X-Gm-Message-State: AOAM5307PyIqIlFl2R7WnSlYUBPKwYhmCDHqvYi8nuuwgydi9q5fMH4A
 UJo4d3QRxgl32qSvs+SxBGp194k/9e3Qtg==
X-Google-Smtp-Source: ABdhPJy1UIb0YOwV312s5f6lzKy5QZt56aTQu69qKZUx4hbVavzK9OOrKJ0G+Ekhmfs9BqlA44GnLA==
X-Received: by 2002:ac8:5b87:: with SMTP id a7mr14663338qta.196.1637825757481; 
 Wed, 24 Nov 2021 23:35:57 -0800 (PST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com.
 [209.85.222.170])
 by smtp.gmail.com with ESMTPSA id z4sm1109762qtj.42.2021.11.24.23.35.56
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Nov 2021 23:35:56 -0800 (PST)
Received: by mail-qk1-f170.google.com with SMTP id m186so9883301qkb.4
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 23:35:56 -0800 (PST)
X-Received: by 2002:a25:ccd0:: with SMTP id l199mr4122013ybf.39.1637825755668; 
 Wed, 24 Nov 2021 23:35:55 -0800 (PST)
MIME-Version: 1.0
References: <20211123112104.3530135-1-hsinyi@chromium.org>
 <75ea1026-63e5-165a-9e07-27b5ac4c7579@arm.com>
In-Reply-To: <75ea1026-63e5-165a-9e07-27b5ac4c7579@arm.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 25 Nov 2021 16:35:43 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AA3XCqxOSdQOOCMEdByDKRz5J9vWB0QghO2SSCqOvQBQ@mail.gmail.com>
Message-ID: <CAAFQd5AA3XCqxOSdQOOCMEdByDKRz5J9vWB0QghO2SSCqOvQBQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Allow restricted-dma-pool to customize IO_TLB_SEGSIZE
To: Robin Murphy <robin.murphy@arm.com>
Cc: devicetree@vger.kernel.org, - <devicetree-spec@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 senozhatsky@chromium.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Maxime Ripard <maxime@cerno.tech>, Hsin-Yi Wang <hsinyi@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

Hi Robin,

On Tue, Nov 23, 2021 at 8:59 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-11-23 11:21, Hsin-Yi Wang wrote:
> > Default IO_TLB_SEGSIZE (128) slabs may be not enough for some use cases.
> > This series adds support to customize io_tlb_segsize for each
> > restricted-dma-pool.
> >
> > Example use case:
> >
> > mtk-isp drivers[1] are controlled by mtk-scp[2] and allocate memory through
> > mtk-scp. In order to use the noncontiguous DMA API[3], we need to use
> > the swiotlb pool. mtk-scp needs to allocate memory with 2560 slabs.
> > mtk-isp drivers also needs to allocate memory with 200+ slabs. Both are
> > larger than the default IO_TLB_SEGSIZE (128) slabs.
>
> Are drivers really doing streaming DMA mappings that large? If so, that
> seems like it might be worth trying to address in its own right for the
> sake of efficiency - allocating ~5MB of memory twice and copying it back
> and forth doesn't sound like the ideal thing to do.
>
> If it's really about coherent DMA buffer allocation, I thought the plan
> was that devices which expect to use a significant amount and/or size of
> coherent buffers would continue to use a shared-dma-pool for that? It's
> still what the binding implies. My understanding was that
> swiotlb_alloc() is mostly just a fallback for the sake of drivers which
> mostly do streaming DMA but may allocate a handful of pages worth of
> coherent buffers here and there. Certainly looking at the mtk_scp
> driver, that seems like it shouldn't be going anywhere near SWIOTLB at all.

First, thanks a lot for taking a look at this patch series.

The drivers would do streaming DMA within a reserved region that is
the only memory accessible to them for security reasons. This seems to
exactly match the definition of the restricted pool as merged
recently.

The new dma_alloc_noncontiguous() API would allow allocating suitable
memory directly from the pool, which would eliminate the need to copy.
However, for a restricted pool, this would exercise the SWIOTLB
allocator, which currently suffers from the limitation as described by
Hsin-Yi. Since the allocator in general is quite general purpose and
already used for coherent allocations as per the current restricted
pool implementation, I think it indeed makes sense to lift the
limitation, rather than trying to come up with yet another thing.

Best regards,
Tomasz

>
> Robin.
>
> > [1] (not in upstream) https://patchwork.kernel.org/project/linux-media/cover/20190611035344.29814-1-jungo.lin@mediatek.com/
> > [2] https://elixir.bootlin.com/linux/latest/source/drivers/remoteproc/mtk_scp.c
> > [3] https://patchwork.kernel.org/project/linux-media/cover/20210909112430.61243-1-senozhatsky@chromium.org/
> >
> > Hsin-Yi Wang (3):
> >    dma: swiotlb: Allow restricted-dma-pool to customize IO_TLB_SEGSIZE
> >    dt-bindings: Add io-tlb-segsize property for restricted-dma-pool
> >    arm64: dts: mt8183: use restricted swiotlb for scp mem
> >
> >   .../reserved-memory/shared-dma-pool.yaml      |  8 +++++
> >   .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  4 +--
> >   include/linux/swiotlb.h                       |  1 +
> >   kernel/dma/swiotlb.c                          | 34 ++++++++++++++-----
> >   4 files changed, 37 insertions(+), 10 deletions(-)
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
