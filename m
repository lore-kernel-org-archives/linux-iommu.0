From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v9 1/5] driver core: Find an existing link between two
	devices
Date: Tue, 13 Mar 2018 20:09:09 +0530
Message-ID: <CAFp+6iGaAbXOj2hXf12oQzi57J2DX+13f86oprOezyF8rkeyNg@mail.gmail.com>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
	<20180313085534.11650-2-vivek.gautam@codeaurora.org>
	<8903307.QazHKW0JrR@aspire.rjw.lan>
	<CAFp+6iE=0PD6fZZVd+bC1Z95Lkt=X-F4YOXz8EtdiXL=jsC1RA@mail.gmail.com>
	<4eaf2006-ea68-d9e9-a0db-89acec0ea299@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4eaf2006-ea68-d9e9-a0db-89acec0ea299-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, robh+dt <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,


On Tue, Mar 13, 2018 at 6:19 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> On 13/03/18 09:55, Vivek Gautam wrote:
>>
>> On Tue, Mar 13, 2018 at 3:10 PM, Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
>> wrote:
>>>
>>> On Tuesday, March 13, 2018 9:55:30 AM CET Vivek Gautam wrote:
>>>>
>>>> The lists managing the device-links can be traversed to
>>>> find the link between two devices. The device_link_add() APIs
>>>> does traverse these lists to check if there's already a link
>>>> setup between the two devices.
>>>> So, add a new APIs, device_link_find(), to find an existing
>>>> device link between two devices - suppliers and consumers.
>>>>
>>>> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>>> Cc: Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
>>>> Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
>>>> ---
>>>>
>>>>   * New patch added to this series.
>>>>
>>>>   drivers/base/core.c    | 30 +++++++++++++++++++++++++++---
>>>>   include/linux/device.h |  2 ++
>>>>   2 files changed, 29 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>>> index 5847364f25d9..e8c9774e4ba2 100644
>>>> --- a/drivers/base/core.c
>>>> +++ b/drivers/base/core.c
>>>> @@ -144,6 +144,30 @@ static int device_reorder_to_tail(struct device
>>>> *dev, void *not_used)
>>>>        return 0;
>>>>   }
>>>>
>>>> +/**
>>>> + * device_link_find - find any existing link between two devices.
>>>> + * @consumer: Consumer end of the link.
>>>> + * @supplier: Supplier end of the link.
>>>> + *
>>>> + * Returns pointer to the existing link between a supplier and
>>>> + * and consumer devices, or NULL if no link exists.
>>>> + */
>>>> +struct device_link *device_link_find(struct device *consumer,
>>>> +                                  struct device *supplier)
>>>> +{
>>>> +     struct device_link *link = NULL;
>>>> +
>>>> +     if (!consumer || !supplier)
>>>> +             return NULL;
>>>> +
>>>> +     list_for_each_entry(link, &supplier->links.consumers, s_node)
>>>> +             if (link->consumer == consumer)
>>>> +                     break;
>>>> +
>>>
>>>
>>> Any mutual exclusion?
>>>
>>> Or is the caller expected to take care of it?  And if so, then how?
>>
>>
>> I think it's better that we take care of lock here in the code rather
>> than depending
>> on the caller.
>> But i can't take device_links_write_lock() since device_link_add()
>> already takes that.
>
>
> Well, the normal pattern is to break out the internal helper function as-is,
> then add a public wrapper which validates inputs, handles locking, etc.,
> equivalently to existing caller(s). See what device_link_del() and others
> do, e.g.:
>
> static struct device_link *__device_link_find(struct device *consumer,
>                 struct device *supplier)
> {
>         list_for_each_entry(link, &supplier->links.consumers, s_node)
>                 if (link->consumer == consumer)
>                         return link;
>         return NULL;
> }
>
> struct device_link *device_link_find(struct device *consumer,
>                 struct device *supplier)
> {
>         struct device_link *link;
>
>         if (!consumer || !supplier)
>                 return NULL;
>
>         device_links_write_lock();
>         link = __device_link_find(consumer, supplier);
>         device_links_write_unlock();
>         return link;
> }
>
> where device_link_add() would call __device_link_find() directly.

Right, I understand it now. Thanks for detailed explanation.

regards
Vivek

>
> However, as Tomasz points out (and I hadn't really considered), if the only
> reasonable thing to with a link once you've found it is to delete it, then
> in terms of the public API it may well make more sense to just implement
> something like a device_link_remove() which does both in one go.
>
> Robin.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
