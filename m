Return-Path: <SRS0=oYak=EI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F36DC00A89
	for <iommu@archiver.kernel.org>; Mon,  2 Nov 2020 05:31:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E9722272
	for <iommu@archiver.kernel.org>; Mon,  2 Nov 2020 05:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZLVHo+aS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E9722272
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B0A8987449;
	Mon,  2 Nov 2020 05:31:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NUhcnkmMh8Z8; Mon,  2 Nov 2020 05:31:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1C10785EAC;
	Mon,  2 Nov 2020 05:31:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00CF9C0889;
	Mon,  2 Nov 2020 05:31:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32633C0051
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 05:31:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 15EA98685A
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 05:31:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y3GDaT03GKfm for <iommu@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 05:31:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by whitealder.osuosl.org (Postfix) with ESMTP id 44C5E86957
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 05:31:49 +0000 (UTC)
X-UUID: 3b0aed76e2bc4c81b33745fc93cfc3f2-20201102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=cV4gOZgbQyw9goU3SziyAlEvKvp/S9N1fy8pc7rAB3Q=; 
 b=ZLVHo+aSzV7qBB4sT5EPJ6lYGQMoM8axFc3P0DOPQyBwMXNwurcX5c+kMX9sHrfkciM8Zq4GoVdxFNzRRqA9Qg1/CeeqVX+whkjVkZT0TEHh0RQ1slxanAUWtz+vOy6mXa9djUH7enMM/fSv9ftdvH4fp5zj1ollUO1rZQdY0vE=;
X-UUID: 3b0aed76e2bc4c81b33745fc93cfc3f2-20201102
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1499802131; Mon, 02 Nov 2020 13:31:41 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 2 Nov 2020 13:31:20 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 2 Nov 2020 13:31:17 +0800
Message-ID: <1604295074.26323.107.camel@mhfsdcap03>
Subject: Re: [PATCH v4 1/3] dt-bindings: memory: mediatek: Convert SMI to DT
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 2 Nov 2020 13:31:14 +0800
In-Reply-To: <20201031113623.GA4019@kozik-lap>
References: <20201030091254.26382-1-yong.wu@mediatek.com>
 <20201030091254.26382-2-yong.wu@mediatek.com>
 <20201031113623.GA4019@kozik-lap>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F09DDD80041E9D994DD9A643C184363ABF8BFAD0A5D980107E056744C25E11032000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Tomasz Figa <tfiga@google.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Fabien Parent <fparent@baylibre.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Sat, 2020-10-31 at 12:36 +0100, Krzysztof Kozlowski wrote:
> On Fri, Oct 30, 2020 at 05:12:52PM +0800, Yong Wu wrote:
> > Convert MediaTek SMI to DT schema.
> > 
> > CC: Fabien Parent <fparent@baylibre.com>
> > CC: Ming-Fan Chen <ming-fan.chen@mediatek.com>
> > CC: Matthias Brugger <matthias.bgg@gmail.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  .../mediatek,smi-common.txt                   |  50 -------
> >  .../mediatek,smi-common.yaml                  | 140 ++++++++++++++++++
> >  .../memory-controllers/mediatek,smi-larb.txt  |  50 -------
> >  .../memory-controllers/mediatek,smi-larb.yaml | 129 ++++++++++++++++
> >  4 files changed, 269 insertions(+), 100 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> 
> +Cc Honghui Zhang,

As comment [1], Honghui's address is not valid now. I will act for him.

> 
> Your Ack is needed as you contributed descriptions to the bindings and
> work is being relicensed to GPL-2.0-only OR BSD-2-Clause.

"GPL-2.0-only OR BSD-2-Clause" is required when we run check-patch.

If I still use "GPL-2.0-only", then the contributors' Ack/SoB is not
needed, right?

[1]
https://lore.kernel.org/linux-iommu/1604051256.26323.100.camel@mhfsdcap03/T/#u

> 
> 
> Best regards,
> Krzysztof
> 
> 
> 
> 
> >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
> >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> > deleted file mode 100644
> > index dbafffe3f41e..000000000000
> > --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> > +++ /dev/null
> > @@ -1,50 +0,0 @@
> > -SMI (Smart Multimedia Interface) Common
> > -
> > -The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
> > -
> > -Mediatek SMI have two generations of HW architecture, here is the list
> > -which generation the SoCs use:
> > -generation 1: mt2701 and mt7623.
> > -generation 2: mt2712, mt6779, mt8167, mt8173 and mt8183.
> > -
> > -There's slight differences between the two SMI, for generation 2, the
> > -register which control the iommu port is at each larb's register base. But
> > -for generation 1, the register is at smi ao base(smi always on register
> > -base). Besides that, the smi async clock should be prepared and enabled for
> > -SMI generation 1 to transform the smi clock into emi clock domain, but that is
> > -not needed for SMI generation 2.
> > -
> > -Required properties:
> > -- compatible : must be one of :
> > -	"mediatek,mt2701-smi-common"
> > -	"mediatek,mt2712-smi-common"
> > -	"mediatek,mt6779-smi-common"
> > -	"mediatek,mt7623-smi-common", "mediatek,mt2701-smi-common"
> > -	"mediatek,mt8167-smi-common"
> > -	"mediatek,mt8173-smi-common"
> > -	"mediatek,mt8183-smi-common"
> > -- reg : the register and size of the SMI block.
> > -- power-domains : a phandle to the power domain of this local arbiter.
> > -- clocks : Must contain an entry for each entry in clock-names.
> > -- clock-names : must contain 3 entries for generation 1 smi HW and 2 entries
> > -  for generation 2 smi HW as follows:
> > -  - "apb" : Advanced Peripheral Bus clock, It's the clock for setting
> > -	    the register.
> > -  - "smi" : It's the clock for transfer data and command.
> > -	    They may be the same if both source clocks are the same.
> > -  - "async" : asynchronous clock, it help transform the smi clock into the emi
> > -	      clock domain, this clock is only needed by generation 1 smi HW.
> > -  and these 2 option clocks for generation 2 smi HW:
> > -  - "gals0": the path0 clock of GALS(Global Async Local Sync).
> > -  - "gals1": the path1 clock of GALS(Global Async Local Sync).
> > -  Here is the list which has this GALS: mt6779 and mt8183.
> > -
> > -Example:
> > -	smi_common: smi@14022000 {
> > -		compatible = "mediatek,mt8173-smi-common";
> > -		reg = <0 0x14022000 0 0x1000>;
> > -		power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
> > -		clocks = <&mmsys CLK_MM_SMI_COMMON>,
> > -			 <&mmsys CLK_MM_SMI_COMMON>;
> > -		clock-names = "apb", "smi";
> > -	};
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> > new file mode 100644
> > index 000000000000..e050a0c2aed6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> > @@ -0,0 +1,140 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (c) 2020 MediaTek Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/memory-controllers/mediatek,smi-common.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SMI (Smart Multimedia Interface) Common
> > +
> > +maintainers:
> > +  - Yong Wu <yong.wu@mediatek.com>
> > +
> > +description: |+
> > +  The hardware block diagram please check bindings/iommu/mediatek,iommu.yaml
> > +
> > +  MediaTek SMI have two generations of HW architecture, here is the list
> > +  which generation the SoCs use:
> > +  generation 1: mt2701 and mt7623.
> > +  generation 2: mt2712, mt6779, mt8167, mt8173 and mt8183.
> > +
> > +  There's slight differences between the two SMI, for generation 2, the
> > +  register which control the iommu port is at each larb's register base. But
> > +  for generation 1, the register is at smi ao base(smi always on register
> > +  base). Besides that, the smi async clock should be prepared and enabled for
> > +  SMI generation 1 to transform the smi clock into emi clock domain, but that is
> > +  not needed for SMI generation 2.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - mediatek,mt2701-smi-common
> > +          - mediatek,mt2712-smi-common
> > +          - mediatek,mt6779-smi-common
> > +          - mediatek,mt8167-smi-common
> > +          - mediatek,mt8173-smi-common
> > +          - mediatek,mt8183-smi-common
> > +
> > +      - description: for mt7623
> > +        items:
> > +          - const: mediatek,mt7623-smi-common
> > +          - const: mediatek,mt2701-smi-common
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    description: |
> > +      apb and smi are mandatory. the async is only for generation 1 smi HW.
> > +      gals(global async local sync) also is optional, see below.
> > +    minItems: 2
> > +    maxItems: 4
> > +    items:
> > +      - description: apb is Advanced Peripheral Bus clock, It's the clock for
> > +          setting the register.
> > +      - description: smi is the clock for transfer data and command.
> > +      - description: async is asynchronous clock, it help transform the smi clock
> > +          into the emi clock domain.
> > +      - description: gals0 is the path0 clock of gals.
> > +      - description: gals1 is the path1 clock of gals.
> > +
> > +  clock-names:
> > +    minItems: 2
> > +    maxItems: 4
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - power-domains
> > +  - clocks
> > +  - clock-names
> > +
> > +allOf:
> > +  - if: #only for gen1 HW
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - mediatek,mt2701-smi-common
> > +    then:
> > +       properties:
> > +         clock:
> > +           items:
> > +             minItems: 3
> > +             maxItems: 3
> > +         clock-names:
> > +           items:
> > +             - const: apb
> > +             - const: smi
> > +             - const: async
> > +
> > +  - if: #for gen2 HW that have gals
> > +      properties:
> > +        compatible:
> > +            enum:
> > +              - mediatek,mt6779-smi-common
> > +              - mediatek,mt8183-smi-common
> > +
> > +    then:
> > +      properties:
> > +        clock:
> > +          items:
> > +            minItems: 4
> > +            maxItems: 4
> > +        clock-names:
> > +          items:
> > +            - const: apb
> > +            - const: smi
> > +            - const: gals0
> > +            - const: gals1
> > +
> > +    else: #for gen2 HW that don't have gals
> > +      properties:
> > +        clock:
> > +          items:
> > +            minItems: 2
> > +            maxItems: 2
> > +        clock-names:
> > +          items:
> > +            - const: apb
> > +            - const: smi
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/mt8173-clk.h>
> > +    #include <dt-bindings/power/mt8173-power.h>
> > +
> > +    smi_common: smi@14022000 {
> > +            compatible = "mediatek,mt8173-smi-common";
> > +            reg = <0x14022000 0x1000>;
> > +            power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
> > +            clocks = <&mmsys CLK_MM_SMI_COMMON>,
> > +                     <&mmsys CLK_MM_SMI_COMMON>;
> > +            clock-names = "apb", "smi";
> > +    };
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
> > deleted file mode 100644
> > index 0c5de12b5496..000000000000
> > --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
> > +++ /dev/null
> > @@ -1,50 +0,0 @@
> > -SMI (Smart Multimedia Interface) Local Arbiter
> > -
> > -The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
> > -
> > -Required properties:
> > -- compatible : must be one of :
> > -		"mediatek,mt2701-smi-larb"
> > -		"mediatek,mt2712-smi-larb"
> > -		"mediatek,mt6779-smi-larb"
> > -		"mediatek,mt7623-smi-larb", "mediatek,mt2701-smi-larb"
> > -		"mediatek,mt8167-smi-larb"
> > -		"mediatek,mt8173-smi-larb"
> > -		"mediatek,mt8183-smi-larb"
> > -- reg : the register and size of this local arbiter.
> > -- mediatek,smi : a phandle to the smi_common node.
> > -- power-domains : a phandle to the power domain of this local arbiter.
> > -- clocks : Must contain an entry for each entry in clock-names.
> > -- clock-names: must contain 2 entries, as follows:
> > -  - "apb" : Advanced Peripheral Bus clock, It's the clock for setting
> > -	    the register.
> > -  - "smi" : It's the clock for transfer data and command.
> > -  and this optional clock name:
> > -  - "gals": the clock for GALS(Global Async Local Sync).
> > -  Here is the list which has this GALS: mt8183.
> > -
> > -Required property for mt2701, mt2712, mt6779, mt7623 and mt8167:
> > -- mediatek,larb-id :the hardware id of this larb.
> > -
> > -Example:
> > -	larb1: larb@16010000 {
> > -		compatible = "mediatek,mt8173-smi-larb";
> > -		reg = <0 0x16010000 0 0x1000>;
> > -		mediatek,smi = <&smi_common>;
> > -		power-domains = <&scpsys MT8173_POWER_DOMAIN_VDEC>;
> > -		clocks = <&vdecsys CLK_VDEC_CKEN>,
> > -			 <&vdecsys CLK_VDEC_LARB_CKEN>;
> > -		clock-names = "apb", "smi";
> > -	};
> > -
> > -Example for mt2701:
> > -	larb0: larb@14010000 {
> > -		compatible = "mediatek,mt2701-smi-larb";
> > -		reg = <0 0x14010000 0 0x1000>;
> > -		mediatek,smi = <&smi_common>;
> > -		mediatek,larb-id = <0>;
> > -		clocks = <&mmsys CLK_MM_SMI_LARB0>,
> > -			 <&mmsys CLK_MM_SMI_LARB0>;
> > -		clock-names = "apb", "smi";
> > -		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
> > -	};
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> > new file mode 100644
> > index 000000000000..a11a105e872f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> > @@ -0,0 +1,129 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (c) 2020 MediaTek Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/memory-controllers/mediatek,smi-larb.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SMI (Smart Multimedia Interface) Local Arbiter
> > +
> > +maintainers:
> > +  - Yong Wu <yong.wu@mediatek.com>
> > +
> > +description: |+
> > +  The hardware block diagram please check bindings/iommu/mediatek,iommu.yaml
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - mediatek,mt2701-smi-larb
> > +          - mediatek,mt2712-smi-larb
> > +          - mediatek,mt6779-smi-larb
> > +          - mediatek,mt8167-smi-larb
> > +          - mediatek,mt8173-smi-larb
> > +          - mediatek,mt8183-smi-larb
> > +
> > +      - description: for mt7623
> > +        items:
> > +          - const: mediatek,mt7623-smi-larb
> > +          - const: mediatek,mt2701-smi-larb
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    description: |
> > +      apb and smi are mandatory. gals(global async local sync) is optional.
> > +    minItems: 2
> > +    maxItems: 3
> > +    items:
> > +       - description: apb is Advanced Peripheral Bus clock, It's the clock for
> > +           setting the register.
> > +       - description: smi is the clock for transfer data and command.
> > +       - description: the clock for gals.
> > +
> > +  clock-names:
> > +    minItems: 2
> > +    maxItems: 3
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  mediatek,smi:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description: a phandle to the smi_common node.
> > +
> > +  mediatek,larb-id:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0
> > +    maximum: 31
> > +    description: the hardware id of this larb.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - power-domains
> > +
> > +allOf:
> > +  - if: # HW has gals
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - mediatek,mt8183-smi-larb
> > +
> > +    then:
> > +      properties:
> > +        clock:
> > +          items:
> > +            minItems: 3
> > +            maxItems: 3
> > +        clock-names:
> > +          items:
> > +            - const: apb
> > +            - const: smi
> > +            - const: gals
> > +
> > +    else:
> > +      properties:
> > +        clock:
> > +          items:
> > +            minItems: 2
> > +            maxItems: 2
> > +        clock-names:
> > +          items:
> > +            - const: apb
> > +            - const: smi
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - mediatek,mt2701-smi-larb
> > +              - mediatek,mt2712-smi-larb
> > +              - mediatek,mt6779-smi-larb
> > +              - mediatek,mt8167-smi-larb
> > +
> > +    then:
> > +      required:
> > +        - mediatek,larb-id
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/mt8173-clk.h>
> > +    #include <dt-bindings/power/mt8173-power.h>
> > +
> > +    larb1: larb@16010000 {
> > +      compatible = "mediatek,mt8173-smi-larb";
> > +      reg = <0x16010000 0x1000>;
> > +      mediatek,smi = <&smi_common>;
> > +      power-domains = <&scpsys MT8173_POWER_DOMAIN_VDEC>;
> > +      clocks = <&vdecsys CLK_VDEC_CKEN>,
> > +               <&vdecsys CLK_VDEC_LARB_CKEN>;
> > +      clock-names = "apb", "smi";
> > +    };
> > -- 
> > 2.18.0
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
