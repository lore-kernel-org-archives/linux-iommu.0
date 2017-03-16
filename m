From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V3 3/5] drivers: arm-smmu: Add clock support for
 QCOM_SMMUV2
Date: Thu, 16 Mar 2017 16:10:39 -0500
Message-ID: <20170316211039.rbqq262syalyfcs6@rob-hp-laptop>
References: <1489073748-3659-1-git-send-email-sricharan@codeaurora.org>
 <1489073748-3659-4-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1489073748-3659-4-git-send-email-sricharan@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com, linux-clk@vger.kernel.org, sboyd@codeaurora.org, devicetree@vger.kernel.org, mathieu.poirier@linaro.org, mark.rutland@arm.com
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 09, 2017 at 09:05:46PM +0530, Sricharan R wrote:
> The QCOM_SMMUV2 is an implementation of the arm,smmu-v2 architecture.
> The qcom,smmu is instantiated for each of the multimedia cores (for eg)
> Venus (video encoder/decoder), mdp (display) etc, and they are connected
> to the Multimedia Aggregator Interconnect (MMAGIC). So the access to
> any of the MMU's registers, as well as MMU's downstream bus access,
> requires the specified MMAGIC clocks to be enabled. So adding a new
> binding for the qcom,smmu-v2 and the required mmagic clock bindings for
> the same. Also adding the support for enabling the qcom,smmu-v2 clocks in
> the driver.
> 
>                -------------  ---------
>                |   VENUS   |  | MDP   |
> 	       |	   |  |       |
> 	       -------------  --------
> 		     |           |
> 		     |           |
>                   ------      ---------
>                   |SMMU |     | SMMU  |
>                   |	|     |       |
>                   ------      --------
> 		    |            |
> 		    |            |
>        -----------------------------------------
>        |	MMAGIC INTERCONNECT (MMSS NOC) |
>        |                                       |
>        -----------------------------------------
>                    |                 |
> 		   |           ----------------------------------
>                  -----         | 	SYSTEM NOC		|
>                  |DDR|	       |				|
>                  -----         ---------------------------------
> 		   |		    |
>                    |               ------
> 		   |<-------------| CPU|
> 				  ------
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.txt         |   8 ++
>  drivers/iommu/arm-smmu.c                           | 124 +++++++++++++++++++++
>  2 files changed, 132 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index b369c13..88e02d6 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -17,6 +17,7 @@ conditions.
>                          "arm,mmu-401"
>                          "arm,mmu-500"
>                          "cavium,smmu-v2"
> +			"qcom,smmu-v2"

I know Cavium did it, but I'd prefer to see SoC specific compatibles 
here.

>  
>                    depending on the particular implementation and/or the
>                    version of the architecture implemented.
> @@ -74,6 +75,13 @@ conditions.
>                    "cfg_clk" is optional if required to access the TCU's programming
>                    interface, apart from the "tcu_clk".
>  
> +		  Should have "mmagic_ahb_clk", "mmagic_cfg_ahb_clk",
> +                              "smmu_core_ahb_clk", "smmu_core_axi_clk",
> +                              "mmagic_core_axi_clk" for "qcom,smmu-v2"

This is instead of the above clocks?

Are these clocks all really part of the SMMU or are the mmagic clocks 
working around no proper driver for the mmagic?

> +
> +		  "mmagic_core_axi_clk" is required for smmu's access to the
> +                   downstream bus and rest for the smmu's register group access.
> +
>  - clocks:         Phandles for respective clocks described by clock-names.
>  
>  - power-domains:  Phandles to SMMU's power domain specifier. This is
