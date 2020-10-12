Return-Path: <SRS0=a71q=DT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13753C433E7
	for <iommu@archiver.kernel.org>; Mon, 12 Oct 2020 13:26:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E1F12072C
	for <iommu@archiver.kernel.org>; Mon, 12 Oct 2020 13:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2D2ESyQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1F12072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2856C85F59;
	Mon, 12 Oct 2020 13:26:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4-eVsPnesP7R; Mon, 12 Oct 2020 13:26:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9685F85C67;
	Mon, 12 Oct 2020 13:26:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85901C0052;
	Mon, 12 Oct 2020 13:26:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 985F2C0051
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 13:26:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7E8568708E
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 13:26:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HMMHMWDTdAUW for <iommu@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 13:26:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 330E687077
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 13:26:20 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7D91120838
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 13:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602509179;
 bh=yGzfcblPNkEu1jThQo3Kr1pZhnuRpAynpzlLmU3Eyto=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=2D2ESyQOMTChv7yvxLAiD0dAuxlG0M14eT38MlEDqC6L6xVG1ZHu4M9xJTVMu5neu
 envgnta/HiKRtEOq8DzGGEU2tSlQMCpbouoj1QusJ1hHAbZKyt9hdK0qWJrfv3/G+f
 WjCjzSGa8vfOIx5nqxsYLyVIBn2+E5lpoNLRstuk=
Received: by mail-ed1-f49.google.com with SMTP id 33so16857280edq.13
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 06:26:19 -0700 (PDT)
X-Gm-Message-State: AOAM5338tcipfx2pqTLsYcN3PJKn+tGW+y1oX9nwqkkMFlagpkskjTo4
 IG6s/DAeI/j6+TWOiNQpYvTgV42p8vXmVkeAiQM=
X-Google-Smtp-Source: ABdhPJxZI9QpirJF8bPQYjiJrUckib3iXod98Zoj/Cz28ZEeJBmZJyvnNsh48f+gVrrDxErmHk+CoScI5f/RtUGp454=
X-Received: by 2002:a50:8b62:: with SMTP id l89mr14553273edl.132.1602509177952; 
 Mon, 12 Oct 2020 06:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200930070647.10188-1-yong.wu@mediatek.com>
 <20200930070647.10188-3-yong.wu@mediatek.com>
 <20201002110831.GD6888@pi3> <1601958428.26323.26.camel@mhfsdcap03>
 <CAJKOXPfOOGnJeNCa58WEZqbzaAFdLHSm-7pyMyGkYgCBEt0+RA@mail.gmail.com>
 <1602310691.26323.39.camel@mhfsdcap03> <20201012071843.GA1889@pi3>
 <1602504119.26323.54.camel@mhfsdcap03>
In-Reply-To: <1602504119.26323.54.camel@mhfsdcap03>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 12 Oct 2020 15:26:05 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcn4scqt2C9eE_EikJ76kqro2QYzThdsXXR_5xtBmyH3g@mail.gmail.com>
Message-ID: <CAJKOXPcn4scqt2C9eE_EikJ76kqro2QYzThdsXXR_5xtBmyH3g@mail.gmail.com>
Subject: Re: [PATCH v3 02/24] dt-bindings: memory: mediatek: Convert SMI to DT
 schema
To: Yong Wu <yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 kernel-team@android.com, Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream@mediatek.com, chao.hao@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Mon, 12 Oct 2020 at 14:02, Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Mon, 2020-10-12 at 09:18 +0200, Krzysztof Kozlowski wrote:
> > On Sat, Oct 10, 2020 at 02:18:11PM +0800, Yong Wu wrote:
> > > On Tue, 2020-10-06 at 09:15 +0200, Krzysztof Kozlowski wrote:
> > > > On Tue, 6 Oct 2020 at 06:27, Yong Wu <yong.wu@mediatek.com> wrote:
> > > > >
> > > > > On Fri, 2020-10-02 at 13:08 +0200, Krzysztof Kozlowski wrote:
> > > > > > On Wed, Sep 30, 2020 at 03:06:25PM +0800, Yong Wu wrote:
> > > > > > > Convert MediaTek SMI to DT schema.
> > > > > > >
> > > > > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > > > > ---
> > > > > > >  .../mediatek,smi-common.txt                   |  49 ---------
> > > > > > >  .../mediatek,smi-common.yaml                  | 100 ++++++++++++++++++
> > > > > > >  .../memory-controllers/mediatek,smi-larb.txt  |  49 ---------
> > > > > > >  .../memory-controllers/mediatek,smi-larb.yaml |  91 ++++++++++++++++
> > > > > > >  4 files changed, 191 insertions(+), 98 deletions(-)
> > > > > > >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> > > > > > >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> > > > > > >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
> > > > > > >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> > > > > ...
> > > > > > > +properties:
> > > > > > > +  compatible:
> > > > > > > +    oneOf:
> > > > > > > +      - enum:
> > > > > > > +          - mediatek,mt2701-smi-common
> > > > > > > +          - mediatek,mt2712-smi-common
> > > > > > > +          - mediatek,mt6779-smi-common
> > > > > > > +          - mediatek,mt8173-smi-common
> > > > > > > +          - mediatek,mt8183-smi-common
> > > > > > > +
> > > > > > > +      - description: for mt7623
> > > > > > > +        items:
> > > > > > > +          - const: mediatek,mt7623-smi-common
> > > > > > > +          - const: mediatek,mt2701-smi-common
> > > > > > > +
> > > > > > > +  reg:
> > > > > > > +    maxItems: 1
> > > > > > > +
> > > > > > > +  clocks:
> > > > > > > +    description: |
> > > > > > > +      apb and smi are mandatory. the async is only for generation 1 smi HW.
> > > > > > > +      gals(global async local sync) also is optional, here is the list which
> > > > > > > +      require gals: mt6779 and mt8183.
> > > > > > > +    minItems: 2
> > > > > > > +    maxItems: 4
> > > > > > > +    items:
> > > > > > > +      - description: apb is Advanced Peripheral Bus clock, It's the clock for
> > > > > > > +          setting the register.
> > > > > > > +      - description: smi is the clock for transfer data and command.
> > > > > > > +      - description: async is asynchronous clock, it help transform the smi clock
> > > > > > > +          into the emi clock domain.
> > > > > > > +      - description: gals0 is the path0 clock of gals.
> > > > > > > +      - description: gals1 is the path1 clock of gals.
> > > > > > > +
> > > > > > > +  clock-names:
> > > > > > > +    oneOf:
> > > > > > > +      - items:
> > > > > > > +          - const: apb
> > > > > > > +          - const: smi
> > > > > > > +      - items:
> > > > > > > +          - const: apb
> > > > > > > +          - const: smi
> > > > > > > +          - const: async
> > > > > > > +      - items:
> > > > > > > +          - const: apb
> > > > > > > +          - const: smi
> > > > > > > +          - const: gals0
> > > > > > > +          - const: gals1
> > > > > >
> > > > > > Similarly to my comment to other properties, this requirement per
> > > > > > compatible should be part of the schema within 'if-then'.
> > > > >
> > > > > I'm not so familiar with this format. Do this has "if-then-'else
> > > > > if'-then-else"?
> > > >
> > > > These are mutually exclusive conditions, so you can skip else:
> > > >  - if-then
> > > >  - if-then
> > > >  - if-then
> > > > It will be more readable then stacking 'if' under 'else'
> > >
> > > Thanks. I will use something like this:
> > >
> > >  anyOf:
> >
> > Then it should be oneOf as only one condition can be valid.
>
> I did do this at the beginning. But I get a warning log when
> dt_binding_check.

Mhmm, right, since "if-else" matches in either of arms, then oneOf
will complain as it expects only one of items to match.  Then just go
with allOf. anyOf might match zero of items, so it would not catch
actual errors, I think.

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
