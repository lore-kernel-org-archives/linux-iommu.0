From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/9] iommu/vt-d: add bind_pasid_table function
Date: Wed, 28 Jun 2017 12:02:03 +0200
Message-ID: <20170628100202.GF14532@8bytes.org>
References: <1498592883-56224-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1498592883-56224-3-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1498592883-56224-3-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Liu-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, "Tian,
	Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 27, 2017 at 12:47:56PM -0700, Jacob Pan wrote:
> Add Intel VT-d ops to the generic iommu_bind_pasid_table API
> functions.
> 
> The primary use case is for direct assignment of SVM capable
> device. Originated from emulated IOMMU in the guest, the request goes
> through many layers (e.g. VFIO). Upon calling host IOMMU driver, caller
> passes guest PASID table pointer (GPA) and size.
> 
> Device context table entry is modified by Intel IOMMU specific
> bind_pasid_table function. This will turn on nesting mode and matching
> translation type.
> 
> The unbind operation restores default context mapping.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Liu, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/intel-iommu.c   | 117 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/dma_remapping.h |   1 +
>  2 files changed, 118 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 8274ce3..ef05b59 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5430,6 +5430,119 @@ struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
>  
>  	return iommu;
>  }
> +
> +static int intel_iommu_bind_pasid_table(struct iommu_domain *domain,
> +		struct device *dev, struct pasid_table_info *pasidt_binfo)
> +{
> +	struct intel_iommu *iommu;
> +	struct context_entry *context;
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +	struct device_domain_info *info;
> +	struct pci_dev *pdev;
> +	u8 bus, devfn;
> +	u16 did, *sid;
> +	int ret = 0;
> +	unsigned long flags;
> +	u64 ctx_lo;
> +
> +	if (pasidt_binfo == NULL || pasidt_binfo->model != IOMMU_MODEL_INTEL_VTD) {
> +		pr_warn("%s: Invalid bind request!\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	iommu = device_to_iommu(dev, &bus, &devfn);
> +	if (!iommu)
> +		return -ENODEV;
> +
> +	sid = (u16 *)&pasidt_binfo->opaque;
> +	/*
> +	 * check SID, if it is not correct, return success to allow looping
> +	 * through all devices within a group
> +	 */
> +	if (PCI_DEVID(bus, devfn) != *sid)
> +		return 0;
> +
> +	if (!dev || !dev_is_pci(dev))
> +		return -ENODEV;
> +
> +	pdev = to_pci_dev(dev);
> +	if (!pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI))
> +		return -EINVAL;
> +
> +	info = dev->archdata.iommu;
> +	if (!info || !info->pasid_supported ||
> +		!pci_enable_pasid(pdev, info->pasid_supported & ~1)) {
> +		pr_err("PCI %04x:%02x:%02x.%d: has no PASID support\n",
> +			       pci_domain_nr(pdev->bus), bus, PCI_SLOT(devfn),
> +			       PCI_FUNC(devfn));

You can either use dev_name() here to decode the device name, or just
use dev_err() instead.
