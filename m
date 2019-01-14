From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 3/8] iommu/vt-d: Move common code out of
 iommu_attch_device()
Date: Mon, 14 Jan 2019 11:45:03 +0000
Message-ID: <20190114114503.00007eac@huawei.com>
References: <20190110030027.31447-1-baolu.lu@linux.intel.com>
        <20190110030027.31447-4-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110030027.31447-4-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, kevin.tian@intel.com, ashok.raj@intel.com, tiwei.bie@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Zeng@mail.linuxfoundation.org, yi.y.sun@intel.com, jacob.jun.pan@intel.com, kvm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 10 Jan 2019 11:00:22 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> This part of code could be used by both normal and aux
> domain specific attach entries. Hence move them into a
> common function to avoid duplication.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Another trivial one (it's going to be one of those days).
Typo in the patch title.

> ---
>  drivers/iommu/intel-iommu.c | 60 ++++++++++++++++++++++---------------
>  1 file changed, 36 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index ee8832d26f7e..e9119d45a29d 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5058,35 +5058,14 @@ static void intel_iommu_domain_free(struct iommu_domain *domain)
>  	domain_exit(to_dmar_domain(domain));
>  }
>  
> -static int intel_iommu_attach_device(struct iommu_domain *domain,
> -				     struct device *dev)
> +static int prepare_domain_attach_device(struct iommu_domain *domain,
> +					struct device *dev)
>  {
>  	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>  	struct intel_iommu *iommu;
>  	int addr_width;
>  	u8 bus, devfn;
>  
> -	if (device_is_rmrr_locked(dev)) {
> -		dev_warn(dev, "Device is ineligible for IOMMU domain attach due to platform RMRR requirement.  Contact your platform vendor.\n");
> -		return -EPERM;
> -	}
> -
> -	/* normally dev is not mapped */
> -	if (unlikely(domain_context_mapped(dev))) {
> -		struct dmar_domain *old_domain;
> -
> -		old_domain = find_domain(dev);
> -		if (old_domain) {
> -			rcu_read_lock();
> -			dmar_remove_one_dev_info(old_domain, dev);
> -			rcu_read_unlock();
> -
> -			if (!domain_type_is_vm_or_si(old_domain) &&
> -			     list_empty(&old_domain->devices))
> -				domain_exit(old_domain);
> -		}
> -	}
> -
>  	iommu = device_to_iommu(dev, &bus, &devfn);
>  	if (!iommu)
>  		return -ENODEV;
> @@ -5119,7 +5098,40 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
>  		dmar_domain->agaw--;
>  	}
>  
> -	return domain_add_dev_info(dmar_domain, dev);
> +	return 0;
> +}
> +
> +static int intel_iommu_attach_device(struct iommu_domain *domain,
> +				     struct device *dev)
> +{
> +	int ret;
> +
> +	if (device_is_rmrr_locked(dev)) {
> +		dev_warn(dev, "Device is ineligible for IOMMU domain attach due to platform RMRR requirement.  Contact your platform vendor.\n");
> +		return -EPERM;
> +	}
> +
> +	/* normally dev is not mapped */
> +	if (unlikely(domain_context_mapped(dev))) {
> +		struct dmar_domain *old_domain;
> +
> +		old_domain = find_domain(dev);
> +		if (old_domain) {
> +			rcu_read_lock();
> +			dmar_remove_one_dev_info(old_domain, dev);
> +			rcu_read_unlock();
> +
> +			if (!domain_type_is_vm_or_si(old_domain) &&
> +			    list_empty(&old_domain->devices))
> +				domain_exit(old_domain);
> +		}
> +	}
> +
> +	ret = prepare_domain_attach_device(domain, dev);
> +	if (ret)
> +		return ret;
> +
> +	return domain_add_dev_info(to_dmar_domain(domain), dev);
>  }
>  
>  static void intel_iommu_detach_device(struct iommu_domain *domain,
