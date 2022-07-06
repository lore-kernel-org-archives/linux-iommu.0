Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E670C43334
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 04:03:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B50683372;
	Wed,  6 Jul 2022 04:03:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2B50683372
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d3L5YKJfA_wq; Wed,  6 Jul 2022 04:03:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E652E8328E;
	Wed,  6 Jul 2022 04:03:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E652E8328E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE79BC0077;
	Wed,  6 Jul 2022 04:03:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5E7AC0070
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 04:03:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 72FE283372
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 04:03:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 72FE283372
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C8nVftGqSaQR for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 04:03:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 92EB68328E
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 92EB68328E
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 04:03:27 +0000 (UTC)
X-UUID: 18eea4dd7bf84249a9b9bebb3bcdeca7-20220706
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8, REQID:27eb5d56-54ae-4fd7-b544-b0014f961ffb, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
 ON:release,TS:0
X-CID-META: VersionHash:0f94e32, CLOUDID:ff85b8d6-5d6d-4eaf-a635-828a3ee48b7c,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
 ,QS:nil,BEC:nil,COL:0
X-UUID: 18eea4dd7bf84249a9b9bebb3bcdeca7-20220706
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw01.mediatek.com (envelope-from <tinghan.shen@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 793912462; Wed, 06 Jul 2022 12:03:20 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; 
 Wed, 6 Jul 2022 12:03:18 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 6 Jul 2022 12:03:18 +0800
Message-ID: <4138b6eff8b83eb5954e84452bb84f77d42bd558.camel@mediatek.com>
Subject: Re: [PATCH v1 01/16] dt-bindings: iommu: mediatek: Increase max
 interrupt number
To: Rob Herring <robh@kernel.org>
Date: Wed, 6 Jul 2022 12:03:18 +0800
In-Reply-To: <20220705204902.GA2596733-robh@kernel.org>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-2-tinghan.shen@mediatek.com>
 <20220705204902.GA2596733-robh@kernel.org>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: devicetree@vger.kernel.org, Weiyi Lu <weiyi.lu@mediatek.com>,
 linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, Enric
 Balletbo i Serra <enric.balletbo@collabora.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Will
 Deacon <will@kernel.org>, Chun-Jie Chen <chun-jie.chen@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
From: Tinghan Shen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tinghan Shen <tinghan.shen@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, 2022-07-05 at 14:49 -0600, Rob Herring wrote:
> On Mon, Jul 04, 2022 at 06:00:13PM +0800, Tinghan Shen wrote:
> > mt8195 infra iommu has max 5 interrupts.
> > 
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > ---
> >  .../devicetree/bindings/iommu/mediatek,iommu.yaml    | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > index 2ae3bbad7f1a..27eb9f6aa3ce 100644
> > --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > @@ -91,7 +91,8 @@ properties:
> >      maxItems: 1
> >  
> >    interrupts:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 5
> >  
> >    clocks:
> >      items:
> > @@ -175,9 +176,18 @@ allOf:
> >                const: mediatek,mt8195-iommu-infra
> >  
> >      then:
> > +      properties:
> > +        interrupts:
> > +          maxItems: 1
> > +
> >        required:
> >          - mediatek,larbs
> >  
> > +    else:
> > +      properties:
> > +        interrupts:
> > +          maxItems: 5
> 
> 5 is already the max.
> 
> minItems: 5
> 

Ok, I'll update in the next version.

Thanks,
TingHan

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
