From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/9] Docs: dt: document qcom iommu bindings
Date: Thu, 23 Mar 2017 17:21:37 -0500
Message-ID: <20170323222137.okq227mgsmsjy5zf@rob-hp-laptop>
References: <20170314151811.17234-1-robdclark@gmail.com>
 <20170314151811.17234-4-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170314151811.17234-4-robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Sricharan <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 14, 2017 at 11:18:05AM -0400, Rob Clark wrote:
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  .../devicetree/bindings/iommu/qcom,iommu.txt       | 113 +++++++++++++++++++++
>  1 file changed, 113 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> 
> diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> new file mode 100644
> index 0000000..fd5b7fa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> @@ -0,0 +1,113 @@
> +* QCOM IOMMU v1 Implementation
> +
> +Qualcomm "B" family devices which are not compatible with arm-smmu have
> +a similar looking IOMMU but without access to the global register space,
> +and optionally requiring additional configuration to route context irqs
> +to non-secure vs secure interrupt line.
> +
> +** Required properties:
> +
> +- compatible       : Should be one of:
> +
> +                        "qcom,msm8916-iommu"
> +
> +- clock-names      : Should be a pair of "iface" (required for IOMMUs
> +                     register group access) and "bus" (required for
> +                     the IOMMUs underlying bus access).
> +- clocks           : Phandles for respective clocks described by
> +                     clock-names.
> +- #address-cells   : must be 1.
> +- #size-cells      : must be 1.
> +- #iommu-cells     : Must be 1.
> +- ranges           : Base address and size of the iommu context banks.
> +- qcom,iommu-secure-id  : secure-id.
> +
> +- List of sub-nodes, one per translation context bank.  Each sub-node
> +  has the following required properties:
> +
> +  - compatible     : Should be one of:
> +        - "qcom,msm-iommu-v1-ns"  : non-secure context bank
> +        - "qcom,msm-iommu-v1-sec" : secure context bank
> +  - reg            : Base address and size of context bank within the iommu
> +  - interrupts     : The context fault irq.
> +
> +** Optional properties:
> +
> +- reg              : Base address and size of the SMMU local base, should
> +                     be only specified if the iommu requires configuration
> +                     for routing of context bank irq's to secure vs non-
> +                     secure lines.  (Ie. if the iommu contains secure
> +                     context banks)
> +
> +
> +** Examples:
> +
> +	apps_iommu: iommu@1e20000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		#iommu-cells = <1>;
> +		compatible = "qcom,msm8916-iommu", "qcom,msm-iommu-v1";

You didn't document the fallback above. Maybe just drop it if only a few 
chips have this iommu.

> +		ranges = <0 0x1e20000 0x40000>;
> +		reg = <0x1ef0000 0x3000>;

When you have both reg and ranges, use reg value for the unit-address.

> +		clocks = <&gcc GCC_SMMU_CFG_CLK>,
> +			 <&gcc GCC_APSS_TCU_CLK>;
> +		clock-names = "iface", "bus";
> +		qcom,iommu-secure-id = <17>;
> +
> +		// mdp_0:
> +		iommu-ctx@4000 {
> +			compatible = "qcom,msm-iommu-v1-ns";
> +			reg = <0x4000 0x1000>;
> +			interrupts = <GIC_SPI 70 0>;
> +		};
> +
> +		// venus_ns:
> +		iommu-ctx@5000 {
> +			compatible = "qcom,msm-iommu-v1-sec";
> +			reg = <0x5000 0x1000>;
> +			interrupts = <GIC_SPI 70 0>;
> +		};
> +	};
> +
> +	gpu_iommu: iommu@1f08000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		#iommu-cells = <1>;
> +		compatible = "qcom,msm8916-iommu", "qcom,msm-iommu-v1";
> +		ranges = <0 0x1f08000 0x10000>;
> +		clocks = <&gcc GCC_SMMU_CFG_CLK>,
> +			 <&gcc GCC_GFX_TCU_CLK>;
> +		clock-names = "iface", "bus";
> +		qcom,iommu-secure-id = <18>;
> +
> +		// gfx3d_user:
> +		iommu-ctx@1f09000 {

iommu-ctx@1000

> +			compatible = "qcom,msm-iommu-v1-ns";
> +			reg = <0x1000 0x1000>;
> +			interrupts = <GIC_SPI 241 0>;
> +		};
> +
> +		// gfx3d_priv:
> +		iommu-ctx@1f0a000 {

iommu-ctx@2000

> +			compatible = "qcom,msm-iommu-v1-ns";
> +			reg = <0x2000 0x1000>;
> +			interrupts = <GIC_SPI 242 0>;
> +		};
> +	};
> +
> +	...
> +
> +	venus: video-codec@1d00000 {
> +		...
> +		iommus = <&apps_iommu 5>;
> +	};
> +
> +	mdp: mdp@1a01000 {
> +		...
> +		iommus = <&apps_iommu 4>;
> +	};
> +
> +	gpu@01c00000 {
> +		...
> +		iommus = <&gpu_iommu 1>, <&gpu_iommu 2>;
> +	};
> -- 
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
