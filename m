From: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v4 9/9] iommu/vt-d: Remove the obsolete per iommu pasid
 tables
Date: Wed, 11 Jul 2018 10:45:06 +0800
Message-ID: <20180711024506.GB2359@xz-mi>
References: <1531113778-28238-1-git-send-email-baolu.lu@linux.intel.com>
 <1531113778-28238-10-git-send-email-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531113778-28238-10-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com, sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, yi.y.sun@intel.com, jacob.jun.pan@intel.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 09, 2018 at 01:22:58PM +0800, Lu Baolu wrote:
> The obsolete per iommu pasid tables are no longer used. Hence,
> clean up them.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  drivers/iommu/intel-iommu.c |  6 +++---
>  drivers/iommu/intel-svm.c   | 17 ++---------------
>  include/linux/intel-iommu.h |  5 ++---
>  3 files changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index f8609b5..9a88081 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1755,7 +1755,7 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
>  	if (pasid_enabled(iommu)) {
>  		if (ecap_prs(iommu->ecap))
>  			intel_svm_finish_prq(iommu);
> -		intel_svm_free_pasid_tables(iommu);
> +		intel_svm_exit(iommu);
>  	}
>  #endif
>  }
> @@ -3336,7 +3336,7 @@ static int __init init_dmars(void)
>  			hw_pass_through = 0;
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  		if (pasid_enabled(iommu))
> -			intel_svm_alloc_pasid_tables(iommu);
> +			intel_svm_init(iommu);
>  #endif
>  	}
>  
> @@ -4330,7 +4330,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
>  
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  	if (pasid_enabled(iommu))
> -		intel_svm_alloc_pasid_tables(iommu);
> +		intel_svm_init(iommu);
>  #endif
>  
>  	if (dmaru->ignored) {
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index a253cde..eb30836 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -38,7 +38,7 @@ struct pasid_state_entry {
>  	u64 val;
>  };
>  
> -int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
> +int intel_svm_init(struct intel_iommu *iommu)
>  {
>  	struct page *pages;
>  	int order;
> @@ -63,15 +63,6 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
>  		iommu->pasid_max = 0x20000;
>  
>  	order = get_order(sizeof(struct pasid_entry) * iommu->pasid_max);
> -	pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
> -	if (!pages) {
> -		pr_warn("IOMMU: %s: Failed to allocate PASID table\n",
> -			iommu->name);
> -		return -ENOMEM;
> -	}
> -	iommu->pasid_table = page_address(pages);
> -	pr_info("%s: Allocated order %d PASID table.\n", iommu->name, order);
> -
>  	if (ecap_dis(iommu->ecap)) {
>  		/* Just making it explicit... */
>  		BUILD_BUG_ON(sizeof(struct pasid_entry) != sizeof(struct pasid_state_entry));

Then do we still need the so-called pasid state table?  I tried to
find out what it did before but I failed since I see that the bit 27
of the extended cap is marked as reserved now in the latest vt-d spec
(then ecap_dis could be meaningless too).

Asked since if we don't need both the per-iommu pasid table and the
pasid state table, then maybe we don't need intel_svm_init() at all?

> @@ -86,14 +77,10 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
>  	return 0;
>  }
>  
> -int intel_svm_free_pasid_tables(struct intel_iommu *iommu)
> +int intel_svm_exit(struct intel_iommu *iommu)

Same thing applies to this exit() function - after we removed the
per-iommu idr, per-iommu pasid table, and (possibly obsolete)
per-iommu pasid state table, do we need that at all?

Thanks,

>  {
>  	int order = get_order(sizeof(struct pasid_entry) * iommu->pasid_max);
>  
> -	if (iommu->pasid_table) {
> -		free_pages((unsigned long)iommu->pasid_table, order);
> -		iommu->pasid_table = NULL;
> -	}
>  	if (iommu->pasid_state_table) {
>  		free_pages((unsigned long)iommu->pasid_state_table, order);
>  		iommu->pasid_state_table = NULL;
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index e7901d4..3c43882 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -453,7 +453,6 @@ struct intel_iommu {
>  	 * devices away to userspace processes (e.g. for DPDK) and don't
>  	 * want to trust that userspace will use *only* the PASID it was
>  	 * told to. But while it's all driver-arbitrated, we're fine. */
> -	struct pasid_entry *pasid_table;
>  	struct pasid_state_entry *pasid_state_table;
>  	struct page_req_dsc *prq;
>  	unsigned char prq_name[16];    /* Name for PRQ interrupt */
> @@ -526,8 +525,8 @@ int for_each_device_domain(int (*fn)(struct device_domain_info *info,
>  				     void *data), void *data);
>  
>  #ifdef CONFIG_INTEL_IOMMU_SVM
> -extern int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu);
> -extern int intel_svm_free_pasid_tables(struct intel_iommu *iommu);
> +int intel_svm_init(struct intel_iommu *iommu);
> +int intel_svm_exit(struct intel_iommu *iommu);
>  extern int intel_svm_enable_prq(struct intel_iommu *iommu);
>  extern int intel_svm_finish_prq(struct intel_iommu *iommu);
>  
> -- 
> 2.7.4
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

-- 
Peter Xu
