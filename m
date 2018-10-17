From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix big-endian CMD_SYNC writes
Date: Wed, 17 Oct 2018 18:10:28 +0100
Message-ID: <439dcb28-5f18-29b4-d655-2b1ed790337d@arm.com>
References: <e14feb6f7dedc90d181e20fbeaaba49156b03b09.1539689371.git.robin.murphy@arm.com>
	<20181017170712.GA4570@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181017170712.GA4570-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 17/10/18 18:07, Will Deacon wrote:
> On Tue, Oct 16, 2018 at 12:31:07PM +0100, Robin Murphy wrote:
>> When we insert the sync sequence number into the CMD_SYNC.MSIData field,
>> we do so in CPU-native byte order, before writing out the whole command
>> as explicitly little-endian dwords. Thus on big-endian systems, the SMMU
>> will receive and write back a byteswapped version of sync_nr, which would
>> be perfect if it were targeting a similarly-little-endian ITS, but since
>> it's actually writing back to memory being polled by the CPUs, they're
>> going to end up seeing the wrong thing.
>>
>> Since the SMMU doesn't care what the MSIData actually contains, the
>> minimal-overhead solution is to simply add an extra byteswap initially,
>> such that it then writes back the big-endian format directly.
>>
>> Fixes: 37de98f8f1cf ("iommu/arm-smmu-v3: Use CMD_SYNC completion MSI")
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>   drivers/iommu/arm-smmu-v3.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index db402e8b068b..867ba548c2cc 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -952,7 +952,7 @@ static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
>>   	struct arm_smmu_cmdq_ent ent = {
>>   		.opcode = CMDQ_OP_CMD_SYNC,
>>   		.sync	= {
>> -			.msiaddr = virt_to_phys(&smmu->sync_count),
>> +			.msiaddr = cpu_to_le32(virt_to_phys(&smmu->sync_count)),
> 
> Hmm, aren't you swabbing the address here? Don't we want to swab the data?
> We also need a comment to explain this!

It's entirely possible that I'm a spectacular idiot. <sigh>

Let me try again...

Robin.
