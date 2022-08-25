Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B5D2F57
	for <iommu@lists.linux.dev>; Thu, 25 Aug 2022 13:41:04 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id ay12so10285666wmb.1
        for <iommu@lists.linux.dev>; Thu, 25 Aug 2022 06:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=P62ueRssPRWFG3vaYmpYNrxNqu1MLhdwYO9xXHU3Eok=;
        b=o5f4hFjZI45NTZlz/j+gp1PsNXot+ZFmfK1pjCF3c/ZkKON5KO2U/U4z3qjDJ5pKHh
         CfMu6+BUgs0fadkrXr33bOXYs5nZcCUNtREG1btzb00TRe5IV0Fw2MLKDbobygsbSmv+
         ulmFWzsKO1LCy7kZMuRaScxVZX/sSB2Q1tOelifSdAS+YWR/Dfk2+lsEoaDrc5WOpa8s
         +ALI41zvnNIBFnNZ3Y4wAAIGxZ9es+16UZ//ZoLewVyBXhkaVmHAnoKsi1PE0YD7jzTi
         +TLD7NKMIzJAoYCRfdP2kxriS9Khnex1VnPO48BPSWgzf7BXhICyZIiRB72cN/l9tpvT
         6VXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=P62ueRssPRWFG3vaYmpYNrxNqu1MLhdwYO9xXHU3Eok=;
        b=caOkU2sl9XQHQtJ+iAyH5kWQuUWKhmeMriZYdtvDcpgelq9Gc9lgn9CuElUarl7/ex
         k4YYPlDiAdWVQXIFwA1821UVcqJBZA2g0xdPPsYPnRDY/Ty8sE3feFuYjBZYOhLdWFIU
         HwMAj0Uuxh1p21RyPxQ1zwMTQMGurRJvm95J81mNh/aYcnmThXJCNdKYkki2l7sjffiw
         y8DpdMYdp8TELfsqPGZyl/inS0FATe0vylDALRu5a9g74o/JDtEeWMmi9B+DpDgiN5pX
         WZZI+1bUP0d8HsUm2+458FchiaXoHOBkLfM5EuOLpY6gtCt4RzGt+X+Ivm5/FJ5SLMMa
         ZciA==
X-Gm-Message-State: ACgBeo06J0I5tWZ6v4Nq6wDfmJl84IvDM7QVQyNQbQqwHlRah4/DD9eQ
	WbxYuncuC9B3vyOwunR8c04=
X-Google-Smtp-Source: AA6agR6HwtACnz86Wj1DGMwmnKmttU1V08jHhgJSrlxz8gPmsiWwe1E9CpRcuRMT3D/r04OwZIh6QA==
X-Received: by 2002:a05:600c:3508:b0:3a6:10a9:8115 with SMTP id h8-20020a05600c350800b003a610a98115mr8721228wmq.164.1661434862814;
        Thu, 25 Aug 2022 06:41:02 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id g8-20020adffc88000000b002258619d342sm641503wrr.2.2022.08.25.06.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 06:41:01 -0700 (PDT)
Message-ID: <ad4d2ed4-5ea0-f6a8-65da-9f61ca54b891@gmail.com>
Date: Thu, 25 Aug 2022 15:41:00 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v6 01/20] dt-bindings: iommu: mediatek: Increase max
 interrupt number
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
References: <20220811025813.21492-1-tinghan.shen@mediatek.com>
 <20220811025813.21492-2-tinghan.shen@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220811025813.21492-2-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/08/2022 04:57, Tinghan Shen wrote:
> mt8195 infra iommu uses 5 interrupts.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Joerg, will you take this through your tree or shall I take care of it?

Regards,
Matthias

> ---
>   .../bindings/iommu/mediatek,iommu.yaml        | 29 ++++++++++++++-----
>   1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index fee0241b50988..f5634c1642e20 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -91,7 +91,8 @@ properties:
>       maxItems: 1
>   
>     interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 5
>   
>     clocks:
>       items:
> @@ -183,14 +184,28 @@ allOf:
>         required:
>           - mediatek,infracfg
>   
> -  - if: # The IOMMUs don't have larbs.
> -      not:
> -        properties:
> -          compatible:
> -            contains:
> -              const: mediatek,mt8195-iommu-infra
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8195-iommu-infra
>   
>       then:
> +      properties:
> +        interrupts:
> +          description: The IOMMU has 5 banks. Each bank has its own interrupt.
> +          items:
> +            - description: The interrupt for IOMMU bank0
> +            - description: The interrupt for IOMMU bank1
> +            - description: The interrupt for IOMMU bank2
> +            - description: The interrupt for IOMMU bank3
> +            - description: The interrupt for IOMMU bank4
> +
> +    else: # For the MM IOMMU
> +      properties:
> +        interrupts:
> +          maxItems: 1
> +
>         required:
>           - mediatek,larbs
>   
