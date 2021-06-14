Return-Path: <SRS0=DplC=LI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA62C4743C
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 10:08:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83F5E61055
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 10:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F5E61055
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 45F0C40169;
	Mon, 14 Jun 2021 10:08:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7mHhd7LNSaxz; Mon, 14 Jun 2021 10:08:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 204D4400D4;
	Mon, 14 Jun 2021 10:08:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0EC7C000E;
	Mon, 14 Jun 2021 10:08:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32BE0C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 10:08:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1516B40168
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 10:08:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R5awdGTQS1hq for <iommu@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 10:08:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 34FF6400D4
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 10:08:24 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 y18-20020a4ae7120000b02902496b7708cfso2506485oou.9
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 03:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2VU+I2JY7nagoQJLZQjBNcNIb1qYx8IdZde11I0FLps=;
 b=rNjbdGE1R6371RlbKuw0VPLhk0hVt+tVCRj+HwZIWyGIyJmhmjaOFD7SKz++9Kx4gX
 bikuCAeXdr5XAPh2pkrHHoQwlPN9xvxMdPaA6yopfD9r7KAoh7yqVpRELa+nqS5J4tC3
 QegydvRCFFQ3nrKsJEaU2V0YPw1gZyK6Tmiydu7JlsvaqicIg1Bod1OVmLcMmIlxhCbQ
 4s0rJ2G1wmaxFcM1kHGmd82ABBRgRm3JmCE0y+H06KHrL5budfoXvEmJ5baAODQr1o8U
 ColYeKSuvr0YztdKM/VPSsIObiebDsbu0cmjc8sxCk2n4mckaoh68/wyNibGa85Bk5IP
 VXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2VU+I2JY7nagoQJLZQjBNcNIb1qYx8IdZde11I0FLps=;
 b=sv4K/BbUnSgHjjD/BfuZZ+c3NmszJYuuqWiZVkn8zYIHvHGeaBHbR0gLF0czajtRNC
 /ZNe4E5MYRZkMp3Spfr6IrODKkmmUWyzNsE73zMXOU/Qh1c1vV/8aeJg3CMe7THEcKDj
 u97K9X/1rNUkvObgx0fx78McWUV4nirLhZyx4bg7umJOZvaNrUq2rUrXkrFobKk1kwyV
 Z2SH8PCA0Q6tZf7tGj49V/MEC7D6FhV2VnyWSt5LJLIOVVConciQA9u4GQ+/V5lxsciD
 bNSz5Znre4/n9v0sv9zORV93Mchh6H8W5YuafZqfDuIoga9rheN8CSnPAMivcL+W2CxT
 ho4Q==
X-Gm-Message-State: AOAM530zkTUBErFs2oucTIkiQkoneWROIWYOs3yOkpFw2J5sZmythVCw
 j87PlBDGhrX8TFx19KQZG6w2VggSglwj7bwZIek=
X-Google-Smtp-Source: ABdhPJzT94HAfh7KH1qNLSmqXHnVlpNeuigsQEcfaynhB2GlcMTV+2U8AmlyonkjfOjKcDdy570egAaH81rScRC+Ydg=
X-Received: by 2002:a4a:e887:: with SMTP id g7mr12530141ooe.64.1623665303198; 
 Mon, 14 Jun 2021 03:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210611131056.3731084-1-aisheng.dong@nxp.com>
 <20210614083609.GA18701@willie-the-truck>
In-Reply-To: <20210614083609.GA18701@willie-the-truck>
From: Dong Aisheng <dongas86@gmail.com>
Date: Mon, 14 Jun 2021 18:07:04 +0800
Message-ID: <CAA+hA=S8x4S0sgAiJbqOC-wgtOshV_jhAq6eVqX5-EAeg3Dczg@mail.gmail.com>
Subject: Re: [PATCH 1/1] dma: coherent: check no-map property for arm64
To: Will Deacon <will@kernel.org>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

Hi Will,

On Mon, Jun 14, 2021 at 4:36 PM Will Deacon <will@kernel.org> wrote:
>
> [+Catalin]
>
> On Fri, Jun 11, 2021 at 09:10:56PM +0800, Dong Aisheng wrote:
> > Coherent dma on ARM64 also can't work with mapped system ram,
> > that means 'no-map' property must be specified in dts.
> > Add the missing check for ARM64 platforms as well.
> > Besides 'no-map' checking, 'linux,dma-default' feature is also
> > enabled for ARM64 along with this patch.
>
> Please can you explain _why_ it can't work? We don't need to tear down
> aliases from the linear map for the streaming DMA API, so why is this
> case different? Also, coherent devices wouldn't need this either way,
> would they? What problem are you solving here?
>

Not sure if i get your point correctly. Here is my understanding. (fix
me if wrong)
In current implementation, the coherent dma memory will be remapped as
writecombine and uncached type which can't reuse the linear mapping.
The prerequisite to do this is the memory must not be mapped System RAM.
e.g. reserved memory with no-map property and invisible to the buddy system.

This seems a little different from CMA which the memory is still
underlying managed
by the buddy system in order to support migration.

The patch here does not resolve a real issue but just open the sanity check for
ARM64 case as well as ARM  which reports the issue a little bit earlier at
rmem_dma_setup() time.

Regards
Aisheng

> Thanks,
>
> Will
>
> >
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  kernel/dma/coherent.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
> > index 5b5b6c7ec7f2..d1831da7afba 100644
> > --- a/kernel/dma/coherent.c
> > +++ b/kernel/dma/coherent.c
> > @@ -356,7 +356,7 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
> >       if (of_get_flat_dt_prop(node, "reusable", NULL))
> >               return -EINVAL;
> >
> > -#ifdef CONFIG_ARM
> > +#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
> >       if (!of_get_flat_dt_prop(node, "no-map", NULL)) {
> >               pr_err("Reserved memory: regions without no-map are not yet supported\n");
> >               return -EINVAL;
> > --
> > 2.25.1
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
