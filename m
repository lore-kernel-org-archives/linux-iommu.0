From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 08/16] iommu: introduce device fault data
Date: Tue, 10 Oct 2017 20:29:29 +0100
Message-ID: <439401c0-a9ff-a69a-dc10-12d72f7abbab@arm.com>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1507244624-39189-9-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1507244624-39189-9-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 06/10/17 00:03, Jacob Pan wrote:
> Device faults detected by IOMMU can be reported outside IOMMU
> subsystem. This patch intends to provide a generic device
> fault data such that device drivers can communicate IOMMU faults
> without model specific knowledge.
> 
> The assumption is that model specific IOMMU driver can filter and
> handle most of the IOMMU faults if the cause is within IOMMU driver
> control. Therefore, the fault reasons can be reported are grouped
> and generalized based common specifications such as PCI ATS.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  include/linux/iommu.h | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 4af1820..3f9b367 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -49,6 +49,7 @@ struct bus_type;
>  struct device;
>  struct iommu_domain;
>  struct notifier_block;
> +struct iommu_fault_event;
>  
>  /* iommu fault flags */
>  #define IOMMU_FAULT_READ	0x0
> @@ -56,6 +57,7 @@ struct notifier_block;
>  
>  typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
>  			struct device *, unsigned long, int, void *);
> +typedef int (*iommu_dev_fault_handler_t)(struct device *, struct iommu_fault_event *);
>  
>  struct iommu_domain_geometry {
>  	dma_addr_t aperture_start; /* First address that can be mapped    */
> @@ -264,6 +266,60 @@ struct iommu_device {
>  	struct device *dev;
>  };
>  
> +enum iommu_model {
> +	IOMMU_MODEL_INTEL = 1,
> +	IOMMU_MODEL_AMD,
> +	IOMMU_MODEL_SMMU3,
> +};

Now unused, I guess?

> +
> +/*  Generic fault types, can be expanded IRQ remapping fault */
> +enum iommu_fault_type {
> +	IOMMU_FAULT_DMA_UNRECOV = 1,	/* unrecoverable fault */
> +	IOMMU_FAULT_PAGE_REQ,		/* page request fault */
> +};
> +
> +enum iommu_fault_reason {
> +	IOMMU_FAULT_REASON_CTX = 1,

If I read the VT-d spec right, this is a fault encountered while fetching
the PASID table pointer?

> +	IOMMU_FAULT_REASON_ACCESS,

And this a pgd or pte access fault?

> +	IOMMU_FAULT_REASON_INVALIDATE,

What would this be?

> +	IOMMU_FAULT_REASON_UNKNOWN,
> +};

I'm currently doing the same exploratory work for virtio-iommu, and I'd be
tempted to report reasons as detailed as possible to guest or device
driver, but it's not clear what they need, how they would use this
information. I'd like to discuss this some more.

For unrecoverable faults I guess CTX means "the host IOMMU driver is
broken", since the device tables are invalid. In which case there is no
use continuing, trying to shutdown the device cleanly is really all the
guest/device driver can do.

For ACCESS the error is the device driver's or guest's fault, since the
device driver triggered DMA on unmapped buffers, or the guest didn't
install the right page tables. This can be repaired without shutting down,
it may even just be one execution stream that failed in the device while
the others continued normally. It's not as recoverable as a PRI Page
Request, but the device driver may still be able to isolate the problem
(e.g. by killing the process responsible) and the device to recover from it.

So maybe ACCESS would benefit from more details, for example
differentiating faults encountered while fetching the pgd from those
encountered while fetching a second-level table or pte. The former is a
lot less recoverable than the latter (bug in the guest IOMMU driver vs.
bug in the device driver).

Generalizing this maybe we should differentiate each step of the
translation in fault_reason:

* Device entry (context) fetch -> host IOMMU driver's fault
* PASID table fetch -> guest IOMMU driver or host userspace's fault
* pgd fetch -> guest IOMMU driver's fault
* pte fetch, including validity and access check -> device driver's fault

It's probably not worth mentioning intermediate table levels (pmd, etc).
Thoughts?

> +/**
> + * struct iommu_fault_event - Generic per device fault data
> + *
> + * - PCI and non-PCI devices
> + * - Recoverable faults (e.g. page request), information based on PCI ATS
> + * and PASID spec.
> + * - Un-recoverable faults of device interest
> + * - DMA remapping and IRQ remapping faults
> +
> + * @type contains fault type.
> + * @reason fault reasons if relevant outside IOMMU driver, IOMMU driver internal
> + *         faults are not reported
> + * @paddr: tells the offending page address
> + * @pasid: contains process address space ID, used in shared virtual memory(SVM)
> + * @rid: requestor ID> + * @page_req_group_id: page request group index
> + * @last_req: last request in a page request group
> + * @pasid_valid: indicates if the PRQ has a valid PASID
> + * @prot: page access protection flag, e.g. IOMMU_READ, IOMMU_WRITE
> + * @private_data: uniquely identify device-specific private data for an
> + *                individual page request

I understand this is for the streaming extension on VT-d, is it
IOMMU-specific or specific to the faulting endpoint? Could the device
driver receiving the fault attempt to decode or modify this field before
sending the page response?

> + */
> +struct iommu_fault_event {
> +	enum iommu_fault_type type;
> +	enum iommu_fault_reason reason;
> +	u64 paddr;
> +	u32 pasid;
> +	u32 rid:16;

I think this is redundant, since you already pass the struct device to the
fault handler. Otherwise it should probably be extended to 32 bits, for
non-PCI or multiple PCI domains.

> +	u32 page_req_group_id : 9;> +	u32 last_req : 1;
> +	u32 pasid_valid : 1;
> +	u32 prot;
> +	u32 private_data;
> +};
> +
>  int  iommu_device_register(struct iommu_device *iommu);
>  void iommu_device_unregister(struct iommu_device *iommu);
>  int  iommu_device_sysfs_add(struct iommu_device *iommu,
> @@ -425,6 +481,18 @@ struct iommu_fwspec {
>  	u32			ids[1];
>  };
>  
> +/**
> + * struct iommu_fault_param - per-device IOMMU runtime data
> + * @dev_fault_handler: Callback function to handle IOMMU faults at device level
> + * @pasid_tbl_bound: Device PASID table is bound to a guest
> + *
> + */
> +struct iommu_fault_param {
> +	iommu_dev_fault_handler_t dev_fault_handler;
> +	bool pasid_tbl_bound:1;
> +	bool pasid_tbl_shadowed:1;

I guess you can remove this?

Thanks,
Jean

> +};
> +
>  int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
>  		      const struct iommu_ops *ops);
>  void iommu_fwspec_free(struct device *dev);
> @@ -437,6 +505,7 @@ struct iommu_ops {};
>  struct iommu_group {};
>  struct iommu_fwspec {};
>  struct iommu_device {};
> +struct iommu_fault_param {};
>  
>  static inline bool iommu_present(struct bus_type *bus)
>  {
> 
