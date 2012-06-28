From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [v2 1/1] iommu/tegra: smmu: Fix unsleepable memory allocation
 at alloc_pdir()
Date: Thu, 28 Jun 2012 13:08:12 -0600
Message-ID: <4FECAB9C.9040809@wwwdotorg.org>
References: <20120628134202.2102f715496a3b980b43f3b0@nvidia.com><1340880707-6934-1-git-send-email-hdoyu@nvidia.com><4FEC8CEE.1000401@wwwdotorg.org> <20120628.213554.1189327754979133382.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120628.213554.1189327754979133382.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org" <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 06/28/2012 12:35 PM, Hiroshi Doyu wrote:
> Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Thu, 28 Jun 2012 18:57:18 +0200:
>> On 06/28/2012 04:51 AM, Hiroshi DOYU wrote:
>>> alloc_pdir() is called from smmu_iommu_domain_init() with spin_lock
>>> held. memory allocations in alloc_pdir() had to be
>>> atomic/unsleepable. Instead of converting into atomic allocation, this
>>> patch once releases a lock, do the allocation, hold the lock again and
>>> then see if it's raced or not in order to avoid introducing mutex.

>>> +static int alloc_pdir(struct smmu_as *as, unsigned long *flags)
>>
>>> +	spin_unlock_irqrestore(&as->lock, *flags);
>>> +	cnt = devm_kzalloc(smmu->dev,
>>> +			   sizeof(cnt[0]) * SMMU_PDIR_COUNT, GFP_KERNEL);
>>> +	page = alloc_page(GFP_KERNEL | __GFP_DMA);
>>> +	spin_lock_irqsave(&as->lock, *flags);
>>> +
>>> +	if (as->pdir_page) {
>>> +		/* We raced, free the redundant */
>>> +		err = -ENODEV;
>>> +		goto err_out;
>>>  	}
>>
>> Is that really an error; it just means that something else allocated the
>> same pdir already. Since the top of the function does:
>>
>>  	if (as->pdir_page)
>>  		return 0;
>>
>> I'd expect to s/err = -ENODEV/err = 0/ inside that if condition that I
>> quoted above, but still of cause "goto err_out" to free the now unneeded
>> allocations.
>>
>> Aside from that, I think this looks reasonable.
> 
> I think that, in the case of race condition, the one which comes
> later, should retry with the another ASID, which is incremented as
> below. So I modified that the latter one returns with -EAGAIN, and try
> with another ASID.
> 
> The complete patch follows this mail.

incremental rather than complete, right?

> 
> Changes:
> 	Modified drivers/iommu/tegra-smmu.c
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index ec656ec..f2c18fa 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -562,7 +562,7 @@ static int alloc_pdir(struct smmu_as *as, unsigned long *flags)
>  
>  	if (as->pdir_page) {
>  		/* We raced, free the redundant */
> -		err = -ENODEV;
> +		err = -EAGAIN;
>  		goto err_out;
>  	}
>  
> @@ -799,8 +799,15 @@ static int smmu_iommu_domain_init(struct iommu_domain *domain)
>  
>  		spin_lock_irqsave(&tmp->lock, flags);
>  		if (!tmp->pdir_page) {
> -			as = tmp;
> -			goto found;
> +			int err;
> +
> +			err = alloc_pdir(tmp, &flags);
> +			if (!err) {
> +				as = tmp;
> +				goto found;
> +			}
> +			if (err == -EAGAIN)
> +				continue;

That loop is going to continue anyway, since that code is right at the
end of the loop. Don't you want to replace that if block with:

if (err != -EAGAIN)
    goto err_alloc_pdir;

?

Also, the first thinig that alloc_pdir does is:

        if (as->pdir_page)
                return 0;

It seems that should be removed completely, right? Since having the
pdir_page already allocated is an error.

>  		}
>  		spin_unlock_irqrestore(&tmp->lock, flags);
>  	}
> @@ -808,9 +815,6 @@ static int smmu_iommu_domain_init(struct iommu_domain *domain)
>  	return -ENODEV;
>  
>  found:
> -	if (alloc_pdir(as, &flags) < 0)
> -		goto err_alloc_pdir;
> -
>  	spin_lock(&smmu->lock);
>  
>  	/* Update PDIR register */
> @@ -826,10 +830,6 @@ found:
>  
>  	dev_dbg(smmu->dev, "smmu_as@%p\n", as);
>  	return 0;
> -
> -err_alloc_pdir:
> -	spin_unlock_irqrestore(&as->lock, flags);
> -	return -ENODEV;
>  }
