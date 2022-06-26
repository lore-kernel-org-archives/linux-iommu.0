Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18B0CCA480
	for <iommu@archiver.kernel.org>; Sun, 26 Jun 2022 08:36:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1289E61027;
	Sun, 26 Jun 2022 08:36:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1289E61027
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=f6yc1RaN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X4zUN_y47kcD; Sun, 26 Jun 2022 08:36:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1D22F605EA;
	Sun, 26 Jun 2022 08:36:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D22F605EA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA1ECC007A;
	Sun, 26 Jun 2022 08:36:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C308FC002D
 for <iommu@lists.linux-foundation.org>; Sun, 26 Jun 2022 08:36:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A63E83E48
 for <iommu@lists.linux-foundation.org>; Sun, 26 Jun 2022 08:36:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8A63E83E48
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=f6yc1RaN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7hfoFt0K-yqM for <iommu@lists.linux-foundation.org>;
 Sun, 26 Jun 2022 08:36:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 71A9283E3E
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 71A9283E3E
 for <iommu@lists.linux-foundation.org>; Sun, 26 Jun 2022 08:36:24 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 501C961176
 for <iommu@lists.linux-foundation.org>; Sun, 26 Jun 2022 08:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BB3C341D1
 for <iommu@lists.linux-foundation.org>; Sun, 26 Jun 2022 08:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656232582;
 bh=juR3pWHFZdE8Vf6QGsSTJiJ2f3ZwildJoxwQZWNpG/E=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=f6yc1RaNJwQq5dElIkyuYvUvwHkvBLBi9KqlHP2ZC+oxWcerSMGK3hkxIM7cIAAT/
 TtueQ33cy4/n0Uda61TReBytE65eLfQrezytZmtm7bX//WKI/yOT60iTP49ZEIOPSW
 6z1NOCnw36qsukMeObt289BsjK4np0rxC1P8TL2Fy3MIi0PXPCcxYI0ThEmMrCWGfS
 UrkYBYjapcfJFTuf2LfH5cpnGXFFNt0wE6A6XBDTb085dl806k7RyMDAUO+JHUYTkX
 Au2xvaXvS/pK8PTQWyJuWsS1hRHbV8q3oa+eOltOLdGmLNGlNuBwPHqKBVX/LvLixJ
 OvRvGfKxK4K+w==
Received: by mail-yb1-f180.google.com with SMTP id v38so1058543ybi.3
 for <iommu@lists.linux-foundation.org>; Sun, 26 Jun 2022 01:36:22 -0700 (PDT)
X-Gm-Message-State: AJIora+95fv9Qj2PFr2FtUaq8X34bR3Ns0zJdFykcxfMQVX4iDLU4neq
 yqnsyQGmoFdbNVjwznakPBWMHNMzukZfzpySiHs=
X-Google-Smtp-Source: AGRyM1s9r/oqGpmVzKxZ+US+FaaRE8PSLnvRSxz/eiJkctG/2AzfYvDmvG4YKVmQhXgJnW7ApVihluVitAAeI1SlHhw=
X-Received: by 2002:a25:8b8b:0:b0:669:b37d:f9cd with SMTP id
 j11-20020a258b8b000000b00669b37df9cdmr7722013ybl.394.1656232581073; Sun, 26
 Jun 2022 01:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
 <CAK8P3a1XfwkTOV7qOs1fTxf4vthNBRXKNu8A5V7TWnHT081NGA@mail.gmail.com>
 <6d1d88ee-1cf6-c735-1e6d-bafd2096e322@gmail.com>
In-Reply-To: <6d1d88ee-1cf6-c735-1e6d-bafd2096e322@gmail.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Sun, 26 Jun 2022 10:36:02 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1KKPXr0ews9po_xjmnGYUWf18gBaZYYmnC+DvtxTKLmQ@mail.gmail.com>
Message-ID: <CAK8P3a1KKPXr0ews9po_xjmnGYUWf18gBaZYYmnC+DvtxTKLmQ@mail.gmail.com>
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

(On Sun, Jun 26, 2022 at 7:21 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>  > The same could be done for the two vme drivers (scsi/mvme147.c
> > and ethernet/82596.c), which do the cache management but
> > apparently don't need swiotlb bounce buffering.
> >
> > Rewriting the drivers to modern APIs is of course non-trivial,
> > and if you want a shortcut here, I would suggest introducing
> > platform specific helpers similar to isa_virt_to_bus() and call
> > them amiga_virt_to_bus() and vme_virt_to_bus, respectively.
>
> I don't think Amiga and m68k VME differ at all in that respect, so might
> just call it m68k_virt_to_bus() for now.
>
> > Putting these into a platform specific header file at least helps
> > clarify that both the helper functions and the drivers using them
> > are non-portable.
>
> There are no platform specific header files other than asm/amigahw.h and
> asm/mvme147hw.h, currently only holding register address definitions.
> Would it be OK to add m68k_virt_to_bus() in there if it can't remain in
> asm/virtconvert.h, Geert?

In that case, I would just leave it under the current name and not change
m68k at all. I don't like the m68k_virt_to_bus() name because there is
not anything CPU specific in what it does, and keeping it in a common
header does nothing to prevent it from being used on other platforms
either.

> >> 32bit powerpc is a different matter though.
> >
> > It's similar, but unrelated. The two apple ethernet drivers
> > (bmac and mace) can again either get changed to use the
> > dma-mapping interfaces, or get a custom pmac_virt_to_bus()/
> > pmac_bus_to_virt() helper.
>
> Hmmm - I see Finn had done the DMA API conversion on macmace.c which
> might give some hints on what to do about mace.c ... no idea about
> bmac.c though. And again, haven't got hardware to test, so custom
> helpers is it, then.

Ok.

          Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
