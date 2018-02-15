From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 07/37] iommu: Add a page fault handler
Date: Thu, 15 Feb 2018 13:49:41 +0000
Message-ID: <2be857f1-cde2-a448-2bca-045f068396e7@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
	<20180212183352.22730-8-jean-philippe.brucker@arm.com>
	<20180213231821.5863ef99@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180213231821.5863ef99@jacob-builder>
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
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, rjw@rjwyso
List-Id: iommu@lists.linux-foundation.org

On 14/02/18 07:18, Jacob Pan wrote:
[...]
>> +/* Used to store incomplete fault groups */
>> +static LIST_HEAD(iommu_partial_faults);
>> +static DEFINE_SPINLOCK(iommu_partial_faults_lock);
>> +
> should partial fault list be per iommu?

That would be good, but I don't see an easy way to retrieve the iommu
instance in report_device_fault(). Maybe the driver should pass it to
report_device_fault(), and we can then store partial faults in struct
iommu_device.

[...]
>> +/**
>> + * iommu_report_device_fault() - Handle fault in device driver or mm
>> + *
>> + * If the device driver expressed interest in handling fault, report
>> it through
>> + * the callback. If the fault is recoverable, try to page in the
>> address.
>> + */
>> +int iommu_report_device_fault(struct device *dev, struct
>> iommu_fault_event *evt) +{
>> +	int ret = -ENOSYS;
>> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>> +
>> +	if (!domain)
>> +		return -ENODEV;
>> +
>> +	/*
>> +	 * if upper layers showed interest and installed a fault
>> handler,
>> +	 * invoke it.
>> +	 */
>> +	if (iommu_has_device_fault_handler(dev)) {
> I think Alex pointed out this is racy, so adding a mutex to the
> iommu_fault_param and acquire it would help. Do we really
> atomic handler?

Yes I think a few IOMMU drivers will call this function from IRQ context,
so a spinlock might be better for acquiring iommu_fault_param.

>> +		struct iommu_fault_param *param =
>> dev->iommu_param->fault_param; +
>> +		return param->handler(evt, param->data);
> Even upper layer (VFIO) registered handler to propagate PRQ to a guest
> to fault in the pages, we may still need to keep track of the page
> requests that need page response later, i.e. last page in group or
> stream request in vt-d. This will allow us sanitize the page response
> come back from the guest/VFIO.
> In my next round, I am adding a per device list under iommu_fault_param
> for pending page request. This will also address the situation where
> guest failed to send response. We can enforce time or credit limit of
> pending requests based on this list.

Sounds good

Thanks,
Jean
