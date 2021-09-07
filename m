Return-Path: <SRS0=whWg=N5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428D8C433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Sep 2021 07:36:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C047C6109D
	for <iommu@archiver.kernel.org>; Tue,  7 Sep 2021 07:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C047C6109D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 78B41404BE;
	Tue,  7 Sep 2021 07:36:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sMyQXK0FnZIC; Tue,  7 Sep 2021 07:36:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 151CA4028E;
	Tue,  7 Sep 2021 07:36:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5F98C000F;
	Tue,  7 Sep 2021 07:36:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AF8FC000D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Sep 2021 07:36:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 05EFF4028E
 for <iommu@lists.linux-foundation.org>; Tue,  7 Sep 2021 07:36:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dBIDqLw41GZ1 for <iommu@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 07:36:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com
 [209.85.217.49])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4808440294
 for <iommu@lists.linux-foundation.org>; Tue,  7 Sep 2021 07:36:14 +0000 (UTC)
Received: by mail-vs1-f49.google.com with SMTP id a25so7500878vso.5
 for <iommu@lists.linux-foundation.org>; Tue, 07 Sep 2021 00:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gu8ftFQBmy6294PSiMcsspcGVUSc3c2tW9Gp1+2I/Zk=;
 b=PtcPujwUUHa4seAav6k620kIcSe5EjtqUAmgmMSA8S2sW6e5ntsV/SGzI4T2Ok1O2v
 U32K3+EavpYlFwvYCTHFDnuwC2iW2KgaLiRPv+qvRRYTyPhyF7A+hyoXtFS99uqe5Q/D
 6adEShHejzHgcMZZ0pKo0RTKT5FG30NhvLrI/n41m3ItWJzJZ8BcHJUFO4Bgq5ihdsJm
 r5wpPS9SBU7BRYl7z8UyBGkK704MvMK25srqaEYDZeUxJeGbOiPpjJsxBL8kBxiFXGBE
 o74sNbQWBWIrxkWGpkhZpziIIZJ66s/KBVK+GvCebD/r0oO++c6EPFpN5kVgYCsvAbPv
 v3AA==
X-Gm-Message-State: AOAM531+HA7xWxQefFMt9qVHk0XqXLYZIfXNGL6jpZbWyEmjc/sbgcFE
 3wG2labuOhSQPfCRWu5+rC+SS343IFY/I4jUkLw=
X-Google-Smtp-Source: ABdhPJz1Vb9NsSNDBeLVanlKheSFZ4A6ZkOJQuErr/vdKmi2vpPjRPiEEpL4KWRP6eJ+TUIxe8GtMC5FJy8iQZuSQ+E=
X-Received: by 2002:a67:efd6:: with SMTP id s22mr8284552vsp.50.1631000173016; 
 Tue, 07 Sep 2021 00:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210901102705.556093-1-yoshihiro.shimoda.uh@renesas.com>
 <20210901102705.556093-3-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdXwf0_+VKfuiFQf6roZErz-JAm06P5RBzD-Jwm1uk=p9A@mail.gmail.com>
 <TY2PR01MB36928CB43B188D4082829A1FD8D39@TY2PR01MB3692.jpnprd01.prod.outlook.com>
 <CAMuHMdVmkJqiK3XB3s_ibnqy9SUSUFW6mny+kefOYaWi9Ce-4g@mail.gmail.com>
 <TY2PR01MB36929B7C850349E2FA9E547BD8D39@TY2PR01MB3692.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB36929B7C850349E2FA9E547BD8D39@TY2PR01MB3692.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 7 Sep 2021 09:36:01 +0200
Message-ID: <CAMuHMdUf7nR2r4b7KMhghmSKJWs1jz+SWZmGPJxg_2Wdd2Xqqw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iommu/ipmmu-vmsa: Add support for r8a779a0
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

On Tue, Sep 7, 2021 at 9:29 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > From: Geert Uytterhoeven, Sent: Tuesday, September 7, 2021 3:34 PM
> > On Tue, Sep 7, 2021 at 2:02 AM Yoshihiro Shimoda
> > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > > From: Geert Uytterhoeven, Sent: Tuesday, September 7, 2021 12:34 AM
> > > > On Wed, Sep 1, 2021 at 12:27 PM Yoshihiro Shimoda
> > > > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > > > Add support for r8a779a0 (R-Car V3U). The IPMMU hardware design
> > > > > of this SoC differs than others. So, add a new ipmmu_features for it.
> > > > >
> > > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > >
> > > > > --- a/drivers/iommu/ipmmu-vmsa.c
> > > > > +++ b/drivers/iommu/ipmmu-vmsa.c
> > > >
> > > > > @@ -922,6 +922,20 @@ static const struct ipmmu_features ipmmu_features_rcar_gen3 = {
> > > > >         .utlb_offset_base = 0,
> > > > >  };
> > > > >
> > > > > +static const struct ipmmu_features ipmmu_features_r8a779a0 = {
> > > > > +       .use_ns_alias_offset = false,
> > > > > +       .has_cache_leaf_nodes = true,
> > > > > +       .number_of_contexts = 8,
> > > >
> > > > Shouldn't this be 16?
> > > > Or do you plan to add support for more than 8 contexts later, as that
> > > > would require increasing IPMMU_CTX_MAX, and updating ipmmu_ctx_reg()
> > > > to handle the second bank of 8 contexts?
> > >
> > > I would like to add support for more than 8 contexts later because
> > > I realized that ctx_offset_{base,stride} are not suitable for the second bank
> > > of 8 contexts...
> >
> > Wouldn't something like below be sufficient?
>
> Thank you for your suggestion!
>
> >  static unsigned int ipmmu_ctx_reg(struct ipmmu_vmsa_device *mmu,
> >                                   unsigned int context_id, unsigned int reg)
> >  {
> > -       return mmu->features->ctx_offset_base +
> > -              context_id * mmu->features->ctx_offset_stride + reg;
> > +       unsigned int base = mmu->features->ctx_offset_base;
> > +
> > +       if (context_id > 7)
> > +               base += 0x800 - 8 * 0x1040;
>
> This should be "base += 0x800 - 8 * 0x40;" because the 8th context address is
> 0x18800, not 0x10800.

Doh, I should have written my first thought ("base += FIXME" ;-)

> I'll send v2 patch to support 16 contexts.
> (I'll change IPMMU_CTX_MAX to 16 too.)

Thanks!

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
