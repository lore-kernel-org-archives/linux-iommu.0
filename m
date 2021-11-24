Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A57C4332F
	for <iommu@archiver.kernel.org>; Wed, 24 Nov 2021 03:55:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 301EF80F2E;
	Wed, 24 Nov 2021 03:55:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c2mYjfizeVMw; Wed, 24 Nov 2021 03:55:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E857A80E7D;
	Wed, 24 Nov 2021 03:55:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8BE4C002E;
	Wed, 24 Nov 2021 03:55:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 044D6C0012
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 03:55:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EB67B40494
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 03:55:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mzXwRa4T2UGO for <iommu@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 03:55:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A35D340488
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 03:55:32 +0000 (UTC)
Received: by mail-il1-x135.google.com with SMTP id h16so346313ila.4
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 19:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/926FuVicfVC1nK0FVXtvbHMwYM36BbozQFkXoWswMk=;
 b=baWredfSFOMml8i0WHnqdj/WGSDAxeAgzkAmd1thTn9aNwNroqW+LAEdqtpecxvh+b
 tCXRUWrN47euOGjLHG7G3uJjFPwytNu/aK/96hIfHSB0xYg3UOLmBcTijw1YMNgbqG93
 r7Ua1tBOsOazX8ohB69fkXFcgQ1isqMA9u8bE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/926FuVicfVC1nK0FVXtvbHMwYM36BbozQFkXoWswMk=;
 b=xnAsQ1Nl3aHrist9nwRfRZNGFYYiI8JWZoqUW5Uxof+8ecFKeMW0YlQL52HiR2H2lb
 /y8JQRsVoHrmcqw7ZSLsQOhnvPPd4f4+6CUNdbQ981OhTEfpu+BiOTSdzk9y+PDbxSGx
 RS7LkCsmXQ5M7cJUeeZifk+tVP1JF65quW9/PC/HBNZOYBUSRnjuiqiE25Urex06cULS
 sD7nnpTg32ba3ksbl0s9CnDPsQxsRYu+l0BztUnfiAynUshNv3TMvPr8SM+9SLoQ9jW6
 Jp9Z0HX/fU0hs2K8iEgl+digE7DggxOjFVCRZaMOxsX1MrF6acnos5gHZpw19mN12B3o
 9qrA==
X-Gm-Message-State: AOAM533n4skPdOYOEp5lE6/f4g5k133E71R78ieGBmDmbpukEh5eZOhW
 xFmB4OODmo5aQeMuJyGQ4kj8oKT6dnYDrKkXikQGKQ==
X-Google-Smtp-Source: ABdhPJzWS1uYf8FWo45Cg3tq/AFpg6d/7sMCQWCP67g5+L5DT9Ag8Vsgz85lfPSTKmIcrxXnM+BisytQv2Zb2NcXTnM=
X-Received: by 2002:a05:6e02:1a63:: with SMTP id
 w3mr9334649ilv.230.1637726131600; 
 Tue, 23 Nov 2021 19:55:31 -0800 (PST)
MIME-Version: 1.0
References: <20211123112104.3530135-1-hsinyi@chromium.org>
 <75ea1026-63e5-165a-9e07-27b5ac4c7579@arm.com>
In-Reply-To: <75ea1026-63e5-165a-9e07-27b5ac4c7579@arm.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Wed, 24 Nov 2021 11:55:05 +0800
Message-ID: <CAJMQK-gHpmfedbRfR-1ZNLw0LpRDJHYoKLd-k3kvkqFf8vnD4A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Allow restricted-dma-pool to customize IO_TLB_SEGSIZE
To: Robin Murphy <robin.murphy@arm.com>
Cc: devicetree@vger.kernel.org, - <devicetree-spec@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 senozhatsky@chromium.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Maxime Ripard <maxime@cerno.tech>, Matthias Brugger <matthias.bgg@gmail.com>,
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

On Tue, Nov 23, 2021 at 7:58 PM Robin Murphy <robin.murphy@arm.com> wrote:
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
>
mtk_scp on its own can use the shared-dma-pool, which it currently uses.
The reason we switched to restricted-dma-pool is that we want to use
the noncontiguous DMA API for mtk-isp. The noncontiguous DMA API is
designed for devices with iommu, and if a device doesn't have an
iommu, it will fallback using swiotlb. But currently noncontiguous DMA
API doesn't work with the shared-dma-pool.

vb2_dc_alloc() -> dma_alloc_noncontiguous() -> alloc_single_sgt() ->
__dma_alloc_pages() -> dma_direct_alloc_pages() ->
__dma_direct_alloc_pages() -> swiotlb_alloc().


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
