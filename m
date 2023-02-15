Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106573C1E
	for <iommu@lists.linux.dev>; Wed, 15 Feb 2023 09:26:41 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so995538wms.1
        for <iommu@lists.linux.dev>; Wed, 15 Feb 2023 01:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pDqcpoPLiHDU8oCdM3OoiluY+MByg/cYzVfroSMx2sk=;
        b=jLIs2Rig2UH6N2f26DYyKCpi7GHi9aVUFhIFP1oGC8vd4gluc++9Uo186mUVJkb3nX
         HKsBY/O/iBPF/+IcDqCglEoHxPRITux9SUEhfB1pGsjncJPpnphXZK1WE0L+utCFB7mW
         vMLmNn8iXoRjUr5MqCCib8L2PpF3p0gEDIHJJG7Q4qSDZZ1pv/lv0D8kZrqxwshxZ6C9
         SxO9URZgHAR3b/iJ7VGuPlkWEsUb3fDk9MM6N4Yp4oJL8YUEGBfxPh6LMYwPQhrNUI3H
         GMW5kQkzYvsbiRbGfAvdi8AZlXBjJVWvFWD2dSy+1vkhbllK3f2E9yFXVwraQCMsw/WX
         KTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pDqcpoPLiHDU8oCdM3OoiluY+MByg/cYzVfroSMx2sk=;
        b=C7uRYG8+FUX2k0bWR6MCSnI82JrDr4IZuoTZSPzvDbaDodlXIpw3tUVK8J2jYat05n
         CZi1qSmJih8dbPur2BowNp8xBzL+pxGyx6usCGz00R2LVvuaY4d/hMnRtBzWeCuTBcQh
         1OcePRV1Gee3d+D6ButWijdzKHRbqTIh3hWqCz0VhBZpHpgyn5VCvE+O4WEeTYJst/Nj
         mfpOxcu0U+BV7/YUo12UQ6GLFJTzIaMOlgdTm7NPHkkQoLRzOILKy2CmGmm8cebUnvZd
         xmE8iRlCRuQeoY4IA9S05C3DAf2ASMsPD69ejDQR4PI9Y2QJkoji9aNDpQnZE3yrpGM3
         O3Gg==
X-Gm-Message-State: AO0yUKWNGjhveFHgtQTRPg+2lR59U/CC57j7kDmcxKraJbAUEeKluqJV
	b9XGGMQGWnzjUCU1OhAn2FnWfg==
X-Google-Smtp-Source: AK7set8RA5uU58/+01j7yB6ab5moJgdO2RqwtybuzHkNa6HHIX9IfrfNZyIuB4QKCVA3fe7Va27xjQ==
X-Received: by 2002:a05:600c:46c6:b0:3e0:14a:697a with SMTP id q6-20020a05600c46c600b003e0014a697amr1682223wmo.6.1676453200227;
        Wed, 15 Feb 2023 01:26:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:7fda:5fd:df14:bb65? ([2a01:e0a:982:cbb0:7fda:5fd:df14:bb65])
        by smtp.gmail.com with ESMTPSA id he7-20020a05600c540700b003e118684d56sm1393389wmb.45.2023.02.15.01.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 01:26:39 -0800 (PST)
Message-ID: <bb6f65a0-a4af-c9e6-ddc8-6ff06452c9dc@linaro.org>
Date: Wed, 15 Feb 2023 10:26:39 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3] dt-bindings: arm-smmu: Add compatible for SM8550 SoC
Content-Language: en-US
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Robin Murphy
 <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>
References: <20230207-topic-sm8550-upstream-smmu-bindings-v3-1-cb15a7123cfe@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230207-topic-sm8550-upstream-smmu-bindings-v3-1-cb15a7123cfe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Will,

On 08/02/2023 10:13, neil.armstrong@linaro.org wrote:
> From: Abel Vesa <abel.vesa@linaro.org>
> 
> Add the SoC specific compatible for SM8550 implementing
> arm,mmu-500.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v3:
> - update allOf:if: for disallowing clocks
> - Link to v2: https://lore.kernel.org/r/20230207-topic-sm8550-upstream-smmu-bindings-v2-1-680cbfae6dac@linaro.org
> 
> Changes in v2:
> - Rebased on new bindings using qcom,smmu-500 & arm,mmu-500
> - Dropped driver changes since we rely on qcom,smmu-500 fallback
> - Link to v1: https://lore.kernel.org/all/20221116114001.2669003-1-abel.vesa@linaro.org/
> ---
>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
>   1 file changed, 2 insertions(+)

Do you think you can pick this patch for v6.3 ?

Thanks,
Neil

> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 807cb511fe18..ea81e9b1860c 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -53,6 +53,7 @@ properties:
>                 - qcom,sm8250-smmu-500
>                 - qcom,sm8350-smmu-500
>                 - qcom,sm8450-smmu-500
> +              - qcom,sm8550-smmu-500
>             - const: qcom,smmu-500
>             - const: arm,mmu-500
>   
> @@ -389,6 +390,7 @@ allOf:
>                 - qcom,sm6375-smmu-500
>                 - qcom,sm8350-smmu-500
>                 - qcom,sm8450-smmu-500
> +              - qcom,sm8550-smmu-500
>       then:
>         properties:
>           clock-names: false
> 
> ---
> base-commit: 49a8133221c71b935f36a7c340c0271c2a9ee2db
> change-id: 20230207-topic-sm8550-upstream-smmu-bindings-dbf9242cc313
> 
> Best regards,

