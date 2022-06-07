Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61802C43334
	for <iommu@archiver.kernel.org>; Tue,  7 Jun 2022 12:44:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12849841D1;
	Tue,  7 Jun 2022 12:44:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TkTlUXbxXzFx; Tue,  7 Jun 2022 12:44:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E4078841BC;
	Tue,  7 Jun 2022 12:44:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA75CC0032;
	Tue,  7 Jun 2022 12:44:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87A08C002D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 09:37:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5AC544059E
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 09:37:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qjfJPcS3RT36 for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 09:37:18 +0000 (UTC)
X-Greylist: delayed 00:27:01 by SQLgrey-1.8.0
Received: from mx2.mythic-beasts.com (mx2.mythic-beasts.com
 [IPv6:2a00:1098:0:82:1000:0:2:1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3B7114036A
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 09:37:18 +0000 (UTC)
Received: from [209.85.167.43] (port=44747 helo=mail-lf1-f43.google.com)
 by balrog.mythic-beasts.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92.3)
 (envelope-from <martyn@welchs.me.uk>) id 1nyVE3-0000eE-BL
 for iommu@lists.linux-foundation.org; Tue, 07 Jun 2022 10:10:15 +0100
Received: by mail-lf1-f43.google.com with SMTP id w20so5642645lfa.11
 for <iommu@lists.linux-foundation.org>; Tue, 07 Jun 2022 02:10:00 -0700 (PDT)
X-Gm-Message-State: AOAM531jiHhA8wbkRvTJpiqFEs52pyh5Hdd/e8Bk1M2xhGpQzbH6BPmr
 yuZcf4IKsrNRQERMdeaUhmJRhaFSZxD6DpA7imQ=
X-Google-Smtp-Source: ABdhPJyULPIdIsKuXm4CBLs/lpx9OuZtHR1zOwsK0gfemBq6DPfmp1b12GD3NCSmZN55f3UVzaaZOjEGtnFIMz9tvoo=
X-Received: by 2002:a05:6512:13a1:b0:448:887e:da38 with SMTP id
 p33-20020a05651213a100b00448887eda38mr18154426lfa.298.1654593000256; Tue, 07
 Jun 2022 02:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220606084109.4108188-1-arnd@kernel.org>
 <Yp3ID86TBFxl7qyL@kroah.com>
In-Reply-To: <Yp3ID86TBFxl7qyL@kroah.com>
From: Martyn Welch <martyn@welchs.me.uk>
Date: Tue, 7 Jun 2022 10:09:49 +0100
X-Gmail-Original-Message-ID: <CAEccXecB=rkZ1Kejmzcfay6qMMVo7Kb7SovSq+Xs1zWMnJOxnQ@mail.gmail.com>
Message-ID: <CAEccXecB=rkZ1Kejmzcfay6qMMVo7Kb7SovSq+Xs1zWMnJOxnQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] phase out CONFIG_VIRT_TO_BUS
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-BlackCat-Spam-Score: 14
X-Mailman-Approved-At: Tue, 07 Jun 2022 12:44:20 +0000
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
 linux-scsi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev@lists.ozlabs.org, Manohar Vanga <manohar.vanga@gmail.com>,
 linux-m68k@lists.linux-m68k.org, Denis Efremov <efremov@linux.com>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 linux-parisc@vger.kernel.org, linux-alpha@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Khalid Aziz <khalid@gonehiking.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, 6 Jun 2022 at 10:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 06, 2022 at 10:41:03AM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The virt_to_bus/bus_to_virt interface has been deprecated for
> > decades. After Jakub Kicinski put a lot of work into cleaning out the
> > network drivers using them, there are only a couple of other drivers
> > left, which can all be removed or otherwise cleaned up, to remove the
> > old interface for good.
> >
> > Any out of tree drivers using virt_to_bus() should be converted to
> > using the dma-mapping interfaces, typically dma_alloc_coherent()
> > or dma_map_single()).
> >
> > There are a few m68k and ppc32 specific drivers that keep using the
> > interfaces, but these are all guarded with architecture-specific
> > Kconfig dependencies, and are not actually broken.
> >
> > There are still a number of drivers that are using virt_to_phys()
> > and phys_to_virt() in place of dma-mapping operations, and these
> > are often broken, but they are out of scope for this series.
>
> I'll take patches 1 and 2 right now through my staging tree if that's
> ok.
>

Hi,

I'd love to say that I could fix this stuff up, however I've lacked access to
suitable hardware for a long time now and don't foresee that changing any
time soon...

Martyn

> thanks,
>
> greg k-h
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
