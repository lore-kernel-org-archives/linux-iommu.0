From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/4] iommu/omap: Add iommu-group support
Date: Tue, 11 Apr 2017 18:14:52 -0500
Message-ID: <fd009f3a-6038-9ca1-9b3a-7f97d8823552@ti.com>
References: <1491576092-23339-1-git-send-email-joro@8bytes.org>
	<1491576092-23339-5-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1491576092-23339-5-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: "sakari.ailus-X3B1VOXEql0@public.gmane.org" <sakari.ailus-X3B1VOXEql0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

This patch is still causing couple of issues.

Adding Laurent and Sakari to the thread as we do have the OMAP3ISP
driver which would need some changes once the iommu groups are
implemented in the OMAP IOMMU driver. The OMAP3 ISP driver
(drivers/media/platform/omap3isp/isp.c) is currently using the
iommu_group API.

On 04/07/2017 09:41 AM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> Support for IOMMU groups will become mandatory for drivers,
> so add it to the omap iommu driver.
> 
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/iommu/omap-iommu.c | 43 +++++++++++++++++++++++++++++++++++++++++--
>  drivers/iommu/omap-iommu.h |  1 +
>  2 files changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index a1ed13c..a7dd46d 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -965,26 +965,42 @@ static int omap_iommu_probe(struct platform_device *pdev)
>  	pm_runtime_irq_safe(obj->dev);
>  	pm_runtime_enable(obj->dev);
>  
> +	obj->group = iommu_group_alloc();
> +	if (IS_ERR(obj->group))
> +		return PTR_ERR(obj->group);
> +

Similar comment as in patch 3, PM runtime status is not handled during
cleanup. Moving this block above the pm_runtime API should avoid
handling the cleanup scenarios.

>  	err = iommu_device_sysfs_add(&obj->iommu, obj->dev, NULL, obj->name);
>  	if (err)
> -		return err;
> +		goto out_group;
>  
>  	iommu_device_set_ops(&obj->iommu, &omap_iommu_ops);
>  
>  	err = iommu_device_register(&obj->iommu);
>  	if (err)
> -		return err;
> +		goto out_sysfs;

Some of this cleanup should be part of Patch 3.

>  
>  	omap_iommu_debugfs_add(obj);
>  
>  	dev_info(&pdev->dev, "%s registered\n", obj->name);
> +
>  	return 0;
> +
> +out_sysfs:
> +	iommu_device_sysfs_remove(&obj->iommu);
> +
> +out_group:
> +	iommu_group_put(obj->group);
> +
> +	return err;
>  }
>  
>  static int omap_iommu_remove(struct platform_device *pdev)
>  {
>  	struct omap_iommu *obj = platform_get_drvdata(pdev);
>  
> +	iommu_group_put(obj->group);
> +	obj->group = NULL;
> +
>  	iommu_device_sysfs_remove(&obj->iommu);
>  	iommu_device_unregister(&obj->iommu);
>  
> @@ -1078,6 +1094,7 @@ static size_t omap_iommu_unmap(struct iommu_domain *domain, unsigned long da,
>  	struct omap_iommu_domain *omap_domain = to_omap_domain(domain);
>  	struct omap_iommu *oiommu;
>  	struct omap_iommu_arch_data *arch_data = dev->archdata.iommu;
> +	struct iommu_group *group;
>  	int ret = 0;
>  
>  	if (!arch_data || !arch_data->name) {
> @@ -1108,6 +1125,15 @@ static size_t omap_iommu_unmap(struct iommu_domain *domain, unsigned long da,
>  		goto out;
>  	}
>  
> +	/*
> +	 * IOMMU group initialization calls into omap_device_group, which needs
> +	 * a valid dev->archdata.iommu pointer
> +	 */
> +	group = iommu_group_get_for_dev(dev);
> +	if (IS_ERR(group))
> +		return PTR_ERR(group);
> +	iommu_group_put(group);
> +

The arch_data->iommu_dev is not initialized yet here, so
omap_device_group returns NULL and iommu_group_get_for_dev crashes due
to a NULL pointer dereference.

>  	omap_domain->iommu_dev = arch_data->iommu_dev = oiommu;
>  	omap_domain->dev = dev;
>  	oiommu->domain = domain;

I tested it by moving it down here, in which case the attach_dev passes
and I can program the IOMMU for the client devices. But during removal,
I get a dependency deadlock between the iommu_group's lock and the OMAP
domain's lock due to the different paths taken during
iommu_attach_device() and iommu_detach_device().

regards
Suman

> @@ -1145,6 +1171,7 @@ static void omap_iommu_detach_dev(struct iommu_domain *domain,
>  	struct omap_iommu_arch_data *arch_data = dev->archdata.iommu;
>  
>  	spin_lock(&omap_domain->lock);
> +	iommu_group_remove_device(dev);
>  	if (arch_data)
>  		iommu_device_unlink(&arch_data->iommu_dev->iommu, dev);
>  	_omap_iommu_detach_dev(omap_domain, dev);
> @@ -1290,6 +1317,17 @@ static void omap_iommu_remove_device(struct device *dev)
>  
>  }
>  
> +static struct iommu_group *omap_device_group(struct device *dev)
> +{
> +	struct omap_iommu_arch_data *arch_data = dev->archdata.iommu;
> +	struct iommu_group *group = NULL;
> +
> +	if (arch_data->iommu_dev)
> +		group = arch_data->iommu_dev->group;
> +
> +	return group;
> +}
> +
>  static const struct iommu_ops omap_iommu_ops = {
>  	.domain_alloc	= omap_iommu_domain_alloc,
>  	.domain_free	= omap_iommu_domain_free,
> @@ -1301,6 +1339,7 @@ static void omap_iommu_remove_device(struct device *dev)
>  	.iova_to_phys	= omap_iommu_iova_to_phys,
>  	.add_device	= omap_iommu_add_device,
>  	.remove_device	= omap_iommu_remove_device,
> +	.device_group	= omap_device_group,
>  	.pgsize_bitmap	= OMAP_IOMMU_PGSIZES,
>  };
>  
> diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
> index ba16a18..8b4e845 100644
> --- a/drivers/iommu/omap-iommu.h
> +++ b/drivers/iommu/omap-iommu.h
> @@ -69,6 +69,7 @@ struct omap_iommu {
>  	u32 id;
>  
>  	struct iommu_device iommu;
> +	struct iommu_group *group;
>  };
>  
>  /**
> 
