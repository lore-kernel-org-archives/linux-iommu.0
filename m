From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 08/16] iommu: introduce device fault data
Date: Mon, 13 Nov 2017 13:06:24 +0000
Message-ID: <d9df78f3-6fed-f09b-88d5-5ff765ff5fd9@arm.com>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1507244624-39189-9-git-send-email-jacob.jun.pan@linux.intel.com>
	<439401c0-a9ff-a69a-dc10-12d72f7abbab@arm.com>
	<A2975661238FB949B60364EF0F2C257439AFC86D@SHSMSX104.ccr.corp.intel.com>
	<09d451dc-c0e9-1fa2-8f85-45a9b1185d48@arm.com>
	<A2975661238FB949B60364EF0F2C257439B06809@SHSMSX104.ccr.corp.intel.com>
	<e95ce88b-7e88-5b1c-3a68-9ac40773a8f6@arm.com>
	<20171109113629.6a9251a4@jacob-builder>
	<0ed3e52b-2ca7-e378-817b-34b517a392da@arm.com>
	<20171110141803.78eca80b@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171110141803.78eca80b@jacob-builder>
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

On 10/11/17 22:18, Jacob Pan wrote:
> On Fri, 10 Nov 2017 13:54:59 +0000
> Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:
> 
>> On 09/11/17 19:36, Jacob Pan wrote:
>>> On Tue, 7 Nov 2017 11:38:50 +0000
>>> Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:
>>>   
>>>> I think the IOMMU should pass the struct device associated to the
>>>> BDF to the fault handler. The fault handler can then deduce the
>>>> BDF from struct device if it needs to. This also allows to support
>>>> faults from non-PCI devices, where the BDF or deviceID is specific
>>>> to the IOMMU and doesn't mean anything to the device driver.
>>>>  
>>> Passing struct device is only useful if we use shared fault
>>> notification method, as I did in V1 patch with group level or
>>> current domain level.
>>>
>>> But the patch proposed here is a per device callback, there is no
>>> need for passing struct device since it is implied.  
>>
>> Sorry I had lost sight of the original patch in this thread. I think
>> the callback is fine as it is, in your patch:
>>
>> typedef int (*iommu_dev_fault_handler_t)(struct device *, struct
>> iommu_fault_event *);
>>
> I should have removed struct device here also. thanks for pointing it
> out.

Why remove it? The device driver will use a single C function as fault
handler for multiple devices, so it needs struct device argument to
understand the context.

[...]
>>>  * @pasid: contains process address space ID, used in shared
>>> virtual memory(SVM)
>>>  * @rid: requestor ID
>>>  * @page_req_group_id: page request group index
>>>  * @last_req: last request in a page request group
>>>  * @pasid_valid: indicates if the PRQ has a valid PASID
>>>  * @prot: page access protection flag, e.g. IOMMU_READ,
>>> IOMMU_WRITE  
>>
>> Should we also extend the prot flags then? PRI needs IOMMU_EXEC,
>> IOMMU_PRIVILEGED. The problem with IOMMU_READ and IOMMU_WRITE is that
>> it's not a bitfield, you can't OR values together. In order to extend
>> it we need to change the value of IOMMU_READ to be 1 and IOMMU_WRITE
>> to be 2. In PRI there is a case where R=W=0 (the PASID Stop marker),
>> and we can't represent it with the existing IOMMU_READ value.
>>
> don't we already have these in bit field? IOMMU_PRIV included. see
> include/linux/iommu.h
> #define IOMMU_READ	(1 << 0)
> #define IOMMU_WRITE	(1 << 1)
> #define IOMMU_CACHE	(1 << 2) /* DMA cache coherency */
> #define IOMMU_NOEXEC	(1 << 3)
> #define IOMMU_MMIO	(1 << 4) /* e.g. things like MSI doorbells */
> #define IOMMU_PRIV	(1 << 5)
> #define IOMMU_EXEC	(1 << 6)

Ah right, I was talking about IOMMU_FAULT_READ and IOMMU_FAULT_WRITE,
sorry for the confusion. These flags are for creating mappings, they
aren't really appropriate for fault reporting. What would the new
IOMMU_EXEC flag mean in the context of iommu_map, which is already using
IOMMU_NOEXEC (1 << 3)? What would IOMMU_CACHE and IOMMU_MMIO mean for
fault reporting? It's probably easier to use a distinct set of flags for
faults, by rewriting the IOMMU_FAULT_* flags.

>>>  * @private_data: uniquely identify device-specific private data
>>> for an
>>>  *                individual page request  
>>
>> We should specify how private_data is used by IOMMU driver and device
>> driver, for people not familiar with VT-d. Since it's device-specific,
>> is the device driver allowed to parse this field, is it allowed to
>> modify it before sending it back via iommu_page_response?
>>
> shall we say the private_data is iommu supplied device specific
> data, this data is only to be interpreted by the device driver or
> hardware.

That would work

>> For SMMU I've been abusing the private_data field to store
>> SMMU-specific flags that can be used by the page_response handler to
>> know how to send send the response:
>>
>> * Whether the fault was PRI or stall (the response command is
>> different)
>> * Whether the PRG response needs a PASID prefix or not. That's just a
>>   lazy shortcut and the property could be obtained differently.
>>
> can you use pasid_valid bit for it?

What I'm referring to is the "PRG Response PASID Required" bit in the PCI
PRI capability, which is needed for the PRI response. I could dig it back
from the struct device passed to the page response handler, but caching it
in the private flags was more convenient. However I think I can get rid of
the other flag PRI/stall by simply looking if struct device is a PCI dev.
So we don't need iommu_private for the moment.

Thanks,
Jean
