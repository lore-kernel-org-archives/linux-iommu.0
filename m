Return-Path: <SRS0=IGn4=DU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254ABC43467
	for <iommu@archiver.kernel.org>; Tue, 13 Oct 2020 07:53:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5999720E65
	for <iommu@archiver.kernel.org>; Tue, 13 Oct 2020 07:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SrxHuU98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5999720E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CC41587AE3;
	Tue, 13 Oct 2020 07:53:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id faXk8uXmAfRI; Tue, 13 Oct 2020 07:53:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 42B1A87A1D;
	Tue, 13 Oct 2020 07:53:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29C3FC07FF;
	Tue, 13 Oct 2020 07:53:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37BD9C0051
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 07:53:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 25FC487446
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 07:53:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VmLIQrhJwmzO for <iommu@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 07:53:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3980187437
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 07:53:17 +0000 (UTC)
X-UUID: 1bc43fa47d6d4977b55a3f99a1ded0d3-20201013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=DqRT1QzR0Az1H7G9M7+DPOyyJAXgFclekkLZ6dVnoXo=; 
 b=SrxHuU98NW7Ucopy/DZ6FpAQgFmdT/j283ahD0i5iG89EdkjAShRpEb/8qBMwdJZ68ECNxXo/tP4vfGNk2x8chc86qjh0NUWKqE0O3C95hRj2s3sINlfdqPhFhT95ll8wjG6dtspOyOdTkvgOxmLtgJDkIiDeO9aFs+g8dno3fE=;
X-UUID: 1bc43fa47d6d4977b55a3f99a1ded0d3-20201013
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 491742245; Tue, 13 Oct 2020 15:53:10 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 13 Oct 2020 15:53:08 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 13 Oct 2020 15:53:07 +0800
Message-ID: <1602575587.26323.57.camel@mhfsdcap03>
Subject: Re: [PATCH v3 02/24] dt-bindings: memory: mediatek: Convert SMI to
 DT schema
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 13 Oct 2020 15:53:07 +0800
In-Reply-To: <CAJKOXPcn4scqt2C9eE_EikJ76kqro2QYzThdsXXR_5xtBmyH3g@mail.gmail.com>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
 <20200930070647.10188-3-yong.wu@mediatek.com> <20201002110831.GD6888@pi3>
 <1601958428.26323.26.camel@mhfsdcap03>
 <CAJKOXPfOOGnJeNCa58WEZqbzaAFdLHSm-7pyMyGkYgCBEt0+RA@mail.gmail.com>
 <1602310691.26323.39.camel@mhfsdcap03> <20201012071843.GA1889@pi3>
 <1602504119.26323.54.camel@mhfsdcap03>
 <CAJKOXPcn4scqt2C9eE_EikJ76kqro2QYzThdsXXR_5xtBmyH3g@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: A35EB6041BCAB07ACFCEAFF35E492E76178322A7338BA766BED6CFFA117BDB422000:8
X-MTK: N
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

On Mon, 2020-10-12 at 15:26 +0200, Krzysztof Kozlowski wrote:
> On Mon, 12 Oct 2020 at 14:02, Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > On Mon, 2020-10-12 at 09:18 +0200, Krzysztof Kozlowski wrote:
> > > On Sat, Oct 10, 2020 at 02:18:11PM +0800, Yong Wu wrote:
> > > > On Tue, 2020-10-06 at 09:15 +0200, Krzysztof Kozlowski wrote:
> > > > > On Tue, 6 Oct 2020 at 06:27, Yong Wu <yong.wu@mediatek.com> wrote:
> > > > > >
> > > > > > On Fri, 2020-10-02 at 13:08 +0200, Krzysztof Kozlowski wrote:
> > > > > > > On Wed, Sep 30, 2020 at 03:06:25PM +0800, Yong Wu wrote:
> > > > > > > > Convert MediaTek SMI to DT schema.
> > > > > > > >
> > > > > > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > > > > > ---
> > > > > > > >  .../mediatek,smi-common.txt                   |  49 ---------
> > > > > > > >  .../mediatek,smi-common.yaml                  | 100 ++++++++++++++++++
> > > > > > > >  .../memory-controllers/mediatek,smi-larb.txt  |  49 ---------
> > > > > > > >  .../memory-controllers/mediatek,smi-larb.yaml |  91 ++++++++++++++++
> > > > > > > >  4 files changed, 191 insertions(+), 98 deletions(-)
> > > > > > > >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> > > > > > > >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> > > > > > > >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
> > > > > > > >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> > > > > > ...
> > > > > > > > +properties:
> > > > > > > > +  compatible:
> > > > > > > > +    oneOf:
> > > > > > > > +      - enum:
> > > > > > > > +          - mediatek,mt2701-smi-common
> > > > > > > > +          - mediatek,mt2712-smi-common
> > > > > > > > +          - mediatek,mt6779-smi-common
> > > > > > > > +          - mediatek,mt8173-smi-common
> > > > > > > > +          - mediatek,mt8183-smi-common
> > > > > > > > +
> > > > > > > > +      - description: for mt7623
> > > > > > > > +        items:
> > > > > > > > +          - const: mediatek,mt7623-smi-common
> > > > > > > > +          - const: mediatek,mt2701-smi-common
> > > > > > > > +
> > > > > > > > +  reg:
> > > > > > > > +    maxItems: 1
> > > > > > > > +
> > > > > > > > +  clocks:
> > > > > > > > +    description: |
> > > > > > > > +      apb and smi are mandatory. the async is only for generation 1 smi HW.
> > > > > > > > +      gals(global async local sync) also is optional, here is the list which
> > > > > > > > +      require gals: mt6779 and mt8183.
> > > > > > > > +    minItems: 2
> > > > > > > > +    maxItems: 4
> > > > > > > > +    items:
> > > > > > > > +      - description: apb is Advanced Peripheral Bus clock, It's the clock for
> > > > > > > > +          setting the register.
> > > > > > > > +      - description: smi is the clock for transfer data and command.
> > > > > > > > +      - description: async is asynchronous clock, it help transform the smi clock
> > > > > > > > +          into the emi clock domain.
> > > > > > > > +      - description: gals0 is the path0 clock of gals.
> > > > > > > > +      - description: gals1 is the path1 clock of gals.
> > > > > > > > +
> > > > > > > > +  clock-names:
> > > > > > > > +    oneOf:
> > > > > > > > +      - items:
> > > > > > > > +          - const: apb
> > > > > > > > +          - const: smi
> > > > > > > > +      - items:
> > > > > > > > +          - const: apb
> > > > > > > > +          - const: smi
> > > > > > > > +          - const: async
> > > > > > > > +      - items:
> > > > > > > > +          - const: apb
> > > > > > > > +          - const: smi
> > > > > > > > +          - const: gals0
> > > > > > > > +          - const: gals1
> > > > > > >
> > > > > > > Similarly to my comment to other properties, this requirement per
> > > > > > > compatible should be part of the schema within 'if-then'.
> > > > > >
> > > > > > I'm not so familiar with this format. Do this has "if-then-'else
> > > > > > if'-then-else"?
> > > > >
> > > > > These are mutually exclusive conditions, so you can skip else:
> > > > >  - if-then
> > > > >  - if-then
> > > > >  - if-then
> > > > > It will be more readable then stacking 'if' under 'else'
> > > >
> > > > Thanks. I will use something like this:
> > > >
> > > >  anyOf:
> > >
> > > Then it should be oneOf as only one condition can be valid.
> >
> > I did do this at the beginning. But I get a warning log when
> > dt_binding_check.
> 
> Mhmm, right, since "if-else" matches in either of arms, then oneOf
> will complain as it expects only one of items to match.  Then just go
> with allOf. anyOf might match zero of items, so it would not catch
> actual errors, I think.

Thanks for the confirm. I will use "allOf" in next version.

> 
> Best regards,
> Krzysztof

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
