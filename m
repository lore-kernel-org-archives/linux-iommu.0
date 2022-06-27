Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBAEC433EF
	for <iommu@archiver.kernel.org>; Mon, 27 Jun 2022 08:33:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 110C740BD6;
	Mon, 27 Jun 2022 08:33:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 110C740BD6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xhaE7WTC3oEC; Mon, 27 Jun 2022 08:33:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D079740BD7;
	Mon, 27 Jun 2022 08:33:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D079740BD7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3E2BC0032;
	Mon, 27 Jun 2022 08:33:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84F30C002D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 08:33:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5192D4155F
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 08:33:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5192D4155F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Iue-K1BsfYx for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 08:33:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 36ACB410DB
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com
 [209.85.160.51])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 36ACB410DB
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 08:33:28 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id
 586e51a60fabf-101d2e81bceso12150938fac.0
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 01:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ir7A3VG3rQ4e3U1bE1FV/pPr5VS7k4YiEaqfUpRXgys=;
 b=PJDLHb9I1T91I91bIVIQJBPzkmikT2YA1QOvwbqgcLhj2puKc4Q7MFmO8hdKQTxyn4
 MgD7OSXq+1SzOi98fNrHWliQUS041pZibJRmJntdpHPf+96YIrzMHEgsy+SiWie94XrW
 gjGTeIpGqNm/3sF+GMAEpWKBtPkbIgIKA5rw+H9Kuc8kg8qMxokYedpXnW5NopcqHo97
 09E1Cy4F8zxZUO7tud2r6TVkkg+RaW39zRtmu++3QGbJFOVHhsJIC21OMwLnp5YyJ9Lz
 0pddNj4/Q9goqRfUWWv1mqmT3lYhzE8BDJ8CKu92GolRmZwe20GIQNAZYuOtOI8vVs09
 hYUQ==
X-Gm-Message-State: AJIora+x8TZbIRKJwnHKbr3dwDxIbZcADGuFOVGzkpc9XYzxLMSe/Ahz
 oCTAUJAKAYu4O/KPjVe0NJwFKirnzzAb3A==
X-Google-Smtp-Source: AGRyM1uvoZhfAIxujPEE1R7kVmTrJTCc/NYMadHzvXbxjxTpvgYShgcij/3X6808L83WcGGmtJ0Umw==
X-Received: by 2002:a05:6870:9a18:b0:101:3954:9730 with SMTP id
 fo24-20020a0568709a1800b0010139549730mr9454320oab.253.1656318807003; 
 Mon, 27 Jun 2022 01:33:27 -0700 (PDT)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com.
 [209.85.161.44]) by smtp.gmail.com with ESMTPSA id
 f26-20020a4ada5a000000b004255ed1b6d9sm5545566oou.27.2022.06.27.01.33.26
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jun 2022 01:33:26 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id
 r8-20020a4ab508000000b0041bf4086124so1772793ooo.1
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 01:33:26 -0700 (PDT)
X-Received: by 2002:a81:a092:0:b0:318:5c89:a935 with SMTP id
 x140-20020a81a092000000b003185c89a935mr14193176ywg.383.1656318410280; Mon, 27
 Jun 2022 01:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
In-Reply-To: <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 27 Jun 2022 10:26:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
Message-ID: <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 scsi <linux-scsi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Miquel van Smoorenburg <mikevs@xs4all.net>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Denis Efremov <efremov@linux.com>, Mark Salyzyn <salyzyn@android.com>,
 Christoph Hellwig <hch@infradead.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>, Matt Wang <wwentao@vmware.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
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

Hi Michael,

On Sat, Jun 18, 2022 at 3:06 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 18.06.2022 um 00:57 schrieb Arnd Bergmann:
> > From: Arnd Bergmann <arnd@arndb.de>
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

FTR, the sgiwd93 driver use dma_map_single().

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
