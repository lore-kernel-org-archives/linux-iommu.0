From: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 4/9] iommu/vt-d: Move device_domain_info to header
Date: Tue, 1 May 2018 09:21:56 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439BE7509@SHSMSX104.ccr.corp.intel.com>
References: <1523934202-21669-1-git-send-email-baolu.lu@linux.intel.com>
	<1523934202-21669-5-git-send-email-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1523934202-21669-5-git-send-email-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sun, Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan,
	Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Lu Baolu [mailto:baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
> Sent: Tuesday, April 17, 2018 11:03 AM
> 
> This allows the per device iommu data to be accessed from other
> files.
> 
> Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Looks good to me.
Reviewed-by: Liu, Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Regards,
Yi Liu
> ---
>  drivers/iommu/intel-iommu.c | 62 +++--------------------------------------
>  include/linux/intel-iommu.h | 68
> +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 98c5ae9..caa0b5c 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -381,60 +381,6 @@ static int hw_pass_through = 1;
>  	for (idx = 0; idx < g_num_of_iommus; idx++)		\
>  		if (domain->iommu_refcnt[idx])
> 
> -struct dmar_domain {
> -	int	nid;			/* node id */
> -
> -	unsigned	iommu_refcnt[DMAR_UNITS_SUPPORTED];
> -					/* Refcount of devices per iommu */
> -
> -
> -	u16		iommu_did[DMAR_UNITS_SUPPORTED];
> -					/* Domain ids per IOMMU. Use u16 since
> -					 * domain ids are 16 bit wide according
> -					 * to VT-d spec, section 9.3 */
> -
> -	bool has_iotlb_device;
> -	struct list_head devices;	/* all devices' list */
> -	struct iova_domain iovad;	/* iova's that belong to this domain */
> -
> -	struct dma_pte	*pgd;		/* virtual address */
> -	int		gaw;		/* max guest address width */
> -
> -	/* adjusted guest address width, 0 is level 2 30-bit */
> -	int		agaw;
> -
> -	int		flags;		/* flags to find out type of domain */
> -
> -	int		iommu_coherency;/* indicate coherency of iommu access
> */
> -	int		iommu_snooping; /* indicate snooping control feature*/
> -	int		iommu_count;	/* reference count of iommu */
> -	int		iommu_superpage;/* Level of superpages supported:
> -					   0 == 4KiB (no superpages), 1 == 2MiB,
> -					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
> -	u64		max_addr;	/* maximum mapped address */
> -
> -	struct iommu_domain domain;	/* generic domain data structure for
> -					   iommu core */
> -};
> -
> -/* PCI domain-device relationship */
> -struct device_domain_info {
> -	struct list_head link;	/* link to domain siblings */
> -	struct list_head global; /* link to global list */
> -	u8 bus;			/* PCI bus number */
> -	u8 devfn;		/* PCI devfn number */
> -	u8 pasid_supported:3;
> -	u8 pasid_enabled:1;
> -	u8 pri_supported:1;
> -	u8 pri_enabled:1;
> -	u8 ats_supported:1;
> -	u8 ats_enabled:1;
> -	u8 ats_qdep;
> -	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
> -	struct intel_iommu *iommu; /* IOMMU used by this device */
> -	struct dmar_domain *domain; /* pointer to domain */
> -};
> -
>  struct dmar_rmrr_unit {
>  	struct list_head list;		/* list of rmrr units	*/
>  	struct acpi_dmar_header *hdr;	/* ACPI header		*/
> @@ -631,7 +577,7 @@ static void set_iommu_domain(struct intel_iommu *iommu,
> u16 did,
>  		domains[did & 0xff] = domain;
>  }
> 
> -static inline void *alloc_pgtable_page(int node)
> +void *alloc_pgtable_page(int node)
>  {
>  	struct page *page;
>  	void *vaddr = NULL;
> @@ -642,7 +588,7 @@ static inline void *alloc_pgtable_page(int node)
>  	return vaddr;
>  }
> 
> -static inline void free_pgtable_page(void *vaddr)
> +void free_pgtable_page(void *vaddr)
>  {
>  	free_page((unsigned long)vaddr);
>  }
> @@ -725,7 +671,7 @@ int iommu_calculate_agaw(struct intel_iommu *iommu)
>  }
> 
>  /* This functionin only returns single iommu in a domain */
> -static struct intel_iommu *domain_get_iommu(struct dmar_domain *domain)
> +struct intel_iommu *domain_get_iommu(struct dmar_domain *domain)
>  {
>  	int iommu_id;
> 
> @@ -3500,7 +3446,7 @@ static unsigned long intel_alloc_iova(struct device *dev,
>  	return iova_pfn;
>  }
> 
> -static struct dmar_domain *get_valid_domain_for_dev(struct device *dev)
> +struct dmar_domain *get_valid_domain_for_dev(struct device *dev)
>  {
>  	struct dmar_domain *domain, *tmp;
>  	struct dmar_rmrr_unit *rmrr;
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 6b5ef6c..a4463f0 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -31,6 +31,7 @@
>  #include <linux/list.h>
>  #include <linux/iommu.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/dmar.h>
> 
>  #include <asm/cacheflush.h>
>  #include <asm/iommu.h>
> @@ -385,6 +386,50 @@ struct pasid_entry;
>  struct pasid_state_entry;
>  struct page_req_dsc;
> 
> +struct dmar_domain {
> +	int	nid;			/* node id */
> +
> +	unsigned int	iommu_refcnt[DMAR_UNITS_SUPPORTED];
> +					/* Refcount of devices per iommu */
> +
> +	u16		iommu_did[DMAR_UNITS_SUPPORTED];
> +					/*
> +					 * Domain ids per IOMMU. Use u16 since
> +					 * domain ids are 16 bit wide according
> +					 * to VT-d spec, section 9.3
> +					 */
> +
> +	bool has_iotlb_device;
> +	struct list_head devices;	/* all devices' list */
> +	struct iova_domain iovad;	/* iova's that belong to this domain */
> +
> +	struct dma_pte	*pgd;		/* virtual address */
> +	int		gaw;		/* max guest address width */
> +
> +	int		agaw;		/*
> +					 * adjusted guest address width,
> +					 * 0 is level 2 30-bit
> +					 */
> +
> +	int		flags;		/* flags to find out type of domain */
> +
> +	int		iommu_coherency;/* indicate coherency of iommu access
> */
> +	int		iommu_snooping; /* indicate snooping control feature*/
> +	int		iommu_count;	/* reference count of iommu */
> +	int		iommu_superpage;/*
> +					 * Level of superpages supported:
> +					 *  0 == 4KiB (no superpages),
> +					 *  1 == 2MiB, 2 == 1GiB,
> +					 *  3 == 512GiB, 4 == 1TiB
> +					 */
> +	u64		max_addr;	/* maximum mapped address */
> +
> +	struct iommu_domain domain;	/*
> +					 * generic domain data structure for
> +					 * iommu core
> +					 */
> +};
> +
>  struct intel_iommu {
>  	void __iomem	*reg; /* Pointer to hardware regs, virtual addr */
>  	u64 		reg_phys; /* physical address of hw register set */
> @@ -433,6 +478,24 @@ struct intel_iommu {
>  	u32		flags;      /* Software defined flags */
>  };
> 
> +/* PCI domain-device relationship */
> +struct device_domain_info {
> +	struct list_head link;	/* link to domain siblings */
> +	struct list_head global; /* link to global list */
> +	u8 bus;			/* PCI bus number */
> +	u8 devfn;		/* PCI devfn number */
> +	u8 pasid_supported:3;
> +	u8 pasid_enabled:1;
> +	u8 pri_supported:1;
> +	u8 pri_enabled:1;
> +	u8 ats_supported:1;
> +	u8 ats_enabled:1;
> +	u8 ats_qdep;
> +	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
> +	struct intel_iommu *iommu; /* IOMMU used by this device */
> +	struct dmar_domain *domain; /* pointer to domain */
> +};
> +
>  static inline void __iommu_flush_cache(
>  	struct intel_iommu *iommu, void *addr, int size)
>  {
> @@ -459,6 +522,11 @@ extern int qi_submit_sync(struct qi_desc *desc, struct
> intel_iommu *iommu);
> 
>  extern int dmar_ir_support(void);
> 
> +struct dmar_domain *get_valid_domain_for_dev(struct device *dev);
> +void *alloc_pgtable_page(int node);
> +void free_pgtable_page(void *vaddr);
> +struct intel_iommu *domain_get_iommu(struct dmar_domain *domain);
> +
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  extern int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu);
>  extern int intel_svm_free_pasid_tables(struct intel_iommu *iommu);
> --
> 2.7.4
