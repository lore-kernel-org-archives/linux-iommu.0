From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: tegra alloc_pdir
Date: Wed, 27 Jun 2012 11:46:28 +0200
Message-ID: <20120627.124628.673793050413876363.hdoyu@nvidia.com>
References: <20120626181555.GW15796@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120626181555.GW15796-JyIX8gxvWYPr2PDY2+4mTGD2FQJk+8+b@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org" <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Chris,

Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org> wrote @ Tue, 26 Jun 2012 20:15:55 +0200:

> This looks buggy to me:
> 
> drivers/iommu/tegra-smmu.c::smmu_iommu_domain_init()
> 
>   spin_lock_irqsave(&tmp->lock, flags);   <-- lock held, interrupts off
>   alloc_pdir(as = tmp)
>     devm_kzalloc(..., GFP_KERNEL);        <-- potentially sleeping allocation
>     ...
>     alloc_page(..., GFP_KERNEL | __GFP_DMA);   <-- same here

Right. I totally agree. Thank you for pointing this out.

The fix patch follows.
