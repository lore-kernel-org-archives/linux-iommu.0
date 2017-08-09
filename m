From: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2] iommu/arm-smmu: fix null-pointer dereference in
	arm_smmu_add_device
Date: Wed, 9 Aug 2017 14:41:52 -0700
Message-ID: <c399a57d-074f-71ee-b467-91cf4e65b3d9@caviumnetworks.com>
References: <20170808092614.GB12887@arm.com>
	<1502187962-16861-1-git-send-email-asavkov@redhat.com>
	<d7a07e48-862d-a6f7-8bad-9c71f5a5be5b@arm.com>
	<20170808112144.GE13355@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170808112144.GE13355-5wv7dgnIgG8@public.gmane.org>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Artem Savkov <asavkov-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 08/08/2017 04:21 AM, Will Deacon wrote:
> [+ Joerg]
> 
> On Tue, Aug 08, 2017 at 11:37:40AM +0100, Robin Murphy wrote:
>> On 08/08/17 11:26, Artem Savkov wrote:
>>> Commit c54451a "iommu/arm-smmu: Fix the error path in arm_smmu_add_device"
>>> removed fwspec assignment in legacy_binding path as redundant which is
>>> wrong. It needs to be updated after fwspec initialisation in
>>> arm_smmu_register_legacy_master() as it is dereferenced later. Without
>>> this there is a NULL-pointer dereference panic during boot on some hosts.
>>
>> Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>>
>> Thanks for fixing it up, and sorry for failing to document the
>> unfortunately subtle logic in the first place!
> 
> Well, I was the one that messed it up:
> 
> Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> 
> Joerg, can you pick this up as a fix for 4.13, please?

I hit the Oops as well.  This patch fixes it for me on a Cavium CN88xx 
system, so:

Acked-by: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>

Thanks for working on this.



> 
> Will
> 
>>> Signed-off-by: Artem Savkov <asavkov-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>> ---
>>>   drivers/iommu/arm-smmu.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>> index b97188a..2d80fa8 100644
>>> --- a/drivers/iommu/arm-smmu.c
>>> +++ b/drivers/iommu/arm-smmu.c
>>> @@ -1519,6 +1519,13 @@ static int arm_smmu_add_device(struct device *dev)
>>>   
>>>   	if (using_legacy_binding) {
>>>   		ret = arm_smmu_register_legacy_master(dev, &smmu);
>>> +
>>> +		/*
>>> +		 * If dev->iommu_fwspec is initally NULL, arm_smmu_register_legacy_master()
>>> +		 * will allocate/initialise a new one. Thus we need to update fwspec for
>>> +		 * later use.
>>> +		 */
>>> +		fwspec = dev->iommu_fwspec;
>>>   		if (ret)
>>>   			goto out_free;
>>>   	} else if (fwspec && fwspec->ops == &arm_smmu_ops) {
>>>
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
