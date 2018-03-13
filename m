From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v9 1/5] driver core: Find an existing link between two
	devices
Date: Tue, 13 Mar 2018 15:25:18 +0530
Message-ID: <CAFp+6iE=0PD6fZZVd+bC1Z95Lkt=X-F4YOXz8EtdiXL=jsC1RA@mail.gmail.com>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
	<20180313085534.11650-2-vivek.gautam@codeaurora.org>
	<8903307.QazHKW0JrR@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <8903307.QazHKW0JrR-yvgW3jdyMHm1GS7QM15AGw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, " <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, robh+dt <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 13, 2018 at 3:10 PM, Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> wrote:
> On Tuesday, March 13, 2018 9:55:30 AM CET Vivek Gautam wrote:
>> The lists managing the device-links can be traversed to
>> find the link between two devices. The device_link_add() APIs
>> does traverse these lists to check if there's already a link
>> setup between the two devices.
>> So, add a new APIs, device_link_find(), to find an existing
>> device link between two devices - suppliers and consumers.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> Cc: Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
>> Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
>> ---
>>
>>  * New patch added to this series.
>>
>>  drivers/base/core.c    | 30 +++++++++++++++++++++++++++---
>>  include/linux/device.h |  2 ++
>>  2 files changed, 29 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 5847364f25d9..e8c9774e4ba2 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -144,6 +144,30 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
>>       return 0;
>>  }
>>
>> +/**
>> + * device_link_find - find any existing link between two devices.
>> + * @consumer: Consumer end of the link.
>> + * @supplier: Supplier end of the link.
>> + *
>> + * Returns pointer to the existing link between a supplier and
>> + * and consumer devices, or NULL if no link exists.
>> + */
>> +struct device_link *device_link_find(struct device *consumer,
>> +                                  struct device *supplier)
>> +{
>> +     struct device_link *link = NULL;
>> +
>> +     if (!consumer || !supplier)
>> +             return NULL;
>> +
>> +     list_for_each_entry(link, &supplier->links.consumers, s_node)
>> +             if (link->consumer == consumer)
>> +                     break;
>> +
>
> Any mutual exclusion?
>
> Or is the caller expected to take care of it?  And if so, then how?

I think it's better that we take care of lock here in the code rather
than depending
on the caller.
But i can't take device_links_write_lock() since device_link_add()
already takes that.

regards
Vivek

>
>> +     return link;
>> +}
>> +EXPORT_SYMBOL_GPL(device_link_find);
>> +
>>  /**
>>   * device_link_add - Create a link between two devices.
>>   * @consumer: Consumer end of the link.
>> @@ -195,9 +219,9 @@ struct device_link *device_link_add(struct device *consumer,
>>               goto out;
>>       }
>>
>> -     list_for_each_entry(link, &supplier->links.consumers, s_node)
>> -             if (link->consumer == consumer)
>> -                     goto out;
>> +     link = device_link_find(consumer, supplier);
>> +     if (link)
>> +             goto out;
>>
>>       link = kzalloc(sizeof(*link), GFP_KERNEL);
>>       if (!link)
>> diff --git a/include/linux/device.h b/include/linux/device.h
>> index b093405ed525..13bc1884c3eb 100644
>> --- a/include/linux/device.h
>> +++ b/include/linux/device.h
>> @@ -1278,6 +1278,8 @@ extern const char *dev_driver_string(const struct device *dev);
>>  struct device_link *device_link_add(struct device *consumer,
>>                                   struct device *supplier, u32 flags);
>>  void device_link_del(struct device_link *link);
>> +struct device_link *device_link_find(struct device *consumer,
>> +                                  struct device *supplier);
>>
>>  #ifdef CONFIG_PRINTK
>>
>>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
