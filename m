From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Ensure we sync STE when only changing
	config field
Date: Fri, 6 Oct 2017 09:46:47 +0200
Message-ID: <59075e5e-56d5-9a93-8c01-c602be996982@redhat.com>
References: <1507222158-4151-1-git-send-email-will.deacon@arm.com>
	<7e9ef711-b1d7-ee70-b740-5d03a4fc61f6@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <7e9ef711-b1d7-ee70-b740-5d03a4fc61f6-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On 05/10/2017 18:54, Robin Murphy wrote:
> On 05/10/17 17:49, Will Deacon wrote:
>> The SMMUv3 architecture permits caching of data structures deemed to be
>> "reachable" by the SMU, which includes STEs marked as invalid. When
>> transitioning an STE to a bypass/fault configuration at init or detach
>> time, we mistakenly elide the CMDQ_OP_CFGI_STE operation in some cases,
>> therefore potentially leaving the old STE state cached in the SMMU.
>>
>> This patch fixes the problem by ensuring that we perform the
>> CMDQ_OP_CFGI_STE operation irrespective of the validity of the previous
>> STE.
> 
> Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Reviewed-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Thanks

Eric

> 
>> Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> Reported-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
>> ---
>>  drivers/iommu/arm-smmu-v3.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 47f52b1ab838..91fdabdb4de6 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -1085,8 +1085,11 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
>>  		dst[1] = cpu_to_le64(STRTAB_STE_1_SHCFG_INCOMING
>>  			 << STRTAB_STE_1_SHCFG_SHIFT);
>>  		dst[2] = 0; /* Nuke the VMID */
>> -		if (ste_live)
>> -			arm_smmu_sync_ste_for_sid(smmu, sid);
>> +		/*
>> +		 * The SMMU can perform negative caching, so we must sync
>> +		 * the STE regardless of whether the old value was live.
>> +		 */
>> +		arm_smmu_sync_ste_for_sid(smmu, sid);
>>  		return;
>>  	}
>>  
>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
