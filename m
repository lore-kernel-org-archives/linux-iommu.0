Return-Path: <SRS0=boqS=DN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7D3C4727E
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 04:27:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D41208B6
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 04:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GzLo7leM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D41208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 37E55865D0;
	Tue,  6 Oct 2020 04:27:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e527igD2lXtZ; Tue,  6 Oct 2020 04:27:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 87472864FB;
	Tue,  6 Oct 2020 04:27:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72025C016F;
	Tue,  6 Oct 2020 04:27:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B623CC0051
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 04:27:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 55BB1204C5
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 04:27:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3gswkhSy+3si for <iommu@lists.linux-foundation.org>;
 Tue,  6 Oct 2020 04:27:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by silver.osuosl.org (Postfix) with ESMTP id DC95420133
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 04:27:03 +0000 (UTC)
X-UUID: fe44045d466046c2aa4dbc44ea12eb0b-20201006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=+pxD8I7KLNWeEZpM4bXar+ZxPMehQGOOhOWN3s3N3JU=; 
 b=GzLo7leMLv2dfhFmyPQRF6WxaRUhzbUAB4qUkyU1Pzmy+n14iptRg2Iv7tHKv7/EYySuOuMjSu/HiePs8kA1CaxalvYlSeqiu9BDT/gT6lqBa/ZH0lsrHfJtQ/SbRirnONWccZOE0jZWRrstLecyZJsozmiqnhwXsmMsdumCvz8=;
X-UUID: fe44045d466046c2aa4dbc44ea12eb0b-20201006
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 538139451; Tue, 06 Oct 2020 12:26:57 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 6 Oct 2020 12:26:55 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 6 Oct 2020 12:26:54 +0800
Message-ID: <1601958415.26323.25.camel@mhfsdcap03>
Subject: Re: [PATCH v3 01/24] dt-bindings: iommu: mediatek: Convert IOMMU to
 DT schema
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 6 Oct 2020 12:26:55 +0800
In-Reply-To: <20201002110709.GC6888@pi3>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
 <20200930070647.10188-2-yong.wu@mediatek.com> <20201002110709.GC6888@pi3>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9A9DF6700EE416CA650EB803451E471F73CB22B3E312AC0B29EBEE4AED21DE852000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 kernel-team@android.com, Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream@mediatek.com, chao.hao@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@google.com>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

On Fri, 2020-10-02 at 13:07 +0200, Krzysztof Kozlowski wrote:
> On Wed, Sep 30, 2020 at 03:06:24PM +0800, Yong Wu wrote:
> > Convert MediaTek IOMMU to DT schema.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  .../bindings/iommu/mediatek,iommu.txt         | 103 ------------
> >  .../bindings/iommu/mediatek,iommu.yaml        | 154 ++++++++++++++++++
> >  2 files changed, 154 insertions(+), 103 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> >  create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > 

[...]

> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - mediatek,mt2701-m4u # mt2701 generation one HW
> > +          - mediatek,mt2712-m4u # mt2712 generation two HW
> > +          - mediatek,mt6779-m4u # mt6779 generation two HW
> > +          - mediatek,mt8173-m4u # mt8173 generation two HW
> > +          - mediatek,mt8183-m4u # mt8183 generation two HW
> > +
> > +      - description: mt7623 generation one HW
> > +        items:
> > +          - const: mediatek,mt7623-m4u
> > +          - const: mediatek,mt2701-m4u
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    description: |
> > +      bclk is optional. here is the list which require this bclk:
> > +      mt2701, mt2712, mt7623 and mt8173.
> 
> Similarly to my comment in other patch, this should be part of schema
> within 'if-then'.

Thanks for the review.

I will change like this:

=============
  clocks:
    items:
      - description: bclk is the block clock.

  clock-names:
    items:
      - const: bclk

required:
  - compatible
  - reg
  - interrupts
  - mediatek,larbs
  - '#iommu-cells'
if:
  properties:
    compatible:
      contains:
        enum:
          - mediatek,mt2701-m4u
          - mediatek,mt2712-m4u
          - mediatek,mt8173-m4u

then:
 required:
   - clocks
==============

If this is not right, please tell me.
(dt_binding_check is ok.)

> 
> Best regards,
> Krzysztof

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
