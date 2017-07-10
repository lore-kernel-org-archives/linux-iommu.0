From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4 6/6] iommu/arm-smmu: Add support for
	qcom,msm8996-smmu-v2 clocks
Date: Sun, 9 Jul 2017 22:40:57 -0500
Message-ID: <20170710034057.o5tha22rlllbxu3y@rob-hp-laptop>
References: <1499333825-7658-1-git-send-email-vivek.gautam@codeaurora.org>
	<1499333825-7658-7-git-send-email-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1499333825-7658-7-git-send-email-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 06, 2017 at 03:07:05PM +0530, Vivek Gautam wrote:
> qcom,msm8996-smmu-v2 is an arm,smmu-v2 implementation with
> specific clock and power requirements. This smmu core is used
> with multiple masters on msm8996, viz. mdss, video, etc.
> Add bindings for the same.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.txt | 18 ++++++++++++++++++
>  drivers/iommu/arm-smmu.c                             | 13 +++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 00331752d355..5d8e79775fae 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -17,6 +17,7 @@ conditions.
>                          "arm,mmu-401"
>                          "arm,mmu-500"
>                          "cavium,smmu-v2"
> +                        "qcom,msm8996-smmu-v2"
>  
>                    depending on the particular implementation and/or the
>                    version of the architecture implemented.
> @@ -74,11 +75,16 @@ conditions.
>  - clock-names:    Should be "tcu" and "iface" for "arm,mmu-400",
>                    "arm,mmu-401" and "arm,mmu-500"
>  
> +                  Should be "bus", and "iface" for "qcom,msm8996-smmu-v2"
> +                  implementation.
> +
>                    "tcu" clock is required for smmu's register access using the
>                    programming interface and ptw for downstream bus access. This
>                    clock is also used for access to the TBU connected to the
>                    master locally. Sometimes however, TBU is clocked along with
>                    the master.
> +                  "bus" clock for "qcom,msm8996-smmu-v2" is requierd for downstream

s/requierd/required/

> +                  bus access and for the smmu ptw.
>  
>                    "iface" clock is required to access the TCU's programming
>                    interface, apart from the "tcu" clock.
> @@ -161,3 +167,15 @@ conditions.
>                  iommu-map = <0 &smmu3 0 0x400>;
>                  ...
>          };
> +
> +	/* Qcom's arm,smmu-v2 implementation for msm8996 */
> +	smmu4: iommu {
> +		compatible = "qcom,msm8996-smmu-v2";

No registers?

> +		...
> +		#iommu-cells = <1>;
> +		power-domains = <&mmcc MDSS_GDSC>;
> +
> +		clocks = <&mmcc SMMU_MDP_AXI_CLK>,
> +			 <&mmcc SMMU_MDP_AHB_CLK>;
> +		clock-names = "bus", "iface";
> +	};
