From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v8 5/7] iommu/arm-smmu-v3: Add support for non-strict mode
Date: Fri, 28 Sep 2018 13:26:00 +0100
Message-ID: <1d2b57f7-be4e-39c5-4981-7f8e2f601b6a@arm.com>
References: <cover.1537458163.git.robin.murphy@arm.com>
	<b98f8f695178c9c9ac6e081680090d5ac97e8d7c.1537458163.git.robin.murphy@arm.com>
	<20180928121900.GB1577@brain-police>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180928121900.GB1577@brain-police>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, huawei.libin-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 28/09/18 13:19, Will Deacon wrote:
> On Thu, Sep 20, 2018 at 05:10:25PM +0100, Robin Murphy wrote:
>> From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>>
>> Now that io-pgtable knows how to dodge strict TLB maintenance, all
>> that's left to do is bridge the gap between the IOMMU core requesting
>> DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE for default domains, and showing the
>> appropriate IO_PGTABLE_QUIRK_NON_STRICT flag to alloc_io_pgtable_ops().
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>> [rm: convert to domain attribute, tweak commit message]
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>
>> v8:
>>   - Use nested switches for attrs
>>   - Document barrier semantics
>>
>>   drivers/iommu/arm-smmu-v3.c | 79 ++++++++++++++++++++++++++-----------
>>   1 file changed, 56 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index f10c852479fc..db402e8b068b 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -612,6 +612,7 @@ struct arm_smmu_domain {
>>   	struct mutex			init_mutex; /* Protects smmu pointer */
>>   
>>   	struct io_pgtable_ops		*pgtbl_ops;
>> +	bool				non_strict;
>>   
>>   	enum arm_smmu_domain_stage	stage;
>>   	union {
>> @@ -1407,6 +1408,12 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>>   		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
>>   	}
>>   
>> +	/*
>> +	 * NOTE: when io-pgtable is in non-strict mode, we may get here with
>> +	 * PTEs previously cleared by unmaps on the current CPU not yet visible
>> +	 * to the SMMU. We are relying on the DSB implicit in queue_inc_prod()
>> +	 * to guarantee those are observed before the TLBI. Do be careful, 007.
>> +	 */
> 
> Good, so you can ignore my comment on the previous patch :)

Well, I suppose that comment in io-pgtable *could* have explicitly noted 
that same-CPU order is dealt with elsewhere - feel free to fix it up if 
you think it would be a helpful reminder for the future.

Cheers,
Robin.
