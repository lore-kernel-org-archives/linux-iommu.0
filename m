Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098FA1AC89F
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723740897; cv=none; b=hkijNJoTYHT2WpS69Ror04+9zTjTpLW8E8hmRfEFWi4hvWlwfO3POIwk1YAbdIM0rV5bLRkKZHf9WljqHbh5+ON1oYsgIWPfl44JkVVKAo4qRI0Gw5nW486qbfJS6YTOpd9PgILcWAS12z0zmgWrdromAr7ZnNmfuCV3rBEeFCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723740897; c=relaxed/simple;
	bh=VYP5GJMRvLsaY++hEvl0wpXurviY6UQSm/usPrebgeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHWd6M8Z1NVQQVPiAplWw/HKwR2UlngDCFeve/eS33M0pO6p7Pheb8wFxLo8IEl0MMIeHC7tXmWsbuD2qG97O5+16M0EkLsrDXQDGsocAQWLkS6jQO7408S0h/zoMGF0pIqYNwO7aIE8jq4X0PnVZHemDKsfaOw/aQ1NYTQXG3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F11314BF;
	Thu, 15 Aug 2024 09:55:18 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED2743F58B;
	Thu, 15 Aug 2024 09:54:50 -0700 (PDT)
Message-ID: <20369981-37c8-482a-9ffa-cf54d12dad2d@arm.com>
Date: Thu, 15 Aug 2024 17:54:49 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] dma: add IOMMU static calls with clear default ops
To: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 Jason Gunthorpe <jgg@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <cover.1721818168.git.leon@kernel.org>
 <c3179690b16d790d5bfd7d0afabac9b90922ec28.1721818168.git.leon@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <c3179690b16d790d5bfd7d0afabac9b90922ec28.1721818168.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/07/2024 7:04 pm, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Most of the arch DMA ops (which often, but not always, involve
> some sort of IOMMU) are using the same DMA operations, but for all
> modern platforms dma-iommu implementation is really matters.
> 
> So let's make sure to call them directly without need to perform
> function pointers dereference.
> 
> During system initialization, the arch can set its own DMA and in such
> case, the default DMA operations will be overridden.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Leon Romanovsky <leon@kernel.org>
> ---
>   MAINTAINERS                 |   1 +
>   drivers/iommu/Kconfig       |   2 +-
>   drivers/iommu/dma-iommu.c   | 121 ++++++++++----------------
>   drivers/iommu/intel/Kconfig |   1 -
>   include/linux/device.h      |   5 ++
>   include/linux/dma-map-ops.h |  39 +++++----
>   include/linux/iommu-dma.h   | 169 ++++++++++++++++++++++++++++++++++++
>   kernel/dma/Kconfig          |   6 ++
>   kernel/dma/Makefile         |   2 +-
>   kernel/dma/mapping.c        |  90 ++++++++++++++++---
>   10 files changed, 327 insertions(+), 109 deletions(-)
>   create mode 100644 include/linux/iommu-dma.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index da5352dbd4f3..1e64be463da7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11544,6 +11544,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
>   F:	Documentation/devicetree/bindings/iommu/
>   F:	Documentation/userspace-api/iommu.rst
>   F:	drivers/iommu/
> +F:	include/linux/iommu-dma.h

This would belong to the "IOMMU DMA-API LAYER" section just above.

>   F:	include/linux/iommu.h
>   F:	include/linux/iova.h
>   F:	include/linux/of_iommu.h
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index c04584be3089..e24cb857b66c 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -151,7 +151,7 @@ config OF_IOMMU
>   # IOMMU-agnostic DMA-mapping layer
>   config IOMMU_DMA
>   	def_bool ARM64 || X86 || S390
> -	select DMA_OPS
> +	select DMA_OPS_HELPERS
>   	select IOMMU_API
>   	select IOMMU_IOVA
>   	select IRQ_MSI_IOMMU
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 43520e7275cc..ab2d3092ac23 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -17,6 +17,7 @@
>   #include <linux/gfp.h>
>   #include <linux/huge_mm.h>
>   #include <linux/iommu.h>
> +#include <linux/iommu-dma.h>
>   #include <linux/iova.h>
>   #include <linux/irq.h>
>   #include <linux/list_sort.h>
> @@ -1039,9 +1040,8 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
>   	return NULL;
>   }
>   
> -static struct sg_table *iommu_dma_alloc_noncontiguous(struct device *dev,
> -		size_t size, enum dma_data_direction dir, gfp_t gfp,
> -		unsigned long attrs)
> +struct sg_table *iommu_dma_alloc_noncontiguous(struct device *dev, size_t size,
> +	       enum dma_data_direction dir, gfp_t gfp, unsigned long attrs)
>   {
>   	struct dma_sgt_handle *sh;
>   
> @@ -1058,8 +1058,8 @@ static struct sg_table *iommu_dma_alloc_noncontiguous(struct device *dev,
>   	return &sh->sgt;
>   }
>   
> -static void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
> -		struct sg_table *sgt, enum dma_data_direction dir)
> +void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
> +		  struct sg_table *sgt, enum dma_data_direction dir)

Nit: Weird indentation (and in a few other places as well). The original 
style here was two tabs, and TBH I don't see any particularly compelling 
reason to churn that excepct in places where rewrapping will actually 
reduce the line count.

>   {
>   	struct dma_sgt_handle *sh = sgt_handle(sgt);
>   
> @@ -1069,8 +1069,8 @@ static void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
>   	kfree(sh);
>   }
>   
> -static void iommu_dma_sync_single_for_cpu(struct device *dev,
> -		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
> +void iommu_dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
> +				   size_t size, enum dma_data_direction dir)
>   {
>   	phys_addr_t phys;
>   
> @@ -1085,8 +1085,8 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
>   		swiotlb_sync_single_for_cpu(dev, phys, size, dir);
>   }
>   
> -static void iommu_dma_sync_single_for_device(struct device *dev,
> -		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
> +void iommu_dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
> +				      size_t size, enum dma_data_direction dir)
>   {
>   	phys_addr_t phys;
>   
> @@ -1101,9 +1101,8 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
>   		arch_sync_dma_for_device(phys, size, dir);
>   }
>   
> -static void iommu_dma_sync_sg_for_cpu(struct device *dev,
> -		struct scatterlist *sgl, int nelems,
> -		enum dma_data_direction dir)
> +void iommu_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
> +			       int nelems, enum dma_data_direction dir)
>   {
>   	struct scatterlist *sg;
>   	int i;
> @@ -1117,9 +1116,8 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
>   			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
>   }
>   
> -static void iommu_dma_sync_sg_for_device(struct device *dev,
> -		struct scatterlist *sgl, int nelems,
> -		enum dma_data_direction dir)
> +void iommu_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
> +				  int nelems, enum dma_data_direction dir)
>   {
>   	struct scatterlist *sg;
>   	int i;
> @@ -1134,9 +1132,9 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
>   			arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
>   }
>   
> -static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> -		unsigned long offset, size_t size, enum dma_data_direction dir,
> -		unsigned long attrs)
> +dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> +	      unsigned long offset, size_t size, enum dma_data_direction dir,
> +	      unsigned long attrs)
>   {
>   	phys_addr_t phys = page_to_phys(page) + offset;
>   	bool coherent = dev_is_dma_coherent(dev);
> @@ -1194,8 +1192,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>   	return iova;
>   }
>   
> -static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
> -		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
> +	  size_t size, enum dma_data_direction dir, unsigned long attrs)
>   {
>   	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>   	phys_addr_t phys;
> @@ -1348,8 +1346,8 @@ static int iommu_dma_map_sg_swiotlb(struct device *dev, struct scatterlist *sg,
>    * impedance-matching, to be able to hand off a suitably-aligned list,
>    * but still preserve the original offsets and sizes for the caller.
>    */
> -static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
> -		int nents, enum dma_data_direction dir, unsigned long attrs)
> +int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> +		     enum dma_data_direction dir, unsigned long attrs)
>   {
>   	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> @@ -1468,8 +1466,8 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   	return ret;
>   }
>   
> -static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
> -		int nents, enum dma_data_direction dir, unsigned long attrs)
> +void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
> +			enum dma_data_direction dir, unsigned long attrs)
>   {
>   	dma_addr_t end = 0, start;
>   	struct scatterlist *tmp;
> @@ -1518,16 +1516,17 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>   		__iommu_dma_unmap(dev, start, end - start);
>   }
>   
> -static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
> -		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
> +				  size_t size, enum dma_data_direction dir,
> +				  unsigned long attrs)
>   {
>   	return __iommu_dma_map(dev, phys, size,
>   			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
>   			dma_get_mask(dev));
>   }
>   
> -static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
> -		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
> +	      size_t size, enum dma_data_direction dir, unsigned long attrs)
>   {
>   	__iommu_dma_unmap(dev, handle, size);
>   }
> @@ -1563,8 +1562,8 @@ static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
>   		dma_free_contiguous(dev, page, alloc_size);
>   }
>   
> -static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
> -		dma_addr_t handle, unsigned long attrs)
> +void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
> +		    dma_addr_t handle, unsigned long attrs)
>   {
>   	__iommu_dma_unmap(dev, handle, size);
>   	__iommu_dma_free(dev, size, cpu_addr);
> @@ -1607,8 +1606,8 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
>   	return NULL;
>   }
>   
> -static void *iommu_dma_alloc(struct device *dev, size_t size,
> -		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
> +void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
> +		      gfp_t gfp, unsigned long attrs)
>   {
>   	bool coherent = dev_is_dma_coherent(dev);
>   	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
> @@ -1642,9 +1641,8 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
>   	return cpu_addr;
>   }
>   
> -static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
> -		void *cpu_addr, dma_addr_t dma_addr, size_t size,
> -		unsigned long attrs)
> +int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
> +	void *cpu_addr, dma_addr_t dma_addr, size_t size, unsigned long attrs)
>   {
>   	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
>   	unsigned long pfn, off = vma->vm_pgoff;
> @@ -1673,9 +1671,8 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   			       vma->vm_page_prot);
>   }
>   
> -static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
> -		void *cpu_addr, dma_addr_t dma_addr, size_t size,
> -		unsigned long attrs)
> +int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
> +	void *cpu_addr, dma_addr_t dma_addr, size_t size, unsigned long attrs)
>   {
>   	struct page *page;
>   	int ret;
> @@ -1700,19 +1697,19 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
>   	return ret;
>   }
>   
> -static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
> +unsigned long iommu_dma_get_merge_boundary(struct device *dev)
>   {
>   	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>   
>   	return (1UL << __ffs(domain->pgsize_bitmap)) - 1;
>   }
>   
> -static size_t iommu_dma_opt_mapping_size(void)
> +size_t iommu_dma_opt_mapping_size(void)
>   {
>   	return iova_rcache_range();
>   }
>   
> -static size_t iommu_dma_max_mapping_size(struct device *dev)
> +size_t iommu_dma_max_mapping_size(struct device *dev)
>   {
>   	if (dev_is_untrusted(dev))
>   		return swiotlb_max_mapping_size(dev);
> @@ -1720,32 +1717,6 @@ static size_t iommu_dma_max_mapping_size(struct device *dev)
>   	return SIZE_MAX;
>   }
>   
> -static const struct dma_map_ops iommu_dma_ops = {
> -	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED |
> -				  DMA_F_CAN_SKIP_SYNC,
> -	.alloc			= iommu_dma_alloc,
> -	.free			= iommu_dma_free,
> -	.alloc_pages_op		= dma_common_alloc_pages,
> -	.free_pages		= dma_common_free_pages,
> -	.alloc_noncontiguous	= iommu_dma_alloc_noncontiguous,
> -	.free_noncontiguous	= iommu_dma_free_noncontiguous,
> -	.mmap			= iommu_dma_mmap,
> -	.get_sgtable		= iommu_dma_get_sgtable,
> -	.map_page		= iommu_dma_map_page,
> -	.unmap_page		= iommu_dma_unmap_page,
> -	.map_sg			= iommu_dma_map_sg,
> -	.unmap_sg		= iommu_dma_unmap_sg,
> -	.sync_single_for_cpu	= iommu_dma_sync_single_for_cpu,
> -	.sync_single_for_device	= iommu_dma_sync_single_for_device,
> -	.sync_sg_for_cpu	= iommu_dma_sync_sg_for_cpu,
> -	.sync_sg_for_device	= iommu_dma_sync_sg_for_device,
> -	.map_resource		= iommu_dma_map_resource,
> -	.unmap_resource		= iommu_dma_unmap_resource,
> -	.get_merge_boundary	= iommu_dma_get_merge_boundary,
> -	.opt_mapping_size	= iommu_dma_opt_mapping_size,
> -	.max_mapping_size       = iommu_dma_max_mapping_size,
> -};
> -
>   void iommu_setup_dma_ops(struct device *dev)
>   {
>   	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> @@ -1753,19 +1724,15 @@ void iommu_setup_dma_ops(struct device *dev)
>   	if (dev_is_pci(dev))
>   		dev->iommu->pci_32bit_workaround = !iommu_dma_forcedac;
>   
> -	if (iommu_is_dma_domain(domain)) {
> -		if (iommu_dma_init_domain(domain, dev))
> -			goto out_err;
> -		dev->dma_ops = &iommu_dma_ops;
> -	} else if (dev->dma_ops == &iommu_dma_ops) {
> -		/* Clean up if we've switched *from* a DMA domain */
> -		dev->dma_ops = NULL;
> -	}
> +	dev->dma_iommu = iommu_is_dma_domain(domain);
> +	if (dev->dma_iommu && iommu_dma_init_domain(domain, dev))
> +		goto out_err;

FWIW I find this a little less clear than the original flow, but then 
I'm hoping to rip this all apart soon enough anyway, so I guess it 
doesn't really matter.

>   	return;
>   out_err:
> -	 pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
> -		 dev_name(dev));
> +	pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
> +		dev_name(dev));
> +	dev->dma_iommu = false;
>   }
>   
>   static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> index f52fb39c968e..88fd32a9323c 100644
> --- a/drivers/iommu/intel/Kconfig
> +++ b/drivers/iommu/intel/Kconfig
> @@ -12,7 +12,6 @@ config DMAR_DEBUG
>   config INTEL_IOMMU
>   	bool "Support for Intel IOMMU using DMA Remapping Devices"
>   	depends on PCI_MSI && ACPI && X86
> -	select DMA_OPS
>   	select IOMMU_API
>   	select IOMMU_IOVA
>   	select IOMMUFD_DRIVER if IOMMUFD
> diff --git a/include/linux/device.h b/include/linux/device.h
> index ace039151cb8..e66ec47ceb09 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -707,6 +707,8 @@ struct device_physical_location {
>    *		for dma allocations.  This flag is managed by the dma ops
>    *		instance from ->dma_supported.
>    * @dma_skip_sync: DMA sync operations can be skipped for coherent buffers.
> + * @dma_iommu: Device is using default IOMMU implementation for DMA and
> + *		doesn't rely on dma_ops structure.
>    *
>    * At the lowest level, every device in a Linux system is represented by an
>    * instance of struct device. The device structure contains the information
> @@ -822,6 +824,9 @@ struct device {
>   #ifdef CONFIG_DMA_NEED_SYNC
>   	bool			dma_skip_sync:1;
>   #endif
> +#ifdef CONFIG_IOMMU_DMA
> +	bool			dma_iommu : 1;

Nit: I guess dma_ops_bypass already set a precedent for inconsistent 
formatting here, but still...

> +#endif
>   };
>   
>   /**
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 02a1c825896b..103d9c66c445 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -13,20 +13,7 @@
>   struct cma;
>   struct iommu_ops;
>   
> -/*
> - * Values for struct dma_map_ops.flags:
> - *
> - * DMA_F_PCI_P2PDMA_SUPPORTED: Indicates the dma_map_ops implementation can
> - * handle PCI P2PDMA pages in the map_sg/unmap_sg operation.
> - * DMA_F_CAN_SKIP_SYNC: DMA sync operations can be skipped if the device is
> - * coherent and it's not an SWIOTLB buffer.
> - */
> -#define DMA_F_PCI_P2PDMA_SUPPORTED     (1 << 0)
> -#define DMA_F_CAN_SKIP_SYNC            (1 << 1)
> -
>   struct dma_map_ops {
> -	unsigned int flags;
> -
>   	void *(*alloc)(struct device *dev, size_t size,
>   			dma_addr_t *dma_handle, gfp_t gfp,
>   			unsigned long attrs);
> @@ -114,6 +101,28 @@ static inline void set_dma_ops(struct device *dev,
>   }
>   #endif /* CONFIG_DMA_OPS */
>   
> +#ifdef CONFIG_DMA_OPS_HELPERS
> +#include <asm/dma-mapping.h>

What needs a definition of get_arch_dma_ops() in this scope?

> +struct page *dma_common_alloc_pages(struct device *dev, size_t size,
> +		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp);
> +void dma_common_free_pages(struct device *dev, size_t size, struct page *vaddr,
> +		dma_addr_t dma_handle, enum dma_data_direction dir);

Why not bring the rest of the dma_common_* declarations in here as well? 
(Or more literally, add the #ifdef around where they all are already)

> +#else /* CONFIG_DMA_OPS_HELPERS */
> +static inline struct page *
> +dma_common_alloc_pages(struct device *dev, size_t size, dma_addr_t *dma_handle,
> +		       enum dma_data_direction dir, gfp_t gfp)
> +{
> +	return NULL;
> +}
> +static inline void dma_common_free_pages(struct device *dev, size_t size,
> +					 struct page *vaddr,
> +					 dma_addr_t dma_handle,
> +					 enum dma_data_direction dir)
> +{
> +}
> +#endif /* CONFIG_DMA_OPS_HELPERS */
> +
>   #ifdef CONFIG_DMA_CMA
>   extern struct cma *dma_contiguous_default_area;
>   
> @@ -239,10 +248,6 @@ int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
>   int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
>   		void *cpu_addr, dma_addr_t dma_addr, size_t size,
>   		unsigned long attrs);
> -struct page *dma_common_alloc_pages(struct device *dev, size_t size,
> -		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp);
> -void dma_common_free_pages(struct device *dev, size_t size, struct page *vaddr,
> -		dma_addr_t dma_handle, enum dma_data_direction dir);
>   
>   struct page **dma_common_find_pages(void *cpu_addr);
>   void *dma_common_contiguous_remap(struct page *page, size_t size, pgprot_t prot,
> diff --git a/include/linux/iommu-dma.h b/include/linux/iommu-dma.h
> new file mode 100644
> index 000000000000..622232fc9510
> --- /dev/null
> +++ b/include/linux/iommu-dma.h
> @@ -0,0 +1,169 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
> + *
> + * DMA operations that map physical memory through IOMMU.
> + */
> +#ifndef _LINUX_IOMMU_DMA_H
> +#define _LINUX_IOMMU_DMA_H
> +
> +#include <linux/dma-direction.h>
> +
> +#ifdef CONFIG_IOMMU_DMA
> +dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> +			      unsigned long offset, size_t size,
> +			      enum dma_data_direction dir, unsigned long attrs);
> +void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
> +			  size_t size, enum dma_data_direction dir,
> +			  unsigned long attrs);
> +int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> +		     enum dma_data_direction dir, unsigned long attrs);
> +void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
> +			enum dma_data_direction dir, unsigned long attrs);
> +void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
> +		      gfp_t gfp, unsigned long attrs);
> +int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
> +		   void *cpu_addr, dma_addr_t dma_addr,
> +		   size_t size, unsigned long attrs);
> +int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
> +			  void *cpu_addr, dma_addr_t dma_addr, size_t size,
> +			  unsigned long attrs);
> +unsigned long iommu_dma_get_merge_boundary(struct device *dev);
> +size_t iommu_dma_opt_mapping_size(void);
> +size_t iommu_dma_max_mapping_size(struct device *dev);
> +void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
> +		    dma_addr_t handle, unsigned long attrs);
> +dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
> +				  size_t size, enum dma_data_direction dir,
> +				  unsigned long attrs);
> +void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
> +			      size_t size, enum dma_data_direction dir,
> +			      unsigned long attrs);
> +struct sg_table *iommu_dma_alloc_noncontiguous(struct device *dev, size_t size,
> +					       enum dma_data_direction dir,
> +					       gfp_t gfp, unsigned long attrs);
> +void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
> +				  struct sg_table *sgt,
> +				  enum dma_data_direction dir);
> +void iommu_dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
> +				   size_t size, enum dma_data_direction dir);
> +void iommu_dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
> +				      size_t size, enum dma_data_direction dir);
> +void iommu_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
> +			       int nelems, enum dma_data_direction dir);
> +void iommu_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
> +				  int nelems, enum dma_data_direction dir);
> +#else
> +static inline dma_addr_t iommu_dma_map_page(struct device *dev,
> +					    struct page *page,
> +					    unsigned long offset, size_t size,
> +					    enum dma_data_direction dir,
> +					    unsigned long attrs)
> +{
> +	return DMA_MAPPING_ERROR;
> +}
> +static inline void iommu_dma_unmap_page(struct device *dev,
> +					dma_addr_t dma_handle, size_t size,
> +					enum dma_data_direction dir,
> +					unsigned long attrs)
> +{
> +}
> +static inline int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
> +				   int nents, enum dma_data_direction dir,
> +				   unsigned long attrs)
> +{
> +	return -EINVAL;
> +}
> +static inline void iommu_dma_unmap_sg(struct device *dev,
> +				      struct scatterlist *sg, int nents,
> +				      enum dma_data_direction dir,
> +				      unsigned long attrs)
> +{
> +}
> +static inline void *iommu_dma_alloc(struct device *dev, size_t size,
> +				    dma_addr_t *handle, gfp_t gfp,
> +				    unsigned long attrs)
> +{
> +	return NULL;
> +}
> +static inline int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
> +				 void *cpu_addr, dma_addr_t dma_addr,
> +				 size_t size, unsigned long attrs)
> +{
> +	return -EINVAL;
> +}
> +static inline int iommu_dma_get_sgtable(struct device *dev,
> +					struct sg_table *sgt, void *cpu_addr,
> +					dma_addr_t dma_addr, size_t size,
> +					unsigned long attrs)
> +{
> +	return -EINVAL;
> +}
> +static inline unsigned long iommu_dma_get_merge_boundary(struct device *dev)
> +{
> +	return 0;
> +}
> +static inline size_t iommu_dma_opt_mapping_size(void)
> +{
> +	return 0;
> +}
> +static inline size_t iommu_dma_max_mapping_size(struct device *dev)
> +{
> +	return 0;
> +}
> +static inline void iommu_dma_free(struct device *dev, size_t size,
> +				  void *cpu_addr, dma_addr_t handle,
> +				  unsigned long attrs)
> +{
> +}
> +static inline dma_addr_t iommu_dma_map_resource(struct device *dev,
> +						phys_addr_t phys, size_t size,
> +						enum dma_data_direction dir,
> +						unsigned long attrs)
> +{
> +	return DMA_MAPPING_ERROR;
> +}
> +static inline void iommu_dma_unmap_resource(struct device *dev,
> +					    dma_addr_t handle, size_t size,
> +					    enum dma_data_direction dir,
> +					    unsigned long attrs)
> +{
> +}
> +static inline struct sg_table *
> +iommu_dma_alloc_noncontiguous(struct device *dev, size_t size,
> +			      enum dma_data_direction dir, gfp_t gfp,
> +			      unsigned long attrs)
> +{
> +	return NULL;
> +}
> +static inline void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
> +						struct sg_table *sgt,
> +						enum dma_data_direction dir)
> +{
> +}
> +static inline void iommu_dma_sync_single_for_cpu(struct device *dev,
> +						 dma_addr_t dma_handle,
> +						 size_t size,
> +						 enum dma_data_direction dir)
> +{
> +}
> +static inline void iommu_dma_sync_single_for_device(struct device *dev,
> +						    dma_addr_t dma_handle,
> +						    size_t size,
> +						    enum dma_data_direction dir)
> +{
> +}
> +static inline void iommu_dma_sync_sg_for_cpu(struct device *dev,
> +					     struct scatterlist *sgl,
> +					     int nelems,
> +					     enum dma_data_direction dir)
> +{
> +}
> +static inline void iommu_dma_sync_sg_for_device(struct device *dev,
> +						struct scatterlist *sgl,
> +						int nelems,
> +						enum dma_data_direction dir)
> +{
> +}
> +#endif /* CONFIG_IOMMU_DMA */
> +#endif /* _LINUX_IOMMU_DMA_H */
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index c06e56be0ca1..03bb925014a7 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -8,8 +8,14 @@ config HAS_DMA
>   	depends on !NO_DMA
>   	default y
>   
> +# DMA IOMMU uses common ops helpers for certain operations, so let's allow to build
> +# ops_helpers.c even if DMA_OPS is not enabled

Hmm, but actually dma-direct also uses dma_common_contiguous_remap(), so 
something seems a little inconsistent here...

> +config DMA_OPS_HELPERS
> +	bool
> +
>   config DMA_OPS
>   	depends on HAS_DMA
> +	select DMA_OPS_HELPERS
>   	bool
>   
>   #
> diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
> index 21926e46ef4f..2e6e933cf7f3 100644
> --- a/kernel/dma/Makefile
> +++ b/kernel/dma/Makefile
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
>   obj-$(CONFIG_HAS_DMA)			+= mapping.o direct.o
> -obj-$(CONFIG_DMA_OPS)			+= ops_helpers.o
> +obj-$(CONFIG_DMA_OPS_HELPERS)		+= ops_helpers.o
>   obj-$(CONFIG_DMA_OPS)			+= dummy.o
>   obj-$(CONFIG_DMA_CMA)			+= contiguous.o
>   obj-$(CONFIG_DMA_DECLARE_COHERENT)	+= coherent.o
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 6832fd6f0796..02451e27e0b1 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -8,6 +8,7 @@
>   #include <linux/memblock.h> /* for max_pfn */
>   #include <linux/acpi.h>
>   #include <linux/dma-map-ops.h>
> +#include <linux/iommu-dma.h>

Nit: it would be nice to ignore the one existing outlier and maintain 
the otherwise alphabetical order.

>   #include <linux/export.h>
>   #include <linux/gfp.h>
>   #include <linux/kmsan.h>
> @@ -113,11 +114,27 @@ void *dmam_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   }
>   EXPORT_SYMBOL(dmam_alloc_attrs);
>   
> +#ifdef CONFIG_IOMMU_DMA
> +static bool use_dma_iommu(struct device *dev)
> +{
> +	return dev->dma_iommu;
> +}
> +#else
> +static bool use_dma_iommu(struct device *dev)
> +{
> +	return false;
> +}
> +#endif
> +
>   static bool dma_go_direct(struct device *dev, dma_addr_t mask,
>   		const struct dma_map_ops *ops)
>   {
> +	if (use_dma_iommu(dev))
> +		return false;
> +
>   	if (likely(!ops))
>   		return true;
> +
>   #ifdef CONFIG_DMA_OPS_BYPASS
>   	if (dev->dma_ops_bypass)
>   		return min_not_zero(mask, dev->bus_dma_limit) >=
> @@ -159,6 +176,8 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
>   	if (dma_map_direct(dev, ops) ||
>   	    arch_dma_map_page_direct(dev, page_to_phys(page) + offset + size))
>   		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
> +	else if (use_dma_iommu(dev))
> +		addr = iommu_dma_map_page(dev, page, offset, size, dir, attrs);
>   	else
>   		addr = ops->map_page(dev, page, offset, size, dir, attrs);
>   	kmsan_handle_dma(page, offset, size, dir);
> @@ -177,6 +196,8 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
>   	if (dma_map_direct(dev, ops) ||
>   	    arch_dma_unmap_page_direct(dev, addr + size))
>   		dma_direct_unmap_page(dev, addr, size, dir, attrs);
> +	else if (use_dma_iommu(dev))
> +		iommu_dma_unmap_page(dev, addr, size, dir, attrs);
>   	else
>   		ops->unmap_page(dev, addr, size, dir, attrs);
>   	debug_dma_unmap_page(dev, addr, size, dir);
> @@ -197,6 +218,8 @@ static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>   	if (dma_map_direct(dev, ops) ||
>   	    arch_dma_map_sg_direct(dev, sg, nents))
>   		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
> +	else if (use_dma_iommu(dev))
> +		ents = iommu_dma_map_sg(dev, sg, nents, dir, attrs);
>   	else
>   		ents = ops->map_sg(dev, sg, nents, dir, attrs);
>   
> @@ -291,7 +314,9 @@ void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>   	if (dma_map_direct(dev, ops) ||
>   	    arch_dma_unmap_sg_direct(dev, sg, nents))
>   		dma_direct_unmap_sg(dev, sg, nents, dir, attrs);
> -	else
> +	else if (use_dma_iommu(dev))
> +		iommu_dma_unmap_sg(dev, sg, nents, dir, attrs);
> +	else if (ops->unmap_sg)
>   		ops->unmap_sg(dev, sg, nents, dir, attrs);
>   }
>   EXPORT_SYMBOL(dma_unmap_sg_attrs);
> @@ -309,6 +334,8 @@ dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
>   
>   	if (dma_map_direct(dev, ops))
>   		addr = dma_direct_map_resource(dev, phys_addr, size, dir, attrs);
> +	else if (use_dma_iommu(dev))
> +		addr = iommu_dma_map_resource(dev, phys_addr, size, dir, attrs);
>   	else if (ops->map_resource)
>   		addr = ops->map_resource(dev, phys_addr, size, dir, attrs);
>   
> @@ -323,8 +350,12 @@ void dma_unmap_resource(struct device *dev, dma_addr_t addr, size_t size,
>   	const struct dma_map_ops *ops = get_dma_ops(dev);
>   
>   	BUG_ON(!valid_dma_direction(dir));
> -	if (!dma_map_direct(dev, ops) && ops->unmap_resource)
> -		ops->unmap_resource(dev, addr, size, dir, attrs);
> +	if (dma_map_direct(dev, ops))
> +		; /* nothing to do: uncached and no swiotlb */
> +	else if (use_dma_iommu(dev))
> +			iommu_dma_unmap_resource(dev, addr, size, dir, attrs);
> +	else if (ops->unmap_resource)
> +			ops->unmap_resource(dev, addr, size, dir, attrs);

Nit: extra tabs here and above.

>   	debug_dma_unmap_resource(dev, addr, size, dir);
>   }
>   EXPORT_SYMBOL(dma_unmap_resource);
> @@ -338,6 +369,8 @@ void __dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
>   	BUG_ON(!valid_dma_direction(dir));
>   	if (dma_map_direct(dev, ops))
>   		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
> +	else if (use_dma_iommu(dev))
> +		iommu_dma_sync_single_for_cpu(dev, addr, size, dir);
>   	else if (ops->sync_single_for_cpu)
>   		ops->sync_single_for_cpu(dev, addr, size, dir);
>   	debug_dma_sync_single_for_cpu(dev, addr, size, dir);
> @@ -352,6 +385,8 @@ void __dma_sync_single_for_device(struct device *dev, dma_addr_t addr,
>   	BUG_ON(!valid_dma_direction(dir));
>   	if (dma_map_direct(dev, ops))
>   		dma_direct_sync_single_for_device(dev, addr, size, dir);
> +	else if (use_dma_iommu(dev))
> +		iommu_dma_sync_single_for_device(dev, addr, size, dir);
>   	else if (ops->sync_single_for_device)
>   		ops->sync_single_for_device(dev, addr, size, dir);
>   	debug_dma_sync_single_for_device(dev, addr, size, dir);
> @@ -366,6 +401,8 @@ void __dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
>   	BUG_ON(!valid_dma_direction(dir));
>   	if (dma_map_direct(dev, ops))
>   		dma_direct_sync_sg_for_cpu(dev, sg, nelems, dir);
> +	else if (use_dma_iommu(dev))
> +		iommu_dma_sync_sg_for_cpu(dev, sg, nelems, dir);
>   	else if (ops->sync_sg_for_cpu)
>   		ops->sync_sg_for_cpu(dev, sg, nelems, dir);
>   	debug_dma_sync_sg_for_cpu(dev, sg, nelems, dir);
> @@ -380,6 +417,8 @@ void __dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
>   	BUG_ON(!valid_dma_direction(dir));
>   	if (dma_map_direct(dev, ops))
>   		dma_direct_sync_sg_for_device(dev, sg, nelems, dir);
> +	else if (use_dma_iommu(dev))
> +		iommu_dma_sync_sg_for_device(dev, sg, nelems, dir);
>   	else if (ops->sync_sg_for_device)
>   		ops->sync_sg_for_device(dev, sg, nelems, dir);
>   	debug_dma_sync_sg_for_device(dev, sg, nelems, dir);
> @@ -405,7 +444,7 @@ static void dma_setup_need_sync(struct device *dev)
>   {
>   	const struct dma_map_ops *ops = get_dma_ops(dev);
>   
> -	if (dma_map_direct(dev, ops) || (ops->flags & DMA_F_CAN_SKIP_SYNC))
> +	if (dma_map_direct(dev, ops) || use_dma_iommu(dev))
>   		/*
>   		 * dma_skip_sync will be reset to %false on first SWIOTLB buffer
>   		 * mapping, if any. During the device initialization, it's
> @@ -446,6 +485,9 @@ int dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt,
>   	if (dma_alloc_direct(dev, ops))
>   		return dma_direct_get_sgtable(dev, sgt, cpu_addr, dma_addr,
>   				size, attrs);
> +	if (use_dma_iommu(dev))
> +		return iommu_dma_get_sgtable(dev, sgt, cpu_addr, dma_addr,
> +				size, attrs);
>   	if (!ops->get_sgtable)
>   		return -ENXIO;
>   	return ops->get_sgtable(dev, sgt, cpu_addr, dma_addr, size, attrs);
> @@ -482,6 +524,8 @@ bool dma_can_mmap(struct device *dev)
>   
>   	if (dma_alloc_direct(dev, ops))
>   		return dma_direct_can_mmap(dev);
> +	if (use_dma_iommu(dev))
> +		return true;
>   	return ops->mmap != NULL;
>   }
>   EXPORT_SYMBOL_GPL(dma_can_mmap);
> @@ -508,6 +552,9 @@ int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
>   	if (dma_alloc_direct(dev, ops))
>   		return dma_direct_mmap(dev, vma, cpu_addr, dma_addr, size,
>   				attrs);
> +	if (use_dma_iommu(dev))
> +		return iommu_dma_mmap(dev, vma, cpu_addr, dma_addr, size,
> +				      attrs);
>   	if (!ops->mmap)
>   		return -ENXIO;
>   	return ops->mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
> @@ -559,6 +606,8 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   
>   	if (dma_alloc_direct(dev, ops))
>   		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs);
> +	else if (use_dma_iommu(dev))
> +		cpu_addr = iommu_dma_alloc(dev, size, dma_handle, flag, attrs);
>   	else if (ops->alloc)
>   		cpu_addr = ops->alloc(dev, size, dma_handle, flag, attrs);
>   	else
> @@ -591,6 +640,8 @@ void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
>   	debug_dma_free_coherent(dev, size, cpu_addr, dma_handle);
>   	if (dma_alloc_direct(dev, ops))
>   		dma_direct_free(dev, size, cpu_addr, dma_handle, attrs);
> +	else if (use_dma_iommu(dev))
> +		iommu_dma_free(dev, size, cpu_addr, dma_handle, attrs);
>   	else if (ops->free)
>   		ops->free(dev, size, cpu_addr, dma_handle, attrs);
>   }
> @@ -611,6 +662,8 @@ static struct page *__dma_alloc_pages(struct device *dev, size_t size,
>   	size = PAGE_ALIGN(size);
>   	if (dma_alloc_direct(dev, ops))
>   		return dma_direct_alloc_pages(dev, size, dma_handle, dir, gfp);
> +	if (use_dma_iommu(dev))
> +		return dma_common_alloc_pages(dev, size, dma_handle, dir, gfp);
>   	if (!ops->alloc_pages_op)
>   		return NULL;
>   	return ops->alloc_pages_op(dev, size, dma_handle, dir, gfp);
> @@ -635,6 +688,8 @@ static void __dma_free_pages(struct device *dev, size_t size, struct page *page,
>   	size = PAGE_ALIGN(size);
>   	if (dma_alloc_direct(dev, ops))
>   		dma_direct_free_pages(dev, size, page, dma_handle, dir);
> +	else if (use_dma_iommu(dev))
> +		dma_common_free_pages(dev, size, page, dma_handle, dir);
>   	else if (ops->free_pages)
>   		ops->free_pages(dev, size, page, dma_handle, dir);
>   }
> @@ -697,6 +752,8 @@ struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
>   
>   	if (ops && ops->alloc_noncontiguous)
>   		sgt = ops->alloc_noncontiguous(dev, size, dir, gfp, attrs);
> +	else if (use_dma_iommu(dev))
> +		sgt = iommu_dma_alloc_noncontiguous(dev, size, dir, gfp, attrs);
>   	else
>   		sgt = alloc_single_sgt(dev, size, dir, gfp);
>   
> @@ -725,6 +782,8 @@ void dma_free_noncontiguous(struct device *dev, size_t size,
>   	debug_dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir);
>   	if (ops && ops->free_noncontiguous)
>   		ops->free_noncontiguous(dev, size, sgt, dir);
> +	else if (use_dma_iommu(dev))
> +		iommu_dma_free_noncontiguous(dev, size, sgt, dir);
>   	else
>   		free_single_sgt(dev, size, sgt, dir);
>   }
> @@ -772,6 +831,8 @@ static int dma_supported(struct device *dev, u64 mask)
>   {
>   	const struct dma_map_ops *ops = get_dma_ops(dev);
>   
> +	if (WARN_ON(ops && use_dma_iommu(dev)))
> +		return false;
>   	/*
>   	 * ->dma_supported sets the bypass flag, so we must always call
>   	 * into the method here unless the device is truly direct mapped.
> @@ -787,17 +848,14 @@ bool dma_pci_p2pdma_supported(struct device *dev)
>   {
>   	const struct dma_map_ops *ops = get_dma_ops(dev);
>   
> -	/* if ops is not set, dma direct will be used which supports P2PDMA */
> -	if (!ops)
> -		return true;
> -
>   	/*
>   	 * Note: dma_ops_bypass is not checked here because P2PDMA should
>   	 * not be used with dma mapping ops that do not have support even
>   	 * if the specific device is bypassing them.
>   	 */
>   
> -	return ops->flags & DMA_F_PCI_P2PDMA_SUPPORTED;
> +	/* if ops is not set, dma direct and default IOMMU support P2PDMA */
> +	return !ops;
>   }
>   EXPORT_SYMBOL_GPL(dma_pci_p2pdma_supported);
>   
> @@ -865,6 +923,8 @@ size_t dma_max_mapping_size(struct device *dev)
>   
>   	if (dma_map_direct(dev, ops))
>   		size = dma_direct_max_mapping_size(dev);
> +	else if (use_dma_iommu(dev))
> +		size = iommu_dma_max_mapping_size(dev);
>   	else if (ops && ops->max_mapping_size)
>   		size = ops->max_mapping_size(dev);
>   
> @@ -877,9 +937,10 @@ size_t dma_opt_mapping_size(struct device *dev)
>   	const struct dma_map_ops *ops = get_dma_ops(dev);
>   	size_t size = SIZE_MAX;
>   
> -	if (ops && ops->opt_mapping_size)
> +	if (use_dma_iommu(dev))
> +		size = iommu_dma_opt_mapping_size();
> +	else if (ops && ops->opt_mapping_size)
>   		size = ops->opt_mapping_size();
> -
>   	return min(dma_max_mapping_size(dev), size);
>   }
>   EXPORT_SYMBOL_GPL(dma_opt_mapping_size);
> @@ -888,7 +949,12 @@ unsigned long dma_get_merge_boundary(struct device *dev)
>   {
>   	const struct dma_map_ops *ops = get_dma_ops(dev);
>   
> -	if (!ops || !ops->get_merge_boundary)
> +	if (use_dma_iommu(dev))
> +		return iommu_dma_get_merge_boundary(dev);
> +
> +	if (!ops)
> +		return 0;	/* can't merge */
> +	if (!ops->get_merge_boundary)
>   		return 0;	/* can't merge */

Nit: I'd keep the single || condition - those two cases are never going 
to be different.

Thanks,
Robin.
