From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/4] iommu/omap: Make use of 'struct iommu_device'
Date: Tue, 11 Apr 2017 17:35:30 -0500
Message-ID: <e3450b08-f73d-8da1-fc23-6fe90f2a8d27@ti.com>
References: <1491576092-23339-1-git-send-email-joro@8bytes.org>
	<1491576092-23339-4-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1491576092-23339-4-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

On 04/07/2017 09:41 AM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> Modify the driver to register individual iommus and
> establish links between devices and iommus in sysfs.
> 
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/iommu/omap-iommu.c | 25 +++++++++++++++++++++++++
>  drivers/iommu/omap-iommu.h |  2 ++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 08bd731..a1ed13c 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -36,6 +36,8 @@
>  #include "omap-iopgtable.h"
>  #include "omap-iommu.h"
>  
> +static const struct iommu_ops omap_iommu_ops;
> +
>  #define to_iommu(dev)							\
>  	((struct omap_iommu *)platform_get_drvdata(to_platform_device(dev)))
>  
> @@ -963,6 +965,16 @@ static int omap_iommu_probe(struct platform_device *pdev)
>  	pm_runtime_irq_safe(obj->dev);
>  	pm_runtime_enable(obj->dev);
>  
> +	err = iommu_device_sysfs_add(&obj->iommu, obj->dev, NULL, obj->name);
> +	if (err)
> +		return err;
> +
> +	iommu_device_set_ops(&obj->iommu, &omap_iommu_ops);
> +
> +	err = iommu_device_register(&obj->iommu);
> +	if (err)
> +		return err;
> +

Some of the error cleanup from patch 4 can be moved here. Also, if you
can move this to before the pm_runtime_ invocations above, the cleanup
path can stay as in patch 4.

>  	omap_iommu_debugfs_add(obj);
>  
>  	dev_info(&pdev->dev, "%s registered\n", obj->name);
> @@ -973,6 +985,9 @@ static int omap_iommu_remove(struct platform_device *pdev)
>  {
>  	struct omap_iommu *obj = platform_get_drvdata(pdev);
>  
> +	iommu_device_sysfs_remove(&obj->iommu);
> +	iommu_device_unregister(&obj->iommu);
> +
>  	omap_iommu_debugfs_remove(obj);
>  
>  	pm_runtime_disable(obj->dev);
> @@ -1087,6 +1102,12 @@ static size_t omap_iommu_unmap(struct iommu_domain *domain, unsigned long da,
>  		goto out;
>  	}
>  
> +	ret = iommu_device_link(&oiommu->iommu, dev);
> +	if (ret) {
> +		dev_err(dev, "can't link device to iommu\n");
> +		goto out;

Will need to undo the omap_iommu_attach on failure here.

> +	}
> +
>  	omap_domain->iommu_dev = arch_data->iommu_dev = oiommu;
>  	omap_domain->dev = dev;
>  	oiommu->domain = domain;
> @@ -1121,8 +1142,11 @@ static void omap_iommu_detach_dev(struct iommu_domain *domain,
>  				  struct device *dev)
>  {
>  	struct omap_iommu_domain *omap_domain = to_omap_domain(domain);
> +	struct omap_iommu_arch_data *arch_data = dev->archdata.iommu;
>  
>  	spin_lock(&omap_domain->lock);
> +	if (arch_data)
> +		iommu_device_unlink(&arch_data->iommu_dev->iommu, dev);
>  	_omap_iommu_detach_dev(omap_domain, dev);
>  	spin_unlock(&omap_domain->lock);
>  }
> @@ -1263,6 +1287,7 @@ static void omap_iommu_remove_device(struct device *dev)
>  
>  	kfree(arch_data->name);
>  	kfree(arch_data);
> +

stale blank line

regards
Suman

>  }
>  
>  static const struct iommu_ops omap_iommu_ops = {
> diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
> index 3cd414a..ba16a18 100644
> --- a/drivers/iommu/omap-iommu.h
> +++ b/drivers/iommu/omap-iommu.h
> @@ -67,6 +67,8 @@ struct omap_iommu {
>  
>  	int has_bus_err_back;
>  	u32 id;
> +
> +	struct iommu_device iommu;
>  };
>  
>  /**
> 
