Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A71E602F
	for <iommu@lists.linux.dev>; Wed, 20 Jul 2022 17:32:25 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id n18so31452983lfq.1
        for <iommu@lists.linux.dev>; Wed, 20 Jul 2022 10:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FpdLAALfeFZJFf34lr9EAhmP/cSrmy7SxAXiREu4lCE=;
        b=e2PwSymV0hA+iIEXs5JnVHMHTYba9XQeH1c2XfY/o0kRymmpd+9BFAruPDv8CzYshH
         7UNWBFLSTwSwpS7PgmNyLKD7dcV25GMdPqgurrpIqDzTKca1UbsGLc0fX4rKKZVBFR/y
         tuE4CWS3WSCn8N5efQvbI328K33oijpEPSZLThOZimXoq/kosT5TIMmQpwcvj9Zd1RrD
         PvqjlNJQwxnzemXPGKP8NdhOCgS3Oyu7a9qARuKOiabCTX0V0lwBJMAnAT5LTbllpfKX
         t8zNsw2nEL1IgV8iKQxyx31A+hu/coiIuhkosx5vZGkk4e4jyr0Vk0vbcG7gMPruU3FM
         /XIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FpdLAALfeFZJFf34lr9EAhmP/cSrmy7SxAXiREu4lCE=;
        b=Yy2AgbYqDkYHAoaPcmQMpYwWaN7bNSfPtebwewOF9Nq7igIJMYBmonw56RHWobFGhP
         UrYDglKOHG01WP1lK0+esiRoAhGu8rCAe3faNuucCiqSM35cTpWjPStq2s4gm36Lfyak
         iMwNDuuREF9zb2oeCNymTLmulhdbBWDlnLZXA0M9BlmrlBKdjmh6t5KeZm2YJLfaAxmD
         krtJ9w+d8t74GocI0aZsTokg/WePzS07D6ptGoqEsf02DWhSeS0mb+v+lotnNAb1QA/0
         6YA540uIACKVTqa2o9Cwk1ZJVGrIl2cwDP1w5fI61U2/Ly7vK/VRRoGk0P0gCIIX0evB
         9yFw==
X-Gm-Message-State: AJIora9Hu3Hk3+l7zajiLtPq7Bfx5zoUjs8hgZw82vqxsGuuqusFlbDJ
	rasIPWiaD69iEaJOfv6TWY7YGlJe62QdKDqh
X-Google-Smtp-Source: AGRyM1sjIgDPvW7XqgXeKtiTiExWUywK1Bz9F9BKOt5z1/TReYjxYJre4a0CVxkypZSJHZbV45ScyQ==
X-Received: by 2002:a19:700b:0:b0:486:e7ec:67ad with SMTP id h11-20020a19700b000000b00486e7ec67admr19129070lfc.263.1658338344098;
        Wed, 20 Jul 2022 10:32:24 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id o13-20020ac25e2d000000b004896ed8dce3sm3917980lfg.2.2022.07.20.10.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 10:32:23 -0700 (PDT)
Message-ID: <4afe8a76-08be-224f-d40f-0b45566a5147@linaro.org>
Date: Wed, 20 Jul 2022 19:32:22 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 03/21] dt-bindings: power: mediatek: Refine multiple
 level power domain nodes
Content-Language: en-US
To: Tinghan Shen <tinghan.shen@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee.jones@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220720123023.13500-1-tinghan.shen@mediatek.com>
 <20220720123023.13500-4-tinghan.shen@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220720123023.13500-4-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/07/2022 14:30, Tinghan Shen wrote:
> Extract duplicated properties and support more levels of power
> domain nodes.
> 
> This change fix following error when do dtbs_check,
>     arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: power-controller: power-domain@15:power-domain@16:power-domain@18: 'power-domain@19', 'power-domain@20', 'power-domain@21' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	 From schema: Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../power/mediatek,power-controller.yaml      | 131 +++---------------
>  1 file changed, 17 insertions(+), 114 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index b448101fac43..321802c95308 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -42,6 +42,23 @@ properties:
>  
>  patternProperties:
>    "^power-domain@[0-9a-f]+$":
> +    $ref: "#/$defs/power-domain-node"
> +    patternProperties:
> +      "^power-domain@[0-9a-f]+$":
> +        $ref: "#/$defs/power-domain-node"
> +        patternProperties:
> +          "^power-domain@[0-9a-f]+$":
> +            $ref: "#/$defs/power-domain-node"
> +            patternProperties:
> +              "^power-domain@[0-9a-f]+$":
> +                $ref: "#/$defs/power-domain-node"
> +                unevaluatedProperties: false
> +            unevaluatedProperties: false
> +        unevaluatedProperties: false
> +    unevaluatedProperties: false

I see some beauty in previous endless recurrence, but at least we are
specific...


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
