Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D724620E0
	for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 07:34:12 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id bu42so6578815lfb.0
        for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 00:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TA5hj5LY9TtMU86mVjQzKjchWlgrykmSYMSLGFhDRLI=;
        b=GMLdwZdscB3EVWWQJArsx6d/B5HTsSL0X+YyJqJvwd/YISkCGh8eTxRsF7sx+/6Rqk
         vccRH5iciobLCat0H8mQHRB4/daOK9clx7e7zY+qk5o//z50AoX8XNJdR3v40LhXPwZd
         0nnIi2GxiO3DASoJAvpdixcNDWSaZ8qukpbjRfkmWzmxkX2KIpPCBN7muIZQN4hSRflz
         ZhrZMHeMZYj/U0hc0Q994nc0G9v3jsI2W0C2fukcZwIwP4l8K1WBdWVl/VyIGhQTztp9
         iEtO8BP3lyKyDxCSLzdMDOitfwtTyp6jo01eZddW9nEsF1S/Uc4SCeWQrIKcEB34Aq7u
         vB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TA5hj5LY9TtMU86mVjQzKjchWlgrykmSYMSLGFhDRLI=;
        b=VBFQwG8JraI91llVaJTch9Ia+Ho9NwIozLYc0IH6V2l65d8VRYwOlgCtdRQLeNx7dD
         8N64TCR1UY2dzlA8yoaiJh/z4JR0zvo1jMn6T75bzu5CA4K4WnC6c8vnUOWfGGGsF9OD
         /fFzNSNvj+7C6AqoE6d5lKiNR2zMExJf7yv9dXPOAYVrNfmQHd1C3LQUqvfpdpn92TjD
         q5aHfh/z5DZSFoKswpQMC/uFACe9jAbrj7b1cd8z+ph0vARcfIwvpaVDcfqF7sri3bg9
         WFNYn+dOgIRVSs4278cXP1XR1RL9OMKDfyIS9ZcR7t9MbvSbwP1Ot1BMo1ZWMrpgfOyk
         cbVA==
X-Gm-Message-State: AJIora8kjfnncO94qS/XHClaQcO2RyalTP0pqAZ6Eut4FKwwyy6dtf1z
	HlJW38RQSQZh/7/3T7krgbzJQQ==
X-Google-Smtp-Source: AGRyM1tH5bnYQivH0Q5JPcptYdImDfGxTQXL34OhB5o30DvQgYbjSK4eEJREJEcjGz6RCB/F8X5kLg==
X-Received: by 2002:a05:6512:478:b0:47f:86f2:811f with SMTP id x24-20020a056512047800b0047f86f2811fmr6974156lfd.305.1657870450856;
        Fri, 15 Jul 2022 00:34:10 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id u5-20020a196a05000000b00473c87152bcsm769756lfu.127.2022.07.15.00.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 00:34:10 -0700 (PDT)
Message-ID: <18cb5b0a-b096-6056-10c8-9df76db820f0@linaro.org>
Date: Fri, 15 Jul 2022 09:34:07 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 01/19] dt-bindings: iommu: mediatek: Increase max
 interrupt number
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
 <20220714122837.20094-2-tinghan.shen@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220714122837.20094-2-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/07/2022 14:28, Tinghan Shen wrote:
> mt8195 infra iommu uses 5 interrupts.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../devicetree/bindings/iommu/mediatek,iommu.yaml    | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index fee0241b5098..53e712cd0d21 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -91,7 +91,8 @@ properties:
>      maxItems: 1
>  
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 5
>  
>    clocks:
>      items:
> @@ -191,9 +192,18 @@ allOf:
>                const: mediatek,mt8195-iommu-infra
>  
>      then:
> +      properties:
> +        interrupts:
> +          maxItems: 1
> +
>        required:
>          - mediatek,larbs
>  
> +    else:
> +      properties:
> +        interrupts:
> +          minItems: 5

You need to list/describe the items.

Best regards,
Krzysztof
