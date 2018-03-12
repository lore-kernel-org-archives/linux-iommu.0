From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v8 4/5] iommu/arm-smmu: Add the device_link between
	masters and smmu
Date: Mon, 12 Mar 2018 15:51:44 +0530
Message-ID: <CAFp+6iGPWxRVUjiTW34eDoce55HZ0Y8EcKMCSyfg2RnHuX0zMw@mail.gmail.com>
References: <20180302101050.6191-1-vivek.gautam@codeaurora.org>
	<20180302101050.6191-5-vivek.gautam@codeaurora.org>
	<f3011ef1-7ffe-8c2b-b9d6-3fb094789656@arm.com>
	<CAFp+6iF1oM=fmRCqSG-SxcUVvvOLet_Y0p7pmGn+=B-LdMNiww@mail.gmail.com>
	<CAFp+6iFzGYWZMLkNrN1ZJJ2xH4CxQsiU6oYboHDzL0jDwm+4VQ@mail.gmail.com>
	<f6822915-8921-c9cc-218a-f094ac5ed032@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <f6822915-8921-c9cc-218a-f094ac5ed032-5wv7dgnIgG8@public.gmane.org>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, robh+dt <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 9, 2018 at 6:04 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> On 09/03/18 07:11, Vivek Gautam wrote:
>>
>> On Thu, Mar 8, 2018 at 10:29 AM, Vivek Gautam
>> <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>>>
>>> On Wed, Mar 7, 2018 at 6:17 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>>> wrote:
>>>>
>>>> On 02/03/18 10:10, Vivek Gautam wrote:
>>>>>
>>>>>
>>>>> From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>>>>
>>>>> Finally add the device link between the master device and
>>>>> smmu, so that the smmu gets runtime enabled/disabled only when the
>>>>> master needs it. This is done from add_device callback which gets
>>>>> called once when the master is added to the smmu.
>>>>>
>>>>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>>>> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>>>> ---
>>>>>    drivers/iommu/arm-smmu.c | 21 +++++++++++++++++++++
>>>>>    1 file changed, 21 insertions(+)
>>>>>
>>>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>>>> index 3d6a1875431f..bb1ea82c1003 100644
>>>>> --- a/drivers/iommu/arm-smmu.c
>>>>> +++ b/drivers/iommu/arm-smmu.c
>>>>> @@ -217,6 +217,9 @@ struct arm_smmu_device {
>>>>>          /* IOMMU core code handle */
>>>>>          struct iommu_device             iommu;
>>>>> +
>>>>> +       /* runtime PM link to master */
>>>>> +       struct device_link *link;
>>>>
>>>>
>>>>
>>>> Just the one?
>>
>>
>> we will either have to count all the devices that are present on the
>> iommu bus, or
>> maintain a list to which all the links can be added.
>> But to add the list, we will have to initialize a LIST_HEAD in struct
>> device_link
>> as well.
>>
>> Or, I think we don't even need to maintain a pointer to link with smmu.
>> In arm_smmu_remove_device(), we can find out the correct link, and delete
>> it.
>>
>>          list_for_each_entry(link, &dev->links.suppliers, c_node)
>>                  if (link->supplier == smmu->dev);
>>                             device_link_del(link);
>>
>> Should that be fine?
>>
>> Rafael, does the above snippet looks right to you? Context: smmu->dev
>> is the supplier, and dev is the consumer. We want to find the link,
>> and delete it.
>
>
> Actually, looking at the existing code, it seems like device_link_add() will
> in fact look up and return any existing link between a given supplier and
> consumer - is that intentional API behaviour that users may rely on to avoid
> keeping track of explicit link pointers?
> (or conversely, might it be
> reasonable to factor out a device_link_find() function?)

Yea, that sounds better.

regards
Vivek

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
