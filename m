Return-Path: <SRS0=meaX=6A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B897C2BB85
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 10:06:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B3082051A
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 10:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3082051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E301C221C6;
	Thu, 16 Apr 2020 10:06:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id txViDYKAytRz; Thu, 16 Apr 2020 10:06:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 48538221AB;
	Thu, 16 Apr 2020 10:06:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FD16C1D89;
	Thu, 16 Apr 2020 10:06:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6532DC1AE8
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 10:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 60CFF875CD
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 10:06:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2-QzWliV6pmo for <iommu@lists.linux-foundation.org>;
 Thu, 16 Apr 2020 10:06:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oo1-f66.google.com (mail-yw1-f66.google.com
 [209.85.161.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 799DB875A9
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 10:06:34 +0000 (UTC)
Received: by mail-oo1-f66.google.com with SMTP id d21so528882ook.10
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 03:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KwXb3b2d+oSOAkRZRE7aGCXWKVWlnHU5Xmb0ZMFtkXQ=;
 b=D2tVAVVbXtULpd24phDo4EzaB0omEDjwW3qB6p4GeIYn8A2e2h8Ymjpp+J/NpI31he
 cSHi9QSTSsazFk8SOBS3srpovFmd7lv34KKR51og01vpKHTQhW9mclSVxzJzbvbN0q76
 fkx+cLlr+m7Z99T7mWsMU+kZllHzEzgSmefsj7BBuhUhRSQne9vJ4O58Vx0PHKClJ8aJ
 +WULpBXSpC1gJXDa+XVx/dcTeIjT1mFgksu6HsoY25G50NVo+FZWLVSX80lF75QCay2v
 lRBNH+6dbbiRGUY4Pc+Y2wkTRlsBVFm1h3FubJFcMK9H4dODljmkA2ohOTIRdz2hAHB5
 sASQ==
X-Gm-Message-State: AGi0PuaeXFVqWkSi3aBj5K8Ch6BPV6kIwUiSbGv8nbMJr3tjPTa4oraS
 ODgiFkH5wUpORr5DGyeTAXyDvaZO8xqXKyJlR2g=
X-Google-Smtp-Source: APiQypIECoyArWol5p8FJU78Zz2jMDBD8aMqqoEHgACR4iaBZONUmm/3S4d4RiyMOQM81Rrvcr8Uem1CfMGfk9wwqZg=
X-Received: by 2002:a4a:e1af:: with SMTP id 15mr4669777ooy.40.1587031593670;
 Thu, 16 Apr 2020 03:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <1586773533-8893-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdXvZp5GFY5-SjXP0PLE8MiwYencVMti93wU4E3N2c0QVg@mail.gmail.com>
 <TYAPR01MB45440F928F3DDBFCDC0A25CED8D80@TYAPR01MB4544.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB45440F928F3DDBFCDC0A25CED8D80@TYAPR01MB4544.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2020 12:06:22 +0200
Message-ID: <CAMuHMdUvSka3F=3mU0qpjcOxQVftyxjHFhXbx7b+Pun9226L9g@mail.gmail.com>
Subject: Re: [PATCH] dt-bndings: iommu: renesas,
 ipmmu-vmsa: convert to json-schema
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>
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

On Thu, Apr 16, 2020 at 11:56 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > From: Geert Uytterhoeven, Sent: Wednesday, April 15, 2020 11:21 PM
> > On Tue, Apr 14, 2020 at 2:26 AM Yoshihiro Shimoda
> > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > Convert Renesas VMSA-Compatible IOMMU bindings documentation
> > > to json-schema.
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml

> > > +  renesas,ipmmu-main:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +    description:
> > > +      Reference to the main IPMMU instance in two cells. The first cell is
> > > +      a phandle to the main IPMMU and the second cell is the interrupt bit
> > > +      number associated with the particular cache IPMMU device. The interrupt
> > > +      bit number needs to match the main IPMMU IMSSTR register. Only used by
> > > +      cache IPMMU instances.
> >
> > This property is not valid only on R-Car Gen2 and R-Mobile APE6.
>
> That sounds good. But, since ipmmu_mm on R-Car Gen3 also is not valid,
> we cannot use compatible property for detecting it.

What do you mean by "ipmmu_mm is not valid"?

> However, I realized renesas,ipmmu-main is only used by "cache IPMMU"
> and "cache IPMMU" doesn't have interrupts property. So,
> I described the following schema and then it seems success.
> --
> if:
>   properties:
>     interrupts: false
> then:
>   required:
>     - renesas,ipmmu-main

But all other nodes should have interrupts properties, right?
So they are mutually exclusive:

  oneOf:
     - required:
         - interrupts
    - required:
        - renesas,ipmmu-main

> Especially, I could find missing renesas,ipmmu-main property on r8a77980.dtsi
> like below :)  So, I'll make and submit a fixing r8a77980.dtsi patch later (maybe tomorrow).

Good! ;-)

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
