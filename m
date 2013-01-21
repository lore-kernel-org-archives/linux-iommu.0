From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 4/6] iommu/tegra: smmu: Support variable MMIO range
Date: Mon, 21 Jan 2013 10:04:42 -0700
Message-ID: <50FD752A.6060706@wwwdotorg.org>
References: <50F717B8.6050800@wwwdotorg.org><20130118.110546.1909336134474854222.hdoyu@nvidia.com><50F97BDD.8010502@wwwdotorg.org> <20130121.093603.449745485344660335.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130121.093603.449745485344660335.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 01/21/2013 12:36 AM, Hiroshi Doyu wrote:
> Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Fri, 18 Jan 2013 17:44:13 +0100:
> 
>>> Even the checks if "offs" is in some of register blocks could be
>>> ifdef'ed out with DEBUG. "smmu->regbase" can be calculated in probe()
>>> as below. I don't think that we don't need to access "mc" DT entry to
>>> get this address. since "smmu"'s 1st reg block always starts at 0x10.
>>>
>>>   /* same as "mc"'s 1st reg block */
>>>   smmu->regbase = smmu->reg[0] & PAGE_MASK;
>>
>> I don't see regbase in the existing driver or your patch. Are you
> 
> I attached the update one below just for "regbase".
> 
>> proposing to simply make readl/writel add the offset onto a base address
>> that's calculated like that? That may not work in general; if the SMMU
>> register ranges cross a page boundary, and the various separate ranges
>> end up getting mapped to non-contiguous virtual addresses, using a
>> single base address won't work.
> 
> That's not in general, but I think that this works because the 1st
> SMMU register block offset is fixed(0x10) against MC base. If this is
> not acceptable, then, I think that SMMU driver needs to access to MC
> node to get the its base. What do you think?

>  drivers/iommu/tegra-smmu.c |   62 ++++++++++++++++++++++++--------------------
>  1 file changed, 34 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

> +#ifdef DEBUG
> +static inline void smmu_check_reg_range(size_t offs)

Like I said before, when is DEBUG defined? Rarely I suspect. It'd be
best to simply enable smmu_check_reg_range() all the time. As such ...

> +{
> +	int i;
> +
> +	for (i = 0; i < smmu->nregs; i++) {
> +		BUG_ON(offs < smmu->regs[i] - smmu->regbase);
> +		if (offs <= smmu->rege[i] - smmu->regbase)
> +			break;
> +	}
> +}
> +#else
> +static inline void smmu_check_reg_range(size_t offs) { }
> +#endif
> +
>  static inline u32 smmu_read(struct smmu_device *smmu, size_t offs)
>  {
> -	BUG_ON(offs < 0x10);
> -	if (offs < 0x3c)
> -		return readl(smmu->regs[0] + offs - 0x10);
> -	BUG_ON(offs < 0x1f0);
> -	if (offs < 0x200)
> -		return readl(smmu->regs[1] + offs - 0x1f0);
> -	BUG_ON(offs < 0x228);
> -	if (offs < 0x284)
> -		return readl(smmu->regs[2] + offs - 0x228);
> -	BUG();
> +	smmu_check_reg_range(offs);

... here, you'd be doing the loop every access anyway, so you may as
well not calculate regbase at all, move the body of
smmu_check_reg_range() into smmu_read()/smmu_write(), and do the access
inside the if statement inside the loop, with the per-range mapping.

> +	return readl(smmu->regbase + offs);
>  }
