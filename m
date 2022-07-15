Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDC620E0
	for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 07:57:20 +0000 (UTC)
Received: by mail-lj1-f177.google.com with SMTP id by8so1241414ljb.13
        for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 00:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pVS+MTH1XwU1cvawHiiTO1k5At4xPOvBRcWn0E0JKnQ=;
        b=nPbUHaxTybTz+hSdJPP6CMy/vM/46yKwRrdEcsM8O2DT/PEmEm8ExTH8fb2rzJxdNf
         xjorId7Lq1mqbvJSYX2eyWQlr2irAmSAS6rnsqJDpmwkL+6QGJrJDDAQyzR9Iy8xuw+W
         G2Ytl4E09lz7ry/bTjvMUCO5DGdJuNBD5GGICRvvIb1oJkkbuio9/j0nVaKx0WPjH71e
         +AvFWG+fw+j8KIMVJGW2e2zw/kH23rcpmVVe6i5I+58UpQ0pAGEMQ0Ab8I1eatNJjP6W
         PSc5bjLGmcyTLTiBxDZGy1rct8c9+FJxaOOz8NoDM7ZjauLPS6uNYjJzZUgZotVcLO5+
         wEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pVS+MTH1XwU1cvawHiiTO1k5At4xPOvBRcWn0E0JKnQ=;
        b=O8AQKkL6pFZ/nY/3ulG/a5b8dRjeBBirBoXdOBJEYsQY0qVrwcMI54AhVocq9etCT4
         9GEYAXehu4o2zacMZJYpv5RN6Iaf8Vl7XNkxnqxeB08Z7A8zB3D2S7XBRtOgzdvkqDnQ
         YKdceyTFk3H8pIbrNO7fVW+5Ql1wPc/0s8dUuElQc8wg7bpMFmx5yDAtS+VUQK0EdQ4Z
         nYukE2jrL2cRSPRWx/pVDviJP2VCtcI8u4r77kZITVDIPPBRRGepOATqpWcbK/d1R25q
         gc/G/ZHHBdVLoRiF6jokggkBOhK6TcOwVZt0vlOdCgQnwesX6rTq02AhvdZBkJEYV4Xj
         Z6zA==
X-Gm-Message-State: AJIora9790gzWcqfJOQ1ME1aN87IzcouQzNjnQhKN1BVZvRFs0WFhnso
	jsq5TWSnN1e0sLtpGrM7GCgvFg==
X-Google-Smtp-Source: AGRyM1ulJRngwtrHtmZz4bY0FMFRN0qrWGaMpBxRh+yPkwrRe6nsqVmc0rblcJXm/KEw4Ov5c3GRWw==
X-Received: by 2002:a2e:9854:0:b0:25d:883d:faf2 with SMTP id e20-20020a2e9854000000b0025d883dfaf2mr6010968ljj.223.1657871838444;
        Fri, 15 Jul 2022 00:57:18 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id b13-20020a056512070d00b0048960b581e3sm778642lfs.8.2022.07.15.00.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 00:57:17 -0700 (PDT)
Message-ID: <46df4ad5-5102-b5fe-95b7-5b157fb28f01@linaro.org>
Date: Fri, 15 Jul 2022 09:57:14 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 03/19] dt-bindings: power: mediatek: Add bindings for
 MediaTek SCPSYS
Content-Language: en-US
To: Tinghan Shen <tinghan.shen@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee.jones@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Chun-Jie Chen <chun-jie.chen@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220714122837.20094-1-tinghan.shen@mediatek.com>
 <20220714122837.20094-4-tinghan.shen@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220714122837.20094-4-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/07/2022 14:28, Tinghan Shen wrote:
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

This should be a SoC-specific compatible (and filename).

> +        reg = <0x10006000 0x100>;
> +
> +        spm: power-controller {

I think you created before less-portable, quite constrained bindings for
power controller. You now require that mt8195-power-controller is always
a child of some parent device which will share its regmap/MMIO with it.

And what if in your next block there is no scpsys block and power
controller is the scpsys alone? It's not possible with your bindings.

Wouldn't it be better to assign some address space to the
power-controller (now as an offset from scpsys)?

This is just wondering (Rockchip did the same...) and not a blocker as
power-controller bindings are done.

Best regards,
Krzysztof
