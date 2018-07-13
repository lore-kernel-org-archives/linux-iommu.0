From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/3] arm64: dts: stratix10: Add SMMU Node
Date: Fri, 13 Jul 2018 19:09:08 +0100
Message-ID: <2d17b3b1-96a1-8a0a-521e-134de9df72d0@arm.com>
References: <1531499278-32132-1-git-send-email-thor.thayer@linux.intel.com>
	<1531499278-32132-4-git-send-email-thor.thayer@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1531499278-32132-4-git-send-email-thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dinguyen-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 13/07/18 17:27, thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org wrote:
> From: Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> Add the SMMU node and IOMMU parameters to the
> Stratix10 Device Tree.
> 
> Signed-off-by: Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>   arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 44 +++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> index ca67ecb5866e..9b6ead87ae70 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> @@ -162,6 +162,8 @@
>   			reset-names = "stmmaceth", "stmmaceth-ocp";
>   			clocks = <&clkmgr STRATIX10_EMAC0_CLK>;
>   			clock-names = "stmmaceth";
> +			#stream-id-cells = <1>;

The #stream-id-cells property is part of the deprecated mmu-masters 
binding, so you don't need to add these.

> +			iommus = <&smmu 1>;
>   			status = "disabled";
>   		};
>   
> @@ -175,6 +177,8 @@
>   			reset-names = "stmmaceth", "stmmaceth-ocp";
>   			clocks = <&clkmgr STRATIX10_EMAC1_CLK>;
>   			clock-names = "stmmaceth";
> +			#stream-id-cells = <1>;
> +			iommus = <&smmu 2>;
>   			status = "disabled";
>   		};
>   
> @@ -188,6 +192,8 @@
>   			reset-names = "stmmaceth", "stmmaceth-ocp";
>   			clocks = <&clkmgr STRATIX10_EMAC2_CLK>;
>   			clock-names = "stmmaceth";
> +			#stream-id-cells = <1>;
> +			iommus = <&smmu 3>;
>   			status = "disabled";
>   		};
>   
> @@ -298,6 +304,8 @@
>   			clocks = <&clkmgr STRATIX10_L4_MP_CLK>,
>   				 <&clkmgr STRATIX10_SDMMC_CLK>;
>   			clock-names = "biu", "ciu";
> +			#stream-id-cells = <1>;
> +			iommus = <&smmu 5>;
>   			status = "disabled";
>   		};
>   
> @@ -323,6 +331,8 @@
>   			#dma-requests = <32>;
>   			clocks = <&clkmgr STRATIX10_L4_MAIN_CLK>;
>   			clock-names = "apb_pclk";
> +			#stream-id-cells = <1>;
> +			iommus = <&smmu 8>;

Just to double-check, all the channel threads and the manager thread 
share the one stream ID? (I'm accustomed to seeing DMA-330 integrated 
with an SMMU by tapping the AxID outputs off to the stream ID input.)

>   		};
>   
>   		rst: rstmgr@ffd11000 {
> @@ -332,6 +342,36 @@
>   			altr,modrst-offset = <0x20>;
>   		};
>   
> +		smmu: iommu@fa000000 {
> +			compatible = "arm,mmu-500", "arm,smmu-v2";
> +			reg = <0xfa000000 0x40000>;
> +			#global-interrupts = <9>;
> +			#iommu-cells = <1>;
> +			clocks = <&clkmgr STRATIX10_L4_MAIN_CLK>;
> +			clock-names = "smmu_clk";
> +			interrupt-parent = <&intc>;
> +			interrupts = <0 128 4>,	/* Global Secure Fault */
> +				<0 129 4>, /* Global Non-secure Fault */
> +				<0 130 4>, /* FPGA Performance Counter */
> +				<0 131 4>, /* DMA Performance Counter */
> +				<0 132 4>, /* EMAC Performance Counter */
> +				<0 133 4>, /* IO Performance Counter */
> +				<0 134 4>, /* SDM Performance Counter */

Note that there isn't much benefit to adding the secure or PMU 
interrupts here other than to document the hardware - FWIW I have 
actually been working on a PMU driver, and needless to say it turns out 
not to be sufficient just having those munged into the SMMU global fault 
handler.

> +				<0 136 4>, /* Non-secure Combined Interrupt */
> +				<0 137 4>, /* Secure Combined Interrupt */

Similarly the combined interrupt; that's literally just all these other 
interrupt lines ORed together at the SMMU end, and would generally only 
be useful if you *didn't* have the individual lines wired up. As it 
stands with everything listed, any event will also generate a spurious 
global fault IRQ, which isn't ideal (not that you should get many 
interrupts during normal operation, but still...)

Robin.

> +				/* Non-secure Context Interrupts (32) */
> +				<0 138 4>, <0 139 4>, <0 140 4>, <0 141 4>,
> +				<0 142 4>, <0 143 4>, <0 144 4>, <0 145 4>,
> +				<0 146 4>, <0 147 4>, <0 148 4>, <0 149 4>,
> +				<0 150 4>, <0 151 4>, <0 152 4>, <0 153 4>,
> +				<0 154 4>, <0 155 4>, <0 156 4>, <0 157 4>,
> +				<0 158 4>, <0 159 4>, <0 160 4>, <0 161 4>,
> +				<0 162 4>, <0 163 4>, <0 164 4>, <0 165 4>,
> +				<0 166 4>, <0 167 4>, <0 168 4>, <0 169 4>;
> +			stream-match-mask = <0x7ff0>;
> +			status = "disabled";
> +		};
> +
>   		spi0: spi@ffda4000 {
>   			compatible = "snps,dw-apb-ssi";
>   			#address-cells = <1>;
> @@ -439,6 +479,8 @@
>   			resets = <&rst USB0_RESET>, <&rst USB0_OCP_RESET>;
>   			reset-names = "dwc2", "dwc2-ecc";
>   			clocks = <&clkmgr STRATIX10_USB_CLK>;
> +			#stream-id-cells = <1>;
> +			iommus = <&smmu 6>;
>   			status = "disabled";
>   		};
>   
> @@ -451,6 +493,8 @@
>   			resets = <&rst USB1_RESET>, <&rst USB1_OCP_RESET>;
>   			reset-names = "dwc2", "dwc2-ecc";
>   			clocks = <&clkmgr STRATIX10_USB_CLK>;
> +			#stream-id-cells = <1>;
> +			iommus = <&smmu 7>;
>   			status = "disabled";
>   		};
>   
> 
