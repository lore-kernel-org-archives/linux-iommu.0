From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v5 02/12] iommu/vt-d: Manage scalalble mode PASID tables
Date: Mon, 3 Dec 2018 14:44:12 +0100
Message-ID: <20181203134411.lejlkbnagxml54ro@8bytes.org>
References: <20181128035449.10226-1-baolu.lu@linux.intel.com>
 <20181128035449.10226-3-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181128035449.10226-3-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi Baolu,

On Wed, Nov 28, 2018 at 11:54:39AM +0800, Lu Baolu wrote:
> @@ -2482,12 +2482,13 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>  	if (dev)
>  		dev->archdata.iommu = info;
>  
> -	if (dev && dev_is_pci(dev) && info->pasid_supported) {
> +	/* PASID table is mandatory for a PCI device in scalable mode. */
> +	if (dev && dev_is_pci(dev) && sm_supported(iommu)) {

This will also allocate a PASID table if the device does not support
PASIDs, right? Will the table not be used in that case or will the
device just use the fallback PASID? Isn't it better in that case to have
no PASID table?

> @@ -143,18 +143,20 @@ int intel_pasid_alloc_table(struct device *dev)
>  		return -ENOMEM;
>  	INIT_LIST_HEAD(&pasid_table->dev);
>  
> -	size = sizeof(struct pasid_entry);
> -	count = min_t(int, pci_max_pasids(to_pci_dev(dev)), intel_pasid_max_id);
> -	order = get_order(size * count);
> +	if (info->pasid_supported)
> +		max_pasid = min_t(int, pci_max_pasids(to_pci_dev(dev)),
> +				  intel_pasid_max_id);
> +
> +	size = max_pasid >> (PASID_PDE_SHIFT - 3);
> +	order = size ? get_order(size) : 0;
>  	pages = alloc_pages_node(info->iommu->node,
> -				 GFP_ATOMIC | __GFP_ZERO,
> -				 order);
> +				 GFP_ATOMIC | __GFP_ZERO, order);

This is a simple data structure allocation path, does it need
GFP_ATOMIC?



	Joerg
