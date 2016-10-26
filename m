From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH 4/4] iommu/arm-smmu: Add the device_link between masters
	and smmu
Date: Wed, 26 Oct 2016 09:44:05 +0530
Message-ID: <001301d22f3f$6788cf30$369a6d90$@codeaurora.org>
References: <1477070066-15044-1-git-send-email-sricharan@codeaurora.org>
	<CGME20161021171456eucas1p172cd17e1d3b498eac68210a39f54e025@eucas1p1.samsung.com>
	<1477070066-15044-5-git-send-email-sricharan@codeaurora.org>
	<d0489bcc-573f-de7a-fb6e-59fee521dac8@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <d0489bcc-573f-de7a-fb6e-59fee521dac8-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-us
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Marek Szyprowski' <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Marek,

>
>On 2016-10-21 19:14, Sricharan R wrote:
>> The device link between master and its smmu is added so that
>> the smmu gets runtime enabled/disabled when the master needs it.
>> This is done from add_device callback which gets called once
>> when the master is added to the smmu group.
>>
>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>   drivers/iommu/arm-smmu.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 578cdc2..71ce4b6 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -1470,6 +1470,15 @@ static int arm_smmu_add_device(struct device *dev)
>>   		goto out_free;
>>   	pm_runtime_put_sync(smmu->dev);
>>
>> +	/*
>> +	 * Establish the link between smmu and master, so that the
>> +	 * smmu gets runtime enabled/disabled as per the master's
>> +	 * needs.
>> +	 */
>> +
>> +	device_link_add(dev, smmu->dev, DEVICE_LINK_AVAILABLE,
>> +			DEVICE_LINK_PM_RUNTIME);
>
>Please update to the latest version of Rafael's patches. In V5 the
>initial link
>state is not needed anymore and there was an important fix for creating
>links
>during master's driver probing, what happens after applying your IOMMU
>deferred
>probe patchset.

   Sure i will update to V5. I see that i am on V4.

Regards,
 Sricharan
