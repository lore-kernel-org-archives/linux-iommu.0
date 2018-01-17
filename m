From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: suppress MSI allocation failure message
Date: Wed, 17 Jan 2018 19:08:39 +0000
Message-ID: <66706458-d971-be9b-4390-80a9be39248c@arm.com>
References: <1516214399-24012-1-git-send-email-nwatters@codeaurora.org>
	<2f651cfe-e006-cf1d-b624-08e2ba5340fc@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2f651cfe-e006-cf1d-b624-08e2ba5340fc-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 17/01/18 18:54, Robin Murphy wrote:
> [ +Marc just in case ]
> 
> On 17/01/18 18:39, Nate Watterson wrote:
>> From: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>
>> Even though QDF2400 supports MSI interrupts with SMMUv3, it is not enabled
>> in ACPI FW to preserve compatibility with older kernel versions. Code is
>> emitting warning message during boot.
>>
>> This is causing some test tools to record a false warning and is causing
>> support issues.
>>
>> Better reduce the message level.
> 
> Ugh, that's unfortunate, since there are also plenty of genuine error 
> conditions encapsulated in there which we *would* want to report as such 
> (but still then fall back to wired IRQs if possible). Is the return 
> value sufficient to differentiate the "there is no MSI parent" and 
> "there are MSIs but something went wrong" cases, or is it more 
> complicated than that?

Indeed. How about checking dev->msi_domain first, which should tell you
whether it is even possible to allocate MSIs, and fallback to wired IRQs
instead. That way, we keep the warning on genuine failures to allocate
MSIs, and you get to add a nice "Falling back to wired interrupts"
message when msi_domain is NULL.

Thoughts?

	M.

> 
> Robin.
> 
>> Signed-off-by: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> Signed-off-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>   drivers/iommu/arm-smmu-v3.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 744592d..2118fda 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -2331,7 +2331,7 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>>   	/* Allocate MSIs for evtq, gerror and priq. Ignore cmdq */
>>   	ret = platform_msi_domain_alloc_irqs(dev, nvec, arm_smmu_write_msi_msg);
>>   	if (ret) {
>> -		dev_warn(dev, "failed to allocate MSIs\n");
>> +		dev_info(dev, "failed to allocate MSIs\n");
>>   		return;
>>   	}
>>   
>>


-- 
Jazz is not dead. It just smells funny...
