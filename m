From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 2/5] iommu/arm-smmu: Add support for MMU40x/500 clocks
Date: Thu, 16 Mar 2017 16:03:31 -0500
Message-ID: <20170316210331.i47xkr6opm6he3lk@rob-hp-laptop>
References: <1489073748-3659-1-git-send-email-sricharan@codeaurora.org>
	<1489073748-3659-3-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1489073748-3659-3-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 09, 2017 at 09:05:45PM +0530, Sricharan R wrote:
> The MMU400x/500 is the implementation of the SMMUv2
> arch specification. It is split in to two blocks
> TBU, TCU. TBU caches the page table, instantiated
> for each master locally, clocked by the TBUn_clk.
> TCU manages the address translation with PTW and has
> the programming interface as well, clocked using the
> TCU_CLK. The TBU can also be sharing the same clock
> domain as TCU, in which case both are clocked using
> the TCU_CLK.
> 
> This defines the clock bindings for the same and adds the
> init, enable and disable functions for handling the
> clocks.
> 
> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.txt         | 27 ++++++
>  drivers/iommu/arm-smmu.c                           | 95 +++++++++++++++++++++-
>  2 files changed, 121 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 6cdf32d..b369c13 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -60,6 +60,28 @@ conditions.
>                    aliases of secure registers have to be used during
>                    SMMU configuration.
>  
> +- clock-names:    Should be "tbu_clk" and "tcu_clk" and "cfg_clk" for

_clk is redundant

> +                  "arm,mmu-400", "arm,mmu-401" and "arm,mmu-500"
> +
> +                  "tcu_clk" is required for smmu's register access using the
> +                  programming interface and ptw for downstream bus access.
> +
> +                  "tbu_clk" is required for access to the TBU connected to the
> +                  master locally. This clock is optional and not required when
> +                  TBU is in the same clock domain as the TCU or when the TBU is
> +                  clocked along with the master.
> +
> +                  "cfg_clk" is optional if required to access the TCU's programming
> +                  interface, apart from the "tcu_clk".

Clocks generally shouldn't be optional. Either the h/w has a clock or it 
doesn't.

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
> @@ -84,6 +106,11 @@ conditions.
>                               <0 36 4>,
>                               <0 37 4>;
>                  #iommu-cells = <1>;
> +                clocks = <&gcc GCC_SMMU_CFG_CLK>,
> +                         <&gcc GCC_APSS_TCU_CLK>,
> +			 <&gcc GCC_MDP_TBU_CLK>;
> +
> +		clock-names = "cfg_clk", "tcu_clk", "tbu_clk";
>          };
>  
>          /* device with two stream IDs, 0 and 7 */
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index f7e11d3..720a1ef 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -341,6 +341,12 @@ struct arm_smmu_master_cfg {
>  #define for_each_cfg_sme(fw, i, idx) \
>  	for (i = 0; idx = fwspec_smendx(fw, i), i < fw->num_ids; ++i)
>  
> +struct mmu500_clk {
> +	struct clk *cfg_clk;
> +	struct clk *tcu_clk;
> +	struct clk *tbu_clk;
> +};
> +
>  struct arm_smmu_clks {
>  	void *clks;
>  	int (*init_clocks)(struct arm_smmu_device *smmu);
> @@ -455,6 +461,92 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
>  	return container_of(dom, struct arm_smmu_domain, domain);
>  }
>  
> +static int mmu500_enable_clocks(struct arm_smmu_device *smmu)
> +{
> +	int ret = 0;
> +	struct mmu500_clk *sclks = smmu->smmu_clks.clks;
> +
> +	if (!sclks)
> +		return 0;
> +
> +	ret = clk_prepare_enable(sclks->cfg_clk);
> +	if (ret) {
> +		dev_err(smmu->dev, "Couldn't enable cfg_clk");
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(sclks->tcu_clk);
> +	if (ret) {
> +		dev_err(smmu->dev, "Couldn't enable tcu_clk");
> +		clk_disable_unprepare(sclks->cfg_clk);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(sclks->tbu_clk);
> +	if (ret) {
> +		dev_err(smmu->dev, "Couln't enable tbu_clk");
> +		clk_disable_unprepare(sclks->tcu_clk);
> +		clk_disable_unprepare(sclks->cfg_clk);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void mmu500_disable_clocks(struct arm_smmu_device *smmu)
> +{
> +	struct mmu500_clk *sclks = smmu->smmu_clks.clks;
> +
> +	if (!sclks) {
> +		clk_disable_unprepare(sclks->tbu_clk);
> +		clk_disable_unprepare(sclks->tcu_clk);
> +		clk_disable_unprepare(sclks->cfg_clk);
> +	}
> +}
> +
> +static int mmu500_init_clocks(struct arm_smmu_device *smmu)
> +{
> +	struct device *dev = smmu->dev;
> +	struct mmu500_clk *sclks;
> +	int err;
> +
> +	if (!of_find_property(dev->of_node, "clocks", NULL))
> +		return 0;
> +
> +	sclks = devm_kzalloc(dev, sizeof(*sclks), GFP_KERNEL);
> +	if (!sclks)
> +		return -ENOMEM;
> +
> +	sclks->cfg_clk = devm_clk_get(dev, "cfg_clk");
> +	if (IS_ERR(sclks->cfg_clk)) {
> +		err = PTR_ERR(sclks->cfg_clk);
> +		/* Ignore all, except -EPROBE_DEFER for optional clocks */
> +		if (err == -EPROBE_DEFER)
> +			return err;
> +		else
> +			sclks->cfg_clk = NULL;
> +	}
> +
> +	sclks->tcu_clk = devm_clk_get(dev, "tcu_clk");
> +	if (IS_ERR(sclks->tcu_clk)) {
> +		dev_err(dev, "Couldn't get tcu_clk");
> +		return PTR_ERR(sclks->tcu_clk);
> +	}
> +
> +	sclks->tbu_clk = devm_clk_get(dev, "tbu_clk");
> +	if (IS_ERR(sclks->tbu_clk)) {
> +		err = PTR_ERR(sclks->tbu_clk);
> +		/* Ignore all, ecept -EPROBE_DEFER for optional clocks */
> +		if (err == -EPROBE_DEFER)
> +			return err;
> +		else
> +			sclks->tbu_clk = NULL;
> +	}
> +
> +	smmu->smmu_clks.clks = sclks;
> +	return 0;
> +}
> +
>  static void parse_driver_options(struct arm_smmu_device *smmu)
>  {
>  	int i = 0;
> @@ -1981,7 +2073,8 @@ struct arm_smmu_match_data {
>  		    NULL, NULL, NULL);
>  ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU,
>  		    NULL, NULL, NULL);
> -ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500, NULL, NULL, NULL);
> +ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500, mmu500_init_clocks,
> +		    mmu500_enable_clocks, mmu500_disable_clocks);
>  ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2,
>  		    NULL, NULL, NULL);
>  
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 
