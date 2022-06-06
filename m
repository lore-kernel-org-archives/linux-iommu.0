Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B825CCA482
	for <iommu@archiver.kernel.org>; Mon,  6 Jun 2022 15:00:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F02CF41655;
	Mon,  6 Jun 2022 15:00:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nIe8dsjZzVUi; Mon,  6 Jun 2022 15:00:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 779C9415A6;
	Mon,  6 Jun 2022 15:00:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C02DC0039;
	Mon,  6 Jun 2022 15:00:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5AF54C002D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 15:00:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 424FF40127
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 15:00:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CgqxzjtyKEOv for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 15:00:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C7857400E3
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 15:00:38 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B3CCBB81A84
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 15:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC324C341C6
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 15:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654527634;
 bh=tFvHiguChguydwXgPPk94DDRc3Gna/VqX+wPqkO+GTs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=OTdTyPoYJ5bNQJSkFPmXEY+eWfJAwSfsYSgk4cODU6UlwBWjeYnv0Sxuz9qV0iSQM
 shE15IXcfCEfv8Mx+p/2oCrRlPgIxb29Lqv+ZUjwFZNe4LdNbfrgVQtNqfyVVnq8bi
 XXptqX4w9uja7FnAnfusW3dxnevauNzz6jq5hzXcmY+3JqZZyKCwbuEiefqMgnxCHt
 T0oumu3+Q5kYXm0Mn9+i87nfTx/T4bJLwOfqVC2aNx8tOMfbYaNABmt4DoR4wkLm1J
 PB4SHhF3GrdL+mEGCiRj9gV6ZRpnlaKARAORIAFsT5McazycsfBDejvPwC+ypF73Lz
 0VIsuzIGYeRKg==
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-30fa61b1a83so140304057b3.0
 for <iommu@lists.linux-foundation.org>; Mon, 06 Jun 2022 08:00:33 -0700 (PDT)
X-Gm-Message-State: AOAM532Y45PgjF9snq98JoyDdLY2xMtV34Z04D5LQK4zBVYTKWVxbOl/
 2ChE2X0rfxGeMmDTE3SmdCrbXiFkNBuCOywL/r8=
X-Google-Smtp-Source: ABdhPJyPD1+vFTL7zI7MOAWlVQpzZfCC/ogYQOnb9fs+BnJ9OUYDclIzyORrk2d04n90LZcBaiPMBu6CLlPqCKGn2dQ=
X-Received: by 2002:a81:ad7:0:b0:2e6:84de:3223 with SMTP id
 206-20020a810ad7000000b002e684de3223mr26970693ywk.209.1654527628777; Mon, 06
 Jun 2022 08:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220606084109.4108188-1-arnd@kernel.org>
 <20220606084109.4108188-6-arnd@kernel.org>
 <alpine.DEB.2.21.2206061057060.19680@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2206061057060.19680@angie.orcam.me.uk>
From: Arnd Bergmann <arnd@kernel.org>
Date: Mon, 6 Jun 2022 17:00:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0pqQHMucGgZDcLpoWMhoyU5yppXK=8y4Wsn0QL7=uD0g@mail.gmail.com>
Message-ID: <CAK8P3a0pqQHMucGgZDcLpoWMhoyU5yppXK=8y4Wsn0QL7=uD0g@mail.gmail.com>
Subject: Re: [PATCH 5/6] scsi: remove stale BusLogic driver
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: linux-arch <linux-arch@vger.kernel.org>,
 linux-scsi <linux-scsi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Martyn Welch <martyn@welchs.me.uk>, Manohar Vanga <manohar.vanga@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Denis Efremov <efremov@linux.com>, Christoph Hellwig <hch@infradead.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Matt Wang <wwentao@vmware.com>, Parisc List <linux-parisc@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Khalid Aziz <khalid@gonehiking.org>, Robin Murphy <robin.murphy@arm.com>
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

On Mon, Jun 6, 2022 at 12:40 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> On Mon, 6 Jun 2022, Arnd Bergmann wrote:
>
> > This was in turn fixed in commit 56f396146af2 ("scsi: BusLogic: Fix
> > 64-bit system enumeration error for Buslogic"), 8 years later.
> >
> > The fact that this was found at all is an indication that there are
> > users, and it seems that Maciej, Matt and Khalid all have access to
> > this hardware, but if it took eight years to find the problem,
> > it's likely that nobody actually relies on it.
>
>  Umm, I use it with a 32-bit system, so it would be quite an issue for me
> to discover a problem with 64-bit configurations.  And I quite rely on
> this system for various stuff too!

Ok, good to know.

> > Remove it as part of the global virt_to_bus()/bus_to_virt() removal.
> > If anyone is still interested in keeping this driver, the alternative
> > is to stop it from using bus_to_virt(), possibly along the lines of
> > how dpt_i2o gets around the same issue.
>
>  Thanks for the pointer and for cc-ing me.  Please refrain from removing
> the driver at least for this release cycle and let me fix it.

Sure, no problem. It looks like I forgot to actually Cc you on the series
as I had meant to, glad it reached you anyway.

> It should be easy to mimic what I did for the defza driver: all bus addresses in
> the DMA API come associated with virtual addresses, so it is just a matter of
> recording those somewhere for later use rather than trying to mess up with
> bus addresses to figure out a reverse mapping.

I looked at the defza driver and that one appears simpler to me, as you
can look up the virtual address from an index, but it's possible I missed
what you do here. I meant specifically the calculation added by commit
67af2b060e02 ("[SCSI] dpt_i2o: move from virt_to_bus/bus_to_virt
to dma_alloc_coherent") in the dpt_i2o driver that can be used to
compute the virtual address. If something simpler works as well, that
is of course better.

        Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
