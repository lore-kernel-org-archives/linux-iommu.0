From: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [RFC PATCH 05/10] iommu/vt-d: Setup DMA remapping for mediated
 devices
Date: Mon, 23 Jul 2018 04:44:42 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439CA1449@SHSMSX104.ccr.corp.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
 <1532239773-15325-6-git-send-email-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532239773-15325-6-git-send-email-baolu.lu@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "peterx@redhat.com" <peterx@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> Sent: Sunday, July 22, 2018 2:09 PM
> 
> This configures the second level page table when external components request to
> allocate a domain for a mediated device.

I think it should be the time when adding a mediate device to the domain.

> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 73
> ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 66 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c index
> 57ccfc4..b6e9ea8 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2569,8 +2569,9 @@ static struct dmar_domain
> *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>  	if (dev)
>  		dev->archdata.iommu = info;
> 
> -	if (dev && dev_is_pci(dev) && sm_supported(iommu)) {
> -		bool pass_through;
> +	if (dev && sm_supported(iommu)) {
> +		bool pass_through = hw_pass_through &&
> +				domain_type_is_si(domain);
> 
>  		ret = intel_pasid_alloc_table(dev);
>  		if (ret) {
> @@ -2579,12 +2580,21 @@ static struct dmar_domain
> *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>  			return NULL;
>  		}
> 
> -		/* Setup the PASID entry for requests without PASID: */
> -		pass_through = hw_pass_through && domain_type_is_si(domain);
>  		spin_lock(&iommu->lock);
> -		intel_pasid_setup_second_level(iommu, domain, dev,
> -					       PASID_RID2PASID,
> -					       pass_through);
> +
> +		/* Setup the PASID entry for requests without PASID: */
> +		if (dev_is_pci(dev))
> +			intel_pasid_setup_second_level(iommu, domain, dev,
> +						       PASID_RID2PASID,

can domain->default_pasid be initialized to be PASID_RID2PASID if the domain
is not a domain used by mediated device?

> +						       pass_through);
> +		/* Setup the PASID entry for mediated devices: */
> +		else if (dev_is_mdev(dev))
> +			intel_pasid_setup_second_level(iommu, domain, dev,
> +						       domain->default_pasid,
> +						       false);
> +		else
> +			pr_err("Unsupported device %s\n", dev_name(dev));
> +
>  		spin_unlock(&iommu->lock);
>  	}
>  	spin_unlock_irqrestore(&device_domain_lock, flags); @@ -4937,6 +4947,32
> @@ static void domain_context_clear(struct intel_iommu *iommu, struct device
> *dev)
>  	pci_for_each_dma_alias(to_pci_dev(dev), &domain_context_clear_one_cb,
> iommu);  }
> 
> +static void
> +iommu_flush_ext_iotlb(struct intel_iommu *iommu, u16 did, u32 pasid,

Per latest VT-d spec, its new name is pasid-based-iotlb. Pls update the naming
accordingly. :)

Regards,
Yi Liu

> +u64 gran) {
> +	struct qi_desc desc;
> +
> +	desc.high = 0;
> +	desc.low = QI_EIOTLB_PASID(pasid) | QI_EIOTLB_DID(did) |
> +			QI_EIOTLB_GRAN(gran) | QI_EIOTLB_TYPE;
> +
> +	qi_submit_sync(&desc, iommu);
> +}
> +
> +static void iommu_flush_pasid_dev_iotlb(struct intel_iommu *iommu,
> +					struct device *dev, int sid, int pasid) {
> +	struct qi_desc desc;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int qdep = pci_ats_queue_depth(pdev);
> +
> +	desc.low = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
> +			QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE;
> +	desc.high = QI_DEV_EIOTLB_ADDR(-1ULL >> 1) | QI_DEV_EIOTLB_SIZE;
> +
> +	qi_submit_sync(&desc, iommu);
> +}
> +
>  static void __dmar_remove_one_dev_info(struct device_domain_info *info)  {
>  	struct intel_iommu *iommu;
> @@ -4949,6 +4985,29 @@ static void __dmar_remove_one_dev_info(struct
> device_domain_info *info)
> 
>  	iommu = info->iommu;
> 
> +	if (dev_is_mdev(info->dev)) {
> +		struct dmar_domain *domain = info->domain;
> +		int did = domain->iommu_did[iommu->seq_id];
> +		int sid = info->bus << 8 | info->devfn;
> +		struct device *dev = info->dev;
> +
> +		intel_pasid_clear_entry(dev, domain->default_pasid);
> +
> +		/* Flush IOTLB including PASID Cache: */
> +		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
> +
> +		/*
> +		 * Flush EIOTLB. The only way to flush global mappings within
> +		 * a PASID is to use QI_GRAN_ALL_ALL.
> +		 */
> +		iommu_flush_ext_iotlb(iommu, did, domain->default_pasid,
> +				      QI_GRAN_ALL_ALL);
> +
> +		/* Flush Dev TLB: */
> +		iommu_flush_pasid_dev_iotlb(iommu, dev_mdev_parent(dev), sid,
> +					    domain->default_pasid);
> +	}
> +
>  	if (info->dev) {
>  		iommu_disable_dev_iotlb(info);
>  		domain_context_clear(iommu, info->dev);
> --
> 2.7.4
