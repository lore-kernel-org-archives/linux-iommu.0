From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 08/16] iommu: introduce device fault data
Date: Mon, 6 Nov 2017 19:01:54 +0000
Message-ID: <09d451dc-c0e9-1fa2-8f85-45a9b1185d48@arm.com>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1507244624-39189-9-git-send-email-jacob.jun.pan@linux.intel.com>
	<439401c0-a9ff-a69a-dc10-12d72f7abbab@arm.com>
	<A2975661238FB949B60364EF0F2C257439AFC86D@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <A2975661238FB949B60364EF0F2C257439AFC86D-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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
To: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Wysocki, Rafael J" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Lan, Tianyu" <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Yi,

Sorry for the late reply, I seem to have missed this.

On 20/10/17 11:07, Liu, Yi L wrote:
[...]
>>> +
>>> +/*  Generic fault types, can be expanded IRQ remapping fault */ enum
>>> +iommu_fault_type {
>>> +	IOMMU_FAULT_DMA_UNRECOV = 1,	/* unrecoverable fault */
>>> +	IOMMU_FAULT_PAGE_REQ,		/* page request fault */
>>> +};
>>> +
>>> +enum iommu_fault_reason {
>>> +	IOMMU_FAULT_REASON_CTX = 1,
>>
>> If I read the VT-d spec right, this is a fault encountered while fetching the PASID table
>> pointer?
>>
>>> +	IOMMU_FAULT_REASON_ACCESS,
>>
>> And this a pgd or pte access fault?
>>
>>> +	IOMMU_FAULT_REASON_INVALIDATE,
>>
>> What would this be?
>>
>>> +	IOMMU_FAULT_REASON_UNKNOWN,
>>> +};
>>
>> I'm currently doing the same exploratory work for virtio-iommu, and I'd be tempted
>> to report reasons as detailed as possible to guest or device driver, but it's not clear
>> what they need, how they would use this information. I'd like to discuss this some
>> more.
> 
> [Liu, Yi L] In fact, it's not necessary to pass the detailed unrecoverable fault to guest in
> virtualization case. Unrecoverable fault happened on native indicates fault during native
> IOMMU address translation. If the fault is not due to guest IOMMU page table setting,
> then it is not necessary to inject the fault to guest. And hypervisor should be able to
> deduce it by walking the guest IOMMU page table with the fault address.

I'm not sure the hypervisor should go and inspect the guest's page tables.
The pIOMMU already did the walk and reported the fault, so the hypervisor
knows that they are invalid. I thought VT-d and other pIOMMUs provide
enough information in the fault report to tell if the error was due to
invalid page tables?

> So I think for
> virtualization case, pass the fault address is enough. If hypervisor doesn't see any issue
> after checking the guest IOMMU translation hierarchy, no use to let guest know it. Hypervisor
> can either throw error log or stop the guest. If hypervisor see any error in the guest
> iommu translation hierarchy, then inject the error to guest with a proper fault type.>
> But for device driver or other user-space driver, I'm not sure if they need detailed fault
> info. In fact, it is enough to pass the possible info which would help them to deduce whether
> the unrecoverable fault is due to them. This need more inputs from device driver reviewers.

Agreed, though I'm not sure how to reach them.

At the moment, the only users of report_iommu_fault, the existing fault
reporting mechanism, are ARM-based IOMMU drivers and there are only four
device drivers that register a handler with iommu_set_fault_handler. Two
of them simply print the fault, one resets the offending device, and the
last one (msm GPU) wants to provide more detailed debugging information
about the device state.

>> For unrecoverable faults I guess CTX means "the host IOMMU driver is broken", since
>> the device tables are invalid. In which case there is no use continuing, trying to
>> shutdown the device cleanly is really all the guest/device driver can do.
> 
> [Liu, Yi L] Not sure about what device table mean here. But I agree that if host IOMMU
> driver has no valid CTX for the device, then this kind of error should result in a shutdown to
> the device.

Yes by device table I meant VT-d's root table and context tables.
>> For ACCESS the error is the device driver's or guest's fault, since the device driver
>> triggered DMA on unmapped buffers, or the guest didn't install the right page tables.
>> This can be repaired without shutting down, it may even just be one execution
>> stream that failed in the device while the others continued normally. It's not as
>> recoverable as a PRI Page Request, but the device driver may still be able to isolate
>> the problem (e.g. by killing the process responsible) and the device to recover from it.
>>
>> So maybe ACCESS would benefit from more details, for example differentiating
>> faults encountered while fetching the pgd from those encountered while fetching a
>> second-level table or pte. The former is a lot less recoverable than the latter (bug in
>> the guest IOMMU driver vs.
>> bug in the device driver).
>>
>> Generalizing this maybe we should differentiate each step of the translation in
>> fault_reason:
>>
>> * Device entry (context) fetch -> host IOMMU driver's fault
>> * PASID table fetch -> guest IOMMU driver or host userspace's fault
>> * pgd fetch -> guest IOMMU driver's fault
>> * pte fetch, including validity and access check -> device driver's fault
> 
> [Liu, Yi L] It's a good summary here. BTW. why pte fetch is due to device driver's fault?

Mmh, not necessarily the device driver's fault, but the most likely cause
is that the device driver didn't call map() before triggering the DMA.
Another less likely cause is a programming error in the vIOMMU driver,
where it failed to perform the map() or populate the page tables properly.

Thanks,
Jean
