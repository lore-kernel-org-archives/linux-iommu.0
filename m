From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 07/40] iommu: Add a page fault handler
Date: Mon, 21 May 2018 15:48:05 +0100
Message-ID: <d00405e5-9742-1b24-d6b0-6d389bb815ab@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
	<20180511190641.23008-8-jean-philippe.brucker@arm.com>
	<20180517162555.00002bd3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180517162555.00002bd3-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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
To: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rgummal-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 17/05/18 16:25, Jonathan Cameron wrote:
> On Fri, 11 May 2018 20:06:08 +0100
> Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:
> 
>> Some systems allow devices to handle I/O Page Faults in the core mm. For
>> example systems implementing the PCI PRI extension or Arm SMMU stall
>> model. Infrastructure for reporting these recoverable page faults was
>> recently added to the IOMMU core for SVA virtualisation. Add a page fault
>> handler for host SVA.
>>
>> IOMMU driver can now instantiate several fault workqueues and link them to
>> IOPF-capable devices. Drivers can choose between a single global
>> workqueue, one per IOMMU device, one per low-level fault queue, one per
>> domain, etc.
>>
>> When it receives a fault event, supposedly in an IRQ handler, the IOMMU
>> driver reports the fault using iommu_report_device_fault(), which calls
>> the registered handler. The page fault handler then calls the mm fault
>> handler, and reports either success or failure with iommu_page_response().
>> When the handler succeeded, the IOMMU retries the access.
>>
>> The iopf_param pointer could be embedded into iommu_fault_param. But
>> putting iopf_param into the iommu_param structure allows us not to care
>> about ordering between calls to iopf_queue_add_device() and
>> iommu_register_device_fault_handler().
>>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
> 
> Hi Jean-Phillipe,
> 
> One question below on how we would end up with partial faults left when
> doing the queue remove. Code looks fine, but I'm not seeing how that
> would happen without buggy hardware... + we presumably have to rely on
> the hardware timing out on that request or it's dead anyway...

>> +/**
>> + * iopf_queue_remove_device - Remove producer from fault queue
>> + * @dev: device to remove
>> + *
>> + * Caller makes sure that no more fault is reported for this device, and no more
>> + * flush is scheduled for this device.
>> + *
>> + * Note: safe to call unconditionally on a cleanup path, even if the device
>> + * isn't registered to any IOPF queue.
>> + *
>> + * Return 0 if the device was attached to the IOPF queue
>> + */
>> +int iopf_queue_remove_device(struct device *dev)
>> +{
>> +	struct iopf_context *fault, *next;
>> +	struct iopf_device_param *iopf_param;
>> +	struct iommu_param *param = dev->iommu_param;
>> +
>> +	if (!param)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&param->lock);
>> +	iopf_param = param->iopf_param;
>> +	if (iopf_param) {
>> +		refcount_dec(&iopf_param->queue->refs);
>> +		param->iopf_param = NULL;
>> +	}
>> +	mutex_unlock(&param->lock);
>> +	if (!iopf_param)
>> +		return -EINVAL;
>> +
>> +	list_for_each_entry_safe(fault, next, &iopf_param->partial, head)
>> +		kfree(fault);
>> +
> 
> Why would we end up here with partials still in the list?  Buggy hardware?

Buggy hardware is one possibility. There also is the nasty case of PRI
queue overflow. If the PRI queue is full, then the SMMU discards new
Page Requests from the device. It may discard a 'last' PR of a group
that is already in iopf_param->partial. This group will never be freed
until this cleanup.

The spec dismisses PRIq overflows because the OS is supposed to allocate
PRI credits to devices such that they can't send more than the PRI queue
size. This isn't possible in Linux because we don't know exactly how
many PRI-capable devices will share a queue (the upper limit is 2**32,
and devices may be hotplugged well after we allocated the PRI queue). So
PRIq overflow is possible.

Ideally when detecting a PRIq overflow we need to immediately remove all
partial faults of all devices sharing this queue. Since I can't easily
test that case (my device doesn't do PRGs) and it's complicated code, I
left it as TODO in patch 39, and this is our only chance to free
orphaned page requests.

>> +void iopf_queue_free(struct iopf_queue *queue)
>> +{
>> +
> 
> Nitpick : Blank line here doesn't add anything.

Ok

Thanks,
Jean
