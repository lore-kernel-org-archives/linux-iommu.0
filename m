From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4 5/6] iommu/arm-smmu: Add support for MMU40x/500 clocks
Date: Sun, 9 Jul 2017 22:37:55 -0500
Message-ID: <20170710033755.fq36tl26hr42s5j2@rob-hp-laptop>
References: <1499333825-7658-1-git-send-email-vivek.gautam@codeaurora.org>
	<1499333825-7658-6-git-send-email-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1499333825-7658-6-git-send-email-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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

On Thu, Jul 06, 2017 at 03:07:04PM +0530, Vivek Gautam wrote:
> From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> 
> The MMU400x/500 is the implementation of the SMMUv2
> arch specification. It is split in to two blocks
> TBU, TCU. TBU caches the page table, instantiated
> for each master locally, clocked by the TBUn_clk.
> TCU manages the address translation with PTW and has
> the programming interface as well, clocked using the
> TCU_CLK. The TBU can also be sharing the same clock
> domain as TCU, in which case both are clocked using
> the TCU_CLK.

No TBU clock below. When is it shared or not? If that's an integration 
option then the binding should always have a TBU clock with the same 
parent as the TCU_CLK.

> This defines the clock bindings for the same and adds
> the clock names to compatible data.
> 
> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> [vivek: clock rework and cleanup]
> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.txt         | 24 ++++++++++++++++++++++
>  drivers/iommu/arm-smmu.c                           | 12 ++++++++++-
>  2 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 8a6ffce12af5..00331752d355 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -71,6 +71,26 @@ conditions.
>                    or using stream matching with #iommu-cells = <2>, and
>                    may be ignored if present in such cases.
>  
> +- clock-names:    Should be "tcu" and "iface" for "arm,mmu-400",
> +                  "arm,mmu-401" and "arm,mmu-500"
> +
> +                  "tcu" clock is required for smmu's register access using the
> +                  programming interface and ptw for downstream bus access. This
> +                  clock is also used for access to the TBU connected to the
> +                  master locally. Sometimes however, TBU is clocked along with
> +                  the master.
> +
> +                  "iface" clock is required to access the TCU's programming
> +                  interface, apart from the "tcu" clock.
> +
> +- clocks:         Phandles for respective clocks described by clock-names.
> +
> +- power-domains:  Phandles to SMMU's power domain specifier. This is
> +                  required even if SMMU belongs to the master's power
> +                  domain, as the SMMU will have to be enabled and
> +                  accessed before master gets enabled and linked to its
> +                  SMMU.
> +
>  ** Deprecated properties:
>  
>  - mmu-masters (deprecated in favour of the generic "iommus" binding) :
> @@ -95,6 +115,10 @@ conditions.
>                               <0 36 4>,
>                               <0 37 4>;
>                  #iommu-cells = <1>;
> +                clocks = <&gcc GCC_SMMU_CFG_CLK>,
> +                         <&gcc GCC_APSS_TCU_CLK>;
> +
> +		clock-names = "iface", "tcu";
>          };
>  
>          /* device with two stream IDs, 0 and 7 */
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 75567d9698ab..7bb09280fa11 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1947,9 +1947,19 @@ struct arm_smmu_match_data {
>  ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
>  ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
>  ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
> -ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
>  ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
>  
> +static const char * const arm_mmu500_clks[] = {
> +	"tcu", "iface",
> +};
> +
> +static const struct arm_smmu_match_data arm_mmu500 = {
> +	.version = ARM_SMMU_V2,
> +	.model = ARM_MMU500,
> +	.clks = arm_mmu500_clks,
> +	.num_clks = ARRAY_SIZE(arm_mmu500_clks),
> +};
> +
>  static const struct of_device_id arm_smmu_of_match[] = {
>  	{ .compatible = "arm,smmu-v1", .data = &smmu_generic_v1 },
>  	{ .compatible = "arm,smmu-v2", .data = &smmu_generic_v2 },
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
