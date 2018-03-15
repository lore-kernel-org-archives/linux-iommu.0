From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v9 4/5] iommu/arm-smmu: Add the device_link between
	masters and smmu
Date: Thu, 15 Mar 2018 11:12:06 +0000
Message-ID: <63943de8-198d-32ff-36fe-c3f6c4c10f1d@arm.com>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
	<20180313085534.11650-5-vivek.gautam@codeaurora.org>
	<8b427ea2-5c13-4712-13d1-e4c1aed0779e@arm.com>
	<CAFp+6iEFDXKdS_mTgrrpCX2isMAT3XJifRV0FYxV+PFpVGV=2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAFp+6iEFDXKdS_mTgrrpCX2isMAT3XJifRV0FYxV+PFpVGV=2w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 15/03/18 08:57, Vivek Gautam wrote:
> Hi Robin,
> 
> 
> On Wed, Mar 14, 2018 at 11:20 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>> On 13/03/18 08:55, Vivek Gautam wrote:
>>>
>>> From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>>
>>> Finally add the device link between the master device and
>>> smmu, so that the smmu gets runtime enabled/disabled only when the
>>> master needs it. This is done from add_device callback which gets
>>> called once when the master is added to the smmu.
>>>
>>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>> Reviewed-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>>> ---
>>>    drivers/iommu/arm-smmu.c | 29 +++++++++++++++++++++++++++++
>>>    1 file changed, 29 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>> index 56a04ae80bf3..64953ff2281f 100644
>>> --- a/drivers/iommu/arm-smmu.c
>>> +++ b/drivers/iommu/arm-smmu.c
>>> @@ -1460,10 +1460,31 @@ static int arm_smmu_add_device(struct device *dev)
>>>          iommu_device_link(&smmu->iommu, dev);
>>>    +     if (pm_runtime_enabled(smmu->dev)) {
>>> +               struct device_link *link;
>>> +
>>> +               /*
>>> +                * Establish the link between smmu and master, so that the
>>> +                * smmu gets runtime enabled/disabled as per the master's
>>> +                * needs.
>>> +                */
>>> +               link = device_link_add(dev, smmu->dev,
>>> DL_FLAG_PM_RUNTIME);
>>> +               if (!link) {
>>
>>
>> FWIW, given that we don't really care about link itself, I'd be quite happy
>> to simplify that lot down to:
>>
>>          if (pm_runtime_enabled(smmu_dev) &&
>>              !device_link_add(dev, smmu->dev, DL_FLAG_PM_RUNTIME)) {
> 
> Sure, will update this.
> 
>>
>>> +                       dev_warn(smmu->dev,
>>> +                                "Unable to add link to the consumer
>>> %s\n",
>>> +                                dev_name(dev));
>>
>>
>> (side note: since device_link_add() already prints a message on success,
>> maybe it could print its own failure message too?)
> 
> Should we make device_link that verbose - to print failure messages at
> each step (there are atleast a couple where we return link as NULL),
> or we can let the users handle printing the message?

I didn't mean to imply anything more than the idea below (although the 
whole function could of course be refactored further to report explicit 
error values). It just seems a bit unbalanced for the core code to be 
noisy about success yet silent about failure, but ultimately that's an 
entirely separate issue which doesn't have to have any bearing on this 
series.

Robin.

----->8-----
diff --git a/drivers/base/core.c b/drivers/base/core.c
index b2261f92f2f1..895da95f5cb9 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -275,6 +275,9 @@ struct device_link *device_link_add(struct device 
*consumer,
   out:
  	device_pm_unlock();
  	device_links_write_unlock();
+	if (!link)
+		dev_warn(consumer, "Failed to link to supplier %s\n", 
dev_name(supplier));
+
  	return link;
  }
  EXPORT_SYMBOL_GPL(device_link_add);
