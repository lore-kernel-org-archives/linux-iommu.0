Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2725D46B9
	for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 13:38:25 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id a5so2577541wrx.12
        for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 06:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gZbm5v8jczB3m3Zbghv7hORrbzz+8TA8A7EGSVhjSaQ=;
        b=QhSFR35ht5QEM5YZF2rpDWTzxDIE4nFn1yZhWPiMSFmnpD/aDrZwGNbmNuamkHO1XF
         1J4UOj7++gNdTSdZuPgzZvkbRoyZHLZhZb+N2JoI+nCcDQNaD/P8pQ75/GdD+ScQdwp0
         59oDsFg3whwkWU97Rsn5CqHobBGGRYbjWrEOyblVdLZNk34xQRMRGkLoLnzSInu0dPKM
         aZVXK/Fey7k6krYGdUv3TzlEFgETj7JSuoN7kMMtQTCiSSFwqaHVrKTyYziyVfG2EiGk
         5krBajsYVkRMa+oEMQTmJz40cEHzkpD5xdRKxpWJyH+LvNS6bhqZzJy1pKjOn59iCwTx
         9c5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gZbm5v8jczB3m3Zbghv7hORrbzz+8TA8A7EGSVhjSaQ=;
        b=TUtU2tANR86CoxWYwmVW62RGzMAFRLpxwByBwj3J+jForUvEwK0sGit7b5jGjBeGLL
         NhSB/wiaFOkXVQ3c79SGA9i0cho9HRXiH9U3W3Mx5DBF+ulF4TVRAA+V+6wRRQeUopRT
         ivPKAKYLLjXDSrPD5VvdGDS9IL6lvJUi3Gq8iYm5XZtCFN0RgPFv/KtwGnO7cBg3s327
         AM8anHG8rZQCu5itUWpYw2uD/dHwlkYK4AQFwHeIzCF31kMXDixRnJJ4MPsyaf+5bn79
         IZXTv/apXQEnoQiHnNYEzqqazQTC1FUE7U334ka27DuAqbg5EJ4gI4UtBfQKUVPXWjTS
         vu3w==
X-Gm-Message-State: AJIora8fRP+WkDT9YXfvORFFrXx8MBlmoev1oC4nCrrA/1qaxifJPLjy
	daopsmI/zdLDOpRHaHkejKOu+Q==
X-Google-Smtp-Source: AGRyM1uxSpQQUohZAVCvRDTDUH1kMNPkjZLHzaAqEsW41la3u7tmhLBotyjHD8UJYEkeF4RD+P0HJw==
X-Received: by 2002:a05:6000:81d:b0:21d:a495:6e3 with SMTP id bt29-20020a056000081d00b0021da49506e3mr8401904wrb.502.1657805903332;
        Thu, 14 Jul 2022 06:38:23 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c4f9200b003a2ec73887fsm8793750wmq.1.2022.07.14.06.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:38:22 -0700 (PDT)
Date: Thu, 14 Jul 2022 14:38:20 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Tinghan Shen <tinghan.shen@mediatek.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Chun-Jie Chen <chun-jie.chen@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	MandyJH Liu <mandyjh.liu@mediatek.com>,
	Weiyi Lu <weiyi.lu@mediatek.com>, iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 03/19] dt-bindings: power: mediatek: Add bindings for
 MediaTek SCPSYS
Message-ID: <YtAcTCUsy9I67L3V@google.com>
References: <20220714122837.20094-1-tinghan.shen@mediatek.com>
 <20220714122837.20094-4-tinghan.shen@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220714122837.20094-4-tinghan.shen@mediatek.com>

Subject line should be 'mfd', rather than 'power'.

On Thu, 14 Jul 2022, Tinghan Shen wrote:

> The System Control Processor System (SCPSYS) has several power
> management related tasks in the system. Add the bindings for it.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../bindings/mfd/mediatek,scpsys.yaml         | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml b/Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
> new file mode 100644
> index 000000000000..a8b9220f2f27
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/mediatek,scpsys.yaml#
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
> +      - const: mediatek,scpsys
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  power-controller:
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
> +        compatible = "mediatek,scpsys", "syscon", "simple-mfd";

Not sure you need bindings for this.  Seems overkill.

I'll let the DT guys have the final say though.

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
