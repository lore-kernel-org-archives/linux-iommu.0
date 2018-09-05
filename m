From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC PATCH v2 02/10] iommu/vt-d: Add multiple domains per
 device query
Date: Wed, 5 Sep 2018 13:35:40 -0600
Message-ID: <20180905133540.5d7a7ea3@t450s.home>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
        <20180830040922.30426-3-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830040922.30426-3-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Kirti Wankhede <kwankhede@nvidia.com>, ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, tiwei.bie@intel.com, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, 30 Aug 2018 12:09:14 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Add the response to IOMMU_CAP_AUX_DOMAIN capability query
> through iommu_capable(). Return true if IOMMUs support the
> scalable mode, return false otherwise.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 3e49d4029058..891ae70e7bf2 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5193,12 +5193,39 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
>  	return phys;
>  }
>  
> +static inline bool scalable_mode_support(void)
> +{
> +	struct dmar_drhd_unit *drhd;
> +	struct intel_iommu *iommu;
> +	bool ret = true;
> +
> +	rcu_read_lock();
> +	for_each_active_iommu(iommu, drhd) {
> +		if (!sm_supported(iommu)) {
> +			ret = false;
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +
>  static bool intel_iommu_capable(enum iommu_cap cap)
>  {
> -	if (cap == IOMMU_CAP_CACHE_COHERENCY)
> +	switch (cap) {
> +	case IOMMU_CAP_CACHE_COHERENCY:
>  		return domain_update_iommu_snooping(NULL) == 1;
> -	if (cap == IOMMU_CAP_INTR_REMAP)
> +	case IOMMU_CAP_INTR_REMAP:
>  		return irq_remapping_enabled == 1;
> +	case IOMMU_CAP_AUX_DOMAIN:
> +		return scalable_mode_support();
> +	case IOMMU_CAP_NOEXEC:
> +	/* PASSTHROUGH */
> +	default:
> +		pr_info("Unsupported capability query %d\n", cap);
> +		break;

Please don't do this, there's no reason to be noisy about a query of a
capability that VT-d doesn't know about.  We implement capabilities
exactly so that relevant drivers can expose a feature and others can
happily (and quietly) ignore them.  Thanks,

Alex
