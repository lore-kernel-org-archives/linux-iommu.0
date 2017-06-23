From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC 5/9] iommu: Introduce fault notifier API
Date: Fri, 23 Jun 2017 13:15:51 -0600
Message-ID: <20170623131551.6aeb9af7@w520.home>
References: <1497478983-77580-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1497478983-77580-6-git-send-email-jacob.jun.pan@linux.intel.com>
        <20170622165317.20f3ebde@w520.home>
        <20170623115928.13aa8858@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170623115928.13aa8858@jacob-builder>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 23 Jun 2017 11:59:28 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> On Thu, 22 Jun 2017 16:53:17 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
> > On Wed, 14 Jun 2017 15:22:59 -0700
> > Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> >   
> > > Traditionally, device specific faults are detected and handled
> > > within their own device drivers. When IOMMU is enabled, faults such
> > > as DMA related transactions are detected by IOMMU. There is no
> > > generic reporting mechanism to report faults back to the in-kernel
> > > device driver or the guest OS in case of assigned devices.
> > > 
> > > Faults detected by IOMMU is based on the transaction's source ID
> > > which can be reported at per device basis, regardless of the device
> > > type is a PCI device or not.
> > > 
> > > The fault types includes recoverable (e.g. page request) and
> > > unrecoverable faults(e.g. invalid context). In most cases, faults
> > > can be handled by IOMMU drivers. However, there are use cases that
> > > require fault processing outside IOMMU driver, e.g.
> > > 
> > > 1. page request fault originated from an SVM capable device that is
> > > assigned to guest via vIOMMU. In this case, the first level page
> > > tables are owned by the guest. Page request must be propagated to
> > > the guest to let guest OS fault in the pages then send page
> > > response. In this mechanism, the direct receiver of IOMMU fault
> > > notification is VFIO, which can relay notification events to QEMU
> > > or other user space software.
> > > 
> > > 2. faults need more subtle handling by device drivers. Other than
> > > simply invoke reset function, there are needs to let device driver
> > > handle the fault with a smaller impact.
> > > 
> > > This patchset is intended to create a generic fault notification
> > > API such that it can scale as follows:
> > > - all IOMMU types
> > > - PCI and non-PCI devices
> > > - recoverable and unrecoverable faults
> > > - VFIO and other other in kernel users
> > > - DMA & IRQ remapping (TBD)
> > > 
> > > The event data contains both generic and raw architectural data
> > > such that performance is not compromised as the data propagation may
> > > involve many layers.
> > > 
> > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > > ---
> > >  drivers/iommu/iommu.c | 63
> > > +++++++++++++++++++++++++++++++++++++++++++++++++++
> > > include/linux/iommu.h | 54
> > > +++++++++++++++++++++++++++++++++++++++++++ 2 files changed, 117
> > > insertions(+)
> > > 
> > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > index c786370..04c73f3 100644
> > > --- a/drivers/iommu/iommu.c
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -48,6 +48,7 @@ struct iommu_group {
> > >  	struct list_head devices;
> > >  	struct mutex mutex;
> > >  	struct blocking_notifier_head notifier;
> > > +	struct blocking_notifier_head fault_notifier;
> > >  	void *iommu_data;
> > >  	void (*iommu_data_release)(void *iommu_data);
> > >  	char *name;
> > > @@ -345,6 +346,7 @@ struct iommu_group *iommu_group_alloc(void)
> > >  	mutex_init(&group->mutex);
> > >  	INIT_LIST_HEAD(&group->devices);
> > >  	BLOCKING_INIT_NOTIFIER_HEAD(&group->notifier);
> > > +	BLOCKING_INIT_NOTIFIER_HEAD(&group->fault_notifier);
> > >  
> > >  	ret = ida_simple_get(&iommu_group_ida, 0, 0, GFP_KERNEL);
> > >  	if (ret < 0) {
> > > @@ -790,6 +792,67 @@ int iommu_group_unregister_notifier(struct
> > > iommu_group *group,
> > > EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier); 
> > >  /**
> > > + * iommu_register_fault_notifier - Register a notifier for fault
> > > reporting
> > > + * @dev: device to notify fault events
> > > + * @nb: notifier block to signal
> > > + *
> > > + */
> > > +int iommu_register_fault_notifier(struct device *dev,
> > > +				struct notifier_block *nb)
> > > +{
> > > +	int ret;
> > > +	struct iommu_group *group = iommu_group_get(dev);
> > > +
> > > +	if (!group)
> > > +		return -EINVAL;
> > > +
> > > +	ret =
> > > blocking_notifier_chain_register(&group->fault_notifier, nb);
> > > +	iommu_group_put(group);
> > > +
> > > +	return ret;
> > > +
> > > +}
> > > +EXPORT_SYMBOL_GPL(iommu_register_fault_notifier);
> > > +
> > > +/**
> > > + * iommu_unregister_fault_notifier - Unregister a notifier for
> > > fault reporting
> > > + * @domain: the domain to watch
> > > + * @nb: notifier block to signal
> > > + *
> > > + */
> > > +int iommu_unregister_fault_notifier(struct device *dev,
> > > +				  struct notifier_block *nb)
> > > +{
> > > +	int ret;
> > > +	struct iommu_group *group = iommu_group_get(dev);
> > > +
> > > +	if (!group)
> > > +		return -EINVAL;
> > > +
> > > +	ret =
> > > blocking_notifier_chain_unregister(&group->fault_notifier, nb);
> > > +	iommu_group_put(group);
> > > +
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(iommu_unregister_fault_notifier);    
> > 
> > 
> > If the call chains are on the group, why do we register with a device?
> > If I registered with a group, I'd know that I only need to register
> > once per group, that's not clear here and may lead to callers of this
> > getting multiple notifications, one for each device in a group.
> >   
> My thought was that since iommu_group is already part of struct device,
> it is more efficient to share group level notifier than introducing per
> device fault callbacks or notifiers.

That's fine, but the interface should reflect the same.
 
> So you do need to register per device not just once for the group. In
> most cases device with SVM has ACS, it will be 1:1 between device and
> group.

ACS at the endpoint is only one factor in determining grouping, we need
only look at Intel Core processors to find root ports lacking ACS which
will result in multiple devices per group as a very common case.
 
> When the fault event occurs, IOMMU can identify the offending device
> and struct device is embedded in the event data sent to the device
> driver or VFIO, so the receiver can filter out unwanted events.

I think this is a poor design choice.  If the notification list is on
the group then make the registration be on the group.  Otherwise the
number of notifies seen by the caller is automatically multiplied by
the number of devices they're using in the group.  The caller not only
needs to disregard unintended devices, but they need to make sure they
only act on a notification for the device on the correct notifier.
This is designing in unnecessary complexity and overhead.

> > > +
> > > +int iommu_fault_notifier_call_chain(struct iommu_fault_event
> > > *event) +{
> > > +	int ret;
> > > +	struct iommu_group *group = iommu_group_get(event->dev);
> > > +
> > > +	if (!group)
> > > +		return -EINVAL;
> > > +	/* caller provide generic data related to the event, TBD */
> > > +	ret =
> > > (blocking_notifier_call_chain(&group->fault_notifier, 0, (void
> > > *)event)
> > > +		== NOTIFY_BAD) ? -EINVAL : 0;
> > > +	iommu_group_put(group);
> > > +
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL(iommu_fault_notifier_call_chain);
> > > +
> > > +/**
> > >   * iommu_group_id - Return ID for a group
> > >   * @group: the group to ID
> > >   *
> > > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > > index 2cdbaa3..fe89e88 100644
> > > --- a/include/linux/iommu.h
> > > +++ b/include/linux/iommu.h
> > > @@ -42,6 +42,7 @@
> > >   * if the IOMMU page table format is equivalent.
> > >   */
> > >  #define IOMMU_PRIV	(1 << 5)
> > > +#define IOMMU_EXEC	(1 << 6)    
> > 
> > Irrelevant change?
> >   
> yes, it should be separate. used later in svm patch.
> > >  
> > >  struct iommu_ops;
> > >  struct iommu_group;
> > > @@ -97,6 +98,36 @@ struct iommu_domain {
> > >  	void *iova_cookie;
> > >  };
> > >  
> > > +/*
> > > + * Generic fault event notification data, used by all IOMMU
> > > architectures.
> > > + *
> > > + * - PCI and non-PCI devices
> > > + * - Recoverable faults (e.g. page request) & un-recoverable faults
> > > + * - DMA remapping and IRQ remapping faults
> > > + *
> > > + * @dev The device which faults are reported by IOMMU
> > > + * @addr tells the offending address
> > > + * @pasid contains process address space ID, used in shared
> > > virtual memory (SVM)
> > > + * @prot page access protection flag, e.g. IOMMU_READ, IOMMU_WRITE
> > > + * @flags contains fault type, etc.
> > > + * @length tells the size of the buf
> > > + * @buf contains any raw or arch specific data
> > > + *
> > > + */
> > > +struct iommu_fault_event {
> > > +	struct device *dev;
> > > +	__u64 addr;
> > > +	__u32 pasid;
> > > +	__u32 prot;
> > > +	__u32 flags;
> > > +#define IOMMU_FAULT_PAGE_REQ	BIT(0)
> > > +#define IOMMU_FAULT_UNRECOV	BIT(1)
> > > +#define IOMMU_FAULT_IRQ_REMAP	BIT(2)
> > > +#define IOMMU_FAULT_INVAL	BIT(3)    
> > 
> > Details of each of these are defined where?
> >   
> good point, will add description.
> > > +	__u32 length;
> > > +	__u8  buf[];
> > > +};    
> > 
> > This is not UAPI, so I'll be curious how vfio is supposed to expose
> > this to userspace.
> >   
> But this also has other in-kernel users.


Any point where you expect vfio to pass through one of these model
specific data structures needs to be fully specified in a uapi header.
No magic opaque data please.  Thanks,

Alex
