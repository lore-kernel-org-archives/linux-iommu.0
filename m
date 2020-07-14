Return-Path: <SRS0=v902=AZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C701C433E7
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 08:42:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F36121897
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 08:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F36121897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 02F598A2ED;
	Tue, 14 Jul 2020 08:42:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KFFg0CtnFQKE; Tue, 14 Jul 2020 08:42:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 245158A112;
	Tue, 14 Jul 2020 08:42:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4397C0888;
	Tue, 14 Jul 2020 08:42:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45B83C0733
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 08:42:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 32EEB8A112
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 08:42:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k6AlSYERSIG3 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jul 2020 08:41:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6CB8A8A284
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 08:41:59 +0000 (UTC)
Received: by mail-oi1-f195.google.com with SMTP id x83so13300524oif.10
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 01:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oQnzKz3C/NevNjTlEZYFL5iXV3ehjQViqfoH5iOv3SM=;
 b=aywcHTn0ojyvcGaBOLCesS80smg4hZSIIIJuFClupBeXVaY0A4WnFcu0B+Ld+PMiq5
 N5nA0e+c+kEsPEys8OhCJU+hIl3g9rz/J8HYXJD1Awf2mkaN06kKkSlSYEnoCVvMMqUr
 mzchAZKqscu58nmkQClfteRSVfTjH5zy7Sla12i0CnZhRRr8ACYOMWTVrzBjye6o5jd1
 K0JLUsqVURL2uy+evSXq8XwxNAr6o/osCQYdDdUI8kSPdve3pRVmx87L/yl0P8kfFm7b
 Q4o/+b7k92iIkcSyJuGmF/NoCLWEzpIEoBEh5U13d89vSHvYJTotINW//XXVo6xSuwX3
 2gRw==
X-Gm-Message-State: AOAM533Mr+c7jgM6ywOwuNAS5SKFefSaJq8QTDhZ3aSWxRtOsh+KTQtW
 TziMlM17rbffes82RGgUDGcQ1BxzgHhoexruuq0=
X-Google-Smtp-Source: ABdhPJwxHQ4k7EDiUkAc1gcDGSS4Uw8Rp1iYZBGwEma0KUZbSrLDof4x63mIGl3zVqSk/DDgD3zmVlx4dejHfmNAQO0=
X-Received: by 2002:aca:ac10:: with SMTP id v16mr2626302oie.153.1594716118642; 
 Tue, 14 Jul 2020 01:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <1594676120-5862-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594676120-5862-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdV4zzrk_=-2Cmgq8=PKTeU457iveJ58gYekJ-Z8SXqaCQ@mail.gmail.com>
 <CA+V-a8tB0mA17f51GMQQ-Cj_CUXze_JjTahrpoAtmwuOFHQV6g@mail.gmail.com>
In-Reply-To: <CA+V-a8tB0mA17f51GMQQ-Cj_CUXze_JjTahrpoAtmwuOFHQV6g@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Jul 2020 10:41:47 +0200
Message-ID: <CAMuHMdXM3qf266exJtJrN0XAogEsJoM-k3FON9CjX+stLpuMFA@mail.gmail.com>
Subject: Re: [PATCH 2/9] iommu/ipmmu-vmsa: Hook up R8A774E1 DT matching code
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 netdev <netdev@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Sergei Shtylyov <sergei.shtylyov@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, dmaengine <dmaengine@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Prabhakar,

On Tue, Jul 14, 2020 at 10:30 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Tue, Jul 14, 2020 at 9:09 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, Jul 13, 2020 at 11:35 PM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> > >
> > > Add support for RZ/G2H (R8A774E1) SoC IPMMUs.
> > >
> > > Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/iommu/ipmmu-vmsa.c
> > > +++ b/drivers/iommu/ipmmu-vmsa.c
> > > @@ -751,6 +751,7 @@ static const struct soc_device_attribute soc_rcar_gen3[] = {
> > >  static const struct soc_device_attribute soc_rcar_gen3_whitelist[] = {
> > >         { .soc_id = "r8a774b1", },
> > >         { .soc_id = "r8a774c0", },
> > > +       { .soc_id = "r8a774e1", },
> >
> > Adding an entry to soc_rcar_gen3_whitelist[] doesn't do anything, unless
> > you also add the same entry to soc_rcar_gen3[].
> >
> I think the comment "For R-Car Gen3 use a white list to opt-in slave
> devices." is misleading.  Booting through the kernel I do see iommu
> groups (attached is the logs).

Indeed. Without an entry in soc_rcar_gen3[], the IPMMU is enabled
unconditionally, and soc_rcar_gen3_whitelist[] is ignored.
That's why you want an entry in both, unless you have an R-Car Gen3
SoC where the IPMMU works correctly with all slave devices present.
Perhaps soc_rcar_gen3[] should be renamed to soc_rcar_gen3_greylist[]
(or soc_rcar_gen3_maybelist[]) to make this clear?

> Also the recent patch to add
> "r8a77961" just adds to soc_rcar_gen3_whitelist.

Oops, commit 17fe16181639801b ("iommu/renesas: Add support for r8a77961")
did it wrong, too.

> > >         { .soc_id = "r8a7795", .revision = "ES3.*" },
> > >         { .soc_id = "r8a77961", },
> > >         { .soc_id = "r8a77965", },

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
