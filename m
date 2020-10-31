Return-Path: <SRS0=4X9E=EG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5261C4742C
	for <iommu@archiver.kernel.org>; Sat, 31 Oct 2020 11:36:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C0E220825
	for <iommu@archiver.kernel.org>; Sat, 31 Oct 2020 11:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0E220825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0ECD78716A;
	Sat, 31 Oct 2020 11:36:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YnlM4AtKxXKp; Sat, 31 Oct 2020 11:36:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1E3C686DEA;
	Sat, 31 Oct 2020 11:36:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCFF4C088B;
	Sat, 31 Oct 2020 11:36:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11AEAC0051
 for <iommu@lists.linux-foundation.org>; Sat, 31 Oct 2020 11:36:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 001CB8721C
 for <iommu@lists.linux-foundation.org>; Sat, 31 Oct 2020 11:36:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pp_l2ZETIQxJ for <iommu@lists.linux-foundation.org>;
 Sat, 31 Oct 2020 11:36:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 40A11871E5
 for <iommu@lists.linux-foundation.org>; Sat, 31 Oct 2020 11:36:29 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id h22so5139047wmb.0
 for <iommu@lists.linux-foundation.org>; Sat, 31 Oct 2020 04:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/5i7Xu4MHXboDXAyc173g9+q/jTnbwYy+UHkXY4eLZQ=;
 b=rqJGN/PR5gYAZphtNg3E2+Qh2Z4KH4escEPN2MPOKgjiAP0osQDFbhUoo3D44vZhu6
 nv4Gl/M1xKjJDmqzOQfrkf7ayjWfxfGQmCFooRgJZL0XaX6Ox+68D/c0Jg7W48iMUDF7
 xsw4x2ssuTYcPdUFS/L1uXSNB60ZM0lKQzahv7G2NA3IHQ4yHRQBCd0QxaVcx0nqvoO1
 p5l1riuApeoek2WL8GUHJVs+z8LUw6LQXdqTuk6Yxqi7xoxtSeh7DOdlVSEMM0RfDR6u
 Vi+xSaPGAIbg7h+NbmAPg1GLBZRa3rWwsRDxTxBcj+nyoWWsZxtJq3ahn4O5k+th6pX/
 zQXA==
X-Gm-Message-State: AOAM530bEIEWciFyNqC4ZO2a0Z1r/CBeGE74vwbJwinL6lONNwAgWWJH
 8+nTujAdlPTnuHwU7Uo78bM=
X-Google-Smtp-Source: ABdhPJznwM9PsqLHF7/6r60UZtYG2AF8oU/gvc2VY1jXfXhFCKNveN5CWCSXc4b2G/GpNroMyXVE2w==
X-Received: by 2002:a1c:9641:: with SMTP id y62mr7965533wmd.145.1604144187654; 
 Sat, 31 Oct 2020 04:36:27 -0700 (PDT)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
 by smtp.googlemail.com with ESMTPSA id e2sm15256658wrr.85.2020.10.31.04.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2020 04:36:26 -0700 (PDT)
Date: Sat, 31 Oct 2020 12:36:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>, Honghui Zhang <honghui.zhang@mediatek.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: memory: mediatek: Convert SMI to DT
 schema
Message-ID: <20201031113623.GA4019@kozik-lap>
References: <20201030091254.26382-1-yong.wu@mediatek.com>
 <20201030091254.26382-2-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201030091254.26382-2-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Fabien Parent <fparent@baylibre.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@google.com>,
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

On Fri, Oct 30, 2020 at 05:12:52PM +0800, Yong Wu wrote:
> Convert MediaTek SMI to DT schema.
> 
> CC: Fabien Parent <fparent@baylibre.com>
> CC: Ming-Fan Chen <ming-fan.chen@mediatek.com>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../mediatek,smi-common.txt                   |  50 -------
>  .../mediatek,smi-common.yaml                  | 140 ++++++++++++++++++
>  .../memory-controllers/mediatek,smi-larb.txt  |  50 -------
>  .../memory-controllers/mediatek,smi-larb.yaml | 129 ++++++++++++++++
>  4 files changed, 269 insertions(+), 100 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt

+Cc Honghui Zhang,

Your Ack is needed as you contributed descriptions to the bindings and
work is being relicensed to GPL-2.0-only OR BSD-2-Clause.


Best regards,
Krzysztof




>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> deleted file mode 100644
> index dbafffe3f41e..000000000000
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -SMI (Smart Multimedia Interface) Common
> -
> -The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
> -
> -Mediatek SMI have two generations of HW architecture, here is the list
> -which generation the SoCs use:
> -generation 1: mt2701 and mt7623.
> -generation 2: mt2712, mt6779, mt8167, mt8173 and mt8183.
> -
> -There's slight differences between the two SMI, for generation 2, the
> -register which control the iommu port is at each larb's register base. But
> -for generation 1, the register is at smi ao base(smi always on register
> -base). Besides that, the smi async clock should be prepared and enabled for
> -SMI generation 1 to transform the smi clock into emi clock domain, but that is
> -not needed for SMI generation 2.
> -
> -Required properties:
> -- compatible : must be one of :
> -	"mediatek,mt2701-smi-common"
> -	"mediatek,mt2712-smi-common"
> -	"mediatek,mt6779-smi-common"
> -	"mediatek,mt7623-smi-common", "mediatek,mt2701-smi-common"
> -	"mediatek,mt8167-smi-common"
> -	"mediatek,mt8173-smi-common"
> -	"mediatek,mt8183-smi-common"
> -- reg : the register and size of the SMI block.
> -- power-domains : a phandle to the power domain of this local arbiter.
> -- clocks : Must contain an entry for each entry in clock-names.
> -- clock-names : must contain 3 entries for generation 1 smi HW and 2 entries
> -  for generation 2 smi HW as follows:
> -  - "apb" : Advanced Peripheral Bus clock, It's the clock for setting
> -	    the register.
> -  - "smi" : It's the clock for transfer data and command.
> -	    They may be the same if both source clocks are the same.
> -  - "async" : asynchronous clock, it help transform the smi clock into the emi
> -	      clock domain, this clock is only needed by generation 1 smi HW.
> -  and these 2 option clocks for generation 2 smi HW:
> -  - "gals0": the path0 clock of GALS(Global Async Local Sync).
> -  - "gals1": the path1 clock of GALS(Global Async Local Sync).
> -  Here is the list which has this GALS: mt6779 and mt8183.
> -
> -Example:
> -	smi_common: smi@14022000 {
> -		compatible = "mediatek,mt8173-smi-common";
> -		reg = <0 0x14022000 0 0x1000>;
> -		power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
> -		clocks = <&mmsys CLK_MM_SMI_COMMON>,
> -			 <&mmsys CLK_MM_SMI_COMMON>;
> -		clock-names = "apb", "smi";
> -	};
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> new file mode 100644
> index 000000000000..e050a0c2aed6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> @@ -0,0 +1,140 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2020 MediaTek Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/mediatek,smi-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SMI (Smart Multimedia Interface) Common
> +
> +maintainers:
> +  - Yong Wu <yong.wu@mediatek.com>
> +
> +description: |+
> +  The hardware block diagram please check bindings/iommu/mediatek,iommu.yaml
> +
> +  MediaTek SMI have two generations of HW architecture, here is the list
> +  which generation the SoCs use:
> +  generation 1: mt2701 and mt7623.
> +  generation 2: mt2712, mt6779, mt8167, mt8173 and mt8183.
> +
> +  There's slight differences between the two SMI, for generation 2, the
> +  register which control the iommu port is at each larb's register base. But
> +  for generation 1, the register is at smi ao base(smi always on register
> +  base). Besides that, the smi async clock should be prepared and enabled for
> +  SMI generation 1 to transform the smi clock into emi clock domain, but that is
> +  not needed for SMI generation 2.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - mediatek,mt2701-smi-common
> +          - mediatek,mt2712-smi-common
> +          - mediatek,mt6779-smi-common
> +          - mediatek,mt8167-smi-common
> +          - mediatek,mt8173-smi-common
> +          - mediatek,mt8183-smi-common
> +
> +      - description: for mt7623
> +        items:
> +          - const: mediatek,mt7623-smi-common
> +          - const: mediatek,mt2701-smi-common
> +
> +  reg:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  clocks:
> +    description: |
> +      apb and smi are mandatory. the async is only for generation 1 smi HW.
> +      gals(global async local sync) also is optional, see below.
> +    minItems: 2
> +    maxItems: 4
> +    items:
> +      - description: apb is Advanced Peripheral Bus clock, It's the clock for
> +          setting the register.
> +      - description: smi is the clock for transfer data and command.
> +      - description: async is asynchronous clock, it help transform the smi clock
> +          into the emi clock domain.
> +      - description: gals0 is the path0 clock of gals.
> +      - description: gals1 is the path1 clock of gals.
> +
> +  clock-names:
> +    minItems: 2
> +    maxItems: 4
> +
> +required:
> +  - compatible
> +  - reg
> +  - power-domains
> +  - clocks
> +  - clock-names
> +
> +allOf:
> +  - if: #only for gen1 HW
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt2701-smi-common
> +    then:
> +       properties:
> +         clock:
> +           items:
> +             minItems: 3
> +             maxItems: 3
> +         clock-names:
> +           items:
> +             - const: apb
> +             - const: smi
> +             - const: async
> +
> +  - if: #for gen2 HW that have gals
> +      properties:
> +        compatible:
> +            enum:
> +              - mediatek,mt6779-smi-common
> +              - mediatek,mt8183-smi-common
> +
> +    then:
> +      properties:
> +        clock:
> +          items:
> +            minItems: 4
> +            maxItems: 4
> +        clock-names:
> +          items:
> +            - const: apb
> +            - const: smi
> +            - const: gals0
> +            - const: gals1
> +
> +    else: #for gen2 HW that don't have gals
> +      properties:
> +        clock:
> +          items:
> +            minItems: 2
> +            maxItems: 2
> +        clock-names:
> +          items:
> +            - const: apb
> +            - const: smi
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8173-clk.h>
> +    #include <dt-bindings/power/mt8173-power.h>
> +
> +    smi_common: smi@14022000 {
> +            compatible = "mediatek,mt8173-smi-common";
> +            reg = <0x14022000 0x1000>;
> +            power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
> +            clocks = <&mmsys CLK_MM_SMI_COMMON>,
> +                     <&mmsys CLK_MM_SMI_COMMON>;
> +            clock-names = "apb", "smi";
> +    };
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
> deleted file mode 100644
> index 0c5de12b5496..000000000000
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -SMI (Smart Multimedia Interface) Local Arbiter
> -
> -The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
> -
> -Required properties:
> -- compatible : must be one of :
> -		"mediatek,mt2701-smi-larb"
> -		"mediatek,mt2712-smi-larb"
> -		"mediatek,mt6779-smi-larb"
> -		"mediatek,mt7623-smi-larb", "mediatek,mt2701-smi-larb"
> -		"mediatek,mt8167-smi-larb"
> -		"mediatek,mt8173-smi-larb"
> -		"mediatek,mt8183-smi-larb"
> -- reg : the register and size of this local arbiter.
> -- mediatek,smi : a phandle to the smi_common node.
> -- power-domains : a phandle to the power domain of this local arbiter.
> -- clocks : Must contain an entry for each entry in clock-names.
> -- clock-names: must contain 2 entries, as follows:
> -  - "apb" : Advanced Peripheral Bus clock, It's the clock for setting
> -	    the register.
> -  - "smi" : It's the clock for transfer data and command.
> -  and this optional clock name:
> -  - "gals": the clock for GALS(Global Async Local Sync).
> -  Here is the list which has this GALS: mt8183.
> -
> -Required property for mt2701, mt2712, mt6779, mt7623 and mt8167:
> -- mediatek,larb-id :the hardware id of this larb.
> -
> -Example:
> -	larb1: larb@16010000 {
> -		compatible = "mediatek,mt8173-smi-larb";
> -		reg = <0 0x16010000 0 0x1000>;
> -		mediatek,smi = <&smi_common>;
> -		power-domains = <&scpsys MT8173_POWER_DOMAIN_VDEC>;
> -		clocks = <&vdecsys CLK_VDEC_CKEN>,
> -			 <&vdecsys CLK_VDEC_LARB_CKEN>;
> -		clock-names = "apb", "smi";
> -	};
> -
> -Example for mt2701:
> -	larb0: larb@14010000 {
> -		compatible = "mediatek,mt2701-smi-larb";
> -		reg = <0 0x14010000 0 0x1000>;
> -		mediatek,smi = <&smi_common>;
> -		mediatek,larb-id = <0>;
> -		clocks = <&mmsys CLK_MM_SMI_LARB0>,
> -			 <&mmsys CLK_MM_SMI_LARB0>;
> -		clock-names = "apb", "smi";
> -		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
> -	};
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> new file mode 100644
> index 000000000000..a11a105e872f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2020 MediaTek Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/mediatek,smi-larb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SMI (Smart Multimedia Interface) Local Arbiter
> +
> +maintainers:
> +  - Yong Wu <yong.wu@mediatek.com>
> +
> +description: |+
> +  The hardware block diagram please check bindings/iommu/mediatek,iommu.yaml
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - mediatek,mt2701-smi-larb
> +          - mediatek,mt2712-smi-larb
> +          - mediatek,mt6779-smi-larb
> +          - mediatek,mt8167-smi-larb
> +          - mediatek,mt8173-smi-larb
> +          - mediatek,mt8183-smi-larb
> +
> +      - description: for mt7623
> +        items:
> +          - const: mediatek,mt7623-smi-larb
> +          - const: mediatek,mt2701-smi-larb
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description: |
> +      apb and smi are mandatory. gals(global async local sync) is optional.
> +    minItems: 2
> +    maxItems: 3
> +    items:
> +       - description: apb is Advanced Peripheral Bus clock, It's the clock for
> +           setting the register.
> +       - description: smi is the clock for transfer data and command.
> +       - description: the clock for gals.
> +
> +  clock-names:
> +    minItems: 2
> +    maxItems: 3
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  mediatek,smi:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: a phandle to the smi_common node.
> +
> +  mediatek,larb-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 31
> +    description: the hardware id of this larb.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - power-domains
> +
> +allOf:
> +  - if: # HW has gals
> +      properties:
> +        compatible:
> +          enum:
> +            - mediatek,mt8183-smi-larb
> +
> +    then:
> +      properties:
> +        clock:
> +          items:
> +            minItems: 3
> +            maxItems: 3
> +        clock-names:
> +          items:
> +            - const: apb
> +            - const: smi
> +            - const: gals
> +
> +    else:
> +      properties:
> +        clock:
> +          items:
> +            minItems: 2
> +            maxItems: 2
> +        clock-names:
> +          items:
> +            - const: apb
> +            - const: smi
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt2701-smi-larb
> +              - mediatek,mt2712-smi-larb
> +              - mediatek,mt6779-smi-larb
> +              - mediatek,mt8167-smi-larb
> +
> +    then:
> +      required:
> +        - mediatek,larb-id
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8173-clk.h>
> +    #include <dt-bindings/power/mt8173-power.h>
> +
> +    larb1: larb@16010000 {
> +      compatible = "mediatek,mt8173-smi-larb";
> +      reg = <0x16010000 0x1000>;
> +      mediatek,smi = <&smi_common>;
> +      power-domains = <&scpsys MT8173_POWER_DOMAIN_VDEC>;
> +      clocks = <&vdecsys CLK_VDEC_CKEN>,
> +               <&vdecsys CLK_VDEC_LARB_CKEN>;
> +      clock-names = "apb", "smi";
> +    };
> -- 
> 2.18.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
