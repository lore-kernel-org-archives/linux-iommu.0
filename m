From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V5 RESEND 1/3] docs: iommu: Documentation for iommu in
	hi6220 SoC
Date: Fri, 20 Nov 2015 08:21:48 -0600
Message-ID: <20151120142148.GA2448@rob-hp-laptop>
References: <1447986309-47548-1-git-send-email-puck.chen@hisilicon.com>
	<1447986309-47548-2-git-send-email-puck.chen@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1447986309-47548-2-git-send-email-puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, guodong.xu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, puck.chen-Dw/NWeUnuQfQT0dZR+AlfA@public.gmane.org, arnd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 20, 2015 at 10:25:07AM +0800, Chen Feng wrote:
> Documentation for hi6220 iommu driver.
> 
> Signed-off-by: Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> ---
>  .../bindings/iommu/hisi,hi6220-iommu.txt           | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/hisi,hi6220-iommu.txt
> 
> diff --git a/Documentation/devicetree/bindings/iommu/hisi,hi6220-iommu.txt b/Documentation/devicetree/bindings/iommu/hisi,hi6220-iommu.txt
> new file mode 100644
> index 0000000..44f9101
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/hisi,hi6220-iommu.txt
> @@ -0,0 +1,32 @@
> +Hi6220 SoC SMMU Device Driver devicetree document
> +The media system shared the same smmu IP to access DDR memory. And all
> +media IP used the same page table.
> +
> +Below binding describes the system mmu for media system in hi6220 platform
> +
> +Required properties:
> +- compatible: should contain "hisilicon,hi6220-smmu".
> +- reg: A tuple of base address and size of System MMU registers.
> +- clocks: a list of phandle + clock-specifier pairs, one for each entry
> +  in clock-names.
> +- clock-names: should contain:
> +  * "smmu"
> +  * "media-sc"
> +  * "smmu-peri"
> +- interrupts: An interrupt specifier for interrupt signal of System MMU.
> +- #iommu-cells: The iommu-cells should be 0. Because no additional information
> +  needs to be encoded in the specifier.
> +
> +Examples:
> +	iommu@f4210000 {
> +		compatible = "hisilicon,hi6220-smmu";
> +		reg = <0x0 0xf4210000 0x0 0x1000>;
> +		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&sys_ctrl HI6220_MMU_CLK>,
> +		         <&media_ctrl HI6220_MED_MMU>,
> +		         <&sys_ctrl HI6220_MEDIA_PLL_SRC>;
> +		clock-names = "smmu",
> +			      "media-sc",
> +			      "smmu-peri";
> +		#iommu-cells = <0>;
> +	};
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
