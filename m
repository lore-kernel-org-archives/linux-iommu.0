Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03A4396
	for <iommu@lists.linux.dev>; Sun, 26 Feb 2023 17:37:11 +0000 (UTC)
Received: by mail-qv1-f47.google.com with SMTP id ks17so3044300qvb.6
        for <iommu@lists.linux.dev>; Sun, 26 Feb 2023 09:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeF01LQTKaPSV+yQ93rapV3zfUy0qKLEYnaX7XN4O38=;
        b=tGrjTho3rx4shp20U4qSqt81YeakiYt5ZGLjR6YuYSw/iQfrCzN9Iv0tYCU0QMW8NZ
         mFM5taRkSR0x9ashfMg3Ln/74E9GbCHFSjXSfGOBiVI0DzqMIzvXMCyk72KKPFttqyiy
         Tb8X7RMx5UoQwPe6HKCmxzpVB/jltKDnLx/PsKFDZ7XiI11n/sgV7mhSbsFbkTurD0f6
         2Pd+L/uGKfzgiatgROyZyLhfRCQpg1BxcBNZaPL/vRH75NQXBkObKphEdYuyUvF8ufeq
         lnQnYC4pa0nYA9y6aqIFViqimG6A8GprIE2ebHtqflosgewN9aWmDTmXqpBkuw3ree+t
         xTog==
X-Gm-Message-State: AO0yUKURu8F6iv7S/sg28UeKklGPW/viXAiDP8+9h3W1gThV+hJ+hIu2
	FQreEcJMRdyqEiuLmSOTBQ==
X-Google-Smtp-Source: AK7set9lx5qiJgttqc85n8rLAbbDJ8e24SNnumaCwpqbEuYDGUtgKPCqFotwbIQbTouCNSdj1fegvA==
X-Received: by 2002:a05:6214:27ea:b0:56e:ad32:2d66 with SMTP id jt10-20020a05621427ea00b0056ead322d66mr37723114qvb.10.1677433030778;
        Sun, 26 Feb 2023 09:37:10 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:8ddf:ff6b:c94c:94fd:4442])
        by smtp.gmail.com with ESMTPSA id u16-20020a05620a121000b007417affecdcsm3347213qkj.69.2023.02.26.09.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 09:37:10 -0800 (PST)
Received: (nullmailer pid 69080 invoked by uid 1000);
	Sun, 26 Feb 2023 17:37:06 -0000
Date: Sun, 26 Feb 2023 11:37:06 -0600
From: Rob Herring <robh@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, andersson@kernel.org, agross@kernel.org, marijn.suijten@somainline.org, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: arm-smmu: Use qcom,smmu compatible
 for MMU500 adreno SMMUs
Message-ID: <20230226173706.GA60188-robh@kernel.org>
References: <20230217111613.306978-1-konrad.dybcio@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217111613.306978-1-konrad.dybcio@linaro.org>

On Fri, Feb 17, 2023 at 12:16:08PM +0100, Konrad Dybcio wrote:
> qcom,smmu-500 was introduced to prevent people from adding new
> compatibles for what seems to roughly be the same hardware. Use it for
> qcom,adreno-smmu-compatible targets as well.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> v1 -> v2:
> - Add this patch, omitted previously (big oops)
> 
>  .../devicetree/bindings/iommu/arm,smmu.yaml        | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 807cb511fe18..4d7f61700cae 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -75,9 +75,19 @@ properties:
>                - qcom,sm8350-smmu-500
>                - qcom,sm8450-smmu-500
>            - const: arm,mmu-500
> -
> -      - description: Qcom Adreno GPUs implementing "arm,smmu-500"
> +      - description: Qcom Adreno GPUs implementing "qcom,smmu-500" and "arm,smmu-500"
> +        items:
> +          - enum:
> +              - qcom,sc7280-smmu-500
> +              - qcom,sm8150-smmu-500
> +              - qcom,sm8250-smmu-500
> +          - const: qcom,adreno-smmu
> +          - const: qcom,smmu-500
> +          - const: arm,mmu-500

4 compatibles seems excessive. Is adding one that helpful? Is 
'arm,mmu-500' useful on its own?

> +      - description: Qcom Adreno GPUs implementing "arm,smmu-500" (legacy binding)

Perhaps fix the existing typo: arm,mmu-500

> +        deprecated: true
>          items:
> +          # Do not add additional SoC to this list. Instead use previous list.
>            - enum:
>                - qcom,sc7280-smmu-500
>                - qcom,sm8150-smmu-500
> -- 
> 2.39.1
> 
