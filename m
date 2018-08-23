From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v5 01/23] iommu: introduce bind_pasid_table API function
Date: Thu, 23 Aug 2018 18:34:58 +0200
Message-ID: <e9ddb745-9cfb-1d40-05e0-7bd75292a41f@redhat.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1526072055-86990-2-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526072055-86990-2-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Yi L <yi.l.liu@linux.intel.com>, Raj Ashok <ashok.raj@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Liu@mail.linuxfoundation.org, Jean Delvare <khali@linux-fr.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jacob,

On 05/11/2018 10:53 PM, Jacob Pan wrote:
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
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/iommu.c      | 19 +++++++++++++++++++
>  include/linux/iommu.h      | 24 ++++++++++++++++++++++++
>  include/uapi/linux/iommu.h | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 76 insertions(+)
>  create mode 100644 include/uapi/linux/iommu.h
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d2aa2320..3a69620 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1325,6 +1325,25 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
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
> +void iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
> +{
> +	if (unlikely(!domain->ops->unbind_pasid_table))
> +		return;
> +
> +	domain->ops->unbind_pasid_table(domain, dev);
> +}
> +EXPORT_SYMBOL_GPL(iommu_unbind_pasid_table);
> +
>  static void __iommu_detach_device(struct iommu_domain *domain,
>  				  struct device *dev)
>  {
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 19938ee..5199ca4 100644
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
>  	bool (*is_attach_deferred)(struct iommu_domain *domain, struct device *dev);
>  
> +	int (*bind_pasid_table)(struct iommu_domain *domain, struct device *dev,
> +				struct pasid_table_config *pasidt_binfo);
> +	void (*unbind_pasid_table)(struct iommu_domain *domain,
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
> +extern void iommu_unbind_pasid_table(struct iommu_domain *domain,
> +				struct device *dev);
>  extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
>  extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
>  		     phys_addr_t paddr, size_t size, int prot);
> @@ -696,6 +709,17 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
>  	return NULL;
>  }
>  
> +static inline
> +int iommu_bind_pasid_table(struct iommu_domain *domain, struct device *dev,
> +			struct pasid_table_config *pasidt_binfo)
> +{
> +	return -ENODEV;
> +}
> +static inline
> +void iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
> +{
> +}
> +
>  #endif /* CONFIG_IOMMU_API */
>  
>  #endif /* __LINUX_IOMMU_H */
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> new file mode 100644
> index 0000000..cb2d625
> --- /dev/null
> +++ b/include/uapi/linux/iommu.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
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
> +/**
> + * PASID table data used to bind guest PASID table to the host IOMMU. This will
> + * enable guest managed first level page tables.
> + * @version: for future extensions and identification of the data format
> + * @bytes: size of this structure
> + * @base_ptr:	PASID table pointer
> + * @pasid_bits:	number of bits supported in the guest PASID table, must be less
> + *		or equal than the host supported PASID size.
> + */
> +struct pasid_table_config {
> +	__u32 version;
> +#define PASID_TABLE_CFG_VERSION_1 1
> +	__u32 bytes;
> +	__u64 base_ptr;
> +	__u8 pasid_bits;

As reported in "[RFC 00/13] SMMUv3 Nested Stage Setup" thread, this API
could be used for ARM SMMUv3 nested stage enablement without many
changes. Assuming SMMUv3 nested stage is confirmed to be interesting for
vendors and maintainers, we could try to unify the APIs.

As far as I understand the VTD PASID table is equivalent to the ARM
SMMUv3 context descriptor table (CD). This corresponds to the stage 1
context table with one or more entries, each corresponding to one PASID.
maybe using the s1ctx_table_config terminology instead of
pasid_table_config would be more generic, the pasid table being Intel
naming.

on top of pasid_bits, I think an "asid_bits" field may be needed too.
The guest IOMMU might support a different number of asid bits from the
host one.

Although without having skimmed through the whole series yet, I wonder
how you handle the case where stage1 is bypassed or disabled? The guest
may define the S1 context entries but bypass or abort stage 1
translations globally. Looks something missing to me at first sight.

Thanks

Eric
> +};
> +
> +#endif /* _UAPI_IOMMU_H */
> 
