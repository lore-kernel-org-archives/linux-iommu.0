From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu/omap: Permanently keep iommu_dev pointer in
	arch_data
Date: Mon, 3 Apr 2017 15:35:46 -0500
Message-ID: <c3305742-b927-c789-c7c2-883f98a77ada@ti.com>
References: <1490962248-12602-1-git-send-email-joro@8bytes.org>
	<1490962248-12602-3-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1490962248-12602-3-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 03/31/2017 07:10 AM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> Instead of finding the matching IOMMU for a device using
> string comparision functions, keep the pointer to the
> iommu_dev in arch_data permanently populated.
> 
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/iommu/omap-iommu.c | 56 ++++++++++++++++++++--------------------------
>  drivers/iommu/omap-iommu.h |  2 +-
>  2 files changed, 25 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index e9c9b08..45df5c8 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -802,33 +802,14 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
>  	return IRQ_NONE;
>  }
>  
> -static int device_match_by_alias(struct device *dev, void *data)
> -{
> -	struct omap_iommu *obj = to_iommu(dev);
> -	const char *name = data;
> -
> -	pr_debug("%s: %s %s\n", __func__, obj->name, name);
> -
> -	return strcmp(obj->name, name) == 0;
> -}
> -
>  /**
>   * omap_iommu_attach() - attach iommu device to an iommu domain
> - * @name:	name of target omap iommu device
> + * @obj:	target omap iommu device
>   * @iopgd:	page table
>   **/
> -static struct omap_iommu *omap_iommu_attach(const char *name, u32 *iopgd)
> +static int omap_iommu_attach(struct omap_iommu *obj, u32 *iopgd)
>  {
>  	int err;
> -	struct device *dev;
> -	struct omap_iommu *obj;
> -
> -	dev = driver_find_device(&omap_iommu_driver.driver, NULL, (void *)name,
> -				 device_match_by_alias);
> -	if (!dev)
> -		return ERR_PTR(-ENODEV);
> -
> -	obj = to_iommu(dev);
>  
>  	spin_lock(&obj->iommu_lock);
>  
> @@ -841,11 +822,13 @@ static struct omap_iommu *omap_iommu_attach(const char *name, u32 *iopgd)
>  	spin_unlock(&obj->iommu_lock);
>  
>  	dev_dbg(obj->dev, "%s: %s\n", __func__, obj->name);
> -	return obj;
> +
> +	return 0;
>  
>  err_enable:
>  	spin_unlock(&obj->iommu_lock);
> -	return ERR_PTR(err);
> +
> +	return err;
>  }
>  
>  /**
> @@ -1061,11 +1044,11 @@ static size_t omap_iommu_unmap(struct iommu_domain *domain, unsigned long da,
>  omap_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  {
>  	struct omap_iommu_domain *omap_domain = to_omap_domain(domain);
> -	struct omap_iommu *oiommu;
>  	struct omap_iommu_arch_data *arch_data = dev->archdata.iommu;
> +	struct omap_iommu *oiommu;
>  	int ret = 0;
>  
> -	if (!arch_data || !arch_data->name) {
> +	if (!arch_data || !arch_data->iommu_dev) {
>  		dev_err(dev, "device doesn't have an associated iommu\n");
>  		return -EINVAL;
>  	}
> @@ -1079,15 +1062,17 @@ static size_t omap_iommu_unmap(struct iommu_domain *domain, unsigned long da,
>  		goto out;
>  	}
>  
> +	oiommu = arch_data->iommu_dev;
> +
>  	/* get a handle to and enable the omap iommu */
> -	oiommu = omap_iommu_attach(arch_data->name, omap_domain->pgtable);
> -	if (IS_ERR(oiommu)) {
> -		ret = PTR_ERR(oiommu);
> +	ret = omap_iommu_attach(oiommu, omap_domain->pgtable);
> +	if (ret) {
>  		dev_err(dev, "can't get omap iommu: %d\n", ret);
>  		goto out;
>  	}
>  
> -	omap_domain->iommu_dev = arch_data->iommu_dev = oiommu;
> +	arch_data->domain = omap_domain;
> +	omap_domain->iommu_dev = oiommu;
>  	omap_domain->dev = dev;
>  	oiommu->domain = domain;
>  
> @@ -1112,7 +1097,8 @@ static void _omap_iommu_detach_dev(struct omap_iommu_domain *omap_domain,
>  
>  	omap_iommu_detach(oiommu);
>  
> -	omap_domain->iommu_dev = arch_data->iommu_dev = NULL;
> +	omap_domain->iommu_dev = NULL;
> +	arch_data->domain = NULL;
>  	omap_domain->dev = NULL;
>  	oiommu->domain = NULL;
>  }
> @@ -1216,6 +1202,7 @@ static phys_addr_t omap_iommu_iova_to_phys(struct iommu_domain *domain,
>  static int omap_iommu_add_device(struct device *dev)
>  {
>  	struct omap_iommu_arch_data *arch_data;
> +	struct omap_iommu *iommu;
>  	struct device_node *np;
>  	struct platform_device *pdev;
>  
> @@ -1238,13 +1225,19 @@ static int omap_iommu_add_device(struct device *dev)
>  		return -EINVAL;
>  	}
>  
> +	iommu = platform_get_drvdata(pdev);
> +	if (!iommu) {
> +		of_node_put(np);
> +		return -EINVAL;
> +	}

This change is causing the issues. OMAP IOMMU driver is not probed yet,
but this gets called during the driver's init function in
bus_set_iommu() and bus's iommu_ops gets set to NULL. The add_device
today is used to add the linking to an IOMMU device (currently name
primarily to support the legacy non-DT mode which is no longer an issue,
but a dev pointer can be used instead here, and the real enabling is
done during the domain's attach_dev callback.

> +
>  	arch_data = kzalloc(sizeof(*arch_data), GFP_KERNEL);
>  	if (!arch_data) {
>  		of_node_put(np);
>  		return -ENOMEM;
>  	}
>  
> -	arch_data->name = kstrdup(dev_name(&pdev->dev), GFP_KERNEL);
> +	arch_data->iommu_dev = iommu;
>  	dev->archdata.iommu = arch_data;
>  
>  	of_node_put(np);
> @@ -1259,7 +1252,6 @@ static void omap_iommu_remove_device(struct device *dev)
>  	if (!dev->of_node || !arch_data)
>  		return;
>  
> -	kfree(arch_data->name);
>  	kfree(arch_data);
>  }
>  
> diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
> index 3cd414a..05bd279 100644
> --- a/drivers/iommu/omap-iommu.h
> +++ b/drivers/iommu/omap-iommu.h
> @@ -80,8 +80,8 @@ struct omap_iommu {
>   * utilize omap-specific plumbing anymore.
>   */
>  struct omap_iommu_arch_data {
> -	const char *name;

Missing the removal from the structure kerneldoc documentation.

>  	struct omap_iommu *iommu_dev;
> +	struct omap_iommu_domain *domain;

This doesn't seem to serve any purpose for now, is there a plan/purpose
for this? The iommu_domain is being stored within the omap_iommu
structure at the moment and it is stored during attach_dev() callback.

regards
Suman

>  };
>  
>  struct cr_regs {
> 
