Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752B1C433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 07:04:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CDCE82FC9;
	Tue, 28 Jun 2022 07:04:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1CDCE82FC9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rUrPI-fujJzc; Tue, 28 Jun 2022 07:04:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D399981B35;
	Tue, 28 Jun 2022 07:04:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D399981B35
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2BB5C0032;
	Tue, 28 Jun 2022 07:04:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CA04C002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:04:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3783781B36
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:04:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3783781B36
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5I4idQzlNfZl for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 07:04:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 097B081B35
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 097B081B35
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:04:08 +0000 (UTC)
Received: by mail-qv1-f51.google.com with SMTP id n15so18694231qvh.12
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 00:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oUnjhZMiGNi6v7nsbqYIrss5xtOvLOvLOLR2zcKJEss=;
 b=cUq4qf4ZYL0tR/fjbqru9b8fJsiUhpoB2nRSNeVhDDLd9ZQTc5wkfWr4yQWFLN5RDE
 qP+tjc7Xdsg5n0AzPutcMoXujU7zMkDehrik4ogUhqdL7+TRuTLDRP7QiFpcMwec8WVx
 ifGy1jBgaQrcj4smcne0OeTa0g20L2tfAShVofXnm7DvJ8sFrEeTAqV8zyCj21jExj6k
 dZ0jORZ2AqjRaoa4AUtnDqKP1d7HRocX7oEizrCRkuD9srkYwGW/YTuCR5YN34Yldc/z
 ICsnALDoqPmhzUVkmjX+kxxxqgCacFG3Npts7vMD9GaMChLV2BJwpxPJfBZVQhwQ2FE+
 Kovg==
X-Gm-Message-State: AJIora86EdljanXcjgLpJ0Eye0WPJAcJXgSRtY2lZ8vZ6dvgu/DKnNtp
 BF0Q3UtNskF82bPNXnhnD5f1XkQETKOYlQ==
X-Google-Smtp-Source: AGRyM1sHvRXgzzPP+wNiTNJ8fl4pO3qhqOIVK+CPruFgUSK9fESYyA1Er/6Bk+CAt02FR3w2f2XVZA==
X-Received: by 2002:a05:6214:250c:b0:472:6e5e:e2f3 with SMTP id
 gf12-20020a056214250c00b004726e5ee2f3mr1380011qvb.45.1656399847432; 
 Tue, 28 Jun 2022 00:04:07 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com.
 [209.85.219.169]) by smtp.gmail.com with ESMTPSA id
 d8-20020ac85ac8000000b00304e70585f9sm9175474qtd.72.2022.06.28.00.04.06
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jun 2022 00:04:06 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id p136so14467850ybg.4
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 00:04:06 -0700 (PDT)
X-Received: by 2002:a05:6902:905:b0:64a:2089:f487 with SMTP id
 bu5-20020a056902090500b0064a2089f487mr18678075ybb.202.1656399845934; Tue, 28
 Jun 2022 00:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
 <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
 <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com>
 <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
In-Reply-To: <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Jun 2022 09:03:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXUihTPD9A9hs__Xr2ErfOqkZ5KgCHqm+9HvRf39uS5kA@mail.gmail.com>
Message-ID: <CAMuHMdXUihTPD9A9hs__Xr2ErfOqkZ5KgCHqm+9HvRf39uS5kA@mail.gmail.com>
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

On Tue, Jun 28, 2022 at 5:26 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 28.06.2022 um 09:12 schrieb Michael Schmitz:
> > On 27/06/22 20:26, Geert Uytterhoeven wrote:
> >> On Sat, Jun 18, 2022 at 3:06 AM Michael Schmitz <schmitzmic@gmail.com>
> >> wrote:
> >>> Am 18.06.2022 um 00:57 schrieb Arnd Bergmann:
> >>>> From: Arnd Bergmann <arnd@arndb.de>
> >>>>
> >>>> All architecture-independent users of virt_to_bus() and bus_to_virt()
> >>>> have been fixed to use the dma mapping interfaces or have been
> >>>> removed now.  This means the definitions on most architectures, and the
> >>>> CONFIG_VIRT_TO_BUS symbol are now obsolete and can be removed.
> >>>>
> >>>> The only exceptions to this are a few network and scsi drivers for m68k
> >>>> Amiga and VME machines and ppc32 Macintosh. These drivers work
> >>>> correctly
> >>>> with the old interfaces and are probably not worth changing.
> >>> The Amiga SCSI drivers are all old WD33C93 ones, and replacing
> >>> virt_to_bus by virt_to_phys in the dma_setup() function there would
> >>> cause no functional change at all.
> >> FTR, the sgiwd93 driver use dma_map_single().
> >
> > Thanks! From what I see, it doesn't have to deal with bounce buffers
> > though?
>
> Leaving the bounce buffer handling in place, and taking a few other
> liberties - this is what converting the easiest case (a3000 SCSI) might
> look like. Any obvious mistakes? The mvme147 driver would be very
> similar to handle (after conversion to a platform device).

Thanks, looks reasonable.

> The driver allocates bounce buffers using kmalloc if it hits an
> unaligned data buffer - can such buffers still even happen these days?

No idea.

> If I understand dma_map_single() correctly, the resulting dma handle
> would be equally misaligned?
>
> To allocate a bounce buffer, would it be OK to use dma_alloc_coherent()
> even though AFAIU memory used for DMA buffers generally isn't consistent
> on m68k?
>
> Thinking ahead to the other two Amiga drivers - I wonder whether
> allocating a static bounce buffer or a DMA pool at driver init is likely
> to succeed if the kernel runs from the low 16 MB RAM chunk? It certainly
> won't succeed if the kernel runs from a higher memory address, so the
> present bounce buffer logic around amiga_chip_alloc() might still need
> to be used here.
>
> Leaves the question whether converting the gvp11 and a2091 drivers is
> actually worth it, if bounce buffers still have to be handled explicitly.

A2091 should be straight-forward, as A3000 is basically A2091 on the
motherboard (comparing the two drivers, looks like someone's been
sprinkling mb()s over the A3000 driver).

I don't have any of these SCSI host adapters (not counting the A590
(~A2091) expansion of the old A500, which is not Linux-capable, and
 hasn't been powered on for 20 years).

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
