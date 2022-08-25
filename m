Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B682F57
	for <iommu@lists.linux.dev>; Thu, 25 Aug 2022 13:36:23 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id a4so24700830wrq.1
        for <iommu@lists.linux.dev>; Thu, 25 Aug 2022 06:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=o1UpxoiRuNt3oUSMcF8VYdjioVIlJJnIPZzUkRCOFOs=;
        b=BAPDeOCpMKXOQRMSoIMiS+mUnKLVXfABtBKM/70xGPTvsTNCwiOL8aeiF6qIitDeKf
         2ps6ylszW3YeCgmYj/rF/rrQo5dqhFryE0AHN/LYZEZub/FFrtyHX/hf+Oj1DkCZg7rp
         4Tu3cAcrILV64LGxaFkYK0r3POMb6MgrYmqbBZlZ0S3oLpV3LE1wJt0FhNUuwLZ66LVG
         NNECmr2MIWVXOnYMalYzU6czysgigZayP3xMrNN8WOMSrrGTQTiFqp4MAjOAynmzszr0
         N6YD6gjJKCDUAmq46OuRK+WI4e8V8LNNTNixMWXVHmBDvzA1EdKyJPjiw+7INrmhgV15
         kWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=o1UpxoiRuNt3oUSMcF8VYdjioVIlJJnIPZzUkRCOFOs=;
        b=sK8EphrI4D7k08aX40PfC0C77vH3oKM5eEAzLX1Cj3av47HGapsyHh3jammkQh62am
         e2zBh4y+6WVp5rfKl74nLHfk1o1rlESKkd+95JSxuMx/eHzih+2r8r0hGnDi3IIQ4kc9
         TGcA8ewx4Ol31ZFpqbbrZmAEbfPeWFVhxlz1GWbK7WN4dTiugRhnksgmF6Igf7Wz/ioS
         yb9AmL5yb1MyMYDllmOj+3D7RyFHdcOcHxx7QZigQ35z76aVh+/ejErKRL8FKXue8/Er
         ZdnEP6t/fm/RWz7OhGwCPfFnOsErs1FULQjVwhRkNFJ8qy0HoEaA3WcGbztHvOpbSH6h
         W4EA==
X-Gm-Message-State: ACgBeo2SvmvNCy3QIl4R+wqrAAqWJt/NMmn0PpdnnDqcRu8CX3RP8BR0
	nVSjVIJCBjZwKZu0fbr6j6k=
X-Google-Smtp-Source: AA6agR51DTr6LrwquXxqYW/bTahA+91PGJ3st7kartiD0AdFt0Nd5Iv4F33QY1hXXicmBdatc+1D0w==
X-Received: by 2002:adf:f881:0:b0:225:4f49:55dc with SMTP id u1-20020adff881000000b002254f4955dcmr2437885wrp.414.1661434581558;
        Thu, 25 Aug 2022 06:36:21 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id y8-20020a5d4ac8000000b0021f73c66198sm19385965wrs.1.2022.08.25.06.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 06:36:20 -0700 (PDT)
Message-ID: <b96810d6-df43-1599-b3cc-83e97b9faf2c@gmail.com>
Date: Thu, 25 Aug 2022 15:36:19 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v4 05/20] dt-bindings: power: mediatek: Update maintainer
 list
Content-Language: en-US
To: Tinghan Shen <tinghan.shen@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220729063208.16799-1-tinghan.shen@mediatek.com>
 <20220729063208.16799-6-tinghan.shen@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220729063208.16799-6-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/07/2022 08:31, Tinghan Shen wrote:
> Update the maintainer list of power controller binding.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied, thanks

> ---
>   .../devicetree/bindings/power/mediatek,power-controller.yaml    | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index 2d6afc0909473..03b7f6aa591d4 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Mediatek Power Domains Controller
>   
>   maintainers:
> -  - Weiyi Lu <weiyi.lu@mediatek.com>
> +  - MandyJH Liu <mandyjh.liu@mediatek.com>
>     - Matthias Brugger <mbrugger@suse.com>
>   
>   description: |
