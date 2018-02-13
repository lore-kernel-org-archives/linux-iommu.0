From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 04/37] iommu/sva: Add a mm_exit callback for device
 drivers
Date: Tue, 13 Feb 2018 08:11:03 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D1910028F9@SHSMSX101.ccr.corp.intel.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-5-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180212183352.22730-5-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "sudeep.holla-5wv7dgnIgG8@public.gmane.org" <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "robin.murphy-5wv7dgnIgG8@public.gmane.org" <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org" <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, "liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, xieyisheng1-hv44wF8Li91hl2p70BpVqQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

> From: Jean-Philippe Brucker
> Sent: Tuesday, February 13, 2018 2:33 AM
> 
> When an mm exits, devices that were bound to it must stop performing
> DMA
> on its PASID. Let device drivers register a callback to be notified on mm
> exit. Add the callback to the iommu_param structure attached to struct
> device.

what about registering the callback in sva_device_init? 

> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/iommu-sva.c | 54
> +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iommu.h     | 18 ++++++++++++++++
>  2 files changed, 72 insertions(+)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index f9af9d66b3ed..90b524c99d3d 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -569,3 +569,57 @@ void __iommu_sva_unbind_dev_all(struct device
> *dev)
>  	spin_unlock(&iommu_sva_lock);
>  }
>  EXPORT_SYMBOL_GPL(__iommu_sva_unbind_dev_all);
> +
> +/**
> + * iommu_register_mm_exit_handler() - Set a callback for mm exit
> + * @dev: the device
> + * @handler: exit handler
> + *
> + * Users of the bind/unbind API should call this function to set a
> + * device-specific callback telling them when a mm is exiting.
> + *
> + * After the callback returns, the device must not issue any more
> transaction
> + * with the PASID given as argument to the handler. In addition the
> handler gets
> + * an opaque pointer corresponding to the drvdata passed as argument of
> bind().
> + *
> + * The handler itself should return 0 on success, and an appropriate error
> code
> + * otherwise.
> + */
> +int iommu_register_mm_exit_handler(struct device *dev,
> +				   iommu_mm_exit_handler_t handler)
> +{
> +	struct iommu_param *dev_param = dev->iommu_param;
> +
> +	if (!dev_param)
> +		return -EINVAL;
> +
> +	/*
> +	 * FIXME: racy. Same as iommu_sva_device_init, but here we'll
> need a
> +	 * spinlock to call the mm_exit param from atomic context.
> +	 */
> +	if (dev_param->mm_exit)
> +		return -EBUSY;
> +
> +	get_device(dev);
> +	dev_param->mm_exit = handler;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iommu_register_mm_exit_handler);
> +
> +/**
> + * iommu_unregister_mm_exit_handler() - Remove mm exit callback
> + */
> +int iommu_unregister_mm_exit_handler(struct device *dev)
> +{
> +	struct iommu_param *dev_param = dev->iommu_param;
> +
> +	if (!dev_param || !dev_param->mm_exit)
> +		return -EINVAL;
> +
> +	dev_param->mm_exit = NULL;
> +	put_device(dev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iommu_unregister_mm_exit_handler);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 09d85f44142a..1b1a16892ac1 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -65,6 +65,8 @@ typedef int (*iommu_dev_fault_handler_t)(struct
> iommu_fault_event *, void *);
>  /* Request I/O page fault support */
>  #define IOMMU_SVA_FEAT_IOPF		(1 << 1)
> 
> +typedef int (*iommu_mm_exit_handler_t)(struct device *dev, int pasid,
> void *);
> +
>  struct iommu_domain_geometry {
>  	dma_addr_t aperture_start; /* First address that can be mapped
> */
>  	dma_addr_t aperture_end;   /* Last address that can be mapped
> */
> @@ -424,6 +426,7 @@ struct iommu_param {
>  	unsigned int min_pasid;
>  	unsigned int max_pasid;
>  	struct list_head mm_list;
> +	iommu_mm_exit_handler_t mm_exit;
>  };
> 
>  int  iommu_device_register(struct iommu_device *iommu);
> @@ -941,6 +944,10 @@ extern int iommu_sva_bind_device(struct device
> *dev, struct mm_struct *mm,
>  				int *pasid, unsigned long flags, void
> *drvdata);
>  extern int iommu_sva_unbind_device(struct device *dev, int pasid);
>  extern void __iommu_sva_unbind_dev_all(struct device *dev);
> +extern int iommu_register_mm_exit_handler(struct device *dev,
> +					  iommu_mm_exit_handler_t
> handler);
> +extern int iommu_unregister_mm_exit_handler(struct device *dev);
> +
>  #else /* CONFIG_IOMMU_SVA */
>  static inline int iommu_sva_device_init(struct device *dev,
>  					unsigned long features,
> @@ -969,6 +976,17 @@ static inline int iommu_sva_unbind_device(struct
> device *dev, int pasid)
>  static inline void __iommu_sva_unbind_dev_all(struct device *dev)
>  {
>  }
> +
> +static inline int iommu_register_mm_exit_handler(struct device *dev,
> +						 iommu_mm_exit_handler_t
> handler)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int iommu_unregister_mm_exit_handler(struct device *dev)
> +{
> +	return -ENODEV;
> +}
>  #endif /* CONFIG_IOMMU_SVA */
> 
>  #endif /* __LINUX_IOMMU_H */
> --
> 2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
