From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: Fwd: [PATCH v7 2/3] iommu/arm-smmu-v3: Add workaround for Cavium
 ThunderX2 erratum #74
Date: Fri, 9 Jun 2017 16:43:07 +0100
Message-ID: <ee0fb6c3-1c5c-f6d1-b063-ead8102d0c67@arm.com>
References: <1496145821-3411-1-git-send-email-gakula@caviumnetworks.com>
 <1496145821-3411-3-git-send-email-gakula@caviumnetworks.com>
 <9263562d-03a3-d02e-6b7e-01613a4bd296@arm.com>
 <CA+7sy7C_44dTy0-nAE=b5BCXmc8ACQx2O6A1jCOCsemZDD5j4w@mail.gmail.com>
 <20170609113832.GB106079@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170609113832.GB106079@localhost>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Jayachandran C <jnair@caviumnetworks.com>
Cc: Geetha sowjanya <gakula@caviumnetworks.com>, will.deacon@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, iommu@lists.linux-foundation.org, robh@kernel.org, Charles.Garcia-Tobin@arm.com, Geetha Sowjanya <geethasowjanya.akula@cavium.com>, geethasowjanya.akula@gmail.com, jcm@redhat.com, linu.cherian@cavium.com, rjw@rjwysocki.net, robert.moore@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, robert.richter@cavium.com, lv.zheng@intel.com, catalin.marinas@arm.com, sgoutham@cavium.com, linux-arm-kernel@lists.infradead.org, devel@acpica.org
List-Id: iommu@lists.linux-foundation.org

On 09/06/17 12:38, Jayachandran C wrote:
> On Fri, Jun 09, 2017 Robin Murphy wrote:
>>
>> On 30/05/17 13:03, Geetha sowjanya wrote:
>>> From: Linu Cherian <linu.cherian@cavium.com>
>>>
>>> Cavium ThunderX2 SMMU implementation doesn't support page 1 register space
>>> and PAGE0_REGS_ONLY option is enabled as an errata workaround.
>>> This option when turned on, replaces all page 1 offsets used for
>>> EVTQ_PROD/CONS, PRIQ_PROD/CONS register access with page 0 offsets.
>>>
>>> SMMU resource size checks are now based on SMMU option PAGE0_REGS_ONLY,
>>> since resource size can be either 64k/128k.
>>> For this, arm_smmu_device_dt_probe/acpi_probe has been moved before
>>> platform_get_resource call, so that SMMU options are set beforehand.
>>>
>>> Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
>>> Signed-off-by: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
>>> ---
>>>  Documentation/arm64/silicon-errata.txt             |    1 +
>>>  .../devicetree/bindings/iommu/arm,smmu-v3.txt      |    6 ++
>>>  drivers/iommu/arm-smmu-v3.c                        |   64 +++++++++++++++-----
>>>  3 files changed, 56 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
>>> index 10f2ddd..4693a32 100644
>>> --- a/Documentation/arm64/silicon-errata.txt
>>> +++ b/Documentation/arm64/silicon-errata.txt
>>> @@ -62,6 +62,7 @@ stable kernels.
>>>  | Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154        |
>>>  | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456        |
>>>  | Cavium         | ThunderX SMMUv2 | #27704          | N/A                         |
>>> +| Cavium         | ThunderX2 SMMUv3| #74             | N/A                         |
>>>  |                |                 |                 |                             |
>>>  | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
>>>  |                |                 |                 |                             |
>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
>>> index be57550..607e270 100644
>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
>>> @@ -49,6 +49,12 @@ the PCIe specification.
>>>  - hisilicon,broken-prefetch-cmd
>>>                      : Avoid sending CMD_PREFETCH_* commands to the SMMU.
>>>
>>> +- cavium,cn9900-broken-page1-regspace
>>> +                    : Replaces all page 1 offsets used for EVTQ_PROD/CONS,
>>> +                                             PRIQ_PROD/CONS register access with page 0 offsets.
>>> +                                             Set for Caviun ThunderX2 silicon that doesn't support
>>> +                                             SMMU page1 register space.
>>
>> The indentation's a bit funky here - the rest of this file is actually
>> indented with spaces, but either way it's clear your editor isn't set to
>> 8-space tabs ;)
>>
>>> +
>>>  ** Example
>>>
>>>          smmu@2b400000 {
>>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>>> index 380969a..4e80205 100644
>>> --- a/drivers/iommu/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm-smmu-v3.c
>>> @@ -412,6 +412,9 @@
>>>  #define MSI_IOVA_BASE                        0x8000000
>>>  #define MSI_IOVA_LENGTH                      0x100000
>>>
>>> +#define ARM_SMMU_PAGE0_REGS_ONLY(smmu)               \
>>> +     ((smmu)->options & ARM_SMMU_OPT_PAGE0_REGS_ONLY)
>>
>> At the two places we use this macro, frankly I think it would be clearer
>> to just reference smmu->options directly, as we currently do for
>> SKIP_PREFETCH. The abstraction also adds more lines than it saves...
>>
>>> +
>>>  static bool disable_bypass;
>>>  module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
>>>  MODULE_PARM_DESC(disable_bypass,
>>> @@ -597,6 +600,7 @@ struct arm_smmu_device {
>>>       u32                             features;
>>>
>>>  #define ARM_SMMU_OPT_SKIP_PREFETCH   (1 << 0)
>>> +#define ARM_SMMU_OPT_PAGE0_REGS_ONLY    (1 << 1)
>>
>> Whitespace again, although this time it's spaces where there should be a
>> tab.
>>
>>>       u32                             options;
>>>
>>>       struct arm_smmu_cmdq            cmdq;
>>> @@ -663,9 +667,19 @@ struct arm_smmu_option_prop {
>>>
>>>  static struct arm_smmu_option_prop arm_smmu_options[] = {
>>>       { ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
>>> +     { ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium,cn9900-broken-page1-regspace"},
>>>       { 0, NULL},
>>>  };
>>>
>>> +static inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,
>>> +                                              struct arm_smmu_device *smmu)
>>> +{
>>> +     if (offset > SZ_64K && ARM_SMMU_PAGE0_REGS_ONLY(smmu))
>>> +             offset -= SZ_64K;
>>> +
>>> +     return smmu->base + offset;
>>> +}
>>> +
>>>  static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
>>>  {
>>>       return container_of(dom, struct arm_smmu_domain, domain);
>>> @@ -1961,8 +1975,8 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
>>>               return -ENOMEM;
>>>       }
>>>
>>> -     q->prod_reg     = smmu->base + prod_off;
>>> -     q->cons_reg     = smmu->base + cons_off;
>>> +     q->prod_reg     = arm_smmu_page1_fixup(prod_off, smmu);
>>> +     q->cons_reg     = arm_smmu_page1_fixup(cons_off, smmu);
>>>       q->ent_dwords   = dwords;
>>>
>>>       q->q_base  = Q_BASE_RWA;
>>> @@ -2363,8 +2377,10 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>>>
>>>       /* Event queue */
>>>       writeq_relaxed(smmu->evtq.q.q_base, smmu->base + ARM_SMMU_EVTQ_BASE);
>>> -     writel_relaxed(smmu->evtq.q.prod, smmu->base + ARM_SMMU_EVTQ_PROD);
>>> -     writel_relaxed(smmu->evtq.q.cons, smmu->base + ARM_SMMU_EVTQ_CONS);
>>> +     writel_relaxed(smmu->evtq.q.prod,
>>> +                    arm_smmu_page1_fixup(ARM_SMMU_EVTQ_PROD, smmu));
>>> +     writel_relaxed(smmu->evtq.q.cons,
>>> +                    arm_smmu_page1_fixup(ARM_SMMU_EVTQ_CONS, smmu));
> 
> This sequence and the arm_smmu_page1_fixup() call is repeated in quite a few
> places. I think this errata code is messy because the original driver does not
> make the alias page usage explicit.

It *is* explicit - the architecture says the event queue and PRI queue
pointers exist only on page 1, and that is the offset we define for
them. The architecture also says "The equivalent Page 0 offsets of
registers that are defined on Page 1 are Reserved and ARM recommends
that they are not accessed. Access to these offsets is CONSTRAINED
UNPREDICTABLE..."

This workaround is a bodge dependent on a specific implementation always
having a specific CONSTRAINED UNPREDICTABLE behaviour, and I see no
point in trying to dress it up as anything else. Yes, it could be
considered a little bit messy, but messy is what you get when you step
outside the spec. The fixup is invoked a grand total of 6 times, over 3
locations, and there's no way of factoring it out further that doesn't
just add significantly more code and complexity than it would save.

Robin.

> A patch like the one below (no functional changes) would clean up the original
> driver and make the errata change much simpler - any comments?
> 
> -- >8 --
> 
> Date: Tue, 30 May 2017 15:43:29 +0000
> Subject: [PATCH] iommu: arm-smmu-v3: make alias page usage explicit
> 
> ---
>  drivers/iommu/arm-smmu-v3.c | 76 +++++++++++++++++++++++++++------------------
>  1 file changed, 46 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 380969a..11fdb4f 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -171,20 +171,19 @@
>  #define STRTAB_BASE_CFG_FMT_LINEAR	(0 << STRTAB_BASE_CFG_FMT_SHIFT)
>  #define STRTAB_BASE_CFG_FMT_2LVL	(1 << STRTAB_BASE_CFG_FMT_SHIFT)
>  
> +#define ARM_SMMU_Q_PROD(qbase)		((qbase) + 0x8)
> +#define ARM_SMMU_Q_PROD_PAGE1(qbase)	((qbase) + 0x10008)
> +#define ARM_SMMU_Q_CONS(qbase)		((qbase) + 0xc)
> +#define ARM_SMMU_Q_CONS_PAGE1(qbase)	((qbase) + 0x1000c)
> +
>  #define ARM_SMMU_CMDQ_BASE		0x90
> -#define ARM_SMMU_CMDQ_PROD		0x98
> -#define ARM_SMMU_CMDQ_CONS		0x9c
>  
>  #define ARM_SMMU_EVTQ_BASE		0xa0
> -#define ARM_SMMU_EVTQ_PROD		0x100a8
> -#define ARM_SMMU_EVTQ_CONS		0x100ac
>  #define ARM_SMMU_EVTQ_IRQ_CFG0		0xb0
>  #define ARM_SMMU_EVTQ_IRQ_CFG1		0xb8
>  #define ARM_SMMU_EVTQ_IRQ_CFG2		0xbc
>  
>  #define ARM_SMMU_PRIQ_BASE		0xc0
> -#define ARM_SMMU_PRIQ_PROD		0x100c8
> -#define ARM_SMMU_PRIQ_CONS		0x100cc
>  #define ARM_SMMU_PRIQ_IRQ_CFG0		0xd0
>  #define ARM_SMMU_PRIQ_IRQ_CFG1		0xd8
>  #define ARM_SMMU_PRIQ_IRQ_CFG2		0xdc
> @@ -1946,11 +1945,30 @@ static struct iommu_ops arm_smmu_ops = {
>  };
>  
>  /* Probing and initialisation functions */
> +static int arm_smmu_reset_one_queue(struct arm_smmu_device *smmu,
> +				    struct arm_smmu_queue *q,
> +				    unsigned long qoffset,
> +				    int page_to_use)
> +{
> +	unsigned long prod, cons;
> +
> +	writeq_relaxed(q->q_base, smmu->base + qoffset);
> +	if (page_to_use == 1) {
> +		prod = ARM_SMMU_Q_PROD_PAGE1(qoffset);
> +		cons = ARM_SMMU_Q_CONS_PAGE1(qoffset);
> +	} else {
> +		prod = ARM_SMMU_Q_PROD(qoffset);
> +		cons = ARM_SMMU_Q_CONS(qoffset);
> +	}
> +	writeq_relaxed(q->prod, smmu->base + prod);
> +	writeq_relaxed(q->cons, smmu->base + cons);
> +}
> +
>  static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
>  				   struct arm_smmu_queue *q,
> -				   unsigned long prod_off,
> -				   unsigned long cons_off,
> -				   size_t dwords)
> +				   unsigned long qoffset,
> +				   size_t dwords,
> +				   int page_to_use)
>  {
>  	size_t qsz = ((1 << q->max_n_shift) * dwords) << 3;
>  
> @@ -1961,8 +1979,13 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
>  		return -ENOMEM;
>  	}
>  
> -	q->prod_reg	= smmu->base + prod_off;
> -	q->cons_reg	= smmu->base + cons_off;
> +	if (page_to_use == 1) {
> +		q->prod_reg	= smmu->base + ARM_SMMU_Q_PROD_PAGE1(qoffset);
> +		q->cons_reg	= smmu->base + ARM_SMMU_Q_CONS_PAGE1(qoffset);
> +	} else {
> +		q->prod_reg	= smmu->base + ARM_SMMU_Q_PROD(qoffset);
> +		q->cons_reg	= smmu->base + ARM_SMMU_Q_CONS(qoffset);
> +	}
>  	q->ent_dwords	= dwords;
>  
>  	q->q_base  = Q_BASE_RWA;
> @@ -1980,14 +2003,14 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
>  
>  	/* cmdq */
>  	spin_lock_init(&smmu->cmdq.lock);
> -	ret = arm_smmu_init_one_queue(smmu, &smmu->cmdq.q, ARM_SMMU_CMDQ_PROD,
> -				      ARM_SMMU_CMDQ_CONS, CMDQ_ENT_DWORDS);
> +	ret = arm_smmu_init_one_queue(smmu, &smmu->cmdq.q, ARM_SMMU_CMDQ_BASE,
> +				      CMDQ_ENT_DWORDS, 0);
>  	if (ret)
>  		return ret;
>  
>  	/* evtq */
> -	ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q, ARM_SMMU_EVTQ_PROD,
> -				      ARM_SMMU_EVTQ_CONS, EVTQ_ENT_DWORDS);
> +	ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q, ARM_SMMU_EVTQ_BASE,
> +				      EVTQ_ENT_DWORDS, USE_PAGE1);
>  	if (ret)
>  		return ret;
>  
> @@ -1995,8 +2018,8 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
>  	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
>  		return 0;
>  
> -	return arm_smmu_init_one_queue(smmu, &smmu->priq.q, ARM_SMMU_PRIQ_PROD,
> -				       ARM_SMMU_PRIQ_CONS, PRIQ_ENT_DWORDS);
> +	return arm_smmu_init_one_queue(smmu, &smmu->priq.q, ARM_SMMU_PRIQ_BASE,
> +				       PRIQ_ENT_DWORDS, 1);
>  }
>  
>  static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
> @@ -2332,9 +2355,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>  		       smmu->base + ARM_SMMU_STRTAB_BASE_CFG);
>  
>  	/* Command queue */
> -	writeq_relaxed(smmu->cmdq.q.q_base, smmu->base + ARM_SMMU_CMDQ_BASE);
> -	writel_relaxed(smmu->cmdq.q.prod, smmu->base + ARM_SMMU_CMDQ_PROD);
> -	writel_relaxed(smmu->cmdq.q.cons, smmu->base + ARM_SMMU_CMDQ_CONS);
> +	arm_smmu_reset_one_queue(smmu, &smmu->evtq.q,
> +				 ARM_SMMU_CMDQ_BASE, 0);
>  
>  	enables = CR0_CMDQEN;
>  	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
> @@ -2362,9 +2384,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>  	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
>  
>  	/* Event queue */
> -	writeq_relaxed(smmu->evtq.q.q_base, smmu->base + ARM_SMMU_EVTQ_BASE);
> -	writel_relaxed(smmu->evtq.q.prod, smmu->base + ARM_SMMU_EVTQ_PROD);
> -	writel_relaxed(smmu->evtq.q.cons, smmu->base + ARM_SMMU_EVTQ_CONS);
> +	arm_smmu_reset_one_queue(smmu, &smmu->evtq.q,
> +				 ARM_SMMU_EVTQ_BASE, 1);
>  
>  	enables |= CR0_EVTQEN;
>  	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
> @@ -2376,13 +2397,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>  
>  	/* PRI queue */
>  	if (smmu->features & ARM_SMMU_FEAT_PRI) {
> -		writeq_relaxed(smmu->priq.q.q_base,
> -			       smmu->base + ARM_SMMU_PRIQ_BASE);
> -		writel_relaxed(smmu->priq.q.prod,
> -			       smmu->base + ARM_SMMU_PRIQ_PROD);
> -		writel_relaxed(smmu->priq.q.cons,
> -			       smmu->base + ARM_SMMU_PRIQ_CONS);
> -
> +		arm_smmu_reset_one_queue(smmu, &smmu->priq.q,
> +					 ARM_SMMU_PRIQ_BASE, 1);
>  		enables |= CR0_PRIQEN;
>  		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
>  					      ARM_SMMU_CR0ACK);
> 

