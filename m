From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v5 13/23] iommu: introduce device fault report API
Date: Thu, 6 Sep 2018 15:14:25 +0200
Message-ID: <9013df5a-02f9-55b8-eb5e-fad4be0a2c92@redhat.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1526072055-86990-14-git-send-email-jacob.jun.pan@linux.intel.com>
 <2094d667-5dbf-b4b8-8e19-c76d67b82362@redhat.com>
 <e19eb88b-b24b-66bc-8d5b-6196b26f1456@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e19eb88b-b24b-66bc-8d5b-6196b26f1456@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Williamson <alex.williamson@redhat.com>
Cc: Jean Delvare <khali@linux-fr.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Raj Ashok <ashok.raj@intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi Jean-Philippe,

On 09/06/2018 02:42 PM, Jean-Philippe Brucker wrote:
> On 06/09/2018 10:25, Auger Eric wrote:
>>> +		mutex_lock(&fparam->lock);
>>> +		list_add_tail(&evt_pending->list, &fparam->faults);
>> same doubt as Yi Liu. You cannot rely on the userspace willingness to
>> void the queue and deallocate this memory.

By the way I saw there is a kind of garbage collectors for faults which
wouldn't have received any responses. However I am not sure this removes
the concern of having the fault list on kernel side growing beyond
acceptable limits.
>>
>> SMMUv3 holds a queue of events whose size is implementation dependent.
>> I think such a queue should be available at SW level and its size should
>> be negotiated.
> 
> Note that this fault API can also be used by host device drivers that
> want to be notified on fault, in which case a direct callback seems
> easier to use, and perhaps more efficient than an intermediate queue.

> 
> When injecting faults into userspace it makes sense to batch events, to
> avoid context switches. Even though that queue management should
> probably be done by VFIO, the IOMMU API has to help in some way, at
> least to tell VFIO when the IOMMU driver is done processing a batch of
> event.
Yes I am currently investigating the usage of a kfifo in
vfio_iommu_type1, filled by the direct callback.
> 
>> Note SMMU has separate queues for PRI and fault events. Here you use the
>> same queue for all events. I don't know if it would make sense to have
>> separate APIs?
> 
> Host device drivers that use this API to be notified on fault can't deal
> with arch-specific event formats (SMMU event, Vt-d fault event, etc), so
> the APIs should be arch-agnostic. Given that requirement, using a single
> iommu_fault_event structure for both PRI and event queues made sense,
> especially since the even queue can have stall events that look a lot
> like PRI page requests.
I understand the data structure needs to be generic. Now I guess PRI
events and other standard translator error events (that can happen
without PRI) may have different characteristics in event fields, queue
size, that may deserve to create different APIs and internal data
structs. Also this may help separating the concerns. My remark also
stems from the fact the SMMU uses 2 different queues, whose size can
also be different.

Thanks

Eric
> 
> Or do you mean separate APIs for recoverable and non-recoverable faults?
> Using the same queue for PRI and stall event, and a separate one for
> non-recoverable events?
> 
> Separate queues may be useful for the device driver scenario
> (non-virtualization), where recoverable faults are handled by
> io-pgfaults while non-recoverable ones could be reported directly to the
> device driver. For this case I was thinking of adding a
> multiple-consumer thing: both io-pgfaults and the device driver register
> a fault handler. io-pgfault handles recoverable ones and what's left
> goes to the device driver. This could also allow the device driver to be
> notified when io-pgfault doesn't successfully handle a fault
> (handle_mm_fault returns an error).
> 
> Thanks,
> Jean
> 
