From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v5 10/23] iommu: introduce device fault data
Date: Fri, 21 Sep 2018 10:05:50 -0700
Message-ID: <20180921100550.51847a02@jacob-builder>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1526072055-86990-11-git-send-email-jacob.jun.pan@linux.intel.com>
        <72b3e4d8-de99-11d3-c725-1211fc64b262@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <72b3e4d8-de99-11d3-c725-1211fc64b262@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Auger Eric <eric.auger@redhat.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Yi L <yi.l.liu@linux.intel.com>, Raj Ashok <ashok.raj@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Liu@mail.linuxfoundation.org, Jean Delvare <khali@linux-fr.org>, jacob.jun.pan@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

On Fri, 21 Sep 2018 12:07:09 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 5/11/18 10:54 PM, Jacob Pan wrote:
> > Device faults detected by IOMMU can be reported outside IOMMU
> > subsystem for further processing. This patch intends to provide
> > a generic device fault data such that device drivers can be
> > communicated with IOMMU faults without model specific knowledge.
> > 
> > The proposed format is the result of discussion at:
> > https://lkml.org/lkml/2017/11/10/291
> > Part of the code is based on Jean-Philippe Brucker's patchset
> > (https://patchwork.kernel.org/patch/9989315/).
> > 
> > The assumption is that model specific IOMMU driver can filter and
> > handle most of the internal faults if the cause is within IOMMU
> > driver control. Therefore, the fault reasons can be reported are
> > grouped and generalized based common specifications such as PCI ATS.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > ---
> >  include/linux/iommu.h | 101
> > +++++++++++++++++++++++++++++++++++++++++++++++++- 1 file changed,
> > 99 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index e8cadb6..aeadb4f 100644
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
> >  struct iommu_domain_geometry {
> >  	dma_addr_t aperture_start; /* First address that can be
> > mapped    */ @@ -264,6 +268,98 @@ struct iommu_device {
> >  	struct device *dev;
> >  };
> >  
> > +/*  Generic fault types, can be expanded IRQ remapping fault */
> > +enum iommu_fault_type {
> > +	IOMMU_FAULT_DMA_UNRECOV = 1,	/* unrecoverable fault
> > */
> > +	IOMMU_FAULT_PAGE_REQ,		/* page request fault
> > */ +};  
> 
> While doing the exercise of mapping the SMMUv3 events to this, I
> failed to map some event types to iommu_fault_reason enum values.
I am not surprised :), this list is intended to grow as we add support
more IOMMU models. I was thinking of these guidelines when adding to
this list
- model agnostic
- needs to be reported outside iommu subsystem
- per device identifiable

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
> 
> Would it be possible to add
>  /* could not access the device context (fetch caused external abort)
> */ IOMMU_FAULT_REASON_DEVICE_CONTEXT_FETCH,
> 
sounds reasonable.
> > +
> > +	/*
> > +	 * PASID is out of range (e.g. exceeds the maximum PASID
> > +	 * supported by the IOMMU) or disabled.
> > +	 */
> > +	IOMMU_FAULT_REASON_PASID_INVALID,  
> Would it be possible to add
> /* source id is out of range */
> IOMMU_FAULT_REASON_SOURCEID_INVALID,
> 
hmm, the fault here should be per device. I guess source ID is PCI dev
requester ID eqivalent. If the source id is invalid, how could it be
reported to the right device in the vIOMMU? Should it be handled by the
host IOMMU itself?
> or alike
> on ARM the sourceid matches the streamid and pasid matches the
> substreamid.
> 
> It would be useful to have:
> /* pasid entry is invalid or has configuration errors */
> IOMMU_FAULT_REASON_BAD_PASID_ENTRY,
> 
> /* device context entry is invalid or has configuration errors */
> IOMMU_FAULT_REASON_BAD_DEVICE_CONTEXT_ENTRY,
> 
> This typically allows to return information to the guest about fields
> in device context entry or pasid entry that are incorrect, not
> matching the physical IOMMU capability
Sounds good.
> > +
> > +	/* Could not access the page directory (Invalid PASID
> > entry) */
> > +	IOMMU_FAULT_REASON_PGD_FETCH,  
> I was unsure about this one. On my side I needed something more
> general such as:
> /*
> * An external abort occurred fetching (or updating) a translation
> * table descriptor
> */
> IOMMU_FAULT_REASON_WALK_EABT,
> 
> > +
> > +	/* Could not access the page table entry (Bad address) */
> > +	IOMMU_FAULT_REASON_PTE_FETCH,  
> I interpreted this one as the actual translation failure but that's
> not obvious to me either. Is it a fetch abort or is it that the PTE is
> marked invalid. Maybe if we have the former we can just have a
> translation fault reason instead.
How about these two?
IOMMU_FAULT_REASON_TRANSL_TBL
IOMMU_FAULT_REASON_TRANSL

> > +
> > +	/* Protection flag check failed */
> > +	IOMMU_FAULT_REASON_PERMISSION,  
> On ARM we also have:
> 
> /* access flag check failed */
> IOMMU_FAULT_REASON_ACCESS,
> 
> and
> 
> /* Output address of a translation stage caused Address Size fault */
>  IOMMU_FAULT_REASON_OOR_ADDRESS
> 
is that for nested translation where stage 1 result is invalid for
stage 2? I am thinking for any misconfiguration, it should be handled
by host iommu driver locally.
> I am aware all those suggestions do not match the original goal of
> your series, mostly targeted at SVA support. However in the prospect
> to make those APIs as generic as possible it may be useful to take
> those requirements as well.
> 
> Hope it does not bring extra noise to the topic ;-)
> 
not at all. appreciate the effort to make it generally useful.

> Thanks
> 
> Eric
> 
> 
> 
> 
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
> > +	u64 device_private;
> > +	u64 iommu_private;
> > +};
> > +
> > +/**
> > + * struct iommu_fault_param - per-device IOMMU fault data
> > + * @dev_fault_handler: Callback function to handle IOMMU faults at
> > device level
> > + * @data: handler private data
> > + *
> > + */
> > +struct iommu_fault_param {
> > +	iommu_dev_fault_handler_t handler;
> > +	void *data;
> > +};
> > +
> > +/**
> > + * struct iommu_param - collection of per-device IOMMU data
> > + *
> > + * @fault_param: IOMMU detected device fault reporting data
> > + *
> > + * TODO: migrate other per device data pointers under
> > iommu_dev_data, e.g.
> > + *	struct iommu_group	*iommu_group;
> > + *	struct iommu_fwspec	*iommu_fwspec;
> > + */
> > +struct iommu_param {
> > +	struct iommu_fault_param *fault_param;
> > +};
> > +
> >  int  iommu_device_register(struct iommu_device *iommu);
> >  void iommu_device_unregister(struct iommu_device *iommu);
> >  int  iommu_device_sysfs_add(struct iommu_device *iommu,
> > @@ -437,6 +533,7 @@ struct iommu_ops {};
> >  struct iommu_group {};
> >  struct iommu_fwspec {};
> >  struct iommu_device {};
> > +struct iommu_fault_param {};
> >  
> >  static inline bool iommu_present(struct bus_type *bus)
> >  {
> >   

[Jacob Pan]
