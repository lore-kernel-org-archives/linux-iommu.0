Return-Path: <SRS0=IGn4=DU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FD8C43457
	for <iommu@archiver.kernel.org>; Tue, 13 Oct 2020 07:53:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 708AC214D8
	for <iommu@archiver.kernel.org>; Tue, 13 Oct 2020 07:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NfBmMAeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708AC214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 018D08744A;
	Tue, 13 Oct 2020 07:53:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qR2xgdHQ5ug5; Tue, 13 Oct 2020 07:53:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8240B87437;
	Tue, 13 Oct 2020 07:53:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BA0DC07FF;
	Tue, 13 Oct 2020 07:53:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 514E8C0051
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 07:53:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3764387437
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 07:53:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kbcUcF9vjpyw for <iommu@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 07:53:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BBA9A87440
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 07:53:18 +0000 (UTC)
X-UUID: 08507b90f26c4ecab32543976e863125-20201013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=hSQpx7aGiFaBvdW2xKyY2Ng20CMPICvnjIERCoViN0I=; 
 b=NfBmMAeSCOJXXulcR1a0zazmOI998zqF+5u06u0xaBN+d0w/Rm4YTFs5ffJPaGehuk+KJ2ZFoLK7U5gTz22mSa07titI7bYt1+l3FQFdyfUzEVoKToXcLSMpKT4+ngMNCN/K3/OPxVYgo7hyQSbqOpaPG60t5ZJIfUeiBtJ1CfM=;
X-UUID: 08507b90f26c4ecab32543976e863125-20201013
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1838484348; Tue, 13 Oct 2020 15:53:12 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 13 Oct 2020 15:53:10 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 13 Oct 2020 15:53:09 +0800
Message-ID: <1602575589.26323.58.camel@mhfsdcap03>
Subject: Re: [PATCH v3 01/24] dt-bindings: iommu: mediatek: Convert IOMMU to
 DT schema
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 13 Oct 2020 15:53:09 +0800
In-Reply-To: <CAJKOXPedQdOYque5igJ0_v_-_0L4S+NW6puUw-kWc+zWM96i_Q@mail.gmail.com>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
 <20200930070647.10188-2-yong.wu@mediatek.com> <20201002110709.GC6888@pi3>
 <1601958415.26323.25.camel@mhfsdcap03>
 <CAJKOXPedQdOYque5igJ0_v_-_0L4S+NW6puUw-kWc+zWM96i_Q@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F0136768EC9E69320BFE32C8620BE1722F1A041A55A2EB7E73DFE4BD0D6C98E72000:8
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

On Mon, 2020-10-12 at 19:08 +0200, Krzysztof Kozlowski wrote:
> On Tue, 6 Oct 2020 at 06:27, Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > On Fri, 2020-10-02 at 13:07 +0200, Krzysztof Kozlowski wrote:
> > > On Wed, Sep 30, 2020 at 03:06:24PM +0800, Yong Wu wrote:
> > > > Convert MediaTek IOMMU to DT schema.
> > > >
> > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > ---
> > > >  .../bindings/iommu/mediatek,iommu.txt         | 103 ------------
> > > >  .../bindings/iommu/mediatek,iommu.yaml        | 154 ++++++++++++++++++
> > > >  2 files changed, 154 insertions(+), 103 deletions(-)
> > > >  delete mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> > > >  create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > > >
> >
> > [...]
> >
> > > > +properties:
> > > > +  compatible:
> > > > +    oneOf:
> > > > +      - enum:
> > > > +          - mediatek,mt2701-m4u # mt2701 generation one HW
> > > > +          - mediatek,mt2712-m4u # mt2712 generation two HW
> > > > +          - mediatek,mt6779-m4u # mt6779 generation two HW
> > > > +          - mediatek,mt8173-m4u # mt8173 generation two HW
> > > > +          - mediatek,mt8183-m4u # mt8183 generation two HW
> > > > +
> > > > +      - description: mt7623 generation one HW
> > > > +        items:
> > > > +          - const: mediatek,mt7623-m4u
> > > > +          - const: mediatek,mt2701-m4u
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupts:
> > > > +    maxItems: 1
> > > > +
> > > > +  clocks:
> > > > +    description: |
> > > > +      bclk is optional. here is the list which require this bclk:
> > > > +      mt2701, mt2712, mt7623 and mt8173.
> > >
> > > Similarly to my comment in other patch, this should be part of schema
> > > within 'if-then'.
> >
> > Thanks for the review.
> >
> > I will change like this:
> >
> > =============
> >   clocks:
> >     items:
> >       - description: bclk is the block clock.
> >
> >   clock-names:
> >     items:
> >       - const: bclk
> >
> > required:
> >   - compatible
> >   - reg
> >   - interrupts
> >   - mediatek,larbs
> >   - '#iommu-cells'
> > if:
> >   properties:
> >     compatible:
> >       contains:
> >         enum:
> >           - mediatek,mt2701-m4u
> >           - mediatek,mt2712-m4u
> >           - mediatek,mt8173-m4u
> >
> > then:
> >  required:
> >    - clocks
> > ==============
> >
> > If this is not right, please tell me.
> > (dt_binding_check is ok.)
> 
> Looks fine, except "if" should be part of some "allOf" block.

Thanks very much for the review.
I will add "allOf" in next version.

> 
> Best regards,
> Krzysztof

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
