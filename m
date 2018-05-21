From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v4 10/22] iommu: introduce device fault data
Date: Mon, 21 May 2018 16:16:21 -0700
Message-ID: <20180521161621.0ae30c8d@jacob-builder>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-11-git-send-email-jacob.jun.pan@linux.intel.com>
	<A2975661238FB949B60364EF0F2C257439BF3E05@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <A2975661238FB949B60364EF0F2C257439BF3E05-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Wysocki,
	Rafael J" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sun, 20 May 2018 08:17:43 +0000
"Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> Hi Jacob,
> 
> > From: Jacob Pan [mailto:jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
> > Sent: Tuesday, April 17, 2018 5:49 AM
> >  include/linux/iommu.h | 102
> > +++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 100 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index e963dbd..8968933 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -49,13 +49,17 @@ struct bus_type;
> >  struct device;
> >  struct iommu_domain;
> >  struct notifier_block;
> > +struct iommu_fault_event;
> > 
> >  /* iommu fault flags */
> > -#define IOMMU_FAULT_READ	0x0
> > -#define IOMMU_FAULT_WRITE	0x1
> > +#define IOMMU_FAULT_READ		(1 << 0)
> > +#define IOMMU_FAULT_WRITE		(1 << 1)
> > +#define IOMMU_FAULT_EXEC		(1 << 2)
> > +#define IOMMU_FAULT_PRIV		(1 << 3)
> > 
> >  typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
> >  			struct device *, unsigned long, int, void
> > *); +typedef int (*iommu_dev_fault_handler_t)(struct
> > iommu_fault_event *, void *);
> > 
> >  struct iommu_domain_geometry {
> >  	dma_addr_t aperture_start; /* First address that can be
> > mapped    */ @@ -264,6 +268,99 @@ struct iommu_device {
> >  	struct device *dev;
> >  };
> > 
> > +/*  Generic fault types, can be expanded IRQ remapping fault */
> > +enum iommu_fault_type {
> > +	IOMMU_FAULT_DMA_UNRECOV = 1,	/* unrecoverable fault
> > */
> > +	IOMMU_FAULT_PAGE_REQ,		/* page request fault
> > */ +};
> > +
> > +enum iommu_fault_reason {
> > +	IOMMU_FAULT_REASON_UNKNOWN = 0,
> > +
> > +	/* IOMMU internal error, no specific reason to report out
> > */
> > +	IOMMU_FAULT_REASON_INTERNAL,
> > +
> > +	/* Could not access the PASID table */
> > +	IOMMU_FAULT_REASON_PASID_FETCH,
> > +
> > +	/*
> > +	 * PASID is out of range (e.g. exceeds the maximum PASID
> > +	 * supported by the IOMMU) or disabled.
> > +	 */
> > +	IOMMU_FAULT_REASON_PASID_INVALID,
> > +
> > +	/* Could not access the page directory (Invalid PASID
> > entry) */
> > +	IOMMU_FAULT_REASON_PGD_FETCH,
> > +
> > +	/* Could not access the page table entry (Bad address) */
> > +	IOMMU_FAULT_REASON_PTE_FETCH,
> > +
> > +	/* Protection flag check failed */
> > +	IOMMU_FAULT_REASON_PERMISSION,
> > +};
> > +
> > +/**
> > + * struct iommu_fault_event - Generic per device fault data
> > + *
> > + * - PCI and non-PCI devices
> > + * - Recoverable faults (e.g. page request), information based on
> > PCI ATS
> > + * and PASID spec.
> > + * - Un-recoverable faults of device interest
> > + * - DMA remapping and IRQ remapping faults
> > +
> > + * @type contains fault type.
> > + * @reason fault reasons if relevant outside IOMMU driver, IOMMU
> > driver internal
> > + *         faults are not reported
> > + * @addr: tells the offending page address
> > + * @pasid: contains process address space ID, used in shared
> > virtual memory(SVM)
> > + * @rid: requestor ID
> > + * @page_req_group_id: page request group index
> > + * @last_req: last request in a page request group
> > + * @pasid_valid: indicates if the PRQ has a valid PASID
> > + * @prot: page access protection flag, e.g. IOMMU_FAULT_READ,
> > IOMMU_FAULT_WRITE
> > + * @device_private: if present, uniquely identify device-specific
> > + *                  private data for an individual page request.
> > + * @iommu_private: used by the IOMMU driver for storing
> > fault-specific
> > + *                 data. Users should not modify this field before
> > + *                 sending the fault response.
> > + */
> > +struct iommu_fault_event {
> > +	enum iommu_fault_type type;
> > +	enum iommu_fault_reason reason;
> > +	u64 addr;
> > +	u32 pasid;
> > +	u32 page_req_group_id;
> > +	u32 last_req : 1;
> > +	u32 pasid_valid : 1;
> > +	u32 prot;  
> 
> I think userspace also needs to know the fault type, reason, pasid,
> addr, goup_id, prot. So the definition should be included in
> uapi/Linux/iommu.h.
> 
> This comment also applies to "struct page_response_msg". Qemu also
> wants to pass the page response to host.
> 
sounds good. i assume vfio layer would reuse these data.
> > +	u64 device_private;
> > +	u64 iommu_private;  
> 
> These two seems to be in kernel driver specific data. May split the
> iommu_fault_event definition into two parts. One part for the data
> required by both driver and userspace. One part for in kernel driver
> specific data.
> 
even device and iommu private data can be potentially consumed by the
guest kernel for some special processing. But for now, we just copy
back to the response message. e.g. vt-d streaming page response
request is embedded in the iommu private data.

> Thanks,
> Yi Liu
> 

[Jacob Pan]
