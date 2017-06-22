From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC 8/9] iommu/intel-svm: notify page request to guest
Date: Thu, 22 Jun 2017 16:53:58 -0600
Message-ID: <20170622165358.70cfe33b@w520.home>
References: <1497478983-77580-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1497478983-77580-9-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497478983-77580-9-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 14 Jun 2017 15:23:02 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> If the source device of a page request has its PASID table pointer
> bond to a guest, the first level page tables are owned by the guest.
> In this case, we shall let guest OS to manage page fault.
> 
> This patch uses the IOMMU fault notification API to send notifications,
> possibly via VFIO, to the guest OS. Once guest pages are fault in, guest
> will issue page response which will be passed down via the invalidation
> passdown APIs.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> ---
>  drivers/iommu/intel-svm.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 80 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 23c4276..d1d2d23 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -525,6 +525,80 @@ static bool access_error(struct vm_area_struct *vma, struct page_req_dsc *req)
>  	return (requested & ~vma->vm_flags) != 0;
>  }
>  
> +static int prq_to_iommu_prot(struct page_req_dsc *req)
> +{
> +	int prot = 0;
> +
> +	if (req->rd_req)
> +		prot |= IOMMU_READ;
> +	if (req->wr_req)
> +		prot |= IOMMU_WRITE;
> +	if (req->exe_req)
> +		prot |= IOMMU_EXEC;
> +	if (req->priv_req)
> +		prot |= IOMMU_PRIV;
> +
> +	return prot;
> +}
> +
> +static int intel_svm_prq_notify(struct device *dev, struct page_req_dsc *desc)
> +{
> +	int ret = 0;
> +	struct iommu_fault_event *event;
> +	struct pci_dev *pdev;
> +	struct device_domain_info *info;
> +	unsigned long buf_offset;
> +
> +	/**
> +	 * If caller does not provide struct device, this is the case where
> +	 * guest PASID table is bond to the device. So we need to retrieve
> +	 * struct device from the page request deescriptor then proceed.
> +	 */
> +	if (!dev) {
> +		pdev = pci_get_bus_and_slot(desc->bus, desc->devfn);
> +		if (!pdev) {
> +			pr_err("No PCI device found for PRQ [%02x:%02x.%d]\n",
> +				desc->bus, PCI_SLOT(desc->devfn),
> +				PCI_FUNC(desc->devfn));
> +			return -ENODEV;
> +		}
> +		/**
> +		 * Make sure PASID table pointer is bond to guest, if yes notify
> +		 * handler in the guest, e.g. via VFIO.
> +		 */
> +		info = pdev->dev.archdata.iommu;
> +		if (!info || !info->pasid_tbl_bond) {
> +			pr_debug("PRQ device pasid table not bond.\n");

I can "bond" two things together, they are then "bound".

> +			return -EINVAL;
> +		}
> +		dev = &pdev->dev;

Leaks pdev reference.  Both normal and error path.

> +	}
> +
> +	pr_debug("Notify PRQ device [%02x:%02x.%d]\n",
> +		desc->bus, PCI_SLOT(desc->devfn),
> +		PCI_FUNC(desc->devfn));
> +	event = kzalloc(sizeof(*event) + sizeof(*desc), GFP_KERNEL);
> +	if (!event)
> +		return -ENOMEM;
> +
> +	get_device(dev);
> +	/* Fill in event data for device specific processing */
> +	event->dev = dev;
> +	buf_offset = offsetofend(struct iommu_fault_event, length);
> +	memcpy(buf_offset + event, desc, sizeof(*desc));
> +	event->addr = desc->addr;
> +	event->pasid = desc->pasid;
> +	event->prot = prq_to_iommu_prot(desc);
> +	event->length = sizeof(*desc);
> +	event->flags = IOMMU_FAULT_PAGE_REQ;
> +
> +	ret = iommu_fault_notifier_call_chain(event);
> +	put_device(dev);
> +	kfree(event);
> +
> +	return ret;
> +}
> +
>  static irqreturn_t prq_event_thread(int irq, void *d)
>  {
>  	struct intel_iommu *iommu = d;
> @@ -548,7 +622,12 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  		handled = 1;
>  
>  		req = &iommu->prq[head / sizeof(*req)];
> -
> +		/**
> +		 * If prq is to be handled outside iommu driver via receiver of
> +		 * the fault notifiers, we skip the page response here.
> +		 */
> +		if (!intel_svm_prq_notify(NULL, req))
> +			continue;
>  		result = QI_RESP_FAILURE;
>  		address = (u64)req->addr << VTD_PAGE_SHIFT;
>  		if (!req->pasid_present) {
