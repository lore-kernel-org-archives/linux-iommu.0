From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3 01/10] iommu: Introduce Shared Virtual Addressing API
Date: Sun, 23 Sep 2018 10:39:25 +0800
Message-ID: <f406bcf7-4e54-9f1b-88eb-03fc642ffede@linux.intel.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
	<20180920170046.20154-2-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180920170046.20154-2-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On 09/21/2018 01:00 AM, Jean-Philippe Brucker wrote:
> Shared Virtual Addressing (SVA) provides a way for device drivers to bind
> process address spaces to devices. This requires the IOMMU to support page
> table format and features compatible with the CPUs, and usually requires
> the system to support I/O Page Faults (IOPF) and Process Address Space ID
> (PASID). When all of these are available, DMA can access virtual addresses
> of a process. A PASID is allocated for each process, and the device driver
> programs it into the device in an implementation-specific way.
> 
> Add a new API for sharing process page tables with devices. Introduce two
> IOMMU operations, sva_init_device() and sva_shutdown_device(), that
> prepare the IOMMU driver for SVA. For example allocate PASID tables and
> fault queues. Subsequent patches will implement the bind() and unbind()
> operations.
> 
> Introduce a new mutex sva_lock on the device's IOMMU param to serialize
> init(), shutdown(), bind() and unbind() operations. Using the existing
> lock isn't possible because the unbind() and shutdown() operations will
> have to wait while holding sva_lock for concurrent fault queue flushes to
> terminate. These flushes will take the existing lock.
> 
> Support for I/O Page Faults will be added in a later patch using a new
> feature bit (IOMMU_SVA_FEAT_IOPF). With the current API users must pin
> down all shared mappings.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
> ---
> v2->v3:
> * Add sva_lock to serialize init/bind/unbind/shutdown
> * Rename functions for consistency with the rest of the API
> ---
>   drivers/iommu/Kconfig     |   4 ++
>   drivers/iommu/Makefile    |   1 +
>   drivers/iommu/iommu-sva.c | 107 ++++++++++++++++++++++++++++++++++++++
>   drivers/iommu/iommu.c     |   1 +
>   include/linux/iommu.h     |  34 ++++++++++++
>   5 files changed, 147 insertions(+)
>   create mode 100644 drivers/iommu/iommu-sva.c
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index c60395b7470f..884580401919 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -95,6 +95,10 @@ config IOMMU_DMA
>   	select IOMMU_IOVA
>   	select NEED_SG_DMA_LENGTH
>   
> +config IOMMU_SVA
> +	bool
> +	select IOMMU_API
> +
>   config FSL_PAMU
>   	bool "Freescale IOMMU support"
>   	depends on PCI
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index ab5eba6edf82..7d6332be5f0e 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>   obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
>   obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
>   obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
> +obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
>   obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
>   obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
>   obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> new file mode 100644
> index 000000000000..85ef98efede8
> --- /dev/null
> +++ b/drivers/iommu/iommu-sva.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Manage PASIDs and bind process address spaces to devices.
> + *
> + * Copyright (C) 2018 ARM Ltd.
> + */
> +
> +#include <linux/iommu.h>
> +#include <linux/slab.h>
> +
> +/**
> + * iommu_sva_init_device() - Initialize Shared Virtual Addressing for a device
> + * @dev: the device
> + * @features: bitmask of features that need to be initialized
> + * @min_pasid: min PASID value supported by the device
> + * @max_pasid: max PASID value supported by the device
> + *
> + * Users of the bind()/unbind() API must call this function to initialize all
> + * features required for SVA.
> + *
> + * The device must support multiple address spaces (e.g. PCI PASID). By default
> + * the PASID allocated during bind() is limited by the IOMMU capacity, and by
> + * the device PASID width defined in the PCI capability or in the firmware
> + * description. Setting @max_pasid to a non-zero value smaller than this limit
> + * overrides it. Similarly, @min_pasid overrides the lower PASID limit supported
> + * by the IOMMU.
> + *
> + * The device should not be performing any DMA while this function is running,
> + * otherwise the behavior is undefined.
> + *
> + * Return 0 if initialization succeeded, or an error.
> + */
> +int iommu_sva_init_device(struct device *dev, unsigned long features,
> +		       unsigned int min_pasid, unsigned int max_pasid)
> +{
> +	int ret;
> +	struct iommu_sva_param *param;
> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);

This doesn't work for vt-d. The domains for host iova are self-managed
by vt-d driver itself. Hence, iommu_get_domain_for_dev() will always
return NULL unless an UNMANAGED domain is attached to the device.

How about

       const struct iommu_ops *ops = dev->bus->iommu_ops;

instead?

> +
> +	if (!domain || !domain->ops->sva_init_device)
> +		return -ENODEV;
> +
> +	if (features)
> +		return -EINVAL;
> +
> +	param = kzalloc(sizeof(*param), GFP_KERNEL);
> +	if (!param)
> +		return -ENOMEM;
> +
> +	param->features		= features;
> +	param->min_pasid	= min_pasid;
> +	param->max_pasid	= max_pasid;
> +
> +	mutex_lock(&dev->iommu_param->sva_lock);
> +	if (dev->iommu_param->sva_param) {
> +		ret = -EEXIST;
> +		goto err_unlock;
> +	}
> +
> +	/*
> +	 * IOMMU driver updates the limits depending on the IOMMU and device
> +	 * capabilities.
> +	 */
> +	ret = domain->ops->sva_init_device(dev, param);
> +	if (ret)
> +		goto err_unlock;
> +
> +	dev->iommu_param->sva_param = param;
> +	mutex_unlock(&dev->iommu_param->sva_lock);
> +	return 0;
> +
> +err_unlock:
> +	mutex_unlock(&dev->iommu_param->sva_lock);
> +	kfree(param);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_init_device);
> +
> +/**
> + * iommu_sva_shutdown_device() - Shutdown Shared Virtual Addressing for a device
> + * @dev: the device
> + *
> + * Disable SVA. Device driver should ensure that the device isn't performing any
> + * DMA while this function is running.
> + */
> +void iommu_sva_shutdown_device(struct device *dev)
> +{
> +	struct iommu_sva_param *param;
> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);

Ditto.

Best regards,
Lu Baolu

> +
> +	if (!domain)
> +		return;
> +
> +	mutex_lock(&dev->iommu_param->sva_lock);
> +	param = dev->iommu_param->sva_param;
> +	if (!param)
> +		goto out_unlock;
> +
> +	if (domain->ops->sva_shutdown_device)
> +		domain->ops->sva_shutdown_device(dev);
> +
> +	kfree(param);
> +	dev->iommu_param->sva_param = NULL;
> +out_unlock:
> +	mutex_unlock(&dev->iommu_param->sva_lock);
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_shutdown_device);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 58f3477f2993..fa0561ed006f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -653,6 +653,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
>   		goto err_free_name;
>   	}
>   	mutex_init(&dev->iommu_param->lock);
> +	mutex_init(&dev->iommu_param->sva_lock);
>   
>   	kobject_get(group->devices_kobj);
>   
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 8177f7736fcd..4c27cb347770 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -197,6 +197,12 @@ struct page_response_msg {
>   	u64 private_data;
>   };
>   
> +struct iommu_sva_param {
> +	unsigned long features;
> +	unsigned int min_pasid;
> +	unsigned int max_pasid;
> +};
> +
>   /**
>    * struct iommu_ops - iommu ops and capabilities
>    * @capable: check capability
> @@ -204,6 +210,8 @@ struct page_response_msg {
>    * @domain_free: free iommu domain
>    * @attach_dev: attach device to an iommu domain
>    * @detach_dev: detach device from an iommu domain
> + * @sva_init_device: initialize Shared Virtual Addressing for a device
> + * @sva_shutdown_device: shutdown Shared Virtual Addressing for a device
>    * @map: map a physically contiguous memory region to an iommu domain
>    * @unmap: unmap a physically contiguous memory region from an iommu domain
>    * @flush_tlb_all: Synchronously flush all hardware TLBs for this domain
> @@ -239,6 +247,8 @@ struct iommu_ops {
>   
>   	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
>   	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
> +	int (*sva_init_device)(struct device *dev, struct iommu_sva_param *param);
> +	void (*sva_shutdown_device)(struct device *dev);
>   	int (*map)(struct iommu_domain *domain, unsigned long iova,
>   		   phys_addr_t paddr, size_t size, int prot);
>   	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
> @@ -393,6 +403,9 @@ struct iommu_fault_param {
>    * struct iommu_param - collection of per-device IOMMU data
>    *
>    * @fault_param: IOMMU detected device fault reporting data
> + * @lock: serializes accesses to fault_param
> + * @sva_param: SVA parameters
> + * @sva_lock: serializes accesses to sva_param
>    *
>    * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
>    *	struct iommu_group	*iommu_group;
> @@ -401,6 +414,8 @@ struct iommu_fault_param {
>   struct iommu_param {
>   	struct mutex lock;
>   	struct iommu_fault_param *fault_param;
> +	struct mutex sva_lock;
> +	struct iommu_sva_param *sva_param;
>   };
>   
>   int  iommu_device_register(struct iommu_device *iommu);
> @@ -904,4 +919,23 @@ void iommu_debugfs_setup(void);
>   static inline void iommu_debugfs_setup(void) {}
>   #endif
>   
> +#ifdef CONFIG_IOMMU_SVA
> +extern int iommu_sva_init_device(struct device *dev, unsigned long features,
> +				 unsigned int min_pasid,
> +				 unsigned int max_pasid);
> +extern void iommu_sva_shutdown_device(struct device *dev);
> +#else /* CONFIG_IOMMU_SVA */
> +static inline int iommu_sva_init_device(struct device *dev,
> +					unsigned long features,
> +					unsigned int min_pasid,
> +					unsigned int max_pasid)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline void iommu_sva_shutdown_device(struct device *dev)
> +{
> +}
> +#endif /* CONFIG_IOMMU_SVA */
> +
>   #endif /* __LINUX_IOMMU_H */
> 
