From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 1/7] iommu/arm-smmu-v3: Introduce SMMU option
 PAGE0_REGS_ONLY for ThunderX2 errata #74
Date: Mon, 8 May 2017 10:59:46 +0100
Message-ID: <b4881237-aca6-63ca-467e-30e36b1f02df@arm.com>
References: <1493986091-30521-1-git-send-email-gakula@caviumnetworks.com>
 <1493986091-30521-2-git-send-email-gakula@caviumnetworks.com>
 <20170505230328.GN4906@rric.localdomain> <20170508091739.GA26003@virtx40>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170508091739.GA26003@virtx40>
Sender: linux-acpi-owner@vger.kernel.org
To: Linu Cherian <linu.cherian@cavium.com>, Robert Richter <rric@kernel.org>
Cc: Geetha sowjanya <gakula@caviumnetworks.com>, will.deacon@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, iommu@lists.linux-foundation.org, jcm@redhat.com, linux-kernel@vger.kernel.org, robert.richter@cavium.com, catalin.marinas@arm.com, sgoutham@cavium.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, geethasowjanya.akula@gmail.com, Charles.Garcia-Tobin@arm.com, Geetha Sowjanya <geethasowjanya.akula@cavium.com>
List-Id: iommu@lists.linux-foundation.org

On 08/05/17 10:17, Linu Cherian wrote:
> On Sat May 06, 2017 at 01:03:28AM +0200, Robert Richter wrote:
>> On 05.05.17 17:38:05, Geetha sowjanya wrote:
>>> From: Linu Cherian <linu.cherian@cavium.com>
>>>
>>> Cavium ThunderX2 SMMU implementation doesn't support page 1 register space
>>> and PAGE0_REGS_ONLY option will be enabled as an errata workaround.
>>>
>>> This option when turned on, replaces all page 1 offsets used for
>>> EVTQ_PROD/CONS, PRIQ_PROD/CONS register access with page 0 offsets.
>>>
>>> Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
>>> Signed-off-by: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
>>> ---
>>>  .../devicetree/bindings/iommu/arm,smmu-v3.txt      |  6 +++
>>>  drivers/iommu/arm-smmu-v3.c                        | 44 ++++++++++++++++------
>>>  2 files changed, 38 insertions(+), 12 deletions(-)
>>
>>> @@ -1995,8 +2011,10 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
>>>  	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
>>>  		return 0;
>>>  
>>> -	return arm_smmu_init_one_queue(smmu, &smmu->priq.q, ARM_SMMU_PRIQ_PROD,
>>> -				       ARM_SMMU_PRIQ_CONS, PRIQ_ENT_DWORDS);
>>> +	return arm_smmu_init_one_queue(smmu, &smmu->priq.q,
>>> +				       ARM_SMMU_PRIQ_PROD(smmu),
>>> +				       ARM_SMMU_PRIQ_CONS(smmu),
>>> +				       PRIQ_ENT_DWORDS);
>>
>> I would also suggest Robin's idea from the v1 review here. This works
>> if we rework arm_smmu_init_one_queue() to pass addresses instead of
>> offsets.
>>
>> This would make these widespread offset calculations obsolete.
>>
> 
> Have pasted here the relevant changes for doing fixups on smmu base instead
> of offset to get feedback. 
> 
> This actually results in more lines of changes. If you think the below
> approach is still better, will post a V4 of this series with this change.

Why not just do this?:

static inline unsigned long page1_offset_adjust(
	unsigned long off, struct arm_smmu_device *smmu)
{
	if (off > SZ_64K && ARM_SMMU_PAGE0_REGS_ONLY(smmu))
		return (off - SZ_64K);

	return off;
}

AFAICS that should be the least disruptive way to go about it.

Robin.

> 
> 
> +static inline unsigned long arm_smmu_page1_base(
> +	struct arm_smmu_device *smmu)
> +{
> +	if (ARM_SMMU_PAGE0_REGS_ONLY(smmu))
> +		return smmu->base;
> +	else
> +		return smmu->base + SZ_64K;
> +}
> +
> 
> @@ -1948,8 +1962,8 @@ static void arm_smmu_put_resv_regions(struct device *dev,
>  /* Probing and initialisation functions */
>  static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
>  				   struct arm_smmu_queue *q,
> -				   unsigned long prod_off,
> -				   unsigned long cons_off,
> +				   unsigned long prod_addr,
> +				   unsigned long cons_addr,
>  				   size_t dwords)
>  {
>  	size_t qsz = ((1 << q->max_n_shift) * dwords) << 3;
> @@ -1961,8 +1975,8 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
>  		return -ENOMEM;
>  	}
>  
> -	q->prod_reg	= smmu->base + prod_off;
> -	q->cons_reg	= smmu->base + cons_off;
> +	q->prod_reg	= prod_addr;
> +	q->cons_reg	= cons_addr;
>  	q->ent_dwords	= dwords;
>  
>  	q->q_base  = Q_BASE_RWA;
> @@ -1977,17 +1991,25 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
>  static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
>  {
>  	int ret;
> +	unsigned long page1_base, page0_base;
> +
> +	page0_base = smmu->base;
> +	page1_base = arm_smmu_page1_base(smmu);
>  
>  	/* cmdq */
>  	spin_lock_init(&smmu->cmdq.lock);
> -	ret = arm_smmu_init_one_queue(smmu, &smmu->cmdq.q, ARM_SMMU_CMDQ_PROD,
> -				      ARM_SMMU_CMDQ_CONS, CMDQ_ENT_DWORDS);
> +	ret = arm_smmu_init_one_queue(smmu, &smmu->cmdq.q, 
> +				      page0_base + ARM_SMMU_CMDQ_PROD,
> +				      page0_base + ARM_SMMU_CMDQ_CONS, 
> +				      CMDQ_ENT_DWORDS);
>  	if (ret)
>  		return ret;
>  
>  	/* evtq */
> -	ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q, ARM_SMMU_EVTQ_PROD,
> -				      ARM_SMMU_EVTQ_CONS, EVTQ_ENT_DWORDS);
> +	ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q,
> +				      page1_base + ARM_SMMU_EVTQ_PROD,
> +				      page1_base + ARM_SMMU_EVTQ_CONS,
> +				      EVTQ_ENT_DWORDS);
>  	if (ret)
>  		return ret;
>  
> @@ -1995,8 +2017,10 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
>  	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
>  		return 0;
>  
> -	return arm_smmu_init_one_queue(smmu, &smmu->priq.q, ARM_SMMU_PRIQ_PROD,
> -				       ARM_SMMU_PRIQ_CONS, PRIQ_ENT_DWORDS);
> +	return arm_smmu_init_one_queue(smmu, &smmu->priq.q,
> +				       page1_base + ARM_SMMU_PRIQ_PROD,
> +				       page1_base + ARM_SMMU_PRIQ_CONS,
> +				       PRIQ_ENT_DWORDS);
>  }
> 
> 
> 
> @@ -2301,8 +2349,11 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>  {
>  	int ret;
>  	u32 reg, enables;
> +	unsigned long page1_base;
>  	struct arm_smmu_cmdq_ent cmd;
>  
> +	page1_base = arm_smmu_page1_base(smmu);
> +
>  	/* Clear CR0 and sync (disables SMMU and queue processing) */
>  	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
>  	if (reg & CR0_SMMUEN)
> @@ -2363,8 +2414,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>  
>  	/* Event queue */
>  	writeq_relaxed(smmu->evtq.q.q_base, smmu->base + ARM_SMMU_EVTQ_BASE);
> -	writel_relaxed(smmu->evtq.q.prod, smmu->base + ARM_SMMU_EVTQ_PROD);
> -	writel_relaxed(smmu->evtq.q.cons, smmu->base + ARM_SMMU_EVTQ_CONS);
> +	writel_relaxed(smmu->evtq.q.prod, page1_base + ARM_SMMU_EVTQ_PROD);
> +	writel_relaxed(smmu->evtq.q.cons, page1_base + ARM_SMMU_EVTQ_CONS);
>  
>  	enables |= CR0_EVTQEN;
>  	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
> @@ -2379,9 +2430,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>  		writeq_relaxed(smmu->priq.q.q_base,
>  			       smmu->base + ARM_SMMU_PRIQ_BASE);
>  		writel_relaxed(smmu->priq.q.prod,
> -			       smmu->base + ARM_SMMU_PRIQ_PROD);
> +			       page1_base + ARM_SMMU_PRIQ_PROD);
>  		writel_relaxed(smmu->priq.q.cons,
> -			       smmu->base + ARM_SMMU_PRIQ_CONS);
> +			       page1_base + ARM_SMMU_PRIQ_CONS);
>  
>  		enables |= CR0_PRIQEN;
>  		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
> 
> 
> 
> Thanks.
> 

