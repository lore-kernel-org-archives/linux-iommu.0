From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 08/16] iommu: introduce device fault data
Date: Tue, 7 Nov 2017 11:38:50 +0000
Message-ID: <e95ce88b-7e88-5b1c-3a68-9ac40773a8f6@arm.com>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1507244624-39189-9-git-send-email-jacob.jun.pan@linux.intel.com>
	<439401c0-a9ff-a69a-dc10-12d72f7abbab@arm.com>
	<A2975661238FB949B60364EF0F2C257439AFC86D@SHSMSX104.ccr.corp.intel.com>
	<09d451dc-c0e9-1fa2-8f85-45a9b1185d48@arm.com>
	<A2975661238FB949B60364EF0F2C257439B06809@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <A2975661238FB949B60364EF0F2C257439B06809-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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

On 07/11/17 08:40, Liu, Yi L wrote:
[...]
>>>>> +
>>>>> +/*  Generic fault types, can be expanded IRQ remapping fault */
>>>>> +enum iommu_fault_type {
>>>>> +	IOMMU_FAULT_DMA_UNRECOV = 1,	/* unrecoverable fault */
>>>>> +	IOMMU_FAULT_PAGE_REQ,		/* page request fault */
>>>>> +};
>>>>> +
>>>>> +enum iommu_fault_reason {
>>>>> +	IOMMU_FAULT_REASON_CTX = 1,
>>>>
>>>> If I read the VT-d spec right, this is a fault encountered while
>>>> fetching the PASID table pointer?
>>>>
>>>>> +	IOMMU_FAULT_REASON_ACCESS,
>>>>
>>>> And this a pgd or pte access fault?
>>>>
>>>>> +	IOMMU_FAULT_REASON_INVALIDATE,
>>>>
>>>> What would this be?
>>>>
>>>>> +	IOMMU_FAULT_REASON_UNKNOWN,
>>>>> +};
>>>>
>>>> I'm currently doing the same exploratory work for virtio-iommu, and
>>>> I'd be tempted to report reasons as detailed as possible to guest or
>>>> device driver, but it's not clear what they need, how they would use
>>>> this information. I'd like to discuss this some more.
>>>
>>> [Liu, Yi L] In fact, it's not necessary to pass the detailed
>>> unrecoverable fault to guest in virtualization case. Unrecoverable
>>> fault happened on native indicates fault during native IOMMU address
>>> translation. If the fault is not due to guest IOMMU page table
>>> setting, then it is not necessary to inject the fault to guest. And hypervisor should
>> be able to deduce it by walking the guest IOMMU page table with the fault address.
>>
>> I'm not sure the hypervisor should go and inspect the guest's page tables.
> 
> [Liu, Yi L] I think hypervisor needs to do it to make sure reporting fault to guest
> correctly. If not, hypervisor may report some fault to guest and make guest
> confused. e.g. pIOMMU walks page table and failed during walking root table(VT-d)
> or device table(SMMU). such fault is due to no valid programming in host, guest
> has no duty on it and neither has knowledge to fix it. it would make guest to
> believe that it has programmed the root table or device table in the wrong way
> while the fact is not.
> 
>> The pIOMMU already did the walk and reported the fault, so the hypervisor knows
>> that they are invalid. I thought VT-d and other pIOMMUs provide enough
>> information in the fault report to tell if the error was due to invalid page tables?
> 
> [Liu, Yi L] yes, pIOMMU did walk and get the fault info, but it's not sure who is
> responsible to the fault. With inspecting the guest table, hypervisor may know who
> should be responsible to the fault.

The SMMU adds information about the origin of the fault in its reports,
for example:

* bad streamid, bad ste, ste fetch, stream disabled: the device tables are
invalid, and the SMMU wasn't able to reach the PASID table.
* bad substreamid, CD fetch, bad CD: the PASID tables are invalid, and the
SMMU wasn't able to reach the page directory.
* walk external abort, translation, addr size, access, permission: the
page tables are invalid

If the pIOMMU driver receives this kind of information already, walking
the page table won't tell us anything more. Wouldn't you get a similar
reason granularity on VT-d?

>>> So I think for
>>> virtualization case, pass the fault address is enough. If hypervisor
>>> doesn't see any issue after checking the guest IOMMU translation
>>> hierarchy, no use to let guest know it. Hypervisor can either throw
>>> error log or stop the guest. If hypervisor see any error in the guest
>>> iommu translation hierarchy, then inject the error to guest with a
>>> proper fault type.> But for device driver or other user-space driver,
>>> I'm not sure if they need detailed fault info. In fact, it is enough to pass the
>> possible info which would help them to deduce whether the unrecoverable fault is
>> due to them. This need more inputs from device driver reviewers.
>>
>> Agreed, though I'm not sure how to reach them.
> 
> [Liu, Yi L] I'd like to supplement my words here. Except the fault address, we may also
> need to provide the BDF and PASID if it is there.

I think the IOMMU should pass the struct device associated to the BDF to
the fault handler. The fault handler can then deduce the BDF from struct
device if it needs to. This also allows to support faults from non-PCI
devices, where the BDF or deviceID is specific to the IOMMU and doesn't
mean anything to the device driver.

I agree that we should provide the PASID if present.

>> At the moment, the only users of report_iommu_fault, the existing fault reporting
>> mechanism, are ARM-based IOMMU drivers and there are only four device drivers
>> that register a handler with iommu_set_fault_handler. Two of them simply print the
>> fault, one resets the offending device, and the last one (msm GPU) wants to provide
>> more detailed debugging information about the device state.
> 
> [Liu, Yi L] Well, it looks like device driver may not try to fix the fault, instead, it would
> more likely do kind of clean up after un-recoverable fault. If so, it may be enough to
> have a notification to device driver.

Yes, and reporting faulting address and PASID can help the device driver
decide what to do. For example a GPU driver might share the device between
multiple processes, and an unrecoverable fault might simply be that one of
the process tried to DMA outside its boundaries. In that case you'd want
to kill the process, not reset the device.

>>>> For unrecoverable faults I guess CTX means "the host IOMMU driver is
>>>> broken", since the device tables are invalid. In which case there is
>>>> no use continuing, trying to shutdown the device cleanly is really all the
>> guest/device driver can do.
>>>
>>> [Liu, Yi L] Not sure about what device table mean here. But I agree
>>> that if host IOMMU driver has no valid CTX for the device, then this
>>> kind of error should result in a shutdown to the device.
>>
>> Yes by device table I meant VT-d's root table and context tables.
> [Liu, Yi L] I see.
> 
>>>> For ACCESS the error is the device driver's or guest's fault, since
>>>> the device driver triggered DMA on unmapped buffers, or the guest didn't install
>> the right page tables.
>>>> This can be repaired without shutting down, it may even just be one
>>>> execution stream that failed in the device while the others continued
>>>> normally. It's not as recoverable as a PRI Page Request, but the
>>>> device driver may still be able to isolate the problem (e.g. by killing the process
>> responsible) and the device to recover from it.
>>>>
>>>> So maybe ACCESS would benefit from more details, for example
>>>> differentiating faults encountered while fetching the pgd from those
>>>> encountered while fetching a second-level table or pte. The former is
>>>> a lot less recoverable than the latter (bug in the guest IOMMU driver vs.
>>>> bug in the device driver).
>>>>
>>>> Generalizing this maybe we should differentiate each step of the
>>>> translation in
>>>> fault_reason:
>>>>
>>>> * Device entry (context) fetch -> host IOMMU driver's fault

Actually this could also be that the device simply isn't allowed to DMA,
so not necessarily the pIOMMU driver misprogramming its tables. So the
host IOMMU driver should notify the device driver when encountering an
invalid device entry, telling it to reset the device.

>>>> * PASID table fetch -> guest IOMMU driver or host userspace's fault

Another reason I missed before is "invalid PASID". This means that the
device driver used a PASID that wasn't reserved or that's outside of the
PASID table, so is really the device drivers's fault. It should probably
be distinguished from "pgd fetch error" below, which is the vIOMMU driver
misprogramming the PASID table.

>>>> * pgd fetch -> guest IOMMU driver's fault
>>>> * pte fetch, including validity and access check -> device driver's
>>>> fault
>>>
>>> [Liu, Yi L] It's a good summary here. BTW. why pte fetch is due to device driver's
>> fault?
>>
>> Mmh, not necessarily the device driver's fault, but the most likely cause is that the
>> device driver didn't call map() before triggering the DMA.
>> Another less likely cause is a programming error in the vIOMMU driver, where it
>> failed to perform the map() or populate the page tables properly.
> 
> [Liu, Yi L] Yes, I think for fault during iova(host iova or GPA) translation, the most likely
> reason would be no calling of map() since we are using synchronized map API.
> 
> Besides the four reasons you listed above, I think there is still other reasons like
> no present bit, invalid programming or so. And also, we have several tables which may
> be referenced in an address translation. e.g. VT-d, we have root table, CTX table, pasid
> table, translation page table(1st level, 2nd level). I think AMD-iommu and SMMU should
> have similar stuffs?

Yes but the four (now five) reasons listed above attempt to synthesize
these reasons into a vendor-agnostic format. For example what I called
"Invalid device entry" is "invalid root or ctx table" on VT-d, "Invalid
STE" on SMMU, "illegal dev table entry" on AMD.

Thanks,
Jean
