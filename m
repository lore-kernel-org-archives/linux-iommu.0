From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 07/40] iommu: Add a page fault handler
Date: Thu, 24 May 2018 12:44:38 +0100
Message-ID: <bdf9f221-ab97-2168-d072-b7f6a0dba840@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
	<20180511190641.23008-8-jean-philippe.brucker@arm.com>
	<20180518110434.150a0e64@jacob-builder>
	<8a640794-a6f3-fa01-82a9-06479a6f779a@arm.com>
	<20180522163521.413e60c6@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180522163521.413e60c6@jacob-builder>
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
Cc: "bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rgummal-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <rgummal-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 23/05/18 00:35, Jacob Pan wrote:
>>>> +			/* Insert *before* the last fault */
>>>> +			list_move(&fault->head, &group->faults);
>>>> +	}
>>>> +  
>>> If you already sorted the group list with last fault at the end,
>>> why do you need a separate entry to track the last fault?  
>>
>> Not sure I understand your question, sorry. Do you mean why the
>> iopf_group.last_fault? Just to avoid one more kzalloc.
>>
> kind of :) what i thought was that why can't the last_fault naturally
> be the last entry in your group fault list? then there is no need for
> special treatment in terms of allocation of the last fault. just my
> preference.

But we need a kzalloc for the last fault anyway, so I thought I'd just
piggy-back on the group allocation. And if I don't add the last fault at
the end of group->faults, then it's iopf_handle_group that requires
special treatment. I'm still not sure I understood your question though,
could you send me a patch that does it?

>>>> +
>>>> +	queue->flush(queue->flush_arg, dev);
>>>> +
>>>> +	/*
>>>> +	 * No need to clear the partial list. All PRGs containing
>>>> the PASID that
>>>> +	 * needs to be decommissioned are whole (the device driver
>>>> made sure of
>>>> +	 * it before this function was called). They have been
>>>> submitted to the
>>>> +	 * queue by the above flush().
>>>> +	 */  
>>> So you are saying device driver need to make sure LPIG PRQ is
>>> submitted in the flush call above such that partial list is
>>> cleared?  
>>
>> Not exactly, it's the IOMMU driver that makes sure all LPIG in its
>> queues are submitted by the above flush call. In more details the
>> flow is:
>>
>> * Either device driver calls unbind()/sva_device_shutdown(), or the
>> process exits.
>> * If the device driver called, then it already told the device to stop
>> using the PASID. Otherwise we use the mm_exit() callback to tell the
>> device driver to stop using the PASID.
>> * In either case, when receiving a stop request from the driver, the
>> device sends the LPIGs to the IOMMU queue.
>> * Then, the flush call above ensures that the IOMMU reports the LPIG
>> with iommu_report_device_fault.
>> * While submitting all LPIGs for this PASID to the work queue,
>> ipof_queue_fault also picked up all partial faults, so the partial
>> list is clean.
>>
>> Maybe I should improve this comment?
>>
> thanks for explaining. LPIG submission is done by device asynchronously
> w.r.t. driver stopping/decommission PASID.

Hmm, it should really be synchronous, otherwise there is no way to know
when the PASID can be decommissioned. We need a guarantee such as the
one in 6.20.1 of the PCIe spec, "Managing PASID TLP Prefix Usage":

"When the stop request mechanism indicates completion, the Function has:
* Completed all Non-Posted Requests associated with this PASID.
* Flushed to the host all Posted Requests addressing host memory in all
TCs that were used by the PASID."

That's in combination with "The function shall [...] finish transmitting
any multi-page Page Request Messages for this PASID (i.e. send the Page
Request Message with the L bit Set)." from the ATS spec.

(If I remember correctly a PRI Page Request is a Posted Request.) Only
after this stop request completes can the driver call unbind(), or
return from exit_mm(). Then we know that if there was a LPIG for that
PASID, it is in the IOMMU's PRI queue (or already completed) once we
call flush().

> so if we were to use this
> flow on vt-d, which does not stall page request queue, then we should
> use the iommu model specific flush() callback to ensure LPIG is
> received? There could be queue full condition and retry. I am just
> trying to understand how and where we can make sure LPIG is
> received and all groups are whole.

For SMMU in patch 30, the flush() callback waits until the PRI queue is
empty or, when the PRI thread is running in parallel, until the thread
has done a full circle (handled as many faults as the queue size). It's
really unpleasant to implement because the flush() callback takes a lock
to inspect the hardware state, but I don't think we have a choice.

Thanks,
Jean
