Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084F17F
	for <iommu@lists.linux.dev>; Thu,  4 Aug 2022 02:07:00 +0000 (UTC)
X-UUID: 2c7844a7dea340588d92b79039ce462b-20220804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Zmsrh9X/3g/WCH83lm05EdCSEeqf+efWw7k7n+0nfG0=;
	b=LPsxH2RO+q84+3EsLEWIrbXsBfmmJlPvxHPdKddriMd9a90DQxnj4HgdqgI15Eayn6OLQYiCPk/nl8O862Wf7EKIqbEuiSX/2Mgn+c8wyoyEqctHEL9hkflqN5vV40EA+cCXciEUFYWFH8cgsF04piztSMpaxb9pDrUeZLr4zDQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:72e9a3c4-ea60-40fe-bf02-62777eb7328b,OB:20,L
	OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,AC
	TION:release,TS:45
X-CID-INFO: VERSION:1.1.8,REQID:72e9a3c4-ea60-40fe-bf02-62777eb7328b,OB:20,LOB
	:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTI
	ON:release,TS:45
X-CID-META: VersionHash:0f94e32,CLOUDID:156e3bd0-a6cf-4fb6-be1b-c60094821ca2,C
	OID:9c5ba593ae66,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 2c7844a7dea340588d92b79039ce462b-20220804
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
	(envelope-from <tinghan.shen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
	with ESMTP id 1915268839; Thu, 04 Aug 2022 10:06:54 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 4 Aug 2022 10:06:53 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 4 Aug 2022 10:06:53 +0800
Message-ID: <a745e0bb0ccc6a3686549386cd2aad404ee60faa.camel@mediatek.com>
Subject: Re: [PATCH v4 01/20] dt-bindings: iommu: mediatek: Increase max
 interrupt number
From: Tinghan Shen <tinghan.shen@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Lee Jones <lee@kernel.org>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, MandyJH Liu
	<mandyjh.liu@mediatek.com>
CC: <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<chengci.xu@mediatek.com>
Date: Thu, 4 Aug 2022 10:06:53 +0800
In-Reply-To: <0085fdd057687637ebd5a7688897a279e72e03f6.camel@mediatek.com>
References: <20220729063208.16799-1-tinghan.shen@mediatek.com>
	 <20220729063208.16799-2-tinghan.shen@mediatek.com>
	 <0085fdd057687637ebd5a7688897a279e72e03f6.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N

On Mon, 2022-08-01 at 20:04 +0800, Yong Wu wrote:
> On Fri, 2022-07-29 at 14:31 +0800, Tinghan Shen wrote:
> > mt8195 infra iommu uses 5 interrupts.
> > 
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  .../bindings/iommu/mediatek,iommu.yaml         | 18
> > +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > index fee0241b50988..5afe2a0045330 100644
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
> > @@ -191,9 +192,24 @@ allOf:
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
> > +          description: The IOMMU has 5 banks. Each bank has its own
> > interrupt.
> > +          items:
> > +            - description: The interrupt for IOMMU bank0
> > +            - description: The interrupt for IOMMU bank1
> > +            - description: The interrupt for IOMMU bank2
> > +            - description: The interrupt for IOMMU bank3
> > +            - description: The interrupt for IOMMU bank4
> > +
> 
> Thanks for improving this.
> 
> Before the meaning for this segment is that it require "mediatek,larbs"
> if it is NOT infra iommu. Here we add a new block for infra iommu.
> then we'd better to remove the "not". this should be more readable.
> Something like below:
> 
> if:
>    /* Remove the not here. */
>    properties:
>      compatible:
>        contains:
>          const: mediatek,mt8195-iommu-infra
> then:
>   xxx
> else:
>   xx
> 

Ok, I'll update in the next version.


Thanks,
TingHan


