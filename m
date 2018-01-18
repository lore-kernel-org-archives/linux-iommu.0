From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 04/13] iommu/rockchip: Fix error handling in attach
Date: Thu, 18 Jan 2018 13:23:00 +0000
Message-ID: <fa4277ef-ddfe-e23b-034c-167281cf0db1@arm.com>
References: <20180118115251.5542-1-jeffy.chen@rock-chips.com>
	<20180118115251.5542-5-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180118115251.5542-5-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 18/01/18 11:52, Jeffy Chen wrote:
> From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> 
> Currently if the driver encounters an error while attaching device, it
> will leave the IOMMU in an inconsistent state. Even though it shouldn't
> really happen in reality, let's just add proper error path to keep
> things consistent.
> 
> Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2:
> Move irq request to probe(in patch[0])
> 
>   drivers/iommu/rockchip-iommu.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index b743d82e6fe1..37065a7127c9 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -824,7 +824,7 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>   
>   	ret = rk_iommu_force_reset(iommu);
>   	if (ret)
> -		return ret;
> +		goto err_disable_stall;
>   
>   	iommu->domain = domain;
>   
> @@ -837,7 +837,7 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>   
>   	ret = rk_iommu_enable_paging(iommu);
>   	if (ret)
> -		return ret;
> +		goto err_disable_stall;
>   
>   	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
>   	list_add_tail(&iommu->node, &rk_domain->iommus);
> @@ -848,6 +848,11 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>   	rk_iommu_disable_stall(iommu);
>   
>   	return 0;

Nit: if you like, it looks reasonable to name the label 
"out_disable_stall" and remove these lines above here, to save the 
duplication between the error and success paths (since ret will already 
be 0 on the latter).

Either way,

Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

> +
> +err_disable_stall:
> +	rk_iommu_disable_stall(iommu);
> +
> +	return ret;
>   }
>   
>   static void rk_iommu_detach_device(struct iommu_domain *domain,
> 
