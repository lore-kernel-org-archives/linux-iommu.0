From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 07/16] iommu/vt-d: assign PFSID in device TLB
 invalidation
Date: Tue, 5 Dec 2017 13:45:00 +0800
Message-ID: <5A26325C.2030909@linux.intel.com>
References: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1510944914-54430-8-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510944914-54430-8-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>, Christoph Hellwig <hch@infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 11/18/2017 02:55 AM, Jacob Pan wrote:
> When SRIOV VF device IOTLB is invalidated, we need to provide
> the PF source SID such that IOMMU hardware can gauge the depth
> of invalidation queue which is shared among VFs. This is needed
> when device invalidation throttle (DIT) capability is supported.
>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 13 +++++++++++++
>  include/linux/intel-iommu.h |  3 +++
>  2 files changed, 16 insertions(+)
>
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 000b2b3..e1bd219 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1459,6 +1459,19 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
>  		return;
>  
>  	pdev = to_pci_dev(info->dev);
> +	/* For IOMMU that supports device IOTLB throttling (DIT), we assign
> +	 * PFSID to the invalidation desc of a VF such that IOMMU HW can gauge
> +	 * queue depth at PF level. If DIT is not set, PFSID will be treated as
> +	 * reserved, which should be set to 0.
> +	 */
> +	if (!ecap_dit(info->iommu->ecap))
> +		info->pfsid = 0;
> +	else if (pdev && pdev->is_virtfn) {
> +		if (ecap_dit(info->iommu->ecap))

Isn't this condition always true when it comes here?

Best regards,
Lu Baolu

> +			dev_warn(&pdev->dev, "SRIOV VF device IOTLB enabled without flow control\n");
> +		info->pfsid = PCI_DEVID(pdev->physfn->bus->number, pdev->physfn->devfn);
> +	} else
> +		info->pfsid = PCI_DEVID(info->bus, info->devfn);
>  
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  	/* The PCIe spec, in its wisdom, declares that the behaviour of
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 7f05e36..6956a4e 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -112,6 +112,7 @@
>   * Extended Capability Register
>   */
>  
> +#define ecap_dit(e)		((e >> 41) & 0x1)
>  #define ecap_pasid(e)		((e >> 40) & 0x1)
>  #define ecap_pss(e)		((e >> 35) & 0x1f)
>  #define ecap_eafs(e)		((e >> 34) & 0x1)
> @@ -285,6 +286,7 @@ enum {
>  #define QI_DEV_IOTLB_SID(sid)	((u64)((sid) & 0xffff) << 32)
>  #define QI_DEV_IOTLB_QDEP(qdep)	(((qdep) & 0x1f) << 16)
>  #define QI_DEV_IOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
> +#define QI_DEV_IOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | ((u64)(pfsid & 0xff0) << 48))
>  #define QI_DEV_IOTLB_SIZE	1
>  #define QI_DEV_IOTLB_MAX_INVS	32
>  
> @@ -475,6 +477,7 @@ struct device_domain_info {
>  	struct list_head global; /* link to global list */
>  	u8 bus;			/* PCI bus number */
>  	u8 devfn;		/* PCI devfn number */
> +	u16 pfsid;		/* SRIOV physical function source ID */
>  	u8 pasid_supported:3;
>  	u8 pasid_enabled:1;
>  	u8 pri_supported:1;
