From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v6 08/25] iommu: exynos: refactor function parameters to
	simplify code
Date: Sun, 10 May 2015 22:27:12 +0900
Message-ID: <20150510222712.a955a6d326698ba5a09c6fe7@samsung.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
	<1430727380-10912-9-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1430727380-10912-9-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Seung-Woo Kim <sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, David Wodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 04 May 2015 10:16:03 +0200 Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:

> This patch simplifies the code by:
> - refactoring function parameters from struct device pointer to direct
>   pointer to struct sysmmu drvdata
> - moving list_head enteries from struct exynos_iommu_owner directly to
>   struct sysmmu_drvdata
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/iommu/exynos-iommu.c | 93 ++++++++++++++++++++++----------------------
>  1 file changed, 46 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index c307c400613c..0c23b69022cd 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -186,8 +186,6 @@ static char *sysmmu_fault_name[SYSMMU_FAULTS_NUM] = {
>  
>  /* attached to dev.archdata.iommu of the master device */
>  struct exynos_iommu_owner {
> -	struct list_head client; /* entry of exynos_iommu_domain.clients */
> -	struct device *dev;
>  	struct device *sysmmu;
>  };
>  
> @@ -209,6 +207,7 @@ struct sysmmu_drvdata {
>  	int activations;
>  	spinlock_t lock;
>  	struct iommu_domain *domain;
> +	struct list_head domain_node;
>  	phys_addr_t pgtable;
>  	int version;
>  };
> @@ -514,12 +513,10 @@ static void __sysmmu_tlb_invalidate_flpdcache(struct sysmmu_drvdata *data,
>  		__raw_writel(iova | 0x1, data->sfrbase + REG_MMU_FLUSH_ENTRY);
>  }
>  
> -static void sysmmu_tlb_invalidate_flpdcache(struct device *dev,
> +static void sysmmu_tlb_invalidate_flpdcache(struct sysmmu_drvdata *data,
>  					    sysmmu_iova_t iova)
>  {
>  	unsigned long flags;
> -	struct exynos_iommu_owner *owner = dev->archdata.iommu;
> -	struct sysmmu_drvdata *data = dev_get_drvdata(owner->sysmmu);
>  
>  	if (!IS_ERR(data->clk_master))
>  		clk_enable(data->clk_master);
> @@ -533,14 +530,10 @@ static void sysmmu_tlb_invalidate_flpdcache(struct device *dev,
>  		clk_disable(data->clk_master);
>  }
>  
> -static void sysmmu_tlb_invalidate_entry(struct device *dev, sysmmu_iova_t iova,
> -					size_t size)
> +static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
> +					sysmmu_iova_t iova, size_t size)
>  {
> -	struct exynos_iommu_owner *owner = dev->archdata.iommu;
>  	unsigned long flags;
> -	struct sysmmu_drvdata *data;
> -
> -	data = dev_get_drvdata(owner->sysmmu);
>  
>  	spin_lock_irqsave(&data->lock, flags);
>  	if (is_sysmmu_active(data)) {
> @@ -570,8 +563,8 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, sysmmu_iova_t iova,
>  		if (!IS_ERR(data->clk_master))
>  			clk_disable(data->clk_master);
>  	} else {
> -		dev_dbg(dev, "disabled. Skipping TLB invalidation @ %#x\n",
> -			iova);
> +		dev_dbg(data->master,
> +			"disabled. Skipping TLB invalidation @ %#x\n", iova);
>  	}
>  	spin_unlock_irqrestore(&data->lock, flags);
>  }
> @@ -711,7 +704,7 @@ err_pgtable:
>  static void exynos_iommu_domain_free(struct iommu_domain *domain)
>  {
>  	struct exynos_iommu_domain *priv = to_exynos_domain(domain);
> -	struct exynos_iommu_owner *owner;
> +	struct sysmmu_drvdata *data;
>  	unsigned long flags;
>  	int i;
>  
> @@ -719,14 +712,12 @@ static void exynos_iommu_domain_free(struct iommu_domain *domain)
>  
>  	spin_lock_irqsave(&priv->lock, flags);
>  
> -	list_for_each_entry(owner, &priv->clients, client) {
> -		while (!exynos_sysmmu_disable(owner->dev))
> -			; /* until System MMU is actually disabled */
> +	list_for_each_entry(data, &priv->clients, domain_node) {

Use list_for_each_entry_safe() or you will get panic.

> +		if (__sysmmu_disable(data))
> +			data->master = NULL;
> +		list_del_init(&data->domain_node);
>  	}
>  
> -	while (!list_empty(&priv->clients))
> -		list_del_init(priv->clients.next);
> -
>  	spin_unlock_irqrestore(&priv->lock, flags);
>  
>  	for (i = 0; i < NUM_LV1ENTRIES; i++)
> @@ -744,20 +735,26 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
>  {
>  	struct exynos_iommu_owner *owner = dev->archdata.iommu;
>  	struct exynos_iommu_domain *priv = to_exynos_domain(domain);
> +	struct sysmmu_drvdata *data;
>  	phys_addr_t pagetable = virt_to_phys(priv->pgtable);
>  	unsigned long flags;
> -	int ret;
> +	int ret = -ENODEV;
>  
> -	spin_lock_irqsave(&priv->lock, flags);
> +	if (!has_sysmmu(dev))
> +		return -ENODEV;
>  
> -	ret = __exynos_sysmmu_enable(dev, pagetable, domain);
> -	if (ret == 0) {
> -		list_add_tail(&owner->client, &priv->clients);
> -		owner->domain = domain;
> +	data = dev_get_drvdata(owner->sysmmu);
> +	if (data) {

Is there a case that a probed System MMU without driver data?

> +		ret = __sysmmu_enable(data, pagetable, domain);
> +		if (ret >= 0) {
> +			data->master = dev;
> +
> +			spin_lock_irqsave(&priv->lock, flags);
> +			list_add_tail(&data->domain_node, &priv->clients);
> +			spin_unlock_irqrestore(&priv->lock, flags);
> +		}
>  	}
>  
> -	spin_unlock_irqrestore(&priv->lock, flags);
> -
>  	if (ret < 0) {
>  		dev_err(dev, "%s: Failed to attach IOMMU with pgtable %pa\n",
>  					__func__, &pagetable);
> @@ -773,26 +770,29 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
>  static void exynos_iommu_detach_device(struct iommu_domain *domain,
>  				    struct device *dev)
>  {
> -	struct exynos_iommu_owner *owner;
>  	struct exynos_iommu_domain *priv = to_exynos_domain(domain);
>  	phys_addr_t pagetable = virt_to_phys(priv->pgtable);
> +	struct sysmmu_drvdata *data;
>  	unsigned long flags;
> +	bool found = false;
>  
> -	spin_lock_irqsave(&priv->lock, flags);
> +	if (!has_sysmmu(dev))
> +		return;
>  
> -	list_for_each_entry(owner, &priv->clients, client) {
> -		if (owner == dev->archdata.iommu) {
> -			if (exynos_sysmmu_disable(dev)) {
> -				list_del_init(&owner->client);
> -				owner->domain = NULL;
> +	spin_lock_irqsave(&priv->lock, flags);
> +	list_for_each_entry(data, &priv->clients, domain_node) {
> +		if (data->master == dev) {
> +			if (__sysmmu_disable(data)) {
> +				data->master = NULL;
> +				list_del_init(&data->domain_node);
>  			}
> +			found = true;
>  			break;
>  		}
>  	}
> -
>  	spin_unlock_irqrestore(&priv->lock, flags);
>  
> -	if (owner == dev->archdata.iommu)
> +	if (found)
>  		dev_dbg(dev, "%s: Detached IOMMU with pgtable %pa\n",
>  					__func__, &pagetable);
>  	else
> @@ -839,12 +839,11 @@ static sysmmu_pte_t *alloc_lv2entry(struct exynos_iommu_domain *priv,
>  		 * not currently mapped.
>  		 */
>  		if (need_flush_flpd_cache) {
> -			struct exynos_iommu_owner *owner;
> +			struct sysmmu_drvdata *data;
>  
>  			spin_lock(&priv->lock);
> -			list_for_each_entry(owner, &priv->clients, client)
> -				sysmmu_tlb_invalidate_flpdcache(
> -							owner->dev, iova);
> +			list_for_each_entry(data, &priv->clients, domain_node)
> +				sysmmu_tlb_invalidate_flpdcache(data, iova);
>  			spin_unlock(&priv->lock);
>  		}
>  	}
> @@ -879,13 +878,13 @@ static int lv1set_section(struct exynos_iommu_domain *priv,
>  
>  	spin_lock(&priv->lock);
>  	if (lv1ent_page_zero(sent)) {
> -		struct exynos_iommu_owner *owner;
> +		struct sysmmu_drvdata *data;
>  		/*
>  		 * Flushing FLPD cache in System MMU v3.3 that may cache a FLPD
>  		 * entry by speculative prefetch of SLPD which has no mapping.
>  		 */
> -		list_for_each_entry(owner, &priv->clients, client)
> -			sysmmu_tlb_invalidate_flpdcache(owner->dev, iova);
> +		list_for_each_entry(data, &priv->clients, domain_node)
> +			sysmmu_tlb_invalidate_flpdcache(data, iova);
>  	}
>  	spin_unlock(&priv->lock);
>  
> @@ -990,13 +989,13 @@ static int exynos_iommu_map(struct iommu_domain *domain, unsigned long l_iova,
>  static void exynos_iommu_tlb_invalidate_entry(struct exynos_iommu_domain *priv,
>  						sysmmu_iova_t iova, size_t size)
>  {
> -	struct exynos_iommu_owner *owner;
> +	struct sysmmu_drvdata *data;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&priv->lock, flags);
>  
> -	list_for_each_entry(owner, &priv->clients, client)
> -		sysmmu_tlb_invalidate_entry(owner->dev, iova, size);
> +	list_for_each_entry(data, &priv->clients, domain_node)
> +		sysmmu_tlb_invalidate_entry(data, iova, size);
>  
>  	spin_unlock_irqrestore(&priv->lock, flags);
>  }
> -- 
> 1.9.2
> 


-- 
samsung.com <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
