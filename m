Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789D81C13
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 08:22:29 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id j16so17997829lfe.12
        for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 00:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eh60MayT68uXb/vYDSnEvRU+vPH3Dd6tdfW4oAvniM4=;
        b=U87SGviyAxzWYAFu1aifc5W68sLVeQMWvk4ysqqMB+D9NB/NUmTa9Qgt8ZGM0ALqEz
         lBl4Hr+KzFK8ZWv3toENPa2rFyn9UCc+H25tq8RugjGcnB60eaNPK9ED5AUAOZIO1euF
         fzN01XmDX3nGNU13XWWWS/nd7i4lhYaPVqksTzxYsfVpaB61Utg0HoAXdf0jaYNbj9zK
         7RbJnIf+wQnE7t29kaQtnTnEqoi4l7I8viYWmIY4PQrWL/ROZVD+Q9JYThmzNSsb71n0
         repVjfw+M3Qg/zYMDs+mS9DIdcPI4T4CzOajUz6vTFoA0dMtKur9Rr+yRBKECDm1aalv
         HTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eh60MayT68uXb/vYDSnEvRU+vPH3Dd6tdfW4oAvniM4=;
        b=1K5ataMlF2EfmMgJaA9yrzfTlQyVAHTokuNb97MgU5EJX8v2uQDQbvaZl+0qmK+0R2
         VkGrTgismoiFo78senpM+pWe4xPvzaCsg6vttnHy2PWW8kp5FEatiCR6eVLobX7y8Tgk
         xfO1pdvW5cxgUJfGKoUtj7dmpx2yMr5D4fM7a4DXQlKrMQLeGx0rxVkBXL5peeFo40tG
         16dmZDgn8ycZSm/yWg0Vd8GSouznWd5OsYHV3NCWuRo+d7Ju2dIHY9Is192E5pi4BBdC
         pQ0OmKcQDm7g+9y6dpwIAVZeVYXypPA8+UGh0C50FMjthshcSNgwJhbafIHmdDxpiJlm
         shyA==
X-Gm-Message-State: ANoB5pldgaDAyJuHm9/hnSFWbwtCsaTdn4rQCEunhlMbZXKqFxxk3bc4
	Q8OgoWj78X32jnwDbmBGRTgmgQ==
X-Google-Smtp-Source: AA0mqf67oAA3DSJeOHq5gNAC8fIpIUnEk+d3CewqvFf05f5iE1tja9L6ycoWhSiCcYq9Mm6TrbaYvA==
X-Received: by 2002:a05:6512:3b06:b0:4af:e82f:6013 with SMTP id f6-20020a0565123b0600b004afe82f6013mr4326063lfv.36.1668414147602;
        Mon, 14 Nov 2022 00:22:27 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d6-20020a056512368600b0049b8c0571e5sm1735657lfs.113.2022.11.14.00.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:22:27 -0800 (PST)
Message-ID: <92a75ab2-ffb9-9acd-4a98-a91589ad7e14@linaro.org>
Date: Mon, 14 Nov 2022 09:22:25 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 8/8] dt-bindings: iommu: qcom,iommu: Document MSM8976
 compatible
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 agross@kernel.org
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, marijn.suijten@somainline.org,
 kernel@collabora.com, luca@z3ntu.xyz, a39.skl@gmail.com,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20221111145919.221159-1-angelogioacchino.delregno@collabora.com>
 <20221111145919.221159-9-angelogioacchino.delregno@collabora.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111145919.221159-9-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/2022 15:59, AngeloGioacchino Del Regno wrote:
> Add "qcom,msm8976-iommu" to support IOMMUs on this SoC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/iommu/qcom,iommu.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> index b762772f80e7..b7a5822ac00d 100644
> --- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> +++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> @@ -9,7 +9,8 @@ to non-secure vs secure interrupt line.
>  
>  - compatible       : Should be one of:
>  
> -                        "qcom,msm8916-iommu"
> +                        - "qcom,msm8916-iommu"
> +                        - "qcom,msm8976-iommu"

Shouldn't the new compatible be followed by IOMMU v2, not v1?

Best regards,
Krzysztof

