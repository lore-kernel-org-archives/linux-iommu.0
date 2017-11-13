From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 08/16] iommu: introduce device fault data
Date: Mon, 13 Nov 2017 17:23:14 +0000
Message-ID: <0f500cee-77ea-4dc7-0ee2-3a0fe06e4b1b@arm.com>
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
	<d9df78f3-6fed-f09b-88d5-5ff765ff5fd9@arm.com>
	<20171113085726.237b7a07@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171113085726.237b7a07@jacob-builder>
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

On 13/11/17 16:57, Jacob Pan wrote:
> On Mon, 13 Nov 2017 13:06:24 +0000
> Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:
> 
>> On 10/11/17 22:18, Jacob Pan wrote:
>>> On Fri, 10 Nov 2017 13:54:59 +0000
>>> Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:
>>>   
>>>> On 09/11/17 19:36, Jacob Pan wrote:  
>>>>> On Tue, 7 Nov 2017 11:38:50 +0000
>>>>> Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:
>>>>>     
>>>>>> I think the IOMMU should pass the struct device associated to the
>>>>>> BDF to the fault handler. The fault handler can then deduce the
>>>>>> BDF from struct device if it needs to. This also allows to
>>>>>> support faults from non-PCI devices, where the BDF or deviceID
>>>>>> is specific to the IOMMU and doesn't mean anything to the device
>>>>>> driver. 
>>>>> Passing struct device is only useful if we use shared fault
>>>>> notification method, as I did in V1 patch with group level or
>>>>> current domain level.
>>>>>
>>>>> But the patch proposed here is a per device callback, there is no
>>>>> need for passing struct device since it is implied.    
>>>>
>>>> Sorry I had lost sight of the original patch in this thread. I
>>>> think the callback is fine as it is, in your patch:
>>>>
>>>> typedef int (*iommu_dev_fault_handler_t)(struct device *, struct
>>>> iommu_fault_event *);
>>>>  
>>> I should have removed struct device here also. thanks for pointing
>>> it out.  
>>
>> Why remove it? The device driver will use a single C function as fault
>> handler for multiple devices, so it needs struct device argument to
>> understand the context.
>>
> I meant to replace struct device * with just a void *, driver can
> register fault callback with instance of their private data, this could
> be a container struct of struct device.
> e.g.
> int iommu_register_device_fault_handler(struct device *dev,
> 				iommu_dev_fault_handler_t handler, void
> 				*data);
> 
> typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault_event *, void *);

Ah I see. Yes that should work

Thanks,
Jean
