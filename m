From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v9 4/5] iommu/arm-smmu: Add the device_link between
	masters and smmu
Date: Thu, 15 Mar 2018 10:44:32 +0000
Message-ID: <2cab6e92-c44c-edeb-bf50-946cec5cccac@arm.com>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
	<20180313085534.11650-5-vivek.gautam@codeaurora.org>
	<8b427ea2-5c13-4712-13d1-e4c1aed0779e@arm.com>
	<CAAFQd5AqERQMLsJNLAsVXox79kZ+ZtpCUuMSutn70FGK-3Q7vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAFQd5AqERQMLsJNLAsVXox79kZ+ZtpCUuMSutn70FGK-3Q7vw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 15/03/18 06:18, Tomasz Figa wrote:
> On Thu, Mar 15, 2018 at 2:50 AM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
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
> I think we care whether adding the link succeeded. If it fails to be
> added, we might end up with a complete system lockup on a system with
> power domains.

Well, yeah, that was implicit - the point is that we *only* care about 
whether it succeeded or not. Thus we may as well just check for NULL 
directly instead of assigning the value as if we were actually going to 
do anything with it.

Robin.
