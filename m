Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F287F
	for <iommu@lists.linux.dev>; Tue,  2 Aug 2022 08:58:11 +0000 (UTC)
Received: by mail-lj1-f169.google.com with SMTP id q7so14887185ljp.13
        for <iommu@lists.linux.dev>; Tue, 02 Aug 2022 01:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=npQP1PTeFOBz/aH/qk/2cJgnMA7yHhXLpALhGeue+vw=;
        b=wrhadkP9rdiZt1XXIHzWWCrjD0rl5hQMS+ZHqpbiG8Bt2LLowIhnWcU7ppEYLP+n5h
         feQRYMFdysj8IjhdN8uy//PHWuS2s0gAwNG2Tl4bJRy/VJ9+pKLcCEgofn1G/zzwOdbc
         Bklq4hdGFHGafaOmpt8fbbRFgY2Swqfn0djw4xHaNIQUxdGw7fQt/cg6ATRE6IJ64N3u
         SJgUmnLAuwZUEPt3YYr+G8Cs5Yl1YdtfUahwTnkJ/1KXe+/za3ugN2PeP7+3or95tLx+
         zqcqdUUdODthmLA5lyqRvz90oSbF2qfLtF5jWkgC45Uoo1xD+XGM0+Lw/wJ93t2KtsXd
         AgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=npQP1PTeFOBz/aH/qk/2cJgnMA7yHhXLpALhGeue+vw=;
        b=wTC0M6nExdr4nTztyNrPHuvJ4G+4AvD1s9wURFmAo09mBbCmRyDoFZ4O4tPvw5whhK
         5D4et3EMaJU2sfJTJqhF8DYRE6p4QuUS6V7bmQVeOqi6Kts1SuW+hBQ0EtcQIJmRTPyI
         bt2yZ5hRrTHM64ARZ90RZYMtu99hHdLhq3U5LmXuoWz3WnAwSwX1IsyxLHTxGCfGrmIi
         2c4VeFeyi4nQJgfA/6WuqexJh4ehVmb8pTsmKYWGoRUNl0sdFatV8v3dKhQPcqTjVl/8
         hd4q++Ge1kOOOCUsKouLbWEac/du0v4DxYfSU/BIn9Sl1jZoXdH8nr7eDZCGGywoco4I
         nfcg==
X-Gm-Message-State: AJIora8WW8sCsQfR4sbGn/U+pQRvOuOm07V8V9r1IohUjFjtzdcx5pyc
	Zta/U+TKozoSs8+1UXCBaNxIbA==
X-Google-Smtp-Source: AGRyM1s6TASgKeoeefB3kojxmqJkb8Ddf94gvx/txy9BStGigDLYfFEvUo1PUBytil1oYOafbF8+hQ==
X-Received: by 2002:a05:651c:179f:b0:25d:ba24:2e16 with SMTP id bn31-20020a05651c179f00b0025dba242e16mr5887088ljb.422.1659430689430;
        Tue, 02 Aug 2022 01:58:09 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id bf43-20020a05651225ab00b0047fae90bfb4sm2033495lfb.56.2022.08.02.01.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 01:58:08 -0700 (PDT)
Message-ID: <b265c106-373f-3850-2933-9418c2b515f0@linaro.org>
Date: Tue, 2 Aug 2022 10:58:06 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 06/20] dt-bindings: power: mediatek: Add bindings for
 MediaTek SCPSYS
Content-Language: en-US
To: Tinghan Shen <tinghan.shen@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220729063208.16799-1-tinghan.shen@mediatek.com>
 <20220729063208.16799-7-tinghan.shen@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220729063208.16799-7-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/07/2022 08:31, Tinghan Shen wrote:
> The System Control Processor System (SCPSYS) has several power
> management related tasks in the system. Add the bindings for it.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Thank you for your patch. There is something to discuss/improve.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8195-clk.h>
> +    #include <dt-bindings/power/mt8195-power.h>
> +
> +    syscon@10006000 {
> +      compatible = "mediatek,mt8195-scpsys", "syscon", "simple-mfd";
> +      reg = <0x10006000 0x100>;
> +
> +      spm: power-controller {
> +        compatible = "mediatek,mt8195-power-controller";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        #power-domain-cells = <1>;
> +
> +        /* sample of power domain nodes */
> +        power-domain@MT8195_POWER_DOMAIN_PCIE_PHY {
> +                reg = <MT8195_POWER_DOMAIN_PCIE_PHY>;

Wrong indentation.

Best regards,
Krzysztof
