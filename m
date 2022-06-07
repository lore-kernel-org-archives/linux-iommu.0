Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40E1C43334
	for <iommu@archiver.kernel.org>; Tue,  7 Jun 2022 07:29:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 31CBB410B3;
	Tue,  7 Jun 2022 07:29:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kpAdBc93w1_u; Tue,  7 Jun 2022 07:29:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D20D0404B0;
	Tue,  7 Jun 2022 07:29:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AC63C0032;
	Tue,  7 Jun 2022 07:29:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3EDEC002D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 07:29:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DBC9E60EB2
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 07:29:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q_hFoVa8VhHA for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 07:29:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EDD4760E85
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 07:29:51 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id x18so9169874qtj.3
 for <iommu@lists.linux-foundation.org>; Tue, 07 Jun 2022 00:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/vvSp91df5DXi30Fd3pExmyOkjiZTMAg5zYSvB9bVbM=;
 b=JqUiW6IuK5OMM1ZO8n1XR9nmHiqSxwGM+Uyx1Gx43OveyYIeMGRAT130AaiJEoYxwP
 ulzYtoP8wGWH3tQWU1ezgeXtvDu9u3C8BttWZsofLKyg5WEP6WdoEgQpM/kiK/CgLeoa
 +ns2OOzEPvtVT4Qni12a4/d5njmhZVmDB9nzfFGr/9vlgR5pTckbetAIOAy8wV211YQz
 skETK6OHIOPDF+bYw8Lsgy/ioFinSAWi4mzLg+fyBDD0XD+fO09Qq0X8DI8CIso4Vf4x
 QAOM9l/fr9KxU0uoCwOPgRCQaKckKg7ztO35zOgkB9LQa1LbbD25C1xgAU8siog/yQmC
 6Q3w==
X-Gm-Message-State: AOAM530TKDDwKsvmTq151U+acGK2ZTqJQu1kzaXblAZn1C1Cxb7uF3Bu
 wvduguCyLr14047q98N357cf95R584GSCg==
X-Google-Smtp-Source: ABdhPJzjZuCxK27D2JVeS80mZOK0PXNhxIjUYuHpqESX+V1gu8AJ2R/FDVXJRFosvOofB58/1L9bhQ==
X-Received: by 2002:ac8:5c0c:0:b0:304:baad:7d31 with SMTP id
 i12-20020ac85c0c000000b00304baad7d31mr21444536qti.419.1654586990666; 
 Tue, 07 Jun 2022 00:29:50 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com.
 [209.85.219.169]) by smtp.gmail.com with ESMTPSA id
 de7-20020a05620a370700b006a670348ba5sm13062133qkb.99.2022.06.07.00.29.49
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jun 2022 00:29:50 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id i39so1671576ybj.9
 for <iommu@lists.linux-foundation.org>; Tue, 07 Jun 2022 00:29:49 -0700 (PDT)
X-Received: by 2002:a25:7307:0:b0:65c:b98a:f592 with SMTP id
 o7-20020a257307000000b0065cb98af592mr28407064ybc.380.1654586989616; Tue, 07
 Jun 2022 00:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220606084109.4108188-1-arnd@kernel.org>
 <20220606084109.4108188-7-arnd@kernel.org>
In-Reply-To: <20220606084109.4108188-7-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 7 Jun 2022 09:29:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXi2LkrWSs9=D9tSfhz+YDHB+638F6JdmgQ7V8Gj1ehqQ@mail.gmail.com>
Message-ID: <CAMuHMdXi2LkrWSs9=D9tSfhz+YDHB+638F6JdmgQ7V8Gj1ehqQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] arch/*/: remove CONFIG_VIRT_TO_BUS
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, scsi <linux-scsi@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Martyn Welch <martyn@welchs.me.uk>, Manohar Vanga <manohar.vanga@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Denis Efremov <efremov@linux.com>, Christoph Hellwig <hch@infradead.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
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

On Mon, Jun 6, 2022 at 11:10 AM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> All architecture-independent users of virt_to_bus() and bus_to_virt()
> have been fixed to use the dma mapping interfaces or have been
> removed now.  This means the definitions on most architectures, and the
> CONFIG_VIRT_TO_BUS symbol are now obsolete and can be removed.
>
> The only exceptions to this are a few network and scsi drivers for m68k
> Amiga and VME machines and ppc32 Macintosh. These drivers work correctly
> with the old interfaces and are probably not worth changing.
>
> On alpha and parisc, virt_to_bus() were still used in asm/floppy.h.
> alpha can use isa_virt_to_bus() like x86 does, and parisc can just
> open-code the virt_to_phys() here, as this is architecture specific
> code.
>
> I tried updating the bus-virt-phys-mapping.rst documentation, which
> started as an email from Linus to explain some details of the Linux-2.0
> driver interfaces. The bits about virt_to_bus() were declared obsolete
> backin 2000, and the rest is not all that relevant any more, so in the
> end I just decided to remove the file completely.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

>  arch/m68k/Kconfig                             |   1 -
>  arch/m68k/include/asm/virtconvert.h           |   4 +-

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

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
