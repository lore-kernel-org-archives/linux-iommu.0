Return-Path: <SRS0=a71q=DT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6491BC433E7
	for <iommu@archiver.kernel.org>; Mon, 12 Oct 2020 07:18:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E52042080D
	for <iommu@archiver.kernel.org>; Mon, 12 Oct 2020 07:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52042080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 543FC20555;
	Mon, 12 Oct 2020 07:18:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BzSDOizYI3Re; Mon, 12 Oct 2020 07:18:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 07A0B1FEAE;
	Mon, 12 Oct 2020 07:18:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0607C07FF;
	Mon, 12 Oct 2020 07:18:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50D66C0051
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 07:18:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 370CD85521
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 07:18:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZC4neId13a1x for <iommu@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 07:18:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A835385513
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 07:18:48 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id t20so9506769edr.11
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 00:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OCtzqcTvgm/lHz6dwVOWYKE+wIp/najcKC43qSAnkQQ=;
 b=Ep0Kwy6eJG9Rlqsd1XWo4FkcTd16JPDC/zj18npFeJYdRgu9rGbX4QOxKya0vTxsNI
 wBCUIRYuzq+ju5OectNkmrJscvgkVWWRj1xgP+zkJZ1As1B+NmKzkoIAwyVjqc0p9icb
 kuR06EPRF5cbsi3kPYPYhef6RVFyynqtfAGYpA+BAc98vNLaQUhWvjdONKtqYahOsDxM
 rKX6HdKyCZf3ZklVfMxKUnykVJQkhbUb4sCn9svXLej3VHd6w9OgQBsTHqVbHXujVMzo
 CrpF8xvYq7ySvibskND38TaarZXkZMORTPRldM/M/iEjqnuCR7heQVilk+dQCuCbqjwB
 jNNw==
X-Gm-Message-State: AOAM533Y2IWRMVmZ8J3CuTf5QaoKI+HeB8GaCT+NW81a3/yynszhQI7o
 tD8rxDqi9ti+Tin7E4DR0PY=
X-Google-Smtp-Source: ABdhPJzH66RE1w9X2obXO5dNA8hKqBI0KiAd4eRYjVVAQ32i5EUIaFFJfhg/d3NrvvfQG9iIyYP+oQ==
X-Received: by 2002:aa7:c2c4:: with SMTP id m4mr13091357edp.172.1602487127112; 
 Mon, 12 Oct 2020 00:18:47 -0700 (PDT)
Received: from pi3 ([194.230.155.215])
 by smtp.googlemail.com with ESMTPSA id a10sm9995107edu.78.2020.10.12.00.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 00:18:45 -0700 (PDT)
Date: Mon, 12 Oct 2020 09:18:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v3 02/24] dt-bindings: memory: mediatek: Convert SMI to
 DT schema
Message-ID: <20201012071843.GA1889@pi3>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
 <20200930070647.10188-3-yong.wu@mediatek.com>
 <20201002110831.GD6888@pi3> <1601958428.26323.26.camel@mhfsdcap03>
 <CAJKOXPfOOGnJeNCa58WEZqbzaAFdLHSm-7pyMyGkYgCBEt0+RA@mail.gmail.com>
 <1602310691.26323.39.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1602310691.26323.39.camel@mhfsdcap03>
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

On Sat, Oct 10, 2020 at 02:18:11PM +0800, Yong Wu wrote:
> On Tue, 2020-10-06 at 09:15 +0200, Krzysztof Kozlowski wrote:
> > On Tue, 6 Oct 2020 at 06:27, Yong Wu <yong.wu@mediatek.com> wrote:
> > >
> > > On Fri, 2020-10-02 at 13:08 +0200, Krzysztof Kozlowski wrote:
> > > > On Wed, Sep 30, 2020 at 03:06:25PM +0800, Yong Wu wrote:
> > > > > Convert MediaTek SMI to DT schema.
> > > > >
> > > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > > ---
> > > > >  .../mediatek,smi-common.txt                   |  49 ---------
> > > > >  .../mediatek,smi-common.yaml                  | 100 ++++++++++++++++++
> > > > >  .../memory-controllers/mediatek,smi-larb.txt  |  49 ---------
> > > > >  .../memory-controllers/mediatek,smi-larb.yaml |  91 ++++++++++++++++
> > > > >  4 files changed, 191 insertions(+), 98 deletions(-)
> > > > >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> > > > >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> > > > >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
> > > > >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> > > ...
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    oneOf:
> > > > > +      - enum:
> > > > > +          - mediatek,mt2701-smi-common
> > > > > +          - mediatek,mt2712-smi-common
> > > > > +          - mediatek,mt6779-smi-common
> > > > > +          - mediatek,mt8173-smi-common
> > > > > +          - mediatek,mt8183-smi-common
> > > > > +
> > > > > +      - description: for mt7623
> > > > > +        items:
> > > > > +          - const: mediatek,mt7623-smi-common
> > > > > +          - const: mediatek,mt2701-smi-common
> > > > > +
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  clocks:
> > > > > +    description: |
> > > > > +      apb and smi are mandatory. the async is only for generation 1 smi HW.
> > > > > +      gals(global async local sync) also is optional, here is the list which
> > > > > +      require gals: mt6779 and mt8183.
> > > > > +    minItems: 2
> > > > > +    maxItems: 4
> > > > > +    items:
> > > > > +      - description: apb is Advanced Peripheral Bus clock, It's the clock for
> > > > > +          setting the register.
> > > > > +      - description: smi is the clock for transfer data and command.
> > > > > +      - description: async is asynchronous clock, it help transform the smi clock
> > > > > +          into the emi clock domain.
> > > > > +      - description: gals0 is the path0 clock of gals.
> > > > > +      - description: gals1 is the path1 clock of gals.
> > > > > +
> > > > > +  clock-names:
> > > > > +    oneOf:
> > > > > +      - items:
> > > > > +          - const: apb
> > > > > +          - const: smi
> > > > > +      - items:
> > > > > +          - const: apb
> > > > > +          - const: smi
> > > > > +          - const: async
> > > > > +      - items:
> > > > > +          - const: apb
> > > > > +          - const: smi
> > > > > +          - const: gals0
> > > > > +          - const: gals1
> > > >
> > > > Similarly to my comment to other properties, this requirement per
> > > > compatible should be part of the schema within 'if-then'.
> > >
> > > I'm not so familiar with this format. Do this has "if-then-'else
> > > if'-then-else"?
> > 
> > These are mutually exclusive conditions, so you can skip else:
> >  - if-then
> >  - if-then
> >  - if-then
> > It will be more readable then stacking 'if' under 'else'
> 
> Thanks. I will use something like this:
> 
>  anyOf:

Then it should be oneOf as only one condition can be valid.

Best regards,
Krzysztof

>    - if: #gen1 hw
>      then:
>        use apb/smi/async clocks
> 
>    - if: #gen2 hw that has gals.
>      then:
>        use apb/smi/gals0/gals1 clocks
>      else: # gen2 hw that doesn't have gals.
>        use apb/smi clocks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
