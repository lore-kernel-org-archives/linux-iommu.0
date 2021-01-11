Return-Path: <SRS0=1kRO=GO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B88C433DB
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 18:39:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 621072250E
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 18:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621072250E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D4353870F6;
	Mon, 11 Jan 2021 18:39:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XREJak4crG6Q; Mon, 11 Jan 2021 18:39:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3445086221;
	Mon, 11 Jan 2021 18:39:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16AABC088B;
	Mon, 11 Jan 2021 18:39:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8861DC013A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 18:03:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 64D6A227AA
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 18:03:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zg61FY7uVg61 for <iommu@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 18:03:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by silver.osuosl.org (Postfix) with ESMTPS id F117E204DC
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 18:03:37 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id 91so707866wrj.7
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 10:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OQ88+LI5HEr8LP9MECKHb0an/ILY1uHLC7MWc4xKUSQ=;
 b=nCV1ZS4fAU6hFngRbC7jkRKIcsqPejpew4BRdQ4Ly13ypD++QeZmnDPhiU/2zSCw9+
 Yw7jZGzmxtGbszhlZ7gehioXAMjzXypa6avlszOWtWRD5TWhsSiyX35H2teoKthN/ui7
 FVrSPZ4/XeoXWDQS/byVZYdAJEjkdbdPwGIcM353b45f6urb2PimnhEhz9b+CsXbnx+c
 sLXiNwVrm1OcQG4wBdhbBUOPlsIKUTsNFjPPkYNMBaL7Dv981SGRsghzVSVED+fLBYvr
 N68wnXnivV/CmoxkQ/3xrBdU+nLPuHiJa2WEof02BjcSTON0Afo90YapNzD/LluttZfy
 enDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OQ88+LI5HEr8LP9MECKHb0an/ILY1uHLC7MWc4xKUSQ=;
 b=bKwwyMceTuZ56Y7/YQZ2eKFTzOhLWmDWTz96VuRaDwuQaPGps1SH76E5920g5rXKUP
 G2hhOdSg2SEl5uAHVb6NzEr1a6qm3G2UrgXs1sHDjtVPLKO3ezpiZ9mUz2HfPlpBvgJR
 2S5zxYVm14FsCdZe9DCUrCF2j1GLTCV2i8QgqOVkDAXGhOMNnmFraCqw6UyMtskngp2I
 u+KFozrPiPn7F1YbMwaDH8+oFSr/fWxEB825qqIvgmEGk8leqWkMGXdLdCQW2ifb6RPJ
 nAvFEJNZsX6M38z9S9zfeG8yAZQ4tKes4rcc8ryND9ug2DUBEtlsL/pKsAQCv7P2bADK
 ESgQ==
X-Gm-Message-State: AOAM530OSN3EOvDSgDfQHFRwi5mWBcsvGYbnprwGYdgY7IK3Q3EY5dV/
 SCyFxYgLfMlpuie7MNpjrU9YIATn1e9jQUS4G9m7+Q==
X-Google-Smtp-Source: ABdhPJzsKB2S8tXBu6i5PVjW2kuyXdlPhHhTEht6hD50Xozy9RUpd2RVduyv0+3+XkChb7CKfLEXBKj0UQa8VJy/PqY=
X-Received: by 2002:a5d:5604:: with SMTP id l4mr311015wrv.127.1610388216078;
 Mon, 11 Jan 2021 10:03:36 -0800 (PST)
MIME-Version: 1.0
References: <20210111154335.23388-1-marcorr@google.com>
 <dc6db6b4-88f1-4762-bd3b-edf3dd410366@arm.com>
In-Reply-To: <dc6db6b4-88f1-4762-bd3b-edf3dd410366@arm.com>
Date: Mon, 11 Jan 2021 10:03:24 -0800
Message-ID: <CAA03e5HLN_iPzXRTJ_Dvx5h8KP-Qi+=6u+9mHnaoB9oBMMWs7Q@mail.gmail.com>
Subject: Re: [PATCH] dma: mark unmapped DMA scatter/gather invalid
To: Robin Murphy <robin.murphy@arm.com>
X-Mailman-Approved-At: Mon, 11 Jan 2021 18:39:13 +0000
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jianxiong Gao <jxgao@google.com>, hch@lst.de
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
From: Marc Orr via iommu <iommu@lists.linux-foundation.org>
Reply-To: Marc Orr <marcorr@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> On 2021-01-11 15:43, Marc Orr wrote:

minus stable@vger.kernel.org, per gregkh@'s email.

> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 0a4881e59aa7..3d9b17fe5771 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -374,9 +374,11 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
> >       struct scatterlist *sg;
> >       int i;
> >
> > -     for_each_sg(sgl, sg, nents, i)
> > +     for_each_sg(sgl, sg, nents, i) {
> >               dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
> >                            attrs);
> > +             sg->dma_address = DMA_MAPPING_ERROR;
>
> There are more DMA API backends than just dma-direct, so while this
> might help paper over bugs when SWIOTLB is in use, it's not going to
> have any effect when those same bugs are hit under other circumstances.
> Once again, the moral of the story is that effort is better spent just
> fixing the bugs ;)

Thanks for the quick feedback. What is the correct fix? I understand
the first half. The NVMe driver should be updated to not call unmap on
an address that has already been unmapped within the DMA direct code.
Where I'm less certain is how to communicate to the NVMe driver that
the mapping failed. In particular, the NVMe code explicitly checks if
the first DMA address in the scatter/gather list is set to
DMA_MAPPING_ERROR. Thus, don't we need to update the DMA direct code
to propagate DMA_MAPPING_ERROR back up to the driver, via the
scatter/gather struct?

I skimmed arch/arm/mm/dma-mapping.c, just now. I can see that this
code sets the address within the scatter/gather struct to
DMA_MAPPING_ERROR before trying to map an IO address and write it into
the struct. Is this a good example to follow?

Thanks,
Marc
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
