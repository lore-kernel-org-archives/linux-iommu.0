Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98AB7C433F5
	for <iommu@archiver.kernel.org>; Wed,  2 Feb 2022 09:37:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DE934167A;
	Wed,  2 Feb 2022 09:37:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JDV58FngcqxK; Wed,  2 Feb 2022 09:37:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 521D6416D0;
	Wed,  2 Feb 2022 09:37:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14F53C0011;
	Wed,  2 Feb 2022 09:37:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 553CCC000B
 for <iommu@lists.linux-foundation.org>; Wed,  2 Feb 2022 09:37:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3CDA140527
 for <iommu@lists.linux-foundation.org>; Wed,  2 Feb 2022 09:37:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J0M7nA_O5owW for <iommu@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 09:37:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com
 [209.85.222.47])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 50FE640012
 for <iommu@lists.linux-foundation.org>; Wed,  2 Feb 2022 09:37:03 +0000 (UTC)
Received: by mail-ua1-f47.google.com with SMTP id w21so17981767uan.7
 for <iommu@lists.linux-foundation.org>; Wed, 02 Feb 2022 01:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f7pw+B6zWmFJaMU+pROxATX0iaRAJWkl6aIXWssYesQ=;
 b=nGquqn7ribL8eDS47RmknkHQBGnzH24XJzB1A2heswFAOI0LheA3ID/A7XEDKdPhWA
 XA2uL/d8on36+egIHubYYEcaIwYJG8EFJTio3MoAOgCZk0VTDoIBMupbFar5e9qEuhxW
 7vYrnn6idl/TxGVUYA0CNIc1/EFXcsfNy/qcMhVHwWZSEMoAhM3lUWNMojp/Lu0oZGIn
 N8PM/DjKeNzQgVQACXMtVtJpbw1RIpLSz2fLKOlMZ+V5p31txLl/2AxMmGA46iUQGf14
 K1jiewS8SsekOy/Q2Xq21GmUBPwOOuDkK23+hkYudCFIpvszdiPcU2FloDJj86x6LAGF
 8YcQ==
X-Gm-Message-State: AOAM533Adq2FoRlsRYkAEcN+q1g4u5DAHtx4lGz3k8Rmu/T9UKtZIPkx
 DZq1IXWxnMnS6MX6zetbeanIECNhCwSvcw==
X-Google-Smtp-Source: ABdhPJxGU0z7sjS+6I4VptlvHxdLwPjpFAnt2OMv3jJU1pM7/ukWJVwk9NZkGxBFiSzcl2/sUcugWw==
X-Received: by 2002:a67:b845:: with SMTP id o5mr11535303vsh.78.1643794621953; 
 Wed, 02 Feb 2022 01:37:01 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com.
 [209.85.221.181])
 by smtp.gmail.com with ESMTPSA id ba16sm5544634vkb.39.2022.02.02.01.37.01
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Feb 2022 01:37:01 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id u25so8861781vkk.3
 for <iommu@lists.linux-foundation.org>; Wed, 02 Feb 2022 01:37:01 -0800 (PST)
X-Received: by 2002:a05:6122:c8f:: with SMTP id
 ba15mr12396345vkb.39.1643794621176; 
 Wed, 02 Feb 2022 01:37:01 -0800 (PST)
MIME-Version: 1.0
References: <20220125125602.4144793-1-yoshihiro.shimoda.uh@renesas.com>
 <20220125125602.4144793-2-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdXgg8XApJETkN1oDDSy=N01kJaTz4DADyD9ZOM0ZXXttA@mail.gmail.com>
 <TYBPR01MB5341EA35142A1AFCF75F591FD8229@TYBPR01MB5341.jpnprd01.prod.outlook.com>
In-Reply-To: <TYBPR01MB5341EA35142A1AFCF75F591FD8229@TYBPR01MB5341.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 Feb 2022 10:36:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWSCpu0djVJeirGZP-WDSuzvnaWAHWG5wAviX9+Kt2aRQ@mail.gmail.com>
Message-ID: <CAMuHMdWSCpu0djVJeirGZP-WDSuzvnaWAHWG5wAviX9+Kt2aRQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iommu: renesas,
 ipmmu-vmsa: add r8a779f0 support
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Magnus Damm <magnus.damm@gmail.com>,
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

On Fri, Jan 28, 2022 at 1:09 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > From: Geert Uytterhoeven, Sent: Thursday, January 27, 2022 8:06 PM
>
> > On Tue, Jan 25, 2022 at 6:33 PM Yoshihiro Shimoda
> > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > Document the compatible values for the IPMMU-VMSA blocks in
> > > the Renesas R-Car S4-8 (R8A779F0) SoC and R-Car Gen4.
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

> > > --- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
> > > +++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
> > > @@ -44,6 +44,10 @@ properties:
> > >                - renesas,ipmmu-r8a77990 # R-Car E3
> > >                - renesas,ipmmu-r8a77995 # R-Car D3
> > >                - renesas,ipmmu-r8a779a0 # R-Car V3U
> > > +      - items:
> > > +          - enum:
> > > +              - renesas,ipmmu-r8a779f0 # R-Car S4-8
> > > +          - const: renesas,rcar-gen4-ipmmu-vmsa  # R-Car Gen4
> > >
> >
> > I'm wondering if we need the family-specific fallback.
> > For R-Car Gen3, we don't have it, and match on (all) the SoC-specific
> > compatible values instead.
> > Do you remember why we decided to do it that way?
> >
> > At least R-Car V3M/V3H/D3 have slight differences in the register bits,
> > but I don't think that was the reason.
>
> I don't remember why... Maybe, we had never discussed this topic?
> I searched this topic a little on the ML archive, but I could not find it...

Indeed. I also couldn't find a discussion, and most IPMMUs on R-Car
Gen3 SoCs are identical (although there are differences in parts we
don't use in the driver). The IPMMUs in early R-Car Gen3 SoCs also had
issues, so that's probably why we never went with a family-specific
compatible value. And adding it now wouldn't gain us much.

> Since upcoming R-Car Gen4 SoC's IPMMU is the same specification with r8a779f0,
> I believe renesas,rcar-gen4-ipmmu-vmsa is helpful to support it.

Agreed.
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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
