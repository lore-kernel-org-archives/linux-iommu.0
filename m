From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/rockchip: Handle errors returned from PM
	framework
Date: Tue, 07 Aug 2018 14:09:14 +0200
Message-ID: <2940317.dDZy1L4CDY@phil>
References: <20180807085406.3863-1-marc.zyngier@arm.com>
	<20180807085406.3863-2-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180807085406.3863-2-marc.zyngier-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Cc: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Marc,

Am Dienstag, 7. August 2018, 10:54:05 CEST schrieb Marc Zyngier:
> pm_runtime_get_if_in_use can fail: either PM has been disabled
> altogether (-EINVAL), or the device hasn't been enabled yet (0).
> Sadly, the Rockchip IOMMU driver tends to conflate the two things
> by considering a non-zero return value as successful.
> 
> This has the consequence of hiding other bugs, so let's handle this
> case throughout the driver, with a WARN_ON_ONCE so that we can try
> and work out what happened.
> 
> Fixes: 0f181d3cf7d98 ("iommu/rockchip: Add runtime PM support")
> Signed-off-by: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>

I'm still not sure about the !CONFIG_PM case, as it was probably silently
working in that case before.

But on the other hand we're also already running over it in other places
like in the iommu-shutdown and I guess if someone _really_ disabled
CONFIG_PM, a lot of additional stuff would fail anyway.


So should we wrap that in some #ifdef magic, just ignore it or simply
select PM similar to what Tegra, Renesas and Vexpress seem to do?

I guess I like the 3rd option best ;-)


Heiko



>  drivers/iommu/rockchip-iommu.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 054cd2c8e9c8..4e0f9b61cd7f 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -521,10 +521,11 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
>  	u32 int_status;
>  	dma_addr_t iova;
>  	irqreturn_t ret = IRQ_NONE;
> -	int i;
> +	int i, err;
>  
> -	if (WARN_ON(!pm_runtime_get_if_in_use(iommu->dev)))
> -		return 0;
> +	err = pm_runtime_get_if_in_use(iommu->dev);
> +	if (WARN_ON_ONCE(err <= 0))
> +		return ret;
>  
>  	if (WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks)))
>  		goto out;
> @@ -620,11 +621,15 @@ static void rk_iommu_zap_iova(struct rk_iommu_domain *rk_domain,
>  	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
>  	list_for_each(pos, &rk_domain->iommus) {
>  		struct rk_iommu *iommu;
> +		int ret;
>  
>  		iommu = list_entry(pos, struct rk_iommu, node);
>  
>  		/* Only zap TLBs of IOMMUs that are powered on. */
> -		if (pm_runtime_get_if_in_use(iommu->dev)) {
> +		ret = pm_runtime_get_if_in_use(iommu->dev);
> +		if (WARN_ON_ONCE(ret < 0))
> +			continue;
> +		if (ret) {
>  			WARN_ON(clk_bulk_enable(iommu->num_clocks,
>  						iommu->clocks));
>  			rk_iommu_zap_lines(iommu, iova, size);
> @@ -891,6 +896,7 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
>  	struct rk_iommu *iommu;
>  	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
>  	unsigned long flags;
> +	int ret;
>  
>  	/* Allow 'virtual devices' (eg drm) to detach from domain */
>  	iommu = rk_iommu_from_dev(dev);
> @@ -909,7 +915,9 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
>  	list_del_init(&iommu->node);
>  	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
>  
> -	if (pm_runtime_get_if_in_use(iommu->dev)) {
> +	ret = pm_runtime_get_if_in_use(iommu->dev);
> +	WARN_ON_ONCE(ret < 0);
> +	if (ret > 0) {
>  		rk_iommu_disable(iommu);
>  		pm_runtime_put(iommu->dev);
>  	}
> @@ -946,7 +954,8 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>  	list_add_tail(&iommu->node, &rk_domain->iommus);
>  	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
>  
> -	if (!pm_runtime_get_if_in_use(iommu->dev))
> +	ret = pm_runtime_get_if_in_use(iommu->dev);
> +	if (!ret || WARN_ON_ONCE(ret < 0))
>  		return 0;
>  
  	ret = rk_iommu_enable(iommu);
> 
