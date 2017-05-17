From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: RE: [v6 2/3] iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2
 erratum #74
Date: Wed, 17 May 2017 10:13:01 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838351762@FRAEML521-MBX.china.huawei.com>
References: <1494592866-14076-1-git-send-email-gakula@caviumnetworks.com>
 <1494592866-14076-3-git-send-email-gakula@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1494592866-14076-3-git-send-email-gakula@caviumnetworks.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Geetha sowjanya <gakula@caviumnetworks.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "Charles.Garcia-Tobin@arm.com" <Charles.Garcia-Tobin@arm.com>, Geetha Sowjanya <geethasowjanya.akula@cavium.com>, "geethasowjanya.akula@gmail.com" <geethasowjanya.akula@gmail.com>, "jcm@redhat.com" <jcm@redhat.com>, "linu.cherian@cavium.com" <linu.cherian@cavium.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "robert.moore@intel.com" <robert.moore@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "robert.richter@cavium.com" <robert.richter@cavium.com>, "lv.zheng@intel.com" <lv.zheng@intel.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "sgoutham@cavium.com" <sgoutham@cavium.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, devel@acpica
List-Id: iommu@lists.linux-foundation.org

Hi Geetha,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces@lists.infradead.org] On Behalf Of Geetha sowjanya
> Sent: Friday, May 12, 2017 1:41 PM
> To: will.deacon@arm.com; robin.murphy@arm.com;
> lorenzo.pieralisi@arm.com; hanjun.guo@linaro.org; sudeep.holla@arm.com;
> iommu@lists.linux-foundation.org
> Cc: Charles.Garcia-Tobin@arm.com; Geetha Sowjanya;
> geethasowjanya.akula@gmail.com; jcm@redhat.com;
> linu.cherian@cavium.com; rjw@rjwysocki.net; robert.moore@intel.com;
> linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org;
> robert.richter@cavium.com; lv.zheng@intel.com; catalin.marinas@arm.com;
> sgoutham@cavium.com; linux-arm-kernel@lists.infradead.org;
> devel@acpica.org
> Subject: [v6 2/3] iommu/arm-smmu-v3: Add workaround for Cavium
> ThunderX2 erratum #74
> 
> From: Linu Cherian <linu.cherian@cavium.com>
> 
> Cavium ThunderX2 SMMU implementation doesn't support page 1 register
> space and PAGE0_REGS_ONLY option is enabled as an errata workaround.
> This option when turned on, replaces all page 1 offsets used for
> EVTQ_PROD/CONS, PRIQ_PROD/CONS register access with page 0 offsets.
> 
> SMMU resource size checks are now based on SMMU option
> PAGE0_REGS_ONLY, since resource size can be either 64k/128k.
> For this, arm_smmu_device_dt_probe/acpi_probe has been moved before
> platform_get_resource call, so that SMMU options are set beforehand.
> 
> Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
> Signed-off-by: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
> ---
>  Documentation/arm64/silicon-errata.txt             |  1 +
>  .../devicetree/bindings/iommu/arm,smmu-v3.txt      |  6 ++
>  drivers/iommu/arm-smmu-v3.c                        | 64 +++++++++++++++++-----
>  3 files changed, 56 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/arm64/silicon-errata.txt
> b/Documentation/arm64/silicon-errata.txt
> index 10f2ddd..4693a32 100644
> --- a/Documentation/arm64/silicon-errata.txt
> +++ b/Documentation/arm64/silicon-errata.txt
> @@ -62,6 +62,7 @@ stable kernels.
>  | Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154
> |
>  | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456
> |
>  | Cavium         | ThunderX SMMUv2 | #27704          | N/A                         |
> +| Cavium         | ThunderX2 SMMUv3| #74             | N/A                         |
>  |                |                 |                 |                             |
>  | Freescale/NXP  | LS2080A/LS1043A | A-008585        |
> FSL_ERRATUM_A008585         |
>  |                |                 |                 |                             |
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> index be57550..e6da62b 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> @@ -49,6 +49,12 @@ the PCIe specification.
>  - hisilicon,broken-prefetch-cmd
>                      : Avoid sending CMD_PREFETCH_* commands to the SMMU.
> 
> +- cavium-cn99xx,broken-page1-regspace
> +                    : Replaces all page 1 offsets used for EVTQ_PROD/CONS,
> +						PRIQ_PROD/CONS register
> access with page 0 offsets.
> +						Set for Caviun ThunderX2
> silicon that doesn't support
> +						SMMU page1 register space.
> +
>  ** Example
> 
>          smmu@2b400000 {
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 380969a..c519927c 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -412,6 +412,9 @@
>  #define MSI_IOVA_BASE			0x8000000
>  #define MSI_IOVA_LENGTH			0x100000
> 
> +#define ARM_SMMU_PAGE0_REGS_ONLY(smmu)		\
> +	((smmu)->options & ARM_SMMU_OPT_PAGE0_REGS_ONLY)
> +
>  static bool disable_bypass;
>  module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
> MODULE_PARM_DESC(disable_bypass, @@ -597,6 +600,7 @@ struct
> arm_smmu_device {
>  	u32				features;
> 
>  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> +#define ARM_SMMU_OPT_PAGE0_REGS_ONLY    (1 << 1)
>  	u32				options;
> 
>  	struct arm_smmu_cmdq		cmdq;
> @@ -663,9 +667,19 @@ struct arm_smmu_option_prop {
> 
>  static struct arm_smmu_option_prop arm_smmu_options[] = {
>  	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-
> cmd" },
> +	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY,
> +"cavium-cn99xx,broken-page1-regspace"},
>  	{ 0, NULL},
>  };
> 
> +static inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,
> +						 struct arm_smmu_device
> *smmu)
> +{
> +	if (offset > SZ_64K && ARM_SMMU_PAGE0_REGS_ONLY(smmu))
> +		offset -= SZ_64K;
> +
> +	return smmu->base + offset;
> +}
> +
>  static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain
> *dom)  {
>  	return container_of(dom, struct arm_smmu_domain, domain); @@ -
> 1961,8 +1975,8 @@ static int arm_smmu_init_one_queue(struct
> arm_smmu_device *smmu,
>  		return -ENOMEM;
>  	}
> 
> -	q->prod_reg	= smmu->base + prod_off;
> -	q->cons_reg	= smmu->base + cons_off;
> +	q->prod_reg	= arm_smmu_page1_fixup(prod_off, smmu);
> +	q->cons_reg	= arm_smmu_page1_fixup(cons_off, smmu);
>  	q->ent_dwords	= dwords;
> 
>  	q->q_base  = Q_BASE_RWA;
> @@ -2363,8 +2377,10 @@ static int arm_smmu_device_reset(struct
> arm_smmu_device *smmu, bool bypass)
> 
>  	/* Event queue */
>  	writeq_relaxed(smmu->evtq.q.q_base, smmu->base +
> ARM_SMMU_EVTQ_BASE);
> -	writel_relaxed(smmu->evtq.q.prod, smmu->base +
> ARM_SMMU_EVTQ_PROD);
> -	writel_relaxed(smmu->evtq.q.cons, smmu->base +
> ARM_SMMU_EVTQ_CONS);
> +	writel_relaxed(smmu->evtq.q.prod,
> +		       arm_smmu_page1_fixup(ARM_SMMU_EVTQ_PROD,
> smmu));
> +	writel_relaxed(smmu->evtq.q.cons,
> +		       arm_smmu_page1_fixup(ARM_SMMU_EVTQ_CONS,
> smmu));
> 
>  	enables |= CR0_EVTQEN;
>  	ret = arm_smmu_write_reg_sync(smmu, enables,
> ARM_SMMU_CR0, @@ -2379,9 +2395,9 @@ static int
> arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>  		writeq_relaxed(smmu->priq.q.q_base,
>  			       smmu->base + ARM_SMMU_PRIQ_BASE);
>  		writel_relaxed(smmu->priq.q.prod,
> -			       smmu->base + ARM_SMMU_PRIQ_PROD);
> +
> arm_smmu_page1_fixup(ARM_SMMU_PRIQ_PROD, smmu));
>  		writel_relaxed(smmu->priq.q.cons,
> -			       smmu->base + ARM_SMMU_PRIQ_CONS);
> +
> arm_smmu_page1_fixup(ARM_SMMU_PRIQ_CONS, smmu));
> 
>  		enables |= CR0_PRIQEN;
>  		ret = arm_smmu_write_reg_sync(smmu, enables,
> ARM_SMMU_CR0, @@ -2605,6 +2621,14 @@ static int
> arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)  }
> 
>  #ifdef CONFIG_ACPI
> +static void acpi_smmu_get_options(u32 model, struct arm_smmu_device
> +*smmu) {
> +	if (model == ACPI_IORT_SMMU_CAVIUM_CN99XX)
> +		smmu->options |= ARM_SMMU_OPT_PAGE0_REGS_ONLY;

HiSIlicon hip06/07 boards have a similar existing option to enable,
ARM_SMMU_OPT_SKIP_PREFETCH. I have just sent out a similar patch to enable
It-" [PATCH] iommu/arm-smmu-v3: Enable ACPI based HiSilicon CMD_PREFETCH
 quirk(erratum 161010701)".  May be it can be merged here, if this series goes through.
 Not sure about the protocol though.

Thanks,
Shameer



