From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 01/16] iommu: introduce bind_pasid_table API function
Date: Tue, 10 Oct 2017 17:45:53 +0100
Message-ID: <59945b24-ace9-f0c1-d68d-ccd929e1fe28@arm.com>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1507244624-39189-2-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1507244624-39189-2-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 06/10/17 00:03, Jacob Pan wrote:
> Virtual IOMMU was proposed to support Shared Virtual Memory (SVM)
> use in the guest:
> https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg05311.html
> 
> As part of the proposed architecture, when an SVM capable PCI
> device is assigned to a guest, nested mode is turned on. Guest owns the
> first level page tables (request with PASID) which performs GVA->GPA
> translation. Second level page tables are owned by the host for GPA->HPA
> translation for both request with and without PASID.
> 
> A new IOMMU driver interface is therefore needed to perform tasks as
> follows:
> * Enable nested translation and appropriate translation type
> * Assign guest PASID table pointer (in GPA) and size to host IOMMU
> 
> This patch introduces new API functions to perform bind/unbind guest PASID
> tables. Based on common data, model specific IOMMU drivers can be extended
> to perform the specific steps for binding pasid table of assigned devices.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Liu, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/iommu.c      | 19 ++++++++++++++++
>  include/linux/iommu.h      | 25 +++++++++++++++++++++
>  include/uapi/linux/iommu.h | 55 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 99 insertions(+)
>  create mode 100644 include/uapi/linux/iommu.h
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3de5c0b..761cf50 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1322,6 +1322,25 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(iommu_attach_device);
>  
> +int iommu_bind_pasid_table(struct iommu_domain *domain, struct device *dev,
> +			struct pasid_table_config *pasidt_binfo)
> +{
> +	if (unlikely(!domain->ops->bind_pasid_table))
> +		return -ENODEV;
> +
> +	return domain->ops->bind_pasid_table(domain, dev, pasidt_binfo);
> +}
> +EXPORT_SYMBOL_GPL(iommu_bind_pasid_table);
> +
> +int iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
> +{
> +	if (unlikely(!domain->ops->unbind_pasid_table))
> +		return -EINVAL;
> +
> +	return domain->ops->unbind_pasid_table(domain, dev);
> +}
> +EXPORT_SYMBOL_GPL(iommu_unbind_pasid_table);
> +
>  static void __iommu_detach_device(struct iommu_domain *domain,
>  				  struct device *dev)
>  {
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 41b8c57..672cc06 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -25,6 +25,7 @@
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/of.h>
> +#include <uapi/linux/iommu.h>
>  
>  #define IOMMU_READ	(1 << 0)
>  #define IOMMU_WRITE	(1 << 1)
> @@ -187,6 +188,8 @@ struct iommu_resv_region {
>   * @domain_get_windows: Return the number of windows for a domain
>   * @of_xlate: add OF master IDs to iommu grouping
>   * @pgsize_bitmap: bitmap of all possible supported page sizes
> + * @bind_pasid_table: bind pasid table pointer for guest SVM
> + * @unbind_pasid_table: unbind pasid table pointer and restore defaults
>   */
>  struct iommu_ops {
>  	bool (*capable)(enum iommu_cap);
> @@ -233,8 +236,14 @@ struct iommu_ops {
>  	u32 (*domain_get_windows)(struct iommu_domain *domain);
>  
>  	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
> +

(whitespace change)

>  	bool (*is_attach_deferred)(struct iommu_domain *domain, struct device *dev);
>  
> +	int (*bind_pasid_table)(struct iommu_domain *domain, struct device *dev,
> +				struct pasid_table_config *pasidt_binfo);
> +	int (*unbind_pasid_table)(struct iommu_domain *domain,
> +				struct device *dev);
> +
>  	unsigned long pgsize_bitmap;
>  };
>  
> @@ -296,6 +305,10 @@ extern int iommu_attach_device(struct iommu_domain *domain,
>  			       struct device *dev);
>  extern void iommu_detach_device(struct iommu_domain *domain,
>  				struct device *dev);
> +extern int iommu_bind_pasid_table(struct iommu_domain *domain,
> +		struct device *dev, struct pasid_table_config *pasidt_binfo);
> +extern int iommu_unbind_pasid_table(struct iommu_domain *domain,
> +				struct device *dev);
>  extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
>  extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
>  		     phys_addr_t paddr, size_t size, int prot);
> @@ -696,6 +709,18 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
>  	return NULL;
>  }
>  
> +static inline
> +int iommu_bind_pasid_table(struct iommu_domain *domain, struct device *dev,
> +			struct pasid_table_config *pasidt_binfo)
> +{
> +	return -EINVAL;
> +}
> +static inline
> +int iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
> +{
> +	return -EINVAL;
> +}
> +
>  #endif /* CONFIG_IOMMU_API */
>  
>  #endif /* __LINUX_IOMMU_H */
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> new file mode 100644
> index 0000000..aeeaf0e
> --- /dev/null
> +++ b/include/uapi/linux/iommu.h
> @@ -0,0 +1,55 @@
> +/*
> + * IOMMU user API definitions
> + *
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _UAPI_IOMMU_H
> +#define _UAPI_IOMMU_H
> +
> +#include <linux/types.h>
> +
> +enum pasid_table_model {
> +	PASID_TABLE_FORMAT_HOST,
> +	PASID_TABLE_FORMAT_ARM_1LVL,
> +	PASID_TABLE_FORMAT_ARM_2LVL,

Maybe remove the ARM values and struct for the moment, I'm still not sure
how to implement it. I think this should be a single ARM_SMMUV3 model
(2LVL might correspond to two different formats in SMMUv3, and a future
SMMU version could still have 1- or 2-level PASID table but incompatible
format).

> +	PASID_TABLE_FORMAT_AMD,
> +	PASID_TABLE_FORMAT_INTEL,
> +};
> +
> +/**
> + * PASID table data used to bind guest PASID table to the host IOMMU. This will
> + * enable guest managed first level page tables.
> + * @version: for future extensions and identification of the data format
> + * @bytes: size of this structure
> + * @base_ptr:	PASID table pointer
> + * @pasid_bits:	number of bits supported in the guest PASID table, must be less
> + *		or equal than the host table size.

"host table size" is a bit confusing in this context, especially if using
multi-level tables. Perhaps it's clear enough that @pasid_bits must be
smaller or equal than the PASID size supported by the IOMMU, and we can
remove that second part?

Thanks,
Jean

> + * @model:	PASID table format for different IOMMU models
> + */
> +struct pasid_table_config {
> +	__u32 version;
> +	__u32 bytes;
> +	__u64 base_ptr;
> +	__u8 pasid_bits;
> +	enum pasid_table_model model;
> +	union {
> +		struct {
> +			/* Intel specific fields */
> +		} intel;
> +
> +		struct {
> +			/* ARM specific fields */
> +			bool pasid0_dma_no_pasid;
> +		} arm;
> +
> +		struct {
> +			/* AMD specific fields */
> +		} amd;
> +	};
> +};
> +
> +#endif /* _UAPI_IOMMU_H */
> 
