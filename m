Return-Path: <SRS0=v9UM=BK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEB7C433E0
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 07:47:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A743F2067D
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 07:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l32v6yZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A743F2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7BBFB86A14;
	Fri, 31 Jul 2020 07:47:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CHePTrxEHHHZ; Fri, 31 Jul 2020 07:47:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CCC7D869EC;
	Fri, 31 Jul 2020 07:47:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DF94C0050;
	Fri, 31 Jul 2020 07:47:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 644CCC004D
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 07:47:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 60196885E0
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 07:47:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5iDXLayr9XiH for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 07:47:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3C63587D5C
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 07:47:13 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id a5so17122221wrm.6
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 00:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wu3wJf9K0DWQl4leJgHngVJ9Xd8sy6hRU6+xzAR/K7o=;
 b=l32v6yZDnw0WBZpjX89lZKOhYxiFF/BBw3cxWvQ/lfLXz/ynZwzhhgAYOYtsX3nvD2
 kvTxppcB5Bwdq0MyLT9WZ7S3VBqA74SEy8lcwjE3xTdCmvg1qRoIEIBch7megDwzbyoK
 ubCLse+grwqKWwpXgyUGi0fGM/iyJ8D5D0iGWN5MUUY+cujqRKsEzjE00nXJQbwE5B4P
 XuPa56rtH14igtLP/y3IKKHZgPzK4c7YuKVheWEJ5SaU6NCWtOQFSTp1mdklmzBxP0AC
 8/ezRhVNDaXpF5cWuMgmADbnze/E62BDfHv2lIWKog4qoLIoZ1cea+rOF39A4lBchWOC
 79HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wu3wJf9K0DWQl4leJgHngVJ9Xd8sy6hRU6+xzAR/K7o=;
 b=TYa02531lvGQkHrmXmLBvkn0wKysI2Q+X+uaXs65yqCKziV3ShxXmItTSZ8VHfJbDo
 q67ZDyDjJOii3ZCT+aaPvGEro2cLYybqv+mGzJfF7b9DMTmM9D0VB5qedR9/7cO43RZo
 wi5waBrXDnmT70vAfA+5Eoysxu0FJhnAT5v8zyFj+DhTPwKRjLEX5Q4DdXfBkGM61uur
 YbolNm816AKu9p4yyh7A4khdoe6AmTLlpWBCV8qNHwmh9DJmXUHlwL3d5gahyr7HR0mo
 6vRqzz9HyiAV3v/UmqLENGroLHP8vH0HHxAnQDrzD9cLGP4o9aQvJiwA4cJ3RAp2smm3
 pHMg==
X-Gm-Message-State: AOAM5326zWX9GUvXUytMPKj6ilY/ELzjQ2KZDnGctCBKHkH5D+V4CqiM
 L8ruJ9CQG+6xJ5ZLywTpkOcc5khap1fPBhhYDFsgLw==
X-Google-Smtp-Source: ABdhPJyUqXt1trRbSV6cVaUn1DwFxnl5e0/fJduUkRzFYxNi168QzG/tko3l3vTm9v+17sy6kjbXV5UHtWDBmeoGtvo=
X-Received: by 2002:adf:9ec1:: with SMTP id b1mr2249468wrf.171.1596181631517; 
 Fri, 31 Jul 2020 00:47:11 -0700 (PDT)
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
In-Reply-To: <CAMi1Hd3QNtZVEFUgDprT==wcVHKv6TsvpT3RurVJTDb1op2LnA@mail.gmail.com>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Fri, 31 Jul 2020 13:16:34 +0530
Message-ID: <CAMi1Hd09EbzOgTU5P4EDS8BQ6J2jFntvyR49BePyAqJ15DBB0Q@mail.gmail.com>
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

On Wed, 29 Jul 2020 at 17:52, Amit Pundir <amit.pundir@linaro.org> wrote:
>
> On Wed, 29 Jul 2020 at 16:15, Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> >
> > On Tue, 2020-07-28 at 17:30 +0200, Christoph Hellwig wrote:
> > > On Tue, Jul 28, 2020 at 06:18:41PM +0530, Amit Pundir wrote:
> > > > > Oh well, this leaves me confused again.  It looks like your setup
> > > > > really needs a CMA in zone normal for the dma or dma32 pool.
> > > >
> > > > Anything I should look up in the downstream kernel/dts?
> > >
> > > I don't have a good idea right now.  Nicolas, can you think of something
> > > else?
> >
> > To summarise, the device is:
> >  - Using the dma-direct code path.
> >  - Requesting ZONE_DMA memory to then fail when provided memory falls in
> >    ZONE_DMA. Actually, the only acceptable memory comes from CMA, which is
> >    located topmost of the 4GB boundary.
> >
> > My wild guess is that we may be abusing an iommu identity mapping setup by
> > firmware.
> >

Hi Nicolas, Christoph,

Just out of curiosity, I'm wondering if we can restore the earlier
behaviour and make DMA atomic allocation configured thru platform
specific device tree instead?

Or if you can allow a more hackish approach to restore the earlier
logic, using of_machine_is_compatible() just for my device for the
time being. Meanwhile I'm checking with other developers running the
mainline kernel on sdm845 phones like OnePlus 6/6T, if they see this
issue too.

Regards,
Amit Pundir

> > That said, what would be helpful to me is to find out the troublesome device.
> > Amit, could you try adding this patch along with Christoph's modified series
> > (so the board boots). Ultimately DMA atomic allocations are not that common, so
> > we should get only a few hits:
>
> Hi, still not hitting dma_alloc_from_pool().
>
> I hit the following direct alloc path only once, at starting:
>
> dma_alloc_coherent ()
> -> dma_alloc_attrs()
>    -> dma_is_direct() -> dma_direct_alloc()
>       -> dma_direct_alloc_pages()
>          -> dma_should_alloc_from_pool() #returns FALSE from here
>
> After that I'm hitting following iommu dma alloc path all the time:
>
> dma_alloc_coherent()
> -> dma_alloc_attrs()
>    -> (ops->alloc) -> iommu_dma_alloc()
>       -> iommu_dma_alloc_remap() #always returns from here
>
> So dma_alloc_from_pool() is not getting called at all in either of the
> above cases.
>
> >
> > diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> > index 83fda1039493..de93fce6d5d2 100644
> > --- a/kernel/dma/pool.c
> > +++ b/kernel/dma/pool.c
> > @@ -276,8 +276,11 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
> >         while ((pool = dma_guess_pool(pool, gfp))) {
> >                 page = __dma_alloc_from_pool(dev, size, pool, cpu_addr,
> >                                              phys_addr_ok);
> > -               if (page)
> > +               if (page) {
> > +                       dev_err(dev, "%s: phys addr 0x%llx, size %lu, dev->coherent_dma_mask 0x%llx, dev->bus_dma_limit 0x%llx\n",
> > +                               __func__, (phys_addr_t)*cpu_addr, size, dev->coherent_dma_mask, dev->bus_dma_limit);
> >                         return page;
> > +               }
> >         }
> >
> >         WARN(1, "Failed to get suitable pool for %s\n", dev_name(dev));
> >
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
