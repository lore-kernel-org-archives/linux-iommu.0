Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08C8A938
	for <iommu@lists.linux.dev>; Thu, 16 Mar 2023 19:29:53 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id eh3so11805123edb.11
        for <iommu@lists.linux.dev>; Thu, 16 Mar 2023 12:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678994992;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5WyU0qfnRULjYvTUDcZG4NUcXj63E3kuf4oqTEgEhWM=;
        b=QpZ370ktfsNBat3WA/Sytl7eZ2icaf9k5ZVtBvzG+miJw0o3kMpS53pUzaPKYBRzlm
         3RNMMlqqLCDNSmLyPt7rzFqC+e4fvuBk9STtIJQxJmZutKpTl9qYw6x1POw04z6kzTUC
         mBhD+sk7VwyoRxOa4/5+XB7moNAKCb5l8reeiMvisr559sTx3FKtB8sRLssnbgn3heLz
         6DzVS3WrFm01OYQjwtS+uNhqojvO8LfE5Gzve3HvboTn1r02KcYrfAxJ9fynmUczbplt
         wf8G06BjUJVJsXw3O7H0NMaymAngotahtTTmOiIwcb1oM26a7hULDA9hT2FITUrb5NJB
         D2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678994992;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WyU0qfnRULjYvTUDcZG4NUcXj63E3kuf4oqTEgEhWM=;
        b=17JdlaOo3XfrdjzsCdeF1vaUY17l30BhTseljrjZ81oCLKDJIYbWNMfWxop46rsz4D
         tYtVkCLw/lrb5WN09Nj2XNIlaf16/s+9BSrjfnM3Rcf7iWif2G9HfrcQBkYFWEt2K3zK
         RKiVCf5LPiDCi6dY+A3sPScHBoAqVaHnCr9Be1Zul0vVcoknbunzNXCWxnKKTIzLAMfH
         7pNh4uBq5qphhit9QyIXIo/1g7cEHbXqY4JYYO2TUg1aE1uP0cqUULZN0iRWql+gU50m
         D6BfNGRwd+fgLD/UZtp2Qb0FM2oHXBYUI/T3hqERWdKyr3j8L7sImZBn/TfCphAGifxK
         iI2g==
X-Gm-Message-State: AO0yUKWxONPNPSW049To7hL+zd607wiR88E7IPgcrUQMsS1TknMaJzF7
	EN30Q1fk0ZCrbkC1pEDAOh9qTQ==
X-Google-Smtp-Source: AK7set/rsWHRHF7nlHEmPrEiunpAYhgOMGUC46mRl1vyeV9hyy07MsCnraZ9ocmj2iYUnIVfgEGT5g==
X-Received: by 2002:a17:907:c304:b0:8ae:e724:ea15 with SMTP id tl4-20020a170907c30400b008aee724ea15mr11491159ejc.76.1678994991923;
        Thu, 16 Mar 2023 12:29:51 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id t1-20020a170906178100b008d1dc5f5692sm17887eje.76.2023.03.16.12.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 12:29:51 -0700 (PDT)
Message-ID: <f09e93e1-235a-ea0a-902d-4f41a8c90ee5@linaro.org>
Date: Thu, 16 Mar 2023 20:29:50 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Document SM61[12]5 GPU SMMU
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20230315-topic-kamorta_adrsmmu-v1-0-d1c0dea90bd9@linaro.org>
 <20230315-topic-kamorta_adrsmmu-v1-1-d1c0dea90bd9@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315-topic-kamorta_adrsmmu-v1-1-d1c0dea90bd9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/03/2023 11:52, Konrad Dybcio wrote:
> Both of these SoCs have a Qualcomm MMU500 implementation of SMMU
> in front of their GPUs that expect 3 clocks. Both of them also have
> an APPS SMMU that expects no clocks. Remove qcom,sm61[12]5-smmu-500
> from the "no clocks" list (intentionally 'breaking' the schema checks
> of APPS SMMU, as now it *can* accept clocks - with the current
> structure of this file it would have taken a wastefully-long time to
> sort this out properly..) and add necessary yaml to describe the
> clocks required by the GPU SMMUs.


> +      properties:
> +        compatible:
> +          items:
> +            - enum:
> +                - qcom,sm6115-smmu-500
> +                - qcom,sm6125-smmu-500
> +            - const: qcom,adreno-smmu
> +            - const: qcom,smmu-500
> +            - const: arm,mmu-500

If you drop the hunk later (from allOf:if), then what clocks do you
expect for non-GPU SMMU?

> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: mem
> +            - const: hlos
> +            - const: iface
> +
> +        clocks:
> +          items:
> +            - description: GPU memory bus clock
> +            - description: Voter clock required for HLOS SMMU access
> +            - description: Interface clock required for register access
> +
>    # Disallow clocks for all other platforms with specific compatibles
>    - if:
>        properties:
> @@ -394,8 +420,6 @@ allOf:
>                - qcom,sdm845-smmu-500
>                - qcom,sdx55-smmu-500
>                - qcom,sdx65-smmu-500
> -              - qcom,sm6115-smmu-500
> -              - qcom,sm6125-smmu-500
>                - qcom,sm6350-smmu-500
>                - qcom,sm6375-smmu-500
>                - qcom,sm8350-smmu-500
> 

Best regards,
Krzysztof

