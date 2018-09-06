From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 13/23] iommu: introduce device fault report API
Date: Thu, 6 Sep 2018 18:06:37 +0100
Message-ID: <289610e3-2633-e448-259c-194e6f2c2b52@arm.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1526072055-86990-14-git-send-email-jacob.jun.pan@linux.intel.com>
	<2094d667-5dbf-b4b8-8e19-c76d67b82362@redhat.com>
	<e19eb88b-b24b-66bc-8d5b-6196b26f1456@arm.com>
	<9013df5a-02f9-55b8-eb5e-fad4be0a2c92@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <9013df5a-02f9-55b8-eb5e-fad4be0a2c92-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Raj Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 06/09/2018 14:14, Auger Eric wrote:
> Hi Jean-Philippe,
> 
> On 09/06/2018 02:42 PM, Jean-Philippe Brucker wrote:
>> On 06/09/2018 10:25, Auger Eric wrote:
>>>> +		mutex_lock(&fparam->lock);
>>>> +		list_add_tail(&evt_pending->list, &fparam->faults);
>>> same doubt as Yi Liu. You cannot rely on the userspace willingness to
>>> void the queue and deallocate this memory.
> 
> By the way I saw there is a kind of garbage collectors for faults which
> wouldn't have received any responses. However I am not sure this removes
> the concern of having the fault list on kernel side growing beyond
> acceptable limits.

How about per-device quotas? (https://lkml.org/lkml/2018/4/23/706 for
reference) With PRI the IOMMU driver already sets per-device credits
when initializing the device (pci_enable_pri), so if the device behaves
properly it shouldn't send new page requests once the number of
outstanding ones is maxed out.

The stall mode of SMMU doesn't have per-device limit, and depending on
the implementation it might be easy for one guest using stall to prevent
other guests from receiving faults. For this reason we'll have to
enforce a per-device stall quota in the SMMU driver, and immediately
terminate faults that exceed this quota. We could easily do the same for
PRI, if we don't trust devices to follow the spec. The difficult part is
finding the right number of credits...

>> Host device drivers that use this API to be notified on fault can't deal
>> with arch-specific event formats (SMMU event, Vt-d fault event, etc), so
>> the APIs should be arch-agnostic. Given that requirement, using a single
>> iommu_fault_event structure for both PRI and event queues made sense,
>> especially since the even queue can have stall events that look a lot
>> like PRI page requests.
> I understand the data structure needs to be generic. Now I guess PRI
> events and other standard translator error events (that can happen
> without PRI) may have different characteristics in event fields,

Right, an event contains more information than a PRI page request.
Stage-2 fields (CLASS, S2, IPA, TTRnW) cannot be represented by
iommu_fault_event at the moment. For precise emulation it might be
useful to at least add the S2 flag (as a new iommu_fault_reason?), so
that when the guest maps stage-1 to an invalid GPA, QEMU could for
example inject an external abort.

> queue
> size, that may deserve to create different APIs and internal data
> structs. Also this may help separating the concerns.

It might duplicate them. If the consumer of the event report is a host
device driver, the SMMU needs to report a "generic" iommu_fault_event,
and if the consumer is VFIO it would report a specialized one

> My remark also
> stems from the fact the SMMU uses 2 different queues, whose size can
> also be different.

Hm, for PRI requests the kernel-userspace queue size should actually be
the number of PRI credits for that device. Hadn't thought about it
before, where do we pass that info to userspace? For fault events, the
queue could be as big as the SMMU event queue, though using all that
space might be wasteful. Non-stalled events should be rare and reporting
them isn't urgent. Stalled ones would need the number of stall credits I
mentioned above, which realistically will be a lot less than the SMMU
event queue size. Given that a device will use either PRI or stall but
not both, I still think events and PRI could go through the same queue.

Thanks,
Jean
