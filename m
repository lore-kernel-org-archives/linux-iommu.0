From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [v2 1/1] iommu/tegra: smmu: Fix unsleepable memory allocation
 at alloc_pdir()
Date: Thu, 28 Jun 2012 10:57:18 -0600
Message-ID: <4FEC8CEE.1000401@wwwdotorg.org>
References: <20120628134202.2102f715496a3b980b43f3b0@nvidia.com> <1340880707-6934-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340880707-6934-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 06/28/2012 04:51 AM, Hiroshi DOYU wrote:
> alloc_pdir() is called from smmu_iommu_domain_init() with spin_lock
> held. memory allocations in alloc_pdir() had to be
> atomic/unsleepable. Instead of converting into atomic allocation, this
> patch once releases a lock, do the allocation, hold the lock again and
> then see if it's raced or not in order to avoid introducing mutex.

> ---

You'd typically want to include a brief description of what changed from
v1->v2 here, as a hint to reviewers re: what to concentrate on.

> +static int alloc_pdir(struct smmu_as *as, unsigned long *flags)

> +	spin_unlock_irqrestore(&as->lock, *flags);
> +	cnt = devm_kzalloc(smmu->dev,
> +			   sizeof(cnt[0]) * SMMU_PDIR_COUNT, GFP_KERNEL);
> +	page = alloc_page(GFP_KERNEL | __GFP_DMA);
> +	spin_lock_irqsave(&as->lock, *flags);
> +
> +	if (as->pdir_page) {
> +		/* We raced, free the redundant */
> +		err = -ENODEV;
> +		goto err_out;
>  	}

Is that really an error; it just means that something else allocated the
same pdir already. Since the top of the function does:

 	if (as->pdir_page)
 		return 0;

I'd expect to s/err = -ENODEV/err = 0/ inside that if condition that I
quoted above, but still of cause "goto err_out" to free the now unneeded
allocations.

Aside from that, I think this looks reasonable.
