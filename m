From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 3/3] dts: arm64/sdm845: Add node for qcom,smmu-v2
Date: Tue, 14 Aug 2018 11:49:42 +0100
Message-ID: <27372288-447d-6c9a-504a-8b8ef40e3d58@arm.com>
References: <20180814102740.30222-1-vivek.gautam@codeaurora.org>
 <20180814102740.30222-4-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180814102740.30222-4-vivek.gautam@codeaurora.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>, joro@8bytes.org, robh+dt@kernel.org, andy.gross@linaro.org, will.deacon@arm.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org
Cc: mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jordan Crouse <jcrouse@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

Hi Vivek,

On 14/08/18 11:27, Vivek Gautam wrote:
> Add device node for qcom,smmu-v2 available on sdm845.
> This smmu is available only to GPU device.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 1c2be2082f33..bd1ec5fa5146 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -6,6 +6,7 @@
>    */
>   
>   #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> +#include <dt-bindings/clock/qcom,gpucc-sdm845.h>
>   #include <dt-bindings/clock/qcom,rpmh.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> @@ -989,6 +990,28 @@
>   			cell-index = <0>;
>   		};
>   
> +		gpu_smmu: iommu@5040000 {
> +			compatible = "qcom,sdm845-smmu-v2", "qcom,smmu-v2";

Which of "sdm845" or "msm8996"[1] is the actual SoC name here?

Robin.

[1] 
https://www.mail-archive.com/freedreno@lists.freedesktop.org/msg02659.html

> +			reg = <0x5040000 0x10000>;
> +			#iommu-cells = <1>;
> +			#global-interrupts = <2>;
> +			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 366 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 367 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 368 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 369 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 370 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 371 IRQ_TYPE_EDGE_RISING>;
> +			clock-names = "bus", "iface";
> +			clocks = <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
> +				 <&gcc GCC_GPU_CFG_AHB_CLK>;
> +
> +			/*power-domains = <&gpucc GPU_CX_GDSC>;*/
> +		};
> +
>   		apps_smmu: iommu@15000000 {
>   			compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
>   			reg = <0x15000000 0x80000>;
> 
