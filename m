From: Stanimir Varbanov via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH v1 3/3] arm64: dts: qcom: msm8998: Add PCIe PHY and RC
	nodes
Date: Wed, 10 Apr 2019 18:32:18 +0300
Message-ID: <3f32cfb9-6528-9f5e-85db-cee89fdcfc5d@mm-sol.com>
References: <5eedbe6d-f440-1a77-8a7e-81a920e3a0e7@free.fr>
	<186f7ca2-84e2-a37e-79e6-f1fec8e25374@free.fr>
Reply-To: Stanimir Varbanov <svarbanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <186f7ca2-84e2-a37e-79e6-f1fec8e25374-GANU6spQydw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marc Gonzalez <marc.w.gonzalez-GANU6spQydw@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jeffrey Hugo <jhugo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, MSM <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Evan Green <evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Manu Gautam <mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Marc,

Few comments inline.

On 3/28/19 7:06 PM, Marc Gonzalez wrote:
> Add MSM8998 PCIe QMP PHY and PCIe root complex DT nodes.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez-GANU6spQydw@public.gmane.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 78 +++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index 5a1c0961b281..9f979a51f679 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -621,6 +621,84 @@
>  				<GIC_SPI 369 IRQ_TYPE_EDGE_RISING>;
>  		};
>  
> +		pcie0: pci@1c00000 {
> +			compatible = "qcom,pcie-msm8996";
> +			reg-names = "parf", "dbi", "elbi", "config";
> +			reg =	<0x01c00000 0x2000>,
> +				<0x1b000000 0xf1d>,
> +				<0x1b000f20 0xa8>,
> +				<0x1b100000 0x100000>;

could you please populate reg property and after that reg-names property.

> +			device_type = "pci";
> +			linux,pci-domain = <0>;
> +			bus-range = <0x00 0xff>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			power-domains = <&gcc PCIE_0_GDSC>;
> +
> +			num-lanes = <1>;
> +			phy-names = "pciephy";
> +			phys = <&pciephy>;
> +
> +			ranges =
> +			/*** downstream I/O ***/

could you make this a standard kernel comment or completely drop it

> +			<0x01000000 0x0 0x1b200000 0x1b200000 0x0 0x100000>,
> +			/*** non-prefetchable memory ***/

ditto

> +			<0x02000000 0x0 0x1b300000 0x1b300000 0x0 0xd00000>;
> +
> +			#interrupt-cells = <1>;
> +			interrupt-names = "msi";
> +			interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map =
> +				<0 0 0 1 &intc 0 135 IRQ_TYPE_LEVEL_HIGH>, /* int_a */

move this to a line upper

> +				<0 0 0 2 &intc 0 136 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +				<0 0 0 3 &intc 0 138 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +				<0 0 0 4 &intc 0 139 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +
> +			clock-names = "pipe", "bus_master", "bus_slave", "cfg", "aux";
> +			clocks =
> +				<&gcc GCC_PCIE_0_PIPE_CLK>,

move this to a line upper

> +				<&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> +				<&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> +				<&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				<&gcc GCC_PCIE_0_AUX_CLK>;

please swap the order clocks and clock-names

> +
> +			iommu-map = <0x100 &anoc1_smmu 0x1480 1>;

iommu-map-mask? It is optional but I had to ask :)

> +
> +			/* PCIe Fundamental Reset */

this comment is useless :) please drop it

> +			perst-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		phy@1c06000 {
> +			compatible = "qcom,msm8998-qmp-pcie-phy";
> +			reg = <0x01c06000 0x18c>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			clock-names = "aux", "cfg_ahb", "ref";
> +			clocks =
> +				<&gcc GCC_PCIE_PHY_AUX_CLK>,
> +				<&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				<&gcc GCC_PCIE_CLKREF_CLK>;\

please, swap the order of clocks and clock-names, and move first clock a
line upper. Also delete '\' symbol at the end of last line.

> +
> +			reset-names = "phy", "common";
> +			resets = <&gcc GCC_PCIE_0_PHY_BCR>, <&gcc GCC_PCIE_PHY_BCR>;

resets prop and after that reset-names, please.

> +
> +			vdda-phy-supply = <&vreg_l1a_0p875>;
> +			vdda-pll-supply = <&vreg_l2a_1p2>;
> +
> +			pciephy: lane@1c06800 {
> +				reg = <0x01c06200 0x128>, <0x01c06400 0x1fc>, <0x01c06800 0x20c>;
> +				#phy-cells = <0>;
> +
> +				clock-names = "pipe0";
> +				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;

please, swap clocks and clock-names

> +				clock-output-names = "pcie_0_pipe_clk_src";
> +				#clock-cells = <0>;
> +			};
> +		};
> +
>  		tcsr_mutex_regs: syscon@1f40000 {
>  			compatible = "syscon";
>  			reg = <0x1f40000 0x20000>;
> 

-- 
regards,
Stan
