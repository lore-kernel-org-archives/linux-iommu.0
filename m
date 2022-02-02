Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F6FC433F5
	for <iommu@archiver.kernel.org>; Wed,  2 Feb 2022 11:07:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A02D83252;
	Wed,  2 Feb 2022 11:07:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UeaXFxNQHBIE; Wed,  2 Feb 2022 11:07:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 56F16831D6;
	Wed,  2 Feb 2022 11:07:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28666C0011;
	Wed,  2 Feb 2022 11:07:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC8A9C000B
 for <iommu@lists.linux-foundation.org>; Wed,  2 Feb 2022 11:07:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA23060AD4
 for <iommu@lists.linux-foundation.org>; Wed,  2 Feb 2022 11:07:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yPgh8t2ST5vF for <iommu@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 11:07:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 269C760A7D
 for <iommu@lists.linux-foundation.org>; Wed,  2 Feb 2022 11:07:37 +0000 (UTC)
Received: by mail-vk1-f182.google.com with SMTP id w17so12348318vko.9
 for <iommu@lists.linux-foundation.org>; Wed, 02 Feb 2022 03:07:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+pDjZAPvO1sIIYvozittsGRvtSXtsnf48hAKVptlQVE=;
 b=1uMjS5TXo+QUodO3RkiJl4jeat3PuBK3N5up6DAR84Xx6wLBVsu4e04AgXvz3D9WwX
 NDkHzsoJdka/ldnV4Rcjzf/M3VJqhuW9Do+DjHVnkTtfJ1s9AVvJRPMm9OU61etuTj+A
 NKZxYKVhbiTVRcUVPNH3fSD7dj1ucOqWHD+sOj3TmlsouK7uKazEIEIszvBDRDFDyHcm
 HApvI0+huYHMpvGE7sgMrO7Vu+SYUOFTjM5nbFLd4n19pDOK6AW5HBjr3PHuW8U1qo6g
 eptlmnbrhnFhKuvVWHoW+iWs2TF57HFO/pQu/vNXuYHM6OTHcRbNoDI7YPNK7wEllv0+
 +EBA==
X-Gm-Message-State: AOAM533N54RDnQGLlaeXCR7+6JB/ZP0+7TW8/rZubEZfRY17Mi8ocsp9
 ayTjmdibKuKMY1pOH3X8d1GVLZgUIfa7Cw==
X-Google-Smtp-Source: ABdhPJxKF+ZhcsO7e6OFz22V2F/OQ2RyoHtqQPuUScKMyfzt8qzwpX6NO2gTTNSARTKLZeBFGMiOew==
X-Received: by 2002:a1f:90d4:: with SMTP id s203mr12735872vkd.20.1643800055921; 
 Wed, 02 Feb 2022 03:07:35 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com.
 [209.85.222.42])
 by smtp.gmail.com with ESMTPSA id s65sm5948123vkd.27.2022.02.02.03.07.35
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Feb 2022 03:07:35 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id w21so18366241uan.7
 for <iommu@lists.linux-foundation.org>; Wed, 02 Feb 2022 03:07:35 -0800 (PST)
X-Received: by 2002:ab0:44c:: with SMTP id 70mr12371172uav.78.1643800055391;
 Wed, 02 Feb 2022 03:07:35 -0800 (PST)
MIME-Version: 1.0
References: <20220125125602.4144793-1-yoshihiro.shimoda.uh@renesas.com>
 <20220125125602.4144793-3-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdXmievc1U0PXfv01wsibUs+B+5U6kPbcE8=v2GKTvFbTA@mail.gmail.com>
 <TYBPR01MB5341422A4238B937BFEBD0D6D8279@TYBPR01MB5341.jpnprd01.prod.outlook.com>
In-Reply-To: <TYBPR01MB5341422A4238B937BFEBD0D6D8279@TYBPR01MB5341.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 Feb 2022 12:07:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUkB6+kYWewxHHSkgapioiu2s+A=32me72H4+tQU0+bDA@mail.gmail.com>
Message-ID: <CAMuHMdUkB6+kYWewxHHSkgapioiu2s+A=32me72H4+tQU0+bDA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iommu/ipmmu-vmsa: Add support for R-Car Gen4
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
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

Hi Shimoda-san,

On Wed, Feb 2, 2022 at 11:48 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > From: Geert Uytterhoeven, Sent: Wednesday, February 2, 2022 6:24 PM
> > On Tue, Jan 25, 2022 at 6:36 PM Yoshihiro Shimoda
> > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > Add support for R-Car Gen4 like r8a779f0 (R-Car S4-8). The IPMMU
> > > hardware design of r8a779f0 is the same as r8a779a0. So, rename
> > > "r8a779a0" to "rcar_gen4".
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/iommu/ipmmu-vmsa.c
> > > +++ b/drivers/iommu/ipmmu-vmsa.c
> >
> > > @@ -743,7 +744,7 @@ static bool ipmmu_device_is_allowed(struct device *dev)
> > >         unsigned int i;
> > >
> > >         /*
> > > -        * R-Car Gen3 and RZ/G2 use the allow list to opt-in devices.
> > > +        * R-Car Gen3, Gen4 and RZ/G2 use the allow list to opt-in devices.
> > >          * For Other SoCs, this returns true anyway.
> > >          */
> > >         if (!soc_device_match(soc_needs_opt_in))
> >
> > There are a few more references to "Gen3" that can be extended.
>
> I'm afraid, but I could not understand this mean.

I'm sorry. I mean comments that currently say "Gen3", while they are
applicable to R-Car Gen4, too. I think it would be good to update them
to "Gen3/4".

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
