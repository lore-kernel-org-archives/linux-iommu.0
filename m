From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 08/16] iommu: introduce device fault data
Date: Fri, 10 Nov 2017 13:54:59 +0000
Message-ID: <0ed3e52b-2ca7-e378-817b-34b517a392da@arm.com>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1507244624-39189-9-git-send-email-jacob.jun.pan@linux.intel.com>
	<439401c0-a9ff-a69a-dc10-12d72f7abbab@arm.com>
	<A2975661238FB949B60364EF0F2C257439AFC86D@SHSMSX104.ccr.corp.intel.com>
	<09d451dc-c0e9-1fa2-8f85-45a9b1185d48@arm.com>
	<A2975661238FB949B60364EF0F2C257439B06809@SHSMSX104.ccr.corp.intel.com>
	<e95ce88b-7e88-5b1c-3a68-9ac40773a8f6@arm.com>
	<20171109113629.6a9251a4@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171109113629.6a9251a4@jacob-builder>
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
Cc: "Lan, Tianyu" <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Wysocki,
	Rafael J" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 09/11/17 19:36, Jacob Pan wrote:
> On Tue, 7 Nov 2017 11:38:50 +0000
> Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:
> 
>> I think the IOMMU should pass the struct device associated to the BDF
>> to the fault handler. The fault handler can then deduce the BDF from
>> struct device if it needs to. This also allows to support faults from
>> non-PCI devices, where the BDF or deviceID is specific to the IOMMU
>> and doesn't mean anything to the device driver.
>>
> Passing struct device is only useful if we use shared fault
> notification method, as I did in V1 patch with group level or current
> domain level.
> 
> But the patch proposed here is a per device callback, there is no need
> for passing struct device since it is implied.

Sorry I had lost sight of the original patch in this thread. I think the
callback is fine as it is, in your patch:

typedef int (*iommu_dev_fault_handler_t)(struct device *, struct
iommu_fault_event *);

But iommu_fault_event doesn't need an BDF/RID. It doesn't mean anything
outside of PCI, and a PCI driver can retrieve it easily from
pdev->bus->number and pdev->devfn, if it does need it.

>> I agree that we should provide the PASID if present.
>>
>>  [...]  
>>
>> Yes, and reporting faulting address and PASID can help the device
>> driver decide what to do. For example a GPU driver might share the
>> device between multiple processes, and an unrecoverable fault might
>> simply be that one of the process tried to DMA outside its
>> boundaries. In that case you'd want to kill the process, not reset
>> the device.
>>
>>  [...]  
>>
>> Actually this could also be that the device simply isn't allowed to
>> DMA, so not necessarily the pIOMMU driver misprogramming its tables.
>> So the host IOMMU driver should notify the device driver when
>> encountering an invalid device entry, telling it to reset the device.
>>
>>>>>> * PASID table fetch -> guest IOMMU driver or host userspace's
>>>>>> fault  
>>
>> Another reason I missed before is "invalid PASID". This means that the
>> device driver used a PASID that wasn't reserved or that's outside of
>> the PASID table, so is really the device drivers's fault. It should
>> probably be distinguished from "pgd fetch error" below, which is the
>> vIOMMU driver misprogramming the PASID table.
>>
>>>>>> * pgd fetch -> guest IOMMU driver's fault
>>>>>> * pte fetch, including validity and access check -> device
>>>>>> driver's fault  
>>  [...]  
>>>
>>> [Liu, Yi L] Yes, I think for fault during iova(host iova or GPA)
>>> translation, the most likely reason would be no calling of map()
>>> since we are using synchronized map API.
>>>
>>> Besides the four reasons you listed above, I think there is still
>>> other reasons like no present bit, invalid programming or so. And
>>> also, we have several tables which may be referenced in an address
>>> translation. e.g. VT-d, we have root table, CTX table, pasid table,
>>> translation page table(1st level, 2nd level). I think AMD-iommu and
>>> SMMU should have similar stuffs?  
>>
>> Yes but the four (now five) reasons listed above attempt to synthesize
>> these reasons into a vendor-agnostic format. For example what I called
>> "Invalid device entry" is "invalid root or ctx table" on VT-d,
>> "Invalid STE" on SMMU, "illegal dev table entry" on AMD.
> 
> For reporting purposes, I think we only need to care about the reasons
> that are interesting outside IOMMU subsystem. e.g. invalid root/ctx
> programming are solely responsible by IOMMU driver, there is no need to
> include that in the fault reporting data.

Yes you're probably right. Above I was thinking about non-existing CTX
entry, if we forbid the device to perform any DMA and we don't install an
entry in the device tables. But for the same cost we can simply install a
valid CTX entry pointing to empty PASID or page tables, in which case we
would report faults to the device driver, so that case is irrelevant.

> Could you provide more specific proposals to the fault event? perhaps
> i have missed it somewhere.

I had a proposal in my fault handler patch, but that was before thinking
about non-recoverable faults so it's incomplete:

https://patchwork.kernel.org/patch/9989315/ "struct iommu_fault" is
similar to your iommu_fault_event, but a bit more generic to work with
both PCI PRI and the SMMU Stall model:

* For stall, faults are not grouped in a PRG, so I added the
  IOMMU_FAULT_GROUP flag. Thinking about this more, I think we can just
  ask stall users to always set the "last" flag and we can get rid of
  that group flag.

* Stall faults don't have a PRGI, but something called "stall tag" which
  is pretty much the same as the PRGI, except it's 16 bits instead of 9
  (and it represents a single fault instead of a group).

>  * @type contains fault type.
>  * @reason fault reasons if relevant outside IOMMU driver, IOMMU driver internal
>  *         faults are not reported
>  * @paddr: tells the offending page address

Maybe just "addr", since paddr is easily confused with "physical address".

>  * @pasid: contains process address space ID, used in shared virtual memory(SVM)
>  * @rid: requestor ID
>  * @page_req_group_id: page request group index
>  * @last_req: last request in a page request group
>  * @pasid_valid: indicates if the PRQ has a valid PASID
>  * @prot: page access protection flag, e.g. IOMMU_READ, IOMMU_WRITE

Should we also extend the prot flags then? PRI needs IOMMU_EXEC,
IOMMU_PRIVILEGED. The problem with IOMMU_READ and IOMMU_WRITE is that it's
not a bitfield, you can't OR values together. In order to extend it we
need to change the value of IOMMU_READ to be 1 and IOMMU_WRITE to be 2.
In PRI there is a case where R=W=0 (the PASID Stop marker), and we can't
represent it with the existing IOMMU_READ value.

>  * @private_data: uniquely identify device-specific private data for an
>  *                individual page request

We should specify how private_data is used by IOMMU driver and device
driver, for people not familiar with VT-d. Since it's device-specific,
is the device driver allowed to parse this field, is it allowed to
modify it before sending it back via iommu_page_response?

For SMMU I've been abusing the private_data field to store SMMU-specific
flags that can be used by the page_response handler to know how to send
send the response:

* Whether the fault was PRI or stall (the response command is different)
* Whether the PRG response needs a PASID prefix or not. That's just a
  lazy shortcut and the property could be obtained differently.

I now think that these should be in a separate iommu_private field, to
make it reusable in the future.

>  */
> struct iommu_fault_event {
> 	enum iommu_fault_type type;
> 	enum iommu_fault_reason reason;
> 	u64 paddr;
> 	u32 pasid;
> 	u32 rid:16;
> 	u32 page_req_group_id : 9;
> 	u32 last_req : 1;
> 	u32 pasid_valid : 1;
> 	u32 prot;
> 	u32 private_data;
> };


To summarize, combining everything discussed so far I propose the
following definitions:

#define IOMMU_READ	(1 << 0)
#define IOMMU_WRITE	(1 << 1)
#define IOMMU_EXEC	(1 << 2)
#define IOMMU_PRIV	(1 << 3)

/*  Generic fault types, can be expanded for IRQ remapping fault */
enum iommu_fault_type {
	IOMMU_FAULT_DMA_UNRECOV = 1,	/* unrecoverable fault */
	IOMMU_FAULT_PAGE_REQ,		/* page request fault */
};

/*
 * Note: I tried to synthesize what I believe would be useful to device
 * drivers and guests, with regards to the kind of faults that the ARM
 * SMMU is capable of reporting. Other IOMMUs may report more or less
 * fault reasons, and I guess one should try to associate the faults
 * reason that matches best a generic one when reporting a fault.
 *
 * Finer reason granularity is probably not useful to anyone, and
 * coarser granularity would require more work from intermediate
 * components processing the fault to figure out what happened, whose
 * fault it actually is and where to route it (process vs. device driver
 * vs. vIOMMU driver misprogamming tables).
 */
enum iommu_fault_reason {
	IOMMU_FAULT_REASON_UNKNOWN = 0,

	/* Could not access the PASID table */
	IOMMU_FAULT_REASON_PASID_FETCH,

	/*
	 * PASID is out of range (e.g. exceeds the maximum PASID
	 * supported by the IOMMU) or disabled.
	 */
	IOMMU_FAULT_REASON_PASID_INVALID,

	/* Could not access the page directory (Invalid PASID entry) */
	IOMMU_FAULT_REASON_PGD_FETCH,

	/* Could not access the page table entry (Bad address) */
	IOMMU_FAULT_REASON_PTE_FETCH,

	/* Protection flag check failed */
	IOMMU_FAULT_REASON_PERMISSION,
};

/*
 * @type: contains the fault type
 * @reason: fault reasons if relevant outside IOMMU driver, IOMMU driver
 *          internal faults are not reported
 * @addr: the offending page address
 * @pasid: contains the process address space ID, if pasid_valid is set
 * @id: contains the PRGI for PCI PRI, or a tag unique to the faulting
 *      device identifying the fault.
 * @last_req: last request in a page request group. A page response is
 *            required for any page request with a 'last_req' flag set.
 * @pasid_valid: the pasid field is valid
 * @prot: page access protection, e.g. IOMMU_READ, IOMMU_WRITE
 * @device_private: if present, uniquely identify device-specific
 *                  private data for an individual page request.
 * @iommu_private: used by the IOMMU driver for storing fault-specific
 *                 data. Users should not modify this field before
 *                 sending the fault response.
 */
struct iommu_fault_event {
	enum iommu_fault_type type;
	enum iommu_fault_reason reason;
	u64 addr;
	u32 pasid;
	u32 id;
	u32 last_req : 1;
	u32 pasid_valid : 1;
	u32 prot;
	u64 device_private;
	u64 iommu_private;
};

Thanks,
Jean
