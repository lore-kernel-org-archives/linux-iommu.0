Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6CC2563
	for <iommu@lists.linux.dev>; Thu, 22 Dec 2022 10:16:20 +0000 (UTC)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 4C1B420449;
	Thu, 22 Dec 2022 11:16:12 +0100 (CET)
Date: Thu, 22 Dec 2022 11:16:11 +0100
From: Marijn Suijten <marijn.suijten@somainline.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] dt-bindings: arm-smmu: disallow clocks when not used
Message-ID: <20221222101611.nwt5arux2hcvvtvf@SoMainline.org>
References: <20221222092355.74586-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222092355.74586-1-krzysztof.kozlowski@linaro.org>

Is this missing a cc to linux-arm-msm?

On 2022-12-22 10:23:55, Krzysztof Kozlowski wrote:
> Disallow clocks for variants other than:
> 1. SMMUs with platform-specific compatibles which list explicit clocks
>    and clock-names,
> 2. SMMUs using only generic compatibles, e.g. arm,mmu-500, which have a
>    variable clocks on different implementations.
> 
> This requires such variants with platform-specific compatible, to
> explicitly list the clocks or omit them, making the binding more
> constraint.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

But...

> ---
> 
> Cc: Marijn Suijten <marijn.suijten@somainline.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.yaml   | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 895ec8418465..0d88395e43ad 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -367,6 +367,34 @@ allOf:
>              - description: interface clock required to access smmu's registers
>                  through the TCU's programming interface.
>  
> +  # Disallow clocks for all other platforms with specific compatibles
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - cavium,smmu-v2
> +              - marvell,ap806-smmu-500
> +              - nvidia,smmu-500
> +              - qcom,qcm2290-smmu-500
> +              - qcom,qdu1000-smmu-500
> +              - qcom,sc7180-smmu-500

Hmm, sc7280 has two SMMUs.  The one for Adreno has clocks and a PD, the
one for APPS has neither.  Same story on sm8[12]50.  Aren't those going
to trip up the other `if` that requires clocks in both scenarios?

Note that the Adreno SMMUs have (or will get when we/Konrad submit
support for it) the "qcom,adreno-smmu" compatible to distinguish them.

- Marijn

> +              - qcom,sc8180x-smmu-500
> +              - qcom,sc8280xp-smmu-500
> +              - qcom,sdm670-smmu-500
> +              - qcom,sdm845-smmu-500
> +              - qcom,sdx55-smmu-500
> +              - qcom,sdx65-smmu-500
> +              - qcom,sm6115-smmu-500
> +              - qcom,sm6350-smmu-500
> +              - qcom,sm6375-smmu-500
> +              - qcom,sm8350-smmu-500
> +              - qcom,sm8450-smmu-500
> +    then:
> +      properties:
> +        clock-names: false
> +        clocks: false
> +
>    - if:
>        properties:
>          compatible:
> -- 
> 2.34.1
> 
