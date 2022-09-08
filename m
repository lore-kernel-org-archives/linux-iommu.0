Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681607C
	for <iommu@lists.linux.dev>; Thu,  8 Sep 2022 13:30:41 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id u18so15432142lfo.8
        for <iommu@lists.linux.dev>; Thu, 08 Sep 2022 06:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ssphXCw9dVc4K1o06caOSpIrGhXG1PGN20aX3IK807o=;
        b=ck4sfwitUujJ4vxU9ZOv8HwJvjGvsMZ6KqMM5evDrri5Rht9kYsiegBuwDv4+9EDIf
         sjrTTy8Gxx3SQwy8ByST/AKQejNj1a9cAEZQMJ+OuTI9ffYAJspQo7EsHenHmbfiqJxp
         PEZpXP253o7D9JwQ0QVeyamH+8975QarrG1O9qxnYlX01CoXQMLyJAXjtGKtxP69JJ+h
         kjKArCDi/ob5rxLp/VO4NN8u6S1qY0VkMfXrMBwFqaeJosDzvFQOTvcY4IIoUr47HXLM
         DB55Olq9kSsyaqRMyHVoAq2kr3zBVhcFSj15d6Fm8od7qVplq7ZQnBF7R6EkZ5cBxBJA
         H/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ssphXCw9dVc4K1o06caOSpIrGhXG1PGN20aX3IK807o=;
        b=tn5LdudevaSIkm/2lTAMnImvGG6nOj5inM+J9alT6O/8IpreBh8kLTKyQdZvGIaD1X
         78Y/DVgsjG7a/2Bo4oO5SRAN6Y9l4n0QirPGxiMZgHcOlsXdWN2cf5969UO9fyxciI4P
         ot6j9HNpycchlF+h8Lb+gVh8sDpvM0+NtWOWVU4YpIITryHVIQJerrozDvDcrygpjNug
         3a4NPPHo9VlFvOTgCWAZ12tZbbVGxqw/xgDyo1lwxTkXShGMmEVbnx0g3ua+XM7PAh+0
         DuLfH9oR11WpSND+SJ5pkNWk/bU9JUNqqf3Eu46dnd/xrP47zJXKtLPFvDQgr9J80rFL
         uumA==
X-Gm-Message-State: ACgBeo3P0mrQ8mM6Eo1pVdJAEU2ACJC6Tt4/hJYsHMpul5aj64kaAoQu
	Y07rkC0SGJ+Kc3gfbiQf5bUh4g==
X-Google-Smtp-Source: AA6agR4Cnrp8WVFsJsdGAqok1HmTtsifWI0ssMvOubIq728013GinG5Ar6anwjFrPPS71YUeXLYwHg==
X-Received: by 2002:a05:6512:3ba9:b0:497:ab81:dca5 with SMTP id g41-20020a0565123ba900b00497ab81dca5mr1972140lfv.129.1662643839504;
        Thu, 08 Sep 2022 06:30:39 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 5-20020ac25f45000000b00498f0434efdsm221661lfz.19.2022.09.08.06.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 06:30:39 -0700 (PDT)
Message-ID: <eff1c862-e3f4-d28b-fafa-c6053c48189c@linaro.org>
Date: Thu, 8 Sep 2022 15:30:37 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1] dt-bindings: iommu: mediatek: mt8195: Fix max
 interrupts
Content-Language: en-US
To: matthias.bgg@kernel.org, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 iommu@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger
 <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Matthias Brugger <mbrugger@suse.com>
References: <20220908132535.9350-1-matthias.bgg@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220908132535.9350-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/09/2022 15:25, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> The mt8195-iommu-infra has five banks and one interrupt for each.
> Reflect that in the binding.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> 
> ---
> 
>  .../bindings/iommu/mediatek,iommu.yaml        | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index fee0241b50988..621aca2adfb7f 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -91,7 +91,7 @@ properties:
>      maxItems: 1
>  
>    interrupts:
> -    maxItems: 1

Keep here wide constraints - minItems:1, maxItems:5

> +    description: each bank has one dedicated interrupt


>  
>    clocks:
>      items:
> @@ -183,6 +183,19 @@ allOf:
>        required:
>          - mediatek,infracfg
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8195-iommu-infra
> +
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 5

and then minItems:5

> +      required:
> +        - interrupts

This seems unrelated and not really needed.

> +
>    - if: # The IOMMUs don't have larbs.
>        not:
>          properties:
> @@ -191,8 +204,12 @@ allOf:
>                const: mediatek,mt8195-iommu-infra
>  
>      then:
> +      properties:
> +        interrupts:
> +          maxItems: 1
>        required:
>          - mediatek,larbs
> +        - interrupts

This seems unrelated and not really needed.

>  
>  additionalProperties: false
>  


Best regards,
Krzysztof
