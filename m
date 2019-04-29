From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 01/10] iommu: Add helper to get minimal page size of
 domain
Date: Mon, 29 Apr 2019 11:55:54 +0100
Message-ID: <05eca601-0264-8141-ceeb-7ef7ad5d5650@arm.com>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
 <20190421011719.14909-2-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190421011719.14909-2-baolu.lu@linux.intel.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com, mika.westerberg@linux.intel.com, pengfei.xu@intel.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 21/04/2019 02:17, Lu Baolu wrote:
> This makes it possible for other modules to know the minimal
> page size supported by a domain without the knowledge of the
> structure details.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   include/linux/iommu.h | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index a5007d035218..46679ef19b7e 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -377,6 +377,14 @@ static inline void iommu_tlb_sync(struct iommu_domain *domain)
>   		domain->ops->iotlb_sync(domain);
>   }
>   
> +static inline unsigned long domain_minimal_pgsize(struct iommu_domain *domain)
> +{
> +	if (domain && domain->pgsize_bitmap)
> +		return 1 << __ffs(domain->pgsize_bitmap);

Nit: this would probably be more efficient on most architectures as:

	if (domain)
		return domain->pgsize_bitmap & -domain->pgsize_bitmap;


I'd also suggest s/minimal/min/ in the name, just to stop it getting too 
long. Otherwise, though, I like the idea, and there's at least one other 
place (in iommu-dma) that can make use of it straight away.

Robin.

> +
> +	return 0;
> +}
> +
>   /* PCI device grouping function */
>   extern struct iommu_group *pci_device_group(struct device *dev);
>   /* Generic device grouping function */
> @@ -704,6 +712,11 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
>   	return NULL;
>   }
>   
> +static inline unsigned long domain_minimal_pgsize(struct iommu_domain *domain)
> +{
> +	return 0;
> +}
> +
>   #endif /* CONFIG_IOMMU_API */
>   
>   #ifdef CONFIG_IOMMU_DEBUGFS
> 
