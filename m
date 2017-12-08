From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3 10/16] iommu: introduce device fault report API
Date: Fri, 8 Dec 2017 12:23:58 -0800
Message-ID: <20171208122358.720edd9d@jacob-builder>
References: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1510944914-54430-11-git-send-email-jacob.jun.pan@linux.intel.com>
	<20171207142725.731695ea@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171207142725.731695ea-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 7 Dec 2017 14:27:25 -0700
Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On Fri, 17 Nov 2017 10:55:08 -0800
> Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> 
> > Traditionally, device specific faults are detected and handled
> > within their own device drivers. When IOMMU is enabled, faults such
> > as DMA related transactions are detected by IOMMU. There is no
> > generic reporting mechanism to report faults back to the in-kernel
> > device driver or the guest OS in case of assigned devices.
> > 
> > Faults detected by IOMMU is based on the transaction's source ID
> > which can be reported at per device basis, regardless of the device
> > type is a PCI device or not.
> > 
> > The fault types include recoverable (e.g. page request) and
> > unrecoverable faults(e.g. access error). In most cases, faults can
> > be handled by IOMMU drivers internally. The primary use cases are as
> > follows:
> > 1. page request fault originated from an SVM capable device that is
> > assigned to guest via vIOMMU. In this case, the first level page
> > tables are owned by the guest. Page request must be propagated to
> > the guest to let guest OS fault in the pages then send page
> > response. In this mechanism, the direct receiver of IOMMU fault
> > notification is VFIO, which can relay notification events to QEMU
> > or other user space software.
> > 
> > 2. faults need more subtle handling by device drivers. Other than
> > simply invoke reset function, there are needs to let device driver
> > handle the fault with a smaller impact.
> > 
> > This patchset is intended to create a generic fault report API such
> > that it can scale as follows:
> > - all IOMMU types
> > - PCI and non-PCI devices
> > - recoverable and unrecoverable faults
> > - VFIO and other other in kernel users
> > - DMA & IRQ remapping (TBD)
> > The original idea was brought up by David Woodhouse and discussions
> > summarized at https://lwn.net/Articles/608914/.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/iommu/iommu.c | 63
> > ++++++++++++++++++++++++++++++++++++++++++++++++++-
> > include/linux/iommu.h | 36 +++++++++++++++++++++++++++++ 2 files
> > changed, 98 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 829e9e9..97b7990 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -581,6 +581,12 @@ int iommu_group_add_device(struct iommu_group
> > *group, struct device *dev) goto err_free_name;
> >  	}
> >  
> > +	dev->iommu_param = kzalloc(sizeof(struct
> > iommu_fault_param), GFP_KERNEL);
> > +	if (!dev->iommu_param) {
> > +		ret = -ENOMEM;
> > +		goto err_free_name;
> > +	}
> > +
> >  	kobject_get(group->devices_kobj);
> >  
> >  	dev->iommu_group = group;
> > @@ -657,7 +663,7 @@ void iommu_group_remove_device(struct device
> > *dev) sysfs_remove_link(&dev->kobj, "iommu_group");
> >  
> >  	trace_remove_device_from_group(group->id, dev);
> > -
> > +	kfree(dev->iommu_param);
> >  	kfree(device->name);
> >  	kfree(device);
> >  	dev->iommu_group = NULL;
> > @@ -791,6 +797,61 @@ int iommu_group_unregister_notifier(struct
> > iommu_group *group, }
> >  EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
> >  
> > +int iommu_register_device_fault_handler(struct device *dev,
> > +					iommu_dev_fault_handler_t
> > handler,
> > +					void *data)
> > +{
> > +	struct iommu_param *idata = dev->iommu_param;
> > +
> > +	/*
> > +	 * Device iommu_param should have been allocated when
> > device is
> > +	 * added to its iommu_group.
> > +	 */
> > +	if (!idata)
> > +		return -EINVAL;
> > +	/* Only allow one fault handler registered for each device
> > */
> > +	if (idata->fault_param)
> > +		return -EBUSY;
> > +	get_device(dev);
> > +	idata->fault_param =
> > +		kzalloc(sizeof(struct iommu_fault_param),
> > GFP_KERNEL);
> > +	if (!idata->fault_param)
> > +		return -ENOMEM;
> > +	idata->fault_param->handler = handler;
> > +	idata->fault_param->data = data;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_register_device_fault_handler);
> > +
> > +int iommu_unregister_device_fault_handler(struct device *dev)
> > +{
> > +	struct iommu_param *idata = dev->iommu_param;
> > +
> > +	if (!idata)
> > +		return -EINVAL;
> > +
> > +	kfree(idata->fault_param);
> > +	idata->fault_param = NULL;
> > +	put_device(dev);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_unregister_device_fault_handler);
> > +
> > +
> > +int iommu_report_device_fault(struct device *dev, struct
> > iommu_fault_event *evt) +{
> > +	/* we only report device fault if there is a handler
> > registered */
> > +	if (!dev->iommu_param || !dev->iommu_param->fault_param ||
> > +		!dev->iommu_param->fault_param->handler)
> > +		return -ENOSYS;
> > +
> > +	return dev->iommu_param->fault_param->handler(evt,
> > +
> > dev->iommu_param->fault_param->data); +}
> > +EXPORT_SYMBOL_GPL(iommu_report_device_fault);
> > +  
> 
> Isn't this all rather racy?  I see that we can have multiple callers
> to register racing.
I agree, should use a lock here to prevent unregister. For multiple
caller race, it won't happen since there is only one caller can
register handler.
>  Unregister is buggy, allowing any caller to
> decrement the device reference regardless of whether there's one
> outstanding through this interface.  The reporting callout can also
> race with an unregistration.  Might need a mutex on iommu_param to
> avoid.
> 
you are right, forgot to check outstanding handler. will add mutex also.

Thanks,
> >  /**
> >   * iommu_group_id - Return ID for a group
> >   * @group: the group to ID
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index dfda89b..841c044 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -463,6 +463,14 @@ extern int
> > iommu_group_register_notifier(struct iommu_group *group, struct
> > notifier_block *nb); extern int
> > iommu_group_unregister_notifier(struct iommu_group *group, struct
> > notifier_block *nb); +extern int
> > iommu_register_device_fault_handler(struct device *dev,
> > +					iommu_dev_fault_handler_t
> > handler,
> > +					void *data);
> > +
> > +extern int iommu_unregister_device_fault_handler(struct device
> > *dev); +
> > +extern int iommu_report_device_fault(struct device *dev, struct
> > iommu_fault_event *evt); +
> >  extern int iommu_group_id(struct iommu_group *group);
> >  extern struct iommu_group *iommu_group_get_for_dev(struct device
> > *dev); extern struct iommu_domain
> > *iommu_group_default_domain(struct iommu_group *); @@ -481,6
> > +489,12 @@ extern void iommu_domain_window_disable(struct
> > iommu_domain *domain, u32 wnd_nr) extern int
> > report_iommu_fault(struct iommu_domain *domain, struct device *dev,
> > unsigned long iova, int flags); +static inline bool
> > iommu_has_device_fault_handler(struct device *dev) +{
> > +	return dev->iommu_param && dev->iommu_param->fault_param &&
> > +		dev->iommu_param->fault_param->handler;
> > +}
> > +  
> 
> This interface is racy by design, there's no guarantee that the
> handler isn't immediately unregistered after this check. Thanks,
> 
right, I will fold this check into report function and protect by a
lock. I was trying to save some cycles but it would not work with the
race condition.
> Alex
> 
> >  static inline void iommu_flush_tlb_all(struct iommu_domain *domain)
> >  {
> >  	if (domain->ops->flush_iotlb_all)
> > @@ -734,6 +748,28 @@ static inline int
> > iommu_group_unregister_notifier(struct iommu_group *group, return 0;
> >  }
> >  
> > +static inline int iommu_register_device_fault_handler(struct
> > device *dev,
> > +
> > iommu_dev_fault_handler_t handler,
> > +						void *data)
> > +{
> > +	return 0;
> > +}
> > +
> > +static inline int iommu_unregister_device_fault_handler(struct
> > device *dev) +{
> > +	return 0;
> > +}
> > +
> > +static inline bool iommu_has_device_fault_handler(struct device
> > *dev) +{
> > +	return false;
> > +}
> > +
> > +static inline int iommu_report_device_fault(struct device *dev,
> > struct iommu_fault_event *evt) +{
> > +	return 0;
> > +}
> > +
> >  static inline int iommu_group_id(struct iommu_group *group)
> >  {
> >  	return -ENODEV;  
> 

[Jacob Pan]
