From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 07/10] iommu: Add a page fault handler
Date: Wed, 3 Oct 2018 18:46:11 +0100
Message-ID: <f873cc65-ec0c-9273-eb14-9e07f13d3206@arm.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
	<20180920170046.20154-8-jean-philippe.brucker@arm.com>
	<20180927133746.319e19b8@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180927133746.319e19b8@jacob-builder>
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
Cc: "kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org" <liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 27/09/2018 21:37, Jacob Pan wrote:
> On Thu, 20 Sep 2018 18:00:43 +0100
> Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:
> 
>> +	/*
>> +	 * When removing a PASID, the device driver tells the device
>> to stop
>> +	 * using it, and flush any pending fault to the IOMMU. In
>> this flush
>> +	 * callback, the IOMMU driver makes sure that there are no
>> such faults
>> +	 * left in the low-level queue.
>> +	 */
>> +	queue->flush(queue->flush_arg, dev, pasid);
>> +
>> +	/*
>> +	 * If at some point the low-level fault queue overflowed and
>> the IOMMU
>> +	 * device had to auto-respond to a 'last' page fault, other
>> faults from
>> +	 * the same Page Request Group may still be stuck in the
>> partial list.
>> +	 * We need to make sure that the next address space using
>> the PASID
>> +	 * doesn't receive them.
>> +	 */
> Trying to understand the intended use case under queue full condition.
> 1 model specific iommu driver register a flush callback to handle
>   internal PRQ drain
> 
> 2 IOMMU HW detects queue full and auto respond with 'SUCCESS' code to
>   all device and PASID, raise interrupt
> 
> 3 model specific iommu driver detects queue full and call
> iopf_queue_flush_dev()

I didn't intent for iopf_queue_flush_dev to be called by the IOMMU driver
in this situation, at the moment it's only intended for the SVA code to
clean up before removing a PASID (in which case we have to wipe partial
faults). This version doesn't provide anything to the IOMMU driver for
handling overflow condition cleanly, partial faults are kept until the
PASID is unbound or SVA is disabled.

> 4 call queue->flush() callback to drain PRQ in-flight inside IOMMU HW

Could we avoid this step in this scenario? If it's the PRI IRQ thread that
detects queue full in step 3, then it could drain the HW queue before
calling iopf_flush_partial() (or something like that). I'm a bit worried
about possible locking problems if we go back to the IOMMU driver here
while it is calling us.

> 5.Shoot down partial list for all PASIDs
> 
> If the above understanding is correct, don't we need to shoot down all
> partial groups? instead of just one PASID. At least for VT-d, we need
> to do that.

Passing IOMMU_PASID_INVALID will do that. But It also needs to be done for
all devices that use this IOPF queue, and we don't need to flush the
workqueue, so iopf_queue_flush_dev isn't really adapted.

Thanks,
Jean

> 
> 
>> +	mutex_lock(&param->lock);
>> +	list_for_each_entry_safe(fault, next,
>> &param->iopf_param->partial, head) {
>> +		if (fault->evt.pasid == pasid || pasid ==
>> IOMMU_PASID_INVALID) {
>> +			list_del(&fault->head);
>> +			kfree(fault);
>> +		}
>> +	}
>> +	mutex_unlock(&param->lock);
>> +
>> +	flush_workqueue(queue->wq);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(iopf_queue_flush_dev);
>> +
> [Jacob Pan]
> 
