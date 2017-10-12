From: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v2 02/16] iommu/vt-d: add bind_pasid_table function
Date: Thu, 12 Oct 2017 11:12:46 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439AF6CDD@SHSMSX104.ccr.corp.intel.com>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1507244624-39189-3-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1507244624-39189-3-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David
	Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Wysocki, Rafael J" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: "Lan, Tianyu" <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Jacob Pan [mailto:jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
> Sent: Friday, October 6, 2017 7:04 AM
> To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; Joerg
> Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>; David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>; Greg
> Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>; Wysocki, Rafael J
> <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Jean-Philippe Brucker <jean-
> philippe.brucker-5wv7dgnIgG8@public.gmane.org>
> Cc: Liu, Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Lan, Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Tian, Kevin
> <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Raj, Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Alex Williamson
> <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>; Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>; Liu; Yi
> L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Subject: [PATCH v2 02/16] iommu/vt-d: add bind_pasid_table function
> 
> Add Intel VT-d ops to the generic iommu_bind_pasid_table API functions.
> 
> The primary use case is for direct assignment of SVM capable device. Originated
> from emulated IOMMU in the guest, the request goes through many layers (e.g.
> VFIO). Upon calling host IOMMU driver, caller passes guest PASID table pointer (GPA)
> and size.
> 
> Device context table entry is modified by Intel IOMMU specific bind_pasid_table
> function. This will turn on nesting mode and matching translation type.
> 
> The unbind operation restores default context mapping.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Liu, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/intel-iommu.c   | 117
> ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/dma_remapping.h |   1 +
>  2 files changed, 118 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c index
> 209d99a..7ae569c 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5200,6 +5200,7 @@ static void intel_iommu_put_resv_regions(struct device
> *dev,
> 
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  #define MAX_NR_PASID_BITS (20)
> +#define MIN_NR_PASID_BITS (5)
>  static inline unsigned long intel_iommu_get_pts(struct intel_iommu *iommu)  {
>  	/*
> @@ -5326,6 +5327,118 @@ struct intel_iommu
> *intel_svm_device_to_iommu(struct device *dev)
> 
>  	return iommu;
>  }
> +
> +static int intel_iommu_bind_pasid_table(struct iommu_domain *domain,
> +		struct device *dev, struct pasid_table_config *pasidt_binfo) {
> +	struct intel_iommu *iommu;
> +	struct context_entry *context;
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +	struct device_domain_info *info;
> +	struct pci_dev *pdev;
> +	u8 bus, devfn, host_table_pasid_bits;
> +	u16 did, sid;
> +	int ret = 0;
> +	unsigned long flags;
> +	u64 ctx_lo;
> +
> +	iommu = device_to_iommu(dev, &bus, &devfn);
> +	if (!iommu)
> +		return -ENODEV;
> +	/* VT-d spec 9.4 says pasid table size is encoded as 2^(x+5) */
> +	host_table_pasid_bits = intel_iommu_get_pts(iommu) +
> MIN_NR_PASID_BITS;
> +	if (!pasidt_binfo || pasidt_binfo->pasid_bits > host_table_pasid_bits ||
> +		pasidt_binfo->pasid_bits < MIN_NR_PASID_BITS) {
> +		pr_err("Invalid gPASID bits %d, host range %d - %d\n",
> +			pasidt_binfo->pasid_bits,
> +			MIN_NR_PASID_BITS, host_table_pasid_bits);
> +		return -ERANGE;
> +	}
> +
> +	pdev = to_pci_dev(dev);
> +	if (!pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI))
> +		return -EINVAL;
> +	sid = PCI_DEVID(bus, devfn);
> +
> +	info = dev->archdata.iommu;
> +	if (!info || !info->pasid_supported) {
> +		dev_err(dev, "No PASID support\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	if (!info->pasid_enabled) {
> +		ret = pci_enable_pasid(pdev, info->pasid_supported & ~1);
> +		if (ret)
> +			goto out;
> +	}
> +	if (!device_context_mapped(iommu, bus, devfn)) {
> +		pr_warn("ctx not mapped for bus devfn %x:%x\n", bus, devfn);
> +		ret = -EINVAL;
> +		goto out;
> +	}

[Liu, Yi L] This is checking whether ctx is present. So if it is true, then the following 6 line
should be always true. Perhaps, a merge could be done here with the following 6 lines.

> +	spin_lock_irqsave(&iommu->lock, flags);
> +	context = iommu_context_addr(iommu, bus, devfn, 0);
> +	if (!context) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +

Regards,
Yi L
