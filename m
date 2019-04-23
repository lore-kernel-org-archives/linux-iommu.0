Return-Path: <SRS0=UFM6=SZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93ABC282DD
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 15:01:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 692E621773
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 15:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692E621773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2BE44EFA;
	Tue, 23 Apr 2019 15:01:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 43E70EF5
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 15:01:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ua1-f67.google.com (mail-ua1-f67.google.com
	[209.85.222.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 51D55F4
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 15:01:56 +0000 (UTC)
Received: by mail-ua1-f67.google.com with SMTP id b8so4870444uaq.7
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 08:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=UjKcQDchuiRrcdQ7wcg9oiUE5P+pgqbYSsnauAwr8CU=;
	b=kliZo1AG/ZIovQRUmqgr1/nBeNAs0FFe0MfCczwlO2a86C6Ksauujl/clsy8dCJ/7E
	vBBUIeKn/dbUrCK475W1ALugwbeTGeEFaYkI4aXHWBL25GGjxwsGwKma11a/bOqDhhcl
	Fbmb0xvWUzBgpdoSD8RRbxDXailD0mT7aIJZ/qvlsbmkDQVkpY8igVuMO0LBWr4eYO32
	5sbrZXn68ZZxo3zQX1a52RWxdJu6kd9PO2cMlFNSuTPy6F0yV2VI1qeLr9ilxFzjtcy5
	mCnKLOkOf3LaeJyxBpNloqzdUR1I8NQHYS0LrN0QeeCvwXiOdi+cL7vFHKGLWF1+H8a/
	Kgbw==
X-Gm-Message-State: APjAAAXNDWrqJ+VwSOg0nHzeNE43Sz7R164NFHHci4Rbvr6jYN7qozdt
	iG2uc+c1zgmwN343mAA2KkGGyQ6vfhg9AvAnvBo=
X-Google-Smtp-Source: APXvYqyK6XZDn6WHU0lafDyk+j0Bwmz5Fd1MzX0SG1EaZoHTo12JiitjmIbrukG4caSY8uDaMZKGV0J40RchVZfCyMQ=
X-Received: by 2002:ab0:6419:: with SMTP id x25mr13100402uao.86.1556031714469; 
	Tue, 23 Apr 2019 08:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190403182148.18058-1-geert+renesas@glider.be>
	<20190403182148.18058-2-geert+renesas@glider.be>
	<20190411081028.b2wf3nnzx4tw7xdr@verge.net.au>
	<20190411081214.pgdztqdlud5ta466@verge.net.au>
In-Reply-To: <20190411081214.pgdztqdlud5ta466@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Apr 2019 17:01:42 +0200
Message-ID:
 <CAMuHMdUXK_TKJuWwuJ0XCPNK-gQo1bY4OPGB674hH3nTc2hTxg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] iommu/ipmmu-vmsa: Link IOMMUs and devices in sysfs
To: Simon Horman <horms@verge.net.au>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <damm+renesas@opensource.se>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190423150142.UIrizzE5Qz2C89u4m65K7cys4Aqvfokhlt9HuyGcwkk@z>

Hi Simon,

On Thu, Apr 11, 2019 at 10:12 AM Simon Horman <horms@verge.net.au> wrote:
> On Thu, Apr 11, 2019 at 10:10:28AM +0200, Simon Horman wrote:
> > On Wed, Apr 03, 2019 at 08:21:43PM +0200, Geert Uytterhoeven wrote:
> > > As of commit 7af9a5fdb9e0ca33 ("iommu/ipmmu-vmsa: Use
> > > iommu_device_sysfs_add()/remove()"), IOMMU devices show up under
> > > /sys/class/iommus/, but their "devices" subdirectories are empty.
> >
> > Should the path be /sys/class/iommu/ (no trailing 's') ?

Yes it does, thanks. Will fix.

> > > Likewise, devices tied to an IOMMU do not have an "iommu" backlink.
> > >
> > > Make sure all links are created, on both arm32 and arm64.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > ---
> > > v2:
> > >   - Add Reviewed-by.
> > > ---
> > >  drivers/iommu/ipmmu-vmsa.c | 24 +++++++++++++++++-------
> > >  1 file changed, 17 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> > > index 9a380c10655e182d..9f2b781e20a0eba6 100644
> > > --- a/drivers/iommu/ipmmu-vmsa.c
> > > +++ b/drivers/iommu/ipmmu-vmsa.c
> > > @@ -885,27 +885,37 @@ static int ipmmu_init_arm_mapping(struct device *dev)
> > >
> > >  static int ipmmu_add_device(struct device *dev)
> > >  {
> > > +   struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
> > >     struct iommu_group *group;
> > > +   int ret;
> > >
> > >     /*
> > >      * Only let through devices that have been verified in xlate()
> > >      */
> > > -   if (!to_ipmmu(dev))
> > > +   if (!mmu)
> > >             return -ENODEV;
> > >
> > > -   if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA))
> > > -           return ipmmu_init_arm_mapping(dev);
> > > +   if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)) {
> > > +           ret = ipmmu_init_arm_mapping(dev);
> > > +           if (ret)
> > > +                   return ret;
> > > +   } else {
> > > +           group = iommu_group_get_for_dev(dev);
> > > +           if (IS_ERR(group))
> > > +                   return PTR_ERR(group);
> > >
> > > -   group = iommu_group_get_for_dev(dev);
> > > -   if (IS_ERR(group))
> > > -           return PTR_ERR(group);
> > > +           iommu_group_put(group);
> > > +   }
> > >
> > > -   iommu_group_put(group);
> > > +   iommu_device_link(&mmu->iommu, dev);
>
> Also, is there any value in propagating the return value
> of iommu_device_link() ?

I don't think so.  Sysfs information is not super-critical, and most
drivers just
ignore such return values.  Also, the sysfs cleanup code handles cleanup
after failed setup fine.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
