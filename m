From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RESEND PATCH v4 1/1] dt-bindings: arm-smmu: Add binding doc for
 Qcom smmu-500
Date: Thu, 13 Dec 2018 10:45:24 +0000
Message-ID: <20181213104524.GA31177@edgewater-inn.cambridge.arm.com>
References: <20181213090507.6269-1-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181213090507.6269-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: joro@8bytes.org, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Dec 13, 2018 at 02:35:07PM +0530, Vivek Gautam wrote:
> Qcom's implementation of arm,mmu-500 works well with current
> arm-smmu driver implementation. Adding a soc specific compatible
> along with arm,mmu-500 makes the bindings future safe.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
> 
> Hi Joerg,
> I am picking this out separately from the sdm845 smmu support
> series [1], so that this can go through iommu tree.
> The dt patch from the series [1] can be taken through arm-soc tree.
> 
> Hi Will,
> As asked [2], here's the resend version of dt binding patch for sdm845.
> Kindly ack this so that Joerg can pull this in.

Acked-by: Will Deacon <will.deacon@arm.com>

Joerg -- please can you take this on top of the pull request I sent already?
Vivek included it as part of a separate series which I thought was going
via arm-soc, but actually it needs to go with the other arm-smmu patches
in order to avoid conflicts.

Cheers,

Will

>  Documentation/devicetree/bindings/iommu/arm,smmu.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index a6504b37cc21..3133f3ba7567 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -27,6 +27,10 @@ conditions.
>                    "qcom,msm8996-smmu-v2", "qcom,smmu-v2",
>                    "qcom,sdm845-smmu-v2", "qcom,smmu-v2".
>  
> +                  Qcom SoCs implementing "arm,mmu-500" must also include,
> +                  as below, SoC-specific compatibles:
> +                  "qcom,sdm845-smmu-500", "arm,mmu-500"
> +
>  - reg           : Base address and size of the SMMU.
>  
>  - #global-interrupts : The number of global interrupts exposed by the
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
