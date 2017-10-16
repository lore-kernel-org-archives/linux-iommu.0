From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 4/4] iommu/arm-smmu-v3: Poll for CMD_SYNC outside cmdq
	lock
Date: Mon, 16 Oct 2017 14:12:23 +0100
Message-ID: <495d0124-f5e4-04a4-f6e7-d0934bd38196@arm.com>
References: <cover.1504182142.git.robin.murphy@arm.com>
	<ff239173e47dfa0fc76eaa2a25b3cbcfe8dce5e6.1504182142.git.robin.murphy@arm.com>
	<20171013185917.GB30572@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171013185917.GB30572-5wv7dgnIgG8@public.gmane.org>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 13/10/17 19:59, Will Deacon wrote:
> Hi Robin,
> 
> Some of my comments on patch 3 are addressed here, but I'm really struggling
> to convince myself that this algorithm is correct. My preference would
> be to leave the code as it is for SMMUs that don't implement MSIs, but
> comments below anyway because it's an interesting idea.

>From scrounging up boot logs I can see that neither the Cavium nor
HiSilicon SMMUv3 implementations have MSI support (the one in D05
doesn't even have WFE), so there is a real motivation to improve
scalability on current systems - it's not *just* a cool feature!

> On Thu, Aug 31, 2017 at 02:44:28PM +0100, Robin Murphy wrote:
>> Even without the MSI trick, we can still do a lot better than hogging
>> the entire queue while it drains. All we actually need to do for the
>> necessary guarantee of completion is wait for our particular command to
>> have been consumed, and as long as we keep track of where it is there is
>> no need to block other CPUs from adding further commands in the
>> meantime. There is one theoretical (but incredibly unlikely) edge case
>> to avoid, where cons has wrapped twice to still appear 'behind' the sync
>> position - this is easily disambiguated by adding a generation count to
>> the queue to indicate when prod wraps, since cons cannot wrap twice
>> without prod having wrapped at least once.
>>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>
>> v2: New
>>
>>  drivers/iommu/arm-smmu-v3.c | 81 ++++++++++++++++++++++++++++++++-------------
>>  1 file changed, 58 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 311f482b93d5..f5c5da553803 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -417,7 +417,6 @@
>>  
>>  /* High-level queue structures */
>>  #define ARM_SMMU_POLL_TIMEOUT_US	100
>> -#define ARM_SMMU_CMDQ_DRAIN_TIMEOUT_US	1000000 /* 1s! */
>>  #define ARM_SMMU_SYNC_TIMEOUT_US	1000000 /* 1s! */
>>  
>>  #define MSI_IOVA_BASE			0x8000000
>> @@ -540,6 +539,7 @@ struct arm_smmu_queue {
>>  struct arm_smmu_cmdq {
>>  	struct arm_smmu_queue		q;
>>  	spinlock_t			lock;
>> +	int				generation;
>>  };
>>  
>>  struct arm_smmu_evtq {
>> @@ -770,21 +770,12 @@ static void queue_inc_prod(struct arm_smmu_queue *q)
>>  	writel(q->prod, q->prod_reg);
>>  }
>>  
>> -/*
>> - * Wait for the SMMU to consume items. If drain is true, wait until the queue
>> - * is empty. Otherwise, wait until there is at least one free slot.
>> - */
>> -static int queue_poll_cons(struct arm_smmu_queue *q, bool drain, bool wfe)
>> +/* Wait for the SMMU to consume items, until there is at least one free slot */
>> +static int queue_poll_cons(struct arm_smmu_queue *q, bool wfe)
>>  {
>> -	ktime_t timeout;
>> -	unsigned int delay = 1;
>> +	ktime_t timeout = ktime_add_us(ktime_get(), ARM_SMMU_POLL_TIMEOUT_US);
>>  
>> -	/* Wait longer if it's queue drain */
>> -	timeout = ktime_add_us(ktime_get(), drain ?
>> -					    ARM_SMMU_CMDQ_DRAIN_TIMEOUT_US :
>> -					    ARM_SMMU_POLL_TIMEOUT_US);
>> -
>> -	while (queue_sync_cons(q), (drain ? !queue_empty(q) : queue_full(q))) {
>> +	while (queue_sync_cons(q), queue_full(q)) {
>>  		if (ktime_compare(ktime_get(), timeout) > 0)
>>  			return -ETIMEDOUT;
>>  
>> @@ -792,8 +783,7 @@ static int queue_poll_cons(struct arm_smmu_queue *q, bool drain, bool wfe)
>>  			wfe();
>>  		} else {
>>  			cpu_relax();
>> -			udelay(delay);
>> -			delay *= 2;
>> +			udelay(1);
>>  		}
>>  	}
>>  
>> @@ -959,15 +949,20 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
>>  	queue_write(Q_ENT(q, cons), cmd, q->ent_dwords);
>>  }
>>  
>> -static void arm_smmu_cmdq_insert_cmd(struct arm_smmu_device *smmu, u64 *cmd)
>> +static u32 arm_smmu_cmdq_insert_cmd(struct arm_smmu_device *smmu, u64 *cmd)
>>  {
>>  	struct arm_smmu_queue *q = &smmu->cmdq.q;
>>  	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
>>  
>>  	while (queue_insert_raw(q, cmd) == -ENOSPC) {
>> -		if (queue_poll_cons(q, false, wfe))
>> +		if (queue_poll_cons(q, wfe))
>>  			dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
>>  	}
>> +
>> +	if (Q_IDX(q, q->prod) == 0)
>> +		smmu->cmdq.generation++;
> 
> The readers of generation are using READ_ONCE, so you're missing something
> here.

Yeah, I was a bit back-and-forth on this. The readers want a READ_ONCE
if only to prevent it being hoisted out of the polling loop, but as long
as the update of generation is single-copy-atomic, the exact point at
which it occurs shouldn't matter so much, since it's only written under
the cmdq lock. I guess it depends how much we trust GCC's claim of the
atomicity of int - I have no great objection to

	smmu->cmdq.generation = WRITE_ONCE(smmu->cmdq.generation + 1);

other than it being really long.

>> +
>> +	return q->prod;
>>  }
>>  
>>  static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
>> @@ -997,15 +992,54 @@ static int arm_smmu_sync_poll_msi(struct arm_smmu_device *smmu, u32 sync_idx)
>>  	return (int)(val - sync_idx) < 0 ? -ETIMEDOUT : 0;
>>  }
>>  
>> +static int arm_smmu_sync_poll_cons(struct arm_smmu_device *smmu, u32 sync_idx,
>> +				   int sync_gen)
>> +{
>> +	ktime_t timeout = ktime_add_us(ktime_get(), ARM_SMMU_SYNC_TIMEOUT_US);
>> +	struct arm_smmu_queue *q = &smmu->cmdq.q;
>> +	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
>> +	unsigned int delay = 1;
>> +
>> +	do {
>> +		queue_sync_cons(q);
>> +		/*
>> +		 * If we see updates quickly enough, cons has passed sync_idx,
>> +		 * but not yet wrapped. At worst, cons might have actually
>> +		 * wrapped an even number of times, but that still guarantees
>> +		 * the original sync must have been consumed.
>> +		 */
>> +		if (Q_IDX(q, q->cons) >= Q_IDX(q, sync_idx) &&
>> +		    Q_WRP(q, sync_idx) == Q_WRP(q, q->cons))
> 
> Can you move this into a separate function please, like we have for
> queue_full and queue_empty?

OK, but given that it's only half of the "has cons moved past this
index" operation, I'm not really sure what it could be called -
queue_ahead_not_wrapped() comes to mind, but still seems a bit cryptic.

>> +			return 0;
>> +		/*
>> +		 * Otherwise, cons may have passed sync_idx and wrapped one or
>> +		 * more times to appear behind it again, but in that case prod
>> +		 * must also be one or more generations ahead.
>> +		 */
>> +		if (Q_IDX(q, q->cons) < Q_IDX(q, sync_idx) &&
>> +		    READ_ONCE(smmu->cmdq.generation) != sync_gen)
> 
> There's another daft overflow case here which deserves a comment (and even
> if it *did* happen, we'll recover gracefully).

You mean exactly 2^32 queue generations passing between polls? Yeah, not
happening :P

>> +			return 0;
>> +
>> +		if (wfe) {
>> +			wfe();
> 
> This is a bit scary... if we miss a generation update, just due to store
> propagation latency (maybe it's buffered by the updater), I think we can
> end up going into wfe when there's not an event pending. Using xchg
> everywhere might work, but there's still a race on having somebody update
> generation. The ordering here just looks generally suspicious to me because
> you have the generation writer in arm_smmu_cmdq_insert_cmd effectively
> doing:
> 
>   Write prod
>   Write generation
> 
> and the reader in arm_smmu_sync_poll_cons doing:
> 
>   Read cons
>   Read generation
> 
> so I can't see anything that gives you order to guarantee that the
> generation is seen to be up-to-date.

On reflection I'm pretty sure the below should suffice, to piggy-back
off the DSB implicit in queue_insert_raw(). The readers only care about
the generation *after* cons has been observed to go backwards, so the
exact order of the generation and prod updates makes no practical
difference other than closing that race window.

Robin

----->8-----
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 12cdc5e50675..78ba8269c44c 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -959,14 +959,14 @@ static u32 arm_smmu_cmdq_insert_cmd(struct
arm_smmu_device *smmu, u64 *cmd)
 	struct arm_smmu_queue *q = &smmu->cmdq.q;
 	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);

+	if (Q_IDX(q, q->prod + 1) == 0)
+		smmu->cmdq.generation++;
+
 	while (queue_insert_raw(q, cmd) == -ENOSPC) {
 		if (queue_poll_cons(q, wfe))
 			dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
 	}

-	if (Q_IDX(q, q->prod) == 0)
-		smmu->cmdq.generation++;
-
 	return q->prod;
 }
