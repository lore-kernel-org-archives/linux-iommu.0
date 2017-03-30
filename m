From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 4/4] iommu/arm-smmu: Use per-context TLB sync as
	appropriate
Date: Thu, 30 Mar 2017 16:48:36 +0100
Message-ID: <351fc710-6f78-ef8d-5746-4d1a3dcaa4c0@arm.com>
References: <cover.1488907474.git.robin.murphy@arm.com>
	<03ef837586cd991f2d8431908230fd3a3dd8c9cf.1488907474.git.robin.murphy@arm.com>
	<20170330143744.GG22160@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170330143744.GG22160-5wv7dgnIgG8@public.gmane.org>
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

On 30/03/17 15:37, Will Deacon wrote:
> Hi Robin,
> 
> This mostly looks great, but I have a couple of minor comments below.
> 
> On Tue, Mar 07, 2017 at 06:09:07PM +0000, Robin Murphy wrote:
>> TLB synchronisation typically involves the SMMU blocking all incoming
>> transactions until the TLBs report completion of all outstanding
>> operations. In the common SMMUv2 configuration of a single distributed
>> SMMU serving multiple peripherals, that means that a single unmap
>> request has the potential to bring the hammer down on the entire system
>> if synchronised globally. Since stage 1 contexts, and stage 2 contexts
>> under SMMUv2, offer local sync operations, let's make use of those
>> wherever we can in the hope of minimising global disruption.
>>
>> To that end, rather than add any more branches to the already unwieldy
>> monolithic TLB maintenance ops, break them up into smaller, neater,
>> functions which we can then mix and match as appropriate.
>>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>  drivers/iommu/arm-smmu.c | 156 ++++++++++++++++++++++++++++++-----------------
>>  1 file changed, 100 insertions(+), 56 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index c8aafe304171..f7411109670f 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -237,6 +237,8 @@ enum arm_smmu_s2cr_privcfg {
>>  #define ARM_SMMU_CB_S1_TLBIVAL		0x620
>>  #define ARM_SMMU_CB_S2_TLBIIPAS2	0x630
>>  #define ARM_SMMU_CB_S2_TLBIIPAS2L	0x638
>> +#define ARM_SMMU_CB_TLBSYNC		0x7f0
>> +#define ARM_SMMU_CB_TLBSTATUS		0x7f4
>>  #define ARM_SMMU_CB_ATS1PR		0x800
>>  #define ARM_SMMU_CB_ATSR		0x8f0
>>  
>> @@ -569,14 +571,13 @@ static void __arm_smmu_free_bitmap(unsigned long *map, int idx)
>>  }
>>  
>>  /* Wait for any pending TLB invalidations to complete */
>> -static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
>> +static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu,
>> +				void __iomem *sync, void __iomem *status)
> 
> Given that you take the arm_smmu_device anyway, I think I'd prefer just
> passing the offsets for sync and status and avoiding the additions
> in the caller (a bit like your other patch in this series ;).

Note that the sole reason for passing the arm_smmu_device is for the
dev_err(), but I neither want to remove that nor duplicate it across the
callers...

However, the concrete reason for not passing offsets is that this
function serves for both global and local syncs, so there is no single
base address that can be assumed. At one point I toyed with just passing
a context bank number (using -1 for "global") but even I thought that
ended up looking awful ;)

>>  static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
>> @@ -617,48 +638,66 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
>>  {
>>  	struct arm_smmu_domain *smmu_domain = cookie;
>>  	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>> -	struct arm_smmu_device *smmu = smmu_domain->smmu;
>>  	bool stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
>> -	void __iomem *reg;
>> +	void __iomem *reg = ARM_SMMU_CB(smmu_domain->smmu, cfg->cbndx);
>> +	size_t step;
>>  
>> -	if (stage1) {
>> -		reg = ARM_SMMU_CB(smmu, cfg->cbndx);
>> -		reg += leaf ? ARM_SMMU_CB_S1_TLBIVAL : ARM_SMMU_CB_S1_TLBIVA;
>> -
>> -		if (cfg->fmt != ARM_SMMU_CTX_FMT_AARCH64) {
>> -			iova &= ~12UL;
>> -			iova |= cfg->asid;
>> -			do {
>> -				writel_relaxed(iova, reg);
>> -				iova += granule;
>> -			} while (size -= granule);
>> -		} else {
>> -			iova >>= 12;
>> -			iova |= (u64)cfg->asid << 48;
>> -			do {
>> -				writeq_relaxed(iova, reg);
>> -				iova += granule >> 12;
>> -			} while (size -= granule);
>> -		}
>> -	} else if (smmu->version == ARM_SMMU_V2) {
>> -		reg = ARM_SMMU_CB(smmu, cfg->cbndx);
>> +	if (stage1)
>> +		reg += leaf ? ARM_SMMU_CB_S1_TLBIVAL :
>> +			      ARM_SMMU_CB_S1_TLBIVA;
>> +	else
>>  		reg += leaf ? ARM_SMMU_CB_S2_TLBIIPAS2L :
>>  			      ARM_SMMU_CB_S2_TLBIIPAS2;
>> -		iova >>= 12;
>> -		do {
>> -			smmu_write_atomic_lq(iova, reg);
>> -			iova += granule >> 12;
>> -		} while (size -= granule);
>> +
>> +	if (stage1 && cfg->fmt != ARM_SMMU_CTX_FMT_AARCH64) {
>> +		iova &= ~12UL;
>> +		iova |= cfg->asid;
>> +		step = granule;
>>  	} else {
>> -		reg = ARM_SMMU_GR0(smmu) + ARM_SMMU_GR0_TLBIVMID;
>> -		writel_relaxed(cfg->vmid, reg);
>> +		iova >>= 12;
>> +		step = granule >> 12;
>> +		if (stage1)
>> +			iova |= (u64)cfg->asid << 48;
>>  	}
>> +
>> +	do {
>> +		smmu_write_atomic_lq(iova, reg);
>> +		iova += step;
>> +	} while (size -= granule);
> 
> There seems to be a lot of refactoring going on here, but I'm not entirely
> comfortable with the unconditional move to smmu_write_atomic_lq. Given the
> way in which arm_smmu_tlb_inv_range_nosync is now called (i.e. only for
> stage-1 or SMMUv2 stage-2), then I think you just need to delete the final
> else clause in the current code and you're done.

Yes, this bears the scars of having been split into multiple functions
then put back together again, possibly more than once (I forget the full
history). Now that things have settled on just 3 sets of ops (stage 1,
stage 2, and braindead stage 2), I'll have one last try at a stage
1/stage 2 split, just to try and make the logic less inscrutable (which
is my main gripe with this function), but I'll do so as a standalone
patch that you can have the final call on.

Robin.

> 
> Will
> 
