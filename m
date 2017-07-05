From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 2/9] iommu/vt-d: add bind_pasid_table function
Date: Wed, 5 Jul 2017 07:38:07 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190D25C29@SHSMSX101.ccr.corp.intel.com>
References: <1498592883-56224-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1498592883-56224-3-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1498592883-56224-3-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
	Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "Lan, Tianyu" <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Jacob Pan [mailto:jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
> Sent: Wednesday, June 28, 2017 3:48 AM
> 
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
>  drivers/iommu/intel-iommu.c   | 117
> ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/dma_remapping.h |   1 +
>  2 files changed, 118 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 8274ce3..ef05b59 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5430,6 +5430,119 @@ struct intel_iommu
> *intel_svm_device_to_iommu(struct device *dev)
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
> +	if (pasidt_binfo == NULL || pasidt_binfo->model !=
> IOMMU_MODEL_INTEL_VTD) {
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

Can you elaborate this comment since it's related to caller behavior?
Also better move to earlier as the comment for whole function...

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
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (pasidt_binfo->size > intel_iommu_get_pts(iommu)) {
> +		pr_err("Invalid gPASID table size %llu, host size %lu\n",
> +			pasidt_binfo->size,
> +			intel_iommu_get_pts(iommu));
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	spin_lock_irqsave(&iommu->lock, flags);
> +	context = iommu_context_addr(iommu, bus, devfn, 0);
> +	if (!context || !context_present(context)) {
> +		pr_warn("%s: ctx not present for bus devfn %x:%x\n",
> +			__func__, bus, devfn);
> +		spin_unlock_irqrestore(&iommu->lock, flags);
> +		goto out;
> +	}
> +
> +	/* Anticipate guest to use SVM and owns the first level */
> +	ctx_lo = context[0].lo;
> +	ctx_lo |= CONTEXT_NESTE;
> +	ctx_lo |= CONTEXT_PRS;
> +	ctx_lo |= CONTEXT_PASIDE;
> +	ctx_lo &= ~CONTEXT_TT_MASK;
> +	ctx_lo |= CONTEXT_TT_DEV_IOTLB << 2;
> +	context[0].lo = ctx_lo;
> +
> +	/* Assign guest PASID table pointer and size */
> +	ctx_lo = (pasidt_binfo->ptr & VTD_PAGE_MASK) | pasidt_binfo->size;
> +	context[1].lo = ctx_lo;
> +	/* make sure context entry is updated before flushing */
> +	wmb();
> +	did = dmar_domain->iommu_did[iommu->seq_id];
> +	iommu->flush.flush_context(iommu, did,
> +				(((u16)bus) << 8) | devfn,
> +				DMA_CCMD_MASK_NOBIT,
> +				DMA_CCMD_DEVICE_INVL);
> +	iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
> +	spin_unlock_irqrestore(&iommu->lock, flags);
> +
> +
> +out:
> +	return ret;
> +}
> +
> +static int intel_iommu_unbind_pasid_table(struct iommu_domain *domain,
> +					struct device *dev)
> +{
> +	struct intel_iommu *iommu;
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +	u8 bus, devfn;
> +
> +	iommu = device_to_iommu(dev, &bus, &devfn);
> +	if (!iommu)
> +		return -ENODEV;
> +	/*
> +	 * REVISIT: we might want to clear the PASID table pointer
> +	 * as part of context clear operation. Currently, it leaves
> +	 * stale data but should be ignored by hardware since PASIDE
> +	 * is clear.
> +	 */
> +	/* ATS will be reenabled when remapping is restored */
> +	pci_disable_ats(to_pci_dev(dev));
> +	domain_context_clear(iommu, dev);
> +	return domain_context_mapping_one(dmar_domain, iommu, bus,
> devfn);
> +}
>  #endif /* CONFIG_INTEL_IOMMU_SVM */
> 
>  const struct iommu_ops intel_iommu_ops = {
> @@ -5438,6 +5551,10 @@ const struct iommu_ops intel_iommu_ops = {
>  	.domain_free		= intel_iommu_domain_free,
>  	.attach_dev		= intel_iommu_attach_device,
>  	.detach_dev		= intel_iommu_detach_device,
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +	.bind_pasid_table	= intel_iommu_bind_pasid_table,
> +	.unbind_pasid_table	= intel_iommu_unbind_pasid_table,
> +#endif
>  	.map			= intel_iommu_map,
>  	.unmap			= intel_iommu_unmap,
>  	.map_sg			= default_iommu_map_sg,
> diff --git a/include/linux/dma_remapping.h
> b/include/linux/dma_remapping.h
> index 9088407..85367b7 100644
> --- a/include/linux/dma_remapping.h
> +++ b/include/linux/dma_remapping.h
> @@ -27,6 +27,7 @@
> 
>  #define CONTEXT_DINVE		(1ULL << 8)
>  #define CONTEXT_PRS		(1ULL << 9)
> +#define CONTEXT_NESTE		(1ULL << 10)
>  #define CONTEXT_PASIDE		(1ULL << 11)
> 
>  struct intel_iommu;
> --
> 2.7.4
