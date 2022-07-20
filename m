Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9D85389
	for <iommu@lists.linux.dev>; Wed, 20 Jul 2022 13:31:44 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id z13so6580749wro.13
        for <iommu@lists.linux.dev>; Wed, 20 Jul 2022 06:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jXWsCDJZbVRxP7xR4C+U6rZt5JnCuCWDrPBReQRj/tw=;
        b=fnqIuK/upZAzWSdv8c4Xn98IfAXMtNBC8vAlR5vrMj/2du3XqOPwte1qjMrWLuHE0i
         LIep0Sv1eq7e349LCymGOYm4TUYeyyoDRHZRsmdkOAZeb9iaBgagQLzmDiHToHZAfxRM
         ihx0hQHCepa1CFN2KrYqjfkjfgJACbdUXcIN+5R0y+Lj61RFQK78ZqtbhybUgIgpuG2J
         q+P6QZS4cDKhCHBcdADaCSc47eHksNAsFQlFoJw1+5UU4S7r0y39wr3Pb3wbazLMlntE
         5V5mPFz7By2zGpfa7PTaOGWO23THWYxm8j3qEuzs9U0r//i84t+1A7L6lM7C0McnNL2C
         BdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jXWsCDJZbVRxP7xR4C+U6rZt5JnCuCWDrPBReQRj/tw=;
        b=2N/ZzFDeWTAI9uJY6pfPDGdAT33jYR71MedxFtL/Y8B1CsnIkyBOkKaHdhgMRytom6
         KSOLzAC6NCxyDKKAYkjC8RxBRvUXaVPZVce5SIwaSySqffINHND2LxhSjWWo+EBXVloj
         VuTP3dc0/3aTyq1xvx3q72HcP6XDfxe1cEFZMnM33X52ShUTYKjB8f/as9r+VbKPtPv+
         sCs/V1IF3VTBmzftRF9ng1pi6taTrNii8F4+bCqQ/MANhQV/UO2r0nvJqsgYLunmyqrB
         Pc9ZAUlmaS6vmQUDnlCQg9SxaMOVRMRLAgcQgqIlrGsuZZyZbt/ig3BD3w5kmcy+fgb8
         B9Bw==
X-Gm-Message-State: AJIora9KWQsmOfUB3NWDqIU+wzib+g0WFxktTc/G8MdrIf72h5o9lT/f
	PfTl/yqpDIiZn2nZWERuoYZI2Q==
X-Google-Smtp-Source: AGRyM1tyvKXKdPUtTzvOARCZKmziYzkJtcJwILxnHRLAiFVCrIOmOWmx0ChdTjh6M2BY6gcYj8q5AA==
X-Received: by 2002:a5d:4447:0:b0:21d:6b84:4678 with SMTP id x7-20020a5d4447000000b0021d6b844678mr28881929wrr.668.1658323902346;
        Wed, 20 Jul 2022 06:31:42 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b003a31fd05e0fsm9520548wms.2.2022.07.20.06.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 06:31:41 -0700 (PDT)
Date: Wed, 20 Jul 2022 14:31:39 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Tinghan Shen <tinghan.shen@mediatek.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	MandyJH Liu <mandyjh.liu@mediatek.com>, iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3 06/21] dt-bindings: power: mediatek: Add bindings for
 MediaTek SCPSYS
Message-ID: <YtgDu70Lpl/uPOkf@google.com>
References: <20220720123023.13500-1-tinghan.shen@mediatek.com>
 <20220720123023.13500-7-tinghan.shen@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220720123023.13500-7-tinghan.shen@mediatek.com>

On Wed, 20 Jul 2022, Tinghan Shen wrote:

> The System Control Processor System (SCPSYS) has several power
> management related tasks in the system. Add the bindings for it.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Why have you ignored my review comments from v2?

> ---
>  .../bindings/mfd/mediatek,mt8195-scpsys.yaml  | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
> new file mode 100644
> index 000000000000..4117a6dbc19c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek System Control Processor System
> +
> +maintainers:
> +  - MandyJH Liu <mandyjh.liu@mediatek.com>
> +
> +description:
> +  MediaTek System Control Processor System (SCPSYS) has several
> +  power management tasks. The tasks include MTCMOS power
> +  domain control, thermal measurement, DVFS, etc.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8167-scpsys
> +          - mediatek,mt8173-scpsys
> +          - mediatek,mt8183-scpsys
> +          - mediatek,mt8192-scpsys
> +          - mediatek,mt8195-scpsys
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^power-controller(@[0-9a-f]+)?$":
> +    $ref: /schemas/power/mediatek,power-controller.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8195-clk.h>
> +    #include <dt-bindings/power/mt8195-power.h>
> +
> +    syscon@10006000 {
> +        compatible = "mediatek,mt8195-scpsys", "syscon", "simple-mfd";
> +        reg = <0x10006000 0x100>;
> +
> +        spm: power-controller {
> +            compatible = "mediatek,mt8195-power-controller";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            #power-domain-cells = <1>;
> +
> +            /* sample of power domain nodes */
> +            power-domain@MT8195_POWER_DOMAIN_PCIE_PHY {
> +                    reg = <MT8195_POWER_DOMAIN_PCIE_PHY>;
> +                    #power-domain-cells = <0>;
> +            };
> +
> +            power-domain@MT8195_POWER_DOMAIN_SSUSB_PCIE_PHY {
> +                    reg = <MT8195_POWER_DOMAIN_SSUSB_PCIE_PHY>;
> +                    #power-domain-cells = <0>;
> +            };
> +        };
> +    };

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
