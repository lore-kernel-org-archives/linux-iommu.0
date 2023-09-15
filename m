Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC326AD8
	for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 07:12:07 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50098cc8967so2909229e87.1
        for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 00:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694761926; x=1695366726; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L+1MAm8CUnGgXuX6co+0aREskJOB2spO/R6IQZ493/g=;
        b=SB56mZQYAS7mEfqxnqUNlCpc+b3yxb/L3wg7rDfa+yZO6J0/Rba8HmKaO/5K3zArKO
         71SdozCB84uhQhplvhQwyfQcvKch5EU2CECtf6E93ZU0cUJ++QuNeeEcCfyEK6/lJQbp
         /isZ8SRtZlfULo9uOfHIxRpKn8vgxRtvu2YeoY0eX8Nu8Wocy7FYh4KqrFERXoM76cnC
         MCGAIDSCfT6U3KhGmzzSmXqus9bxwXwXkBowoFwQccraySPblFDgfEV6vQl8BsD6u76b
         7CvcGC4KYNe1uFrQIkDc6TRAnb8LQjj2AH8cLHyQW3M6UNrbL6FCmvvEsTC30tVzNJBv
         s1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694761926; x=1695366726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+1MAm8CUnGgXuX6co+0aREskJOB2spO/R6IQZ493/g=;
        b=mu7o9A9xKt3WjR2Vvg/CMaMMf3MCDBdHO6Db7iuHKkUymhAJo4u3SNmNqj/sphbbhB
         5d7YOa56A/rTqIgT0L2k5CbY6tG9fqKKC3GIMauSg+O/2NzHSm4jaVxfTdPEQJkziXEP
         WUyNsw5QidNkTjeIdi07dqmsvjyBqfRr4EoCzDDIEsL5MhaTRvLx7XfbkvkPKynx+9uK
         tgJuLaEEcmEN8I3iCpFYYii6RrCNpmIeQ5MT6SHLACjMzzz4Sm2TcHD+qT8VeSt4nYMV
         YgYySUWBmXkxHcILyXCQBT+XOy3V351fItM9L8XWsiZtWQbGUY60YwVsB2rNEIkQ0RhB
         5pkA==
X-Gm-Message-State: AOJu0Yx7L1M08dDW5s2Q6LbPrPZ2g+gQsdIIBZQHRLsOWX+GVA3THZBN
	o9v1K3ZepiMLwTkZGYWlHUHg5Q==
X-Google-Smtp-Source: AGHT+IHECa1brdHbyZ+RRYmTLFGKg3RSF3pozRwZjz4PFeKi2aM/YBgZ+azN8FxCn8uEPW/fu+Melw==
X-Received: by 2002:a19:f507:0:b0:502:acf2:88df with SMTP id j7-20020a19f507000000b00502acf288dfmr632313lfb.35.1694761925299;
        Fri, 15 Sep 2023 00:12:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id e6-20020a056402088600b00528dc95ad4bsm1829422edy.95.2023.09.15.00.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 00:12:04 -0700 (PDT)
Message-ID: <bab9dd29-9509-f724-bcba-040501851e5e@linaro.org>
Date: Fri, 15 Sep 2023 09:12:00 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 4/8] dt-bindings: arm-smmu: Add compatible for SM4450
 SoC
Content-Language: en-US
To: Tengfei Fan <quic_tengfan@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, catalin.marinas@arm.com
Cc: geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org,
 nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, quic_tsoni@quicinc.com,
 quic_shashim@quicinc.com, quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
 quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com, kernel@quicinc.com
References: <20230915021509.25773-1-quic_tengfan@quicinc.com>
 <20230915021509.25773-6-quic_tengfan@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915021509.25773-6-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/09/2023 04:15, Tengfei Fan wrote:
> Add the SoC specific compatible for SM4450 implementing arm,mmu-500.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index cf29ab10501c..b57751c8ad90 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -47,6 +47,7 @@ properties:
>                - qcom,sdx55-smmu-500
>                - qcom,sdx65-smmu-500
>                - qcom,sdx75-smmu-500
> +              - qcom,sm4450-smmu-500
>                - qcom,sm6115-smmu-500
>                - qcom,sm6125-smmu-500
>                - qcom,sm6350-smmu-500
> @@ -70,6 +71,7 @@ properties:
>                - qcom,sc8180x-smmu-500
>                - qcom,sc8280xp-smmu-500
>                - qcom,sdm845-smmu-500
> +              - qcom,sm4450-smmu-500

Duplicated patch. Same problem.

Best regards,
Krzysztof

