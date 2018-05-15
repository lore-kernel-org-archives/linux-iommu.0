From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v5 13/23] iommu: introduce device fault report API
Date: Tue, 15 May 2018 14:52:59 +0800
Message-ID: <5AFA83CB.2040301@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1526072055-86990-14-git-send-email-jacob.jun.pan@linux.intel.com>
	<5AF92622.2090902@linux.intel.com>
	<20180514135548.4b95ab93@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180514135548.4b95ab93@jacob-builder>
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
Cc: Raj Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 05/15/2018 04:55 AM, Jacob Pan wrote:
> On Mon, 14 May 2018 14:01:06 +0800
> Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>
>> Hi,
>>
>> On 05/12/2018 04:54 AM, Jacob Pan wrote:
>>> Traditionally, device specific faults are detected and handled
>>> within their own device drivers. When IOMMU is enabled, faults such
>>> as DMA related transactions are detected by IOMMU. There is no
>>> generic reporting mechanism to report faults back to the in-kernel
>>> device driver or the guest OS in case of assigned devices.
>>>
>>> Faults detected by IOMMU is based on the transaction's source ID
>>> which can be reported at per device basis, regardless of the device
>>> type is a PCI device or not.
>>>
>>> The fault types include recoverable (e.g. page request) and
>>> unrecoverable faults(e.g. access error). In most cases, faults can
>>> be handled by IOMMU drivers internally. The primary use cases are as
>>> follows:
>>> 1. page request fault originated from an SVM capable device that is
>>> assigned to guest via vIOMMU. In this case, the first level page
>>> tables are owned by the guest. Page request must be propagated to
>>> the guest to let guest OS fault in the pages then send page
>>> response. In this mechanism, the direct receiver of IOMMU fault
>>> notification is VFIO, which can relay notification events to QEMU
>>> or other user space software.
>>>
>>> 2. faults need more subtle handling by device drivers. Other than
>>> simply invoke reset function, there are needs to let device driver
>>> handle the fault with a smaller impact.
>>>
>>> This patchset is intended to create a generic fault report API such
>>> that it can scale as follows:
>>> - all IOMMU types
>>> - PCI and non-PCI devices
>>> - recoverable and unrecoverable faults
>>> - VFIO and other other in kernel users
>>> - DMA & IRQ remapping (TBD)
>>> The original idea was brought up by David Woodhouse and discussions
>>> summarized at https://lwn.net/Articles/608914/.
>>>
>>> Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>> Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
>>> ---
>>>  drivers/iommu/iommu.c | 149
>>> +++++++++++++++++++++++++++++++++++++++++++++++++-
>>> include/linux/iommu.h |  35 +++++++++++- 2 files changed, 181
>>> insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 3a49b96..b3f9daf 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -609,6 +609,13 @@ int iommu_group_add_device(struct iommu_group
>>> *group, struct device *dev) goto err_free_name;
>>>  	}
>>>  
>>> +	dev->iommu_param = kzalloc(sizeof(*dev->iommu_param),
>>> GFP_KERNEL);
>>> +	if (!dev->iommu_param) {
>>> +		ret = -ENOMEM;
>>> +		goto err_free_name;
>>> +	}
>>> +	mutex_init(&dev->iommu_param->lock);
>>> +
>>>  	kobject_get(group->devices_kobj);
>>>  
>>>  	dev->iommu_group = group;
>>> @@ -639,6 +646,7 @@ int iommu_group_add_device(struct iommu_group
>>> *group, struct device *dev) mutex_unlock(&group->mutex);
>>>  	dev->iommu_group = NULL;
>>>  	kobject_put(group->devices_kobj);
>>> +	kfree(dev->iommu_param);
>>>  err_free_name:
>>>  	kfree(device->name);
>>>  err_remove_link:
>>> @@ -685,7 +693,7 @@ void iommu_group_remove_device(struct device
>>> *dev) sysfs_remove_link(&dev->kobj, "iommu_group");
>>>  
>>>  	trace_remove_device_from_group(group->id, dev);
>>> -
>>> +	kfree(dev->iommu_param);
>>>  	kfree(device->name);
>>>  	kfree(device);
>>>  	dev->iommu_group = NULL;
>>> @@ -820,6 +828,145 @@ int iommu_group_unregister_notifier(struct
>>> iommu_group *group,
>>> EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier); 
>>>  /**
>>> + * iommu_register_device_fault_handler() - Register a device fault
>>> handler
>>> + * @dev: the device
>>> + * @handler: the fault handler
>>> + * @data: private data passed as argument to the handler
>>> + *
>>> + * When an IOMMU fault event is received, call this handler with
>>> the fault event
>>> + * and data as argument. The handler should return 0 on success.
>>> If the fault is
>>> + * recoverable (IOMMU_FAULT_PAGE_REQ), the handler can also
>>> complete
>>> + * the fault by calling iommu_page_response() with one of the
>>> following
>>> + * response code:
>>> + * - IOMMU_PAGE_RESP_SUCCESS: retry the translation
>>> + * - IOMMU_PAGE_RESP_INVALID: terminate the fault
>>> + * - IOMMU_PAGE_RESP_FAILURE: terminate the fault and stop
>>> reporting
>>> + *   page faults if possible.
>>> + *
>>> + * Return 0 if the fault handler was installed successfully, or an
>>> error.
>>> + */
>>> +int iommu_register_device_fault_handler(struct device *dev,
>>> +					iommu_dev_fault_handler_t
>>> handler,
>>> +					void *data)
>>> +{
>>> +	struct iommu_param *param = dev->iommu_param;
>>> +	int ret = 0;
>>> +
>>> +	/*
>>> +	 * Device iommu_param should have been allocated when
>>> device is
>>> +	 * added to its iommu_group.
>>> +	 */
>>> +	if (!param)
>>> +		return -EINVAL;
>>> +
>>> +	mutex_lock(&param->lock);
>>> +	/* Only allow one fault handler registered for each device
>>> */
>>> +	if (param->fault_param) {
>>> +		ret = -EBUSY;
>>> +		goto done_unlock;
>>> +	}
>>> +
>>> +	get_device(dev);
>>> +	param->fault_param =
>>> +		kzalloc(sizeof(struct iommu_fault_param),
>>> GFP_KERNEL);
>>> +	if (!param->fault_param) {
>>> +		put_device(dev);
>>> +		ret = -ENOMEM;
>>> +		goto done_unlock;
>>> +	}
>>> +	mutex_init(&param->fault_param->lock);  
>> Do we really need this mutex lock? Is param->lock enough?
>>
> I am trying to provide more fine locking granularity in that
> iommu_param is meant to be expanded as the sole iommu data under struct
> device, so the scope of param->lock may expand.

Okay, got it.

Best regards,
Lu Baolu

>>  [...]  
>>
>> Best regards,
>> Lu Baolu
> [Jacob Pan]
>
