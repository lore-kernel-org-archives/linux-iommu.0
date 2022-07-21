Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4CE23A0
	for <iommu@lists.linux.dev>; Thu, 21 Jul 2022 03:06:03 +0000 (UTC)
X-UUID: cac5e9ea882b41ceb2d9e69b9651768f-20220721
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:367f56b9-ddfa-4a76-b32c-813601af4475,OB:0,LO
	B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:3c1f8a33-b9e4-42b8-b28a-6364427c76bb,C
	OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
	,QS:nil,BEC:nil,COL:0
X-UUID: cac5e9ea882b41ceb2d9e69b9651768f-20220721
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <tinghan.shen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1690676264; Thu, 21 Jul 2022 11:05:58 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 21 Jul 2022 11:05:56 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 21 Jul 2022 11:05:56 +0800
Message-ID: <00bc3a146f39feb1a83213fc8503ad1b52cda9f9.camel@mediatek.com>
Subject: Re: [PATCH v3 06/21] dt-bindings: power: mediatek: Add bindings for
 MediaTek SCPSYS
From: Tinghan Shen <tinghan.shen@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Yong Wu
	<yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Lee Jones <lee.jones@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, MandyJH Liu
	<mandyjh.liu@mediatek.com>
CC: <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Date: Thu, 21 Jul 2022 11:05:56 +0800
In-Reply-To: <57b0cf62-0312-05cf-31ff-d38f83a35578@linaro.org>
References: <20220720123023.13500-1-tinghan.shen@mediatek.com>
	 <20220720123023.13500-7-tinghan.shen@mediatek.com>
	 <57b0cf62-0312-05cf-31ff-d38f83a35578@linaro.org>
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

On Wed, 2022-07-20 at 19:35 +0200, Krzysztof Kozlowski wrote:
> On 20/07/2022 14:30, Tinghan Shen wrote:
> > The System Control Processor System (SCPSYS) has several power
> > management related tasks in the system. Add the bindings for it.
> > 
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > ---
> >  .../bindings/mfd/mediatek,mt8195-scpsys.yaml  | 68 +++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
> > b/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
> > new file mode 100644
> > index 000000000000..4117a6dbc19c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
> > @@ -0,0 +1,68 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: 
> > https://urldefense.com/v3/__http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml*__;Iw!!CTRNKA9wMg0ARbw!y63E-9qbCW_vyn8RrsCCs7YvZ7NxKqFT7l8C0ZZirEW95Ec0ce3lwegsSq51wrjtz8GjVSpkK-omCBP5CKx1l0WESQ$
> >  
> > +$schema: 
> > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!y63E-9qbCW_vyn8RrsCCs7YvZ7NxKqFT7l8C0ZZirEW95Ec0ce3lwegsSq51wrjtz8GjVSpkK-omCBP5CKzzr9p82Q$
> >  
> > +
> > +title: MediaTek System Control Processor System
> > +
> > +maintainers:
> > +  - MandyJH Liu <mandyjh.liu@mediatek.com>
> > +
> > +description:
> > +  MediaTek System Control Processor System (SCPSYS) has several
> > +  power management tasks. The tasks include MTCMOS power
> > +  domain control, thermal measurement, DVFS, etc.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - mediatek,mt8167-scpsys
> > +          - mediatek,mt8173-scpsys
> > +          - mediatek,mt8183-scpsys
> > +          - mediatek,mt8192-scpsys
> > +          - mediatek,mt8195-scpsys
> > +      - const: syscon
> > +      - const: simple-mfd
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +patternProperties:
> > +  "^power-controller(@[0-9a-f]+)?$":
> > +    $ref: /schemas/power/mediatek,power-controller.yaml#
> 
> We talked that unit address might be useful but it was with an
> assumption that you will actually use it. I think you don't use it, so
> it is kind of meaningless now... unless you plan to use it?

I tried to add the offset in the node name, but the binding check reports this message.
 	
    power-controller@0: node has a unit name, but no reg or ranges property

After considering the fact of mt8195 power controller HW resides in scpsys and the current power
domain driver doesn't support parsing the register address seperated from scpsys, I decide to
keep the power controller node as in v2 to pass the binding check and compatible with driver.

> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/mt8195-clk.h>
> > +    #include <dt-bindings/power/mt8195-power.h>
> > +
> > +    syscon@10006000 {
> > +        compatible = "mediatek,mt8195-scpsys", "syscon", "simple-mfd";
> > +        reg = <0x10006000 0x100>;
> > +
> > +        spm: power-controller {
> > +            compatible = "mediatek,mt8195-power-controller";
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +            #power-domain-cells = <1>;
> > +
> > +            /* sample of power domain nodes */
> > +            power-domain@MT8195_POWER_DOMAIN_PCIE_PHY {
> > +                    reg = <MT8195_POWER_DOMAIN_PCIE_PHY>;
> 
> Wrong indentation.

I missed checking this. I'll udpate in the next version.

Thanks,
TingHan

