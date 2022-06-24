Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23740C433EF
	for <iommu@archiver.kernel.org>; Fri, 24 Jun 2022 09:11:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9EEB984902;
	Fri, 24 Jun 2022 09:11:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9EEB984902
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DujAp35g
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nz49bQlUmR3u; Fri, 24 Jun 2022 09:11:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3E5B4848D6;
	Fri, 24 Jun 2022 09:11:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E5B4848D6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1235CC0039;
	Fri, 24 Jun 2022 09:11:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 562E0C002D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 09:11:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1756B84902
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 09:11:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1756B84902
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0Lx8MBMbXfEN for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 09:11:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E987848FF
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4E987848FF
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 09:11:10 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1A4C36207C
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 09:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854DAC341D1
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 09:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656061867;
 bh=QZAJaXcIRADU/xKJ+9ztqTuLJLuzfPWx4kL+CXKUusE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=DujAp35gBkJI0ojh8Z4cz2WNMnPVa8X09AjvGzpyvg1W3zpRtikVU8S1p5YzkeFQn
 lyqUI2IK/TRwsZ6Fphm5Gnrx8o8G+PE51sAvsFnYOkkSigRwkL7Ti34QY5mgrVlD4K
 q87W/nor5rNmj3N+qIRXTKGiC0CtdvN0KmhO4zeDIsbYYD8QC1BFTaduxwig96j3Pp
 tKSojB4iYnI/xdxLhYubiYytYTgX6J2RKt1/59qilMZK37CJaHmf49rGGpZzrmzm5C
 vXPE3OAWpxbhgHGBmdLEkg9vKAPO5+PD+s0ZO+euAV2nmh7i/+PPY0rPFj46LXVDDi
 0tE0Cc0wwED0w==
Received: by mail-yb1-f181.google.com with SMTP id l11so3405926ybu.13
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 02:11:07 -0700 (PDT)
X-Gm-Message-State: AJIora9EdXNsM8S3Bg5D9tGMNGgfUoMzWjrfjGFwTVjxohPhJSn3RD0n
 vhhtO8yJFyUVh8qZwE+woPv0mwrjGNnSam749r8=
X-Google-Smtp-Source: AGRyM1thOWm6xvviAmnNqulTm+G1aNh8sMElBL34hFaSX/cB93p4OtnA8uz/osirQ5xn1zAs3G7Hy/thW2fsxExc9gs=
X-Received: by 2002:a05:6902:120f:b0:668:2228:9627 with SMTP id
 s15-20020a056902120f00b0066822289627mr14111407ybu.134.1656061866469; Fri, 24
 Jun 2022 02:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
In-Reply-To: <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 24 Jun 2022 11:10:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1XfwkTOV7qOs1fTxf4vthNBRXKNu8A5V7TWnHT081NGA@mail.gmail.com>
Message-ID: <CAK8P3a1XfwkTOV7qOs1fTxf4vthNBRXKNu8A5V7TWnHT081NGA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Miquel van Smoorenburg <mikevs@xs4all.net>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-scsi <linux-scsi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Denis Efremov <efremov@linux.com>, Mark Salyzyn <salyzyn@android.com>,
 Christoph Hellwig <hch@infradead.org>,
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

On Sat, Jun 18, 2022 at 3:06 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 18.06.2022 um 00:57 schrieb Arnd Bergmann:
> >
> > All architecture-independent users of virt_to_bus() and bus_to_virt()
> > have been fixed to use the dma mapping interfaces or have been
> > removed now.  This means the definitions on most architectures, and the
> > CONFIG_VIRT_TO_BUS symbol are now obsolete and can be removed.
> >
> > The only exceptions to this are a few network and scsi drivers for m68k
> > Amiga and VME machines and ppc32 Macintosh. These drivers work correctly
> > with the old interfaces and are probably not worth changing.
>
> The Amiga SCSI drivers are all old WD33C93 ones, and replacing
> virt_to_bus by virt_to_phys in the dma_setup() function there would
> cause no functional change at all.

Ok, thanks for taking a look here.

> drivers/vme/bridges/vme_ca91cx42.c hasn't been used at all on m68k (it
> is a PCI-to-VME bridge chipset driver that would be needed on
> architectures that natively use a PCI bus). I haven't found anything
> that selects that driver, so not sure it is even still in use??

It's gone now, Greg has already taken my patches for this through
the staging tree.

> That would allow you to drop the remaining virt_to_bus define from
> arch/m68k/include/asm/virtconvert.h.
>
> I could submit a patch to convert the Amiga SCSI drivers to use
> virt_to_phys if Geert and the SCSI maintainers think it's worth the churn.

I don't think using virt_to_phys() is an improvement here, as
virt_to_bus() was originally meant as a better abstraction to
replace the use of virt_to_phys() to make drivers portable, before
it got replaced by the dma-mapping interface in turn.

It looks like the Amiga SCSI drivers have an open-coded version of
what dma_map_single() does, to do bounce buffering and cache
management. The ideal solution would be to convert the drivers
actually use the appropriate dma-mapping interfaces and remove
this custom code.

The same could be done for the two vme drivers (scsi/mvme147.c
and ethernet/82596.c), which do the cache management but
apparently don't need swiotlb bounce buffering.

Rewriting the drivers to modern APIs is of course non-trivial,
and if you want a shortcut here, I would suggest introducing
platform specific helpers similar to isa_virt_to_bus() and call
them amiga_virt_to_bus() and vme_virt_to_bus, respectively.

Putting these into a platform specific header file at least helps
clarify that both the helper functions and the drivers using them
are non-portable.

> 32bit powerpc is a different matter though.

It's similar, but unrelated. The two apple ethernet drivers
(bmac and mace) can again either get changed to use the
dma-mapping interfaces, or get a custom pmac_virt_to_bus()/
pmac_bus_to_virt() helper.

There is also drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c,
which I think just needs a trivial change, but I'm not sure
how to do it correctly.

      Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
