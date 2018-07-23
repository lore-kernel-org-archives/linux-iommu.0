From: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [RFC PATCH 02/10] iommu/vt-d: Alloc domain for a mediated device
Date: Mon, 23 Jul 2018 04:44:16 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439CA1432@SHSMSX104.ccr.corp.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
 <1532239773-15325-3-git-send-email-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532239773-15325-3-git-send-email-baolu.lu@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "peterx@redhat.com" <peterx@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> Sent: Sunday, July 22, 2018 2:09 PM
> 
> The PASID-granular 2nd level address translation makes it possible to isolate and
> protect a mediated device exposed by a real device which support PCI PASID

"support" -> "supports"

> features. This patch adds support to allocate a domain for a mediated device. A
> default pasid value will be allocated as well for the mediated device. This will be used

This is not accurate, it is "a default pasid value will be allocated for the domain, and the
mdev will be configed to use this pasid when it is added to this domain"

Regards,
Yi Liu

> by the mediated device attached to this domain for non-SVM DMA transactions.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 17 ++++++++++++++++-  include/linux/intel-iommu.h
> |  5 +++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c index
> fc3ac1c..3ede34a 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1926,6 +1926,9 @@ static void domain_exit(struct dmar_domain *domain)
>  	domain_remove_dev_info(domain);
>  	rcu_read_unlock();
> 
> +	if (domain->default_pasid > 0)
> +		intel_pasid_free_id(domain->default_pasid);
> +
>  	/* destroy iovas */
>  	put_iova_domain(&domain->iovad);
> 
> @@ -2519,11 +2522,23 @@ static struct dmar_domain
> *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>  		}
>  	}
> 
> +	if (dev && dev_is_mdev(dev) && domain->default_pasid <= 0) {
> +		int max = intel_pasid_get_dev_max_id(dev_mdev_parent(dev));
> +
> +		domain->default_pasid = intel_pasid_alloc_id(domain, PASID_MIN,
> +							     max, GFP_KERNEL);
> +		if (domain->default_pasid < 0) {
> +			free_devinfo_mem(info);
> +			return NULL;
> +		}
> +	}
> +
>  	spin_lock_irqsave(&device_domain_lock, flags);
>  	if (dev)
>  		found = find_domain(dev);
> 
> -	if (!found) {
> +	/* A mediated device never has an DMA alias. Ignore searching. */
> +	if (!found && !dev_is_mdev(dev)) {
>  		struct device_domain_info *info2;
>  		info2 = dmar_search_domain_by_dev_info(iommu->segment, bus,
> devfn);
>  		if (info2) {
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h index
> 7efc632..9f5dcf6 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -423,6 +423,11 @@ struct dmar_domain {
>  					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
>  	u64		max_addr;	/* maximum mapped address */
> 
> +	int		default_pasid;	/*
> +					 * The default pasid used for non-SVM
> +					 * traffic on mediated devices.
> +					 */
> +
>  	struct iommu_domain domain;	/* generic domain data structure for
>  					   iommu core */
>  };
> --
> 2.7.4
