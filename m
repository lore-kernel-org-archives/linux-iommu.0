From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [v3 1/1] iommu/tegra: smmu: Support variable MMIO ranges/blocks
Date: Mon, 04 Feb 2013 13:35:45 -0700
Message-ID: <51101BA1.5090208@wwwdotorg.org>
References: <1359620050-28727-1-git-send-email-hdoyu@nvidia.com><20130204195232.GA15278@8bytes.org> <20130204.223114.121259250064618894.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130204.223114.121259250064618894.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 02/04/2013 01:31 PM, Hiroshi Doyu wrote:
> Hi Joerg,
> 
> Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote @ Mon, 4 Feb 2013 20:53:32 +0100:
> 
>>>  static inline u32 smmu_read(struct smmu_device *smmu, size_t offs)
>>>  {
>>> -	BUG_ON(offs < 0x10);
>>> -	if (offs < 0x3c)
>>> -		return readl(smmu->regs[0] + offs - 0x10);
>>> -	BUG_ON(offs < 0x1f0);
>>> -	if (offs < 0x200)
>>> -		return readl(smmu->regs[1] + offs - 0x1f0);
>>> -	BUG_ON(offs < 0x228);
>>> -	if (offs < 0x284)
>>> -		return readl(smmu->regs[2] + offs - 0x228);
>>> +	int i;
>>> +
>>> +	for (i = 0; i < smmu->nregs; i++) {
>>> +		void __iomem *addr = smmu->regbase + offs;
>>> +
>>> +		BUG_ON(addr < smmu->regs[i]);
>>> +		if (addr <= smmu->rege[i])
>>> +			return readl(addr);
>>> +	}
>>
>> This loop is purely for checking offset to be valid. And this loop is
>> repeated in the smmu_write() function. I queued a patch on-top to make
>> this more clear. Please double-check:
> 
> Actually I did the similar thing in the first version of this patch(*1)
> 
> +static inline void smmu_check_reg_range(size_t offs)
> +{
> +	int i;
> +
> +	for (i = 0; i < smmu->nregs; i++) {
> +	    BUG_ON(offs < smmu->regs[i] - smmu->regbase);
> +	    		if (offs <= smmu->rege[i] - smmu->regbase)
> +			   	 break;
> +	 }
> +}
> 
> *1:
> http://lists.linuxfoundation.org/pipermail/iommu/2013-January/005072.html
> 
> Then, Stehpen pointed out about this check function(*2).
> 
> "... here, you'd be doing the loop every access anyway, so you may as
> well not calculate regbase at all, move the body of
> smmu_check_reg_range() into smmu_read()/smmu_write(), and do the access
> inside the if statement inside the loop, with the per-range mapping."

Upon reflection, that comment probably isn't correct, since the only way
to know where each register range begins, relative to the register
numbers that the driver uses, is to calculate reg_base. So, I think you
do need reg_base, and Joerg's latest patch seems reasonable.

> *2:
> http://lists.linuxfoundation.org/pipermail/iommu/2013-January/005074.html
> 
> I might not get Stehpen's point in the latest patch(?), though....
