Return-Path: <SRS0=v9UM=BK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3088C433E0
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 11:18:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E1322CA1
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 11:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CPUzWXJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E1322CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 45C738696D;
	Fri, 31 Jul 2020 11:18:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vZh8oJbr57Ps; Fri, 31 Jul 2020 11:18:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3C5FA8697E;
	Fri, 31 Jul 2020 11:18:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 151A0C0050;
	Fri, 31 Jul 2020 11:18:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 989B5C004D
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 11:18:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8137D886F0
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 11:18:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mNnkOuB9HM0m for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 11:18:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 314138873F
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 11:18:16 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id f7so27680706wrw.1
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 04:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Zq7nLTYSaqh1rrvxGbwcRVUElcSRubeGcO/5MNSrjwA=;
 b=CPUzWXJNQiA07ZGwgZXO+yJ+G5p111Ya3cj2o/NdaIIPCKveW2GuLoxyAD5TAWIBF4
 WlXznc24tEjSHvezA5c2GlUcPbwIhpBTcl4CCGt1fi8WBFKCSiGddb1TOoOdGKk6I7qR
 DfIpJYjrwnAde1up1JA4MBxg19M1dzjXoUb2pROvNrK6GzZL45fAuK8VMHFyviU2Bj1X
 gtXIvYVCHEJ0dZ6Z3OZgC+EmUZJMTB1n7OjLMWQRb0emqmccIdieW1rjewN+TcNagIDg
 5K1p4NApziSG4IabrQ1c67YGOiEzfKR2dFMZHuQRQ4+QeOCZ30XyG/f9kglC75bsKF/v
 6yGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Zq7nLTYSaqh1rrvxGbwcRVUElcSRubeGcO/5MNSrjwA=;
 b=cPN1F6fvwqZ2qq5XMtmE+npd/yijtveGyjwJZNCs3244VKSsmTmF9erFFiKqvaD4fH
 UreD5JdrbZlRbBiEHPbNSDXrdbQMzHpgztqvpfujiLf7I9Z1zxLYlaeVQuHx5B+lkQzv
 gfivd7gEufHvUYMkUJO0Q1xcSZn/cFyk13TMq6lfKJd6PeBow5mV6GZ4U+TreQwV/Vjo
 gBSNSeolRUFJNqqpAVg84NE/Q4vA235UxPkVvVLRCdRbCbA4w5zquwQTiWlyNFnuqoem
 zp51GQKzp9FdYbZ8JST4nBIootWRKtu7ebC7orj2WanJWXD7gBHrIe47CTy8Q+boFeUX
 lS5g==
X-Gm-Message-State: AOAM531JRFZuwqObrgmOzFE4nB9Jm2ZlokGGtQp1YVn6TleNFNOlw6kQ
 KRLUXJcXGqDIOnyFwZYKjstkrBpXV+nV9oXxHbHb4g==
X-Google-Smtp-Source: ABdhPJyww2gqtwBfMwM6EIclXjkBriA8zXp8tnobd541LUIeQfCM2Sl/8CNWPKWA4UIdzxJWjFeTDloC1IdSAxyiQwU=
X-Received: by 2002:adf:d84f:: with SMTP id k15mr2963979wrl.176.1596194293537; 
 Fri, 31 Jul 2020 04:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200728104742.422960-1-hch@lst.de>
 <CAMi1Hd3=6ZZykF1yx_CChqx71k6T-wj12TzJiz_uJZbwrEtTXw@mail.gmail.com>
 <20200728120716.GA2507@lst.de>
 <CAMi1Hd1c3cNMYg+S5Pwuv30QCdcWJw+QxkWmNP34s3nb+_yUuA@mail.gmail.com>
 <20200728124114.GA4865@lst.de>
 <CAMi1Hd0wpcLVJ41h6gs4H0WEDVpNEs7N=wx+KQ_yRKeSv0kQ9g@mail.gmail.com>
 <20200728153055.GA16701@lst.de>
 <18a3b93cc5ba3e0e39ae1b14759ce31121d54045.camel@suse.de>
 <CAMi1Hd3QNtZVEFUgDprT==wcVHKv6TsvpT3RurVJTDb1op2LnA@mail.gmail.com>
 <a0c8eb70cedb05e310c2957a1c0f7968c1e39d53.camel@suse.de>
In-Reply-To: <a0c8eb70cedb05e310c2957a1c0f7968c1e39d53.camel@suse.de>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Fri, 31 Jul 2020 16:47:37 +0530
Message-ID: <CAMi1Hd10=vZez7KhJYR688b9j-Sv6AM8EEDW8b8inYDXQk+6wg@mail.gmail.com>
Subject: Re: dma-pool fixes
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: jeremy.linton@arm.com, iommu@lists.linux-foundation.org,
 linux-rpi-kernel@lists.infradead.org, David Rientjes <rientjes@google.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Fri, 31 Jul 2020 at 16:17, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Hi Amit,
>
> On Wed, 2020-07-29 at 17:52 +0530, Amit Pundir wrote:
> > On Wed, 29 Jul 2020 at 16:15, Nicolas Saenz Julienne
> > <nsaenzjulienne@suse.de> wrote:
> > > On Tue, 2020-07-28 at 17:30 +0200, Christoph Hellwig wrote:
> > > > On Tue, Jul 28, 2020 at 06:18:41PM +0530, Amit Pundir wrote:
> > > > > > Oh well, this leaves me confused again.  It looks like your setup
> > > > > > really needs a CMA in zone normal for the dma or dma32 pool.
> > > > >
> > > > > Anything I should look up in the downstream kernel/dts?
> > > >
> > > > I don't have a good idea right now.  Nicolas, can you think of something
> > > > else?
> > >
> > > To summarise, the device is:
> > >  - Using the dma-direct code path.
> > >  - Requesting ZONE_DMA memory to then fail when provided memory falls in
> > >    ZONE_DMA. Actually, the only acceptable memory comes from CMA, which is
> > >    located topmost of the 4GB boundary.
> > >
> > > My wild guess is that we may be abusing an iommu identity mapping setup by
> > > firmware.
> > >
> > > That said, what would be helpful to me is to find out the troublesome device.
> > > Amit, could you try adding this patch along with Christoph's modified series
> > > (so the board boots). Ultimately DMA atomic allocations are not that common, so
> > > we should get only a few hits:
> >
> > Hi, still not hitting dma_alloc_from_pool().
>
> Sorry I insisted, but not hitting the atomic path makes the issue even harder
> to understand.

No worries. I was more concerned about not following the instructions
correctly. Thank you for looking into this issue.

>
> > I hit the following direct alloc path only once, at starting:
> >
> > dma_alloc_coherent ()
> > -> dma_alloc_attrs()
> >    -> dma_is_direct() -> dma_direct_alloc()
> >       -> dma_direct_alloc_pages()
> >          -> dma_should_alloc_from_pool() #returns FALSE from here
> >
> > After that I'm hitting following iommu dma alloc path all the time:
> >
> > dma_alloc_coherent()
> > -> dma_alloc_attrs()
> >    -> (ops->alloc) -> iommu_dma_alloc()
> >       -> iommu_dma_alloc_remap() #always returns from here
> >
> > So dma_alloc_from_pool() is not getting called at all in either of the
> > above cases.
>
> Ok, so lets see who's doing what and with what constraints:

Here is the relevant dmesg log: https://pastebin.ubuntu.com/p/dh3pPnxS2v/

Regards,
Amit Pundir

>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 4959f5df21bd..d28b3e4b91d3 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -594,6 +594,9 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
>         dma_addr_t iova;
>         void *vaddr;
>
> +       dev_info(dev, "%s, bus_dma_limit %llx, dma_mask %llx, coherent_dma_mask %llx, in irq %lu, size %lu, gfp %x, attrs %lx\n",
> +                __func__, dev->bus_dma_limit, *dev->dma_mask, dev->coherent_dma_mask, in_interrupt(), size, gfp, attrs);
> +
>         *dma_handle = DMA_MAPPING_ERROR;
>
>         if (unlikely(iommu_dma_deferred_attach(dev, domain)))
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index bb0041e99659..e5474e709e7b 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -160,6 +160,9 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>
>         size = PAGE_ALIGN(size);
>
> +       dev_info(dev, "%s, bus_dma_limit %llx, dma_mask %llx, coherent_dma_mask %llx, in irq %lu, size %lu, gfp %x, attrs %lx\n",
> +                __func__, dev->bus_dma_limit, *dev->dma_mask, dev->coherent_dma_mask, in_interrupt(), size, gfp, attrs);
> +
>         if (dma_should_alloc_from_pool(dev, gfp, attrs)) {
>                 ret = dma_alloc_from_pool(dev, size, &page, gfp);
>                 if (!ret)
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
