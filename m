Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7D133E4
	for <iommu@lists.linux.dev>; Thu, 22 Dec 2022 13:33:11 +0000 (UTC)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 2A27F1F8F4;
	Thu, 22 Dec 2022 14:33:07 +0100 (CET)
Date: Thu, 22 Dec 2022 14:33:05 +0100
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
Message-ID: <20221222133305.txcla3kk6lrqk7sc@SoMainline.org>
References: <20221222092355.74586-1-krzysztof.kozlowski@linaro.org>
 <20221222101611.nwt5arux2hcvvtvf@SoMainline.org>
 <bff48e91-3cdc-a052-9573-3c4271f88e5a@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bff48e91-3cdc-a052-9573-3c4271f88e5a@linaro.org>

On 2022-12-22 11:36:16, Krzysztof Kozlowski wrote:
> On 22/12/2022 11:16, Marijn Suijten wrote:
> > Is this missing a cc to linux-arm-msm?
> 
> No, it is not (or maybe but then fix MAINTAINERS). The policy is to use
> get_maintainers.pl to CC people.

Yes, that is the question: is it in MANTAINERS and if not, why not?

> > On 2022-12-22 10:23:55, Krzysztof Kozlowski wrote:
> >> Disallow clocks for variants other than:
> >> 1. SMMUs with platform-specific compatibles which list explicit clocks
> >>    and clock-names,
> >> 2. SMMUs using only generic compatibles, e.g. arm,mmu-500, which have a
> >>    variable clocks on different implementations.
> >>
> >> This requires such variants with platform-specific compatible, to
> >> explicitly list the clocks or omit them, making the binding more
> >> constraint.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> > 
> > But...
> > 
> >> ---
> >>
> >> Cc: Marijn Suijten <marijn.suijten@somainline.org>
> >> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> ---
> >>  .../devicetree/bindings/iommu/arm,smmu.yaml   | 28 +++++++++++++++++++
> >>  1 file changed, 28 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> >> index 895ec8418465..0d88395e43ad 100644
> >> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> >> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> >> @@ -367,6 +367,34 @@ allOf:
> >>              - description: interface clock required to access smmu's registers
> >>                  through the TCU's programming interface.
> >>  
> >> +  # Disallow clocks for all other platforms with specific compatibles
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            enum:
> >> +              - cavium,smmu-v2
> >> +              - marvell,ap806-smmu-500
> >> +              - nvidia,smmu-500
> >> +              - qcom,qcm2290-smmu-500
> >> +              - qcom,qdu1000-smmu-500
> >> +              - qcom,sc7180-smmu-500
> > 
> > Hmm, sc7280 has two SMMUs.  The one for Adreno has clocks and a PD, the
> 
> sc7280 is not here, so what is the mistake you see?

sc7280 has two IOMMU nodes.  One with clocks (should not be in this
list), the other doesn't have clocks (should be in this list).

How do you want to address that?

> > one for APPS has neither.  Same story on sm8[12]50.  Aren't those going
> > to trip up the other `if` that requires clocks in both scenarios?
> 
> They are not here either, so what is the error?

Ditto.

> > Note that the Adreno SMMUs have (or will get when we/Konrad submit
> > support for it) the "qcom,adreno-smmu" compatible to distinguish them.

- Marijn
