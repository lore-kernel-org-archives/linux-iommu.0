From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] iommu/shmobile: Allocate archdata with kzalloc()
Date: Wed, 18 Dec 2013 10:15:21 +0900
Message-ID: <20131218011521.GI18992@verge.net.au>
References: <1387300730-28783-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1387300730-28783-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387300730-28783-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: iommu@lists.linux-foundation.org, linux-sh@vger.kernel.org, Nguyen Viet Dung <nv-dung@jinso.co.jp>
List-Id: iommu@lists.linux-foundation.org

On Tue, Dec 17, 2013 at 06:18:49PM +0100, Laurent Pinchart wrote:
> The archdata attached_list field isn't initialized, leading to random
> crashes when accessed. Use kzalloc() to allocate the whole structure and
> make sure all fields get initialized properly.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/iommu/shmobile-iommu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/shmobile-iommu.c b/drivers/iommu/shmobile-iommu.c
> index d572863..7a3b928 100644
> --- a/drivers/iommu/shmobile-iommu.c
> +++ b/drivers/iommu/shmobile-iommu.c
> @@ -380,14 +380,13 @@ int ipmmu_iommu_init(struct shmobile_ipmmu *ipmmu)
>  		kmem_cache_destroy(l1cache);
>  		return -ENOMEM;
>  	}
> -	archdata = kmalloc(sizeof(*archdata), GFP_KERNEL);
> +	archdata = kzalloc(sizeof(*archdata), GFP_KERNEL);
>  	if (!archdata) {
>  		kmem_cache_destroy(l1cache);
>  		kmem_cache_destroy(l2cache);
>  		return -ENOMEM;
>  	}
>  	spin_lock_init(&archdata->attach_lock);
> -	archdata->attached = NULL;
>  	archdata->ipmmu = ipmmu;
>  	ipmmu_archdata = archdata;
>  	bus_set_iommu(&platform_bus_type, &shmobile_iommu_ops);
> -- 
> 1.8.3.2
> 
