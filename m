From: Ray Jui via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH 0/8] io-pgtable lock removal
Date: Thu, 6 Jul 2017 11:14:00 -0700
Message-ID: <94ba5d4a-0dae-9394-79ef-90da86e49c86@broadcom.com>
References: <b7830be1-9a78-e29f-a29c-4798aaa28c0a@broadcom.com>
	<cdc1799b-f142-09ed-a7e5-d7fd2e70268f@arm.com>
	<e43ba1fe-696e-fabb-a800-52fadaa2fa93@broadcom.com>
	<20170628114609.GD11053@arm.com>
	<87d53115-3d80-5a3d-6632-c31986cb7018@broadcom.com>
	<20170704173155.GN22175@arm.com>
	<6814b246-22f0-bfaa-5002-a269b2735116@broadcom.com>
	<2d5f5ef3-32b1-76c6-6869-ff980557f8e8@broadcom.com>
	<20170705084143.GA9378@arm.com>
	<5149280b-a214-249c-c5e2-3712b1f941d2@broadcom.com>
	<20170706150838.GB15574@arm.com>
Reply-To: Ray Jui <ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170706150838.GB15574-5wv7dgnIgG8@public.gmane.org>
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
Cc: sunil.goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On 7/6/17 8:08 AM, Will Deacon wrote:
> Hi Ray,
> 
> Thanks for testing this, and sorry it didn't help.
> 
> On Wed, Jul 05, 2017 at 04:24:22PM -0700, Ray Jui wrote:
>> On 7/5/17 1:41 AM, Will Deacon wrote:
>>> On Tue, Jul 04, 2017 at 06:45:17PM -0700, Ray Jui wrote:
>>>> Has anything functionally changed between PATCH v2 and v1? I'm seeing a
>>>> very different L2 throughput with v2 (in general a lot worse with v2 vs.
>>>> v1); however, I'm currently unable to reproduce the TLB sync timed out
>>>> issue with v2 (without the patch from Will's email).
>>>>
>>>> It could also be something else that has changed in my setup, but so far
>>>> I have not yet been able to spot anything wrong in the setup.
>>>
>>> There were fixes, and that initially involved a DSB that was found to be
>>> expensive. The patches queued in -next should have that addressed, so please
>>> use those (or my for-joerg/arm-smmu/updates branch).
>>>
>>
>> That was my bad yesterday. I was in a rush and the setup was incorrect.
>>
>> I redo my Ethernet performance test with both PATCH v1 and v2 today, and
>> can confirm the performance is consistent between v1 and v2 as expected.
>>
>> I also made sure the following message can still be reproduced with
>> patch set v2:
>>
>> arm-smmu 64000000.mmu: TLB sync timed out -- SMMU may be deadlocked
>>
>> Then I proceeded to apply your patch that attempt to fix the deadlock
>> issue.
> 
> [...]
> 
>> However, with the fix patch, I can still see the deadlock message when I
>> have > 32 iperf TX threads active in the system:
> 
> Damn. We've been going over this today and the only plausible theory seems
> to be that concurrent TLB syncs are causing the completion to be pushed out,
> resulting in timeouts.
> 
> Can you try this patch below, instead of the one I sent before, please?
> 
> Thanks,
> 
> Will
> 
> --->8

Good news! I can confirm that with the new patch below, the error log of
"TLB sync timed out" is now gone. I ran 20 iterations of the iperf
client test with 64 threads spread across 8 CPUs. The error message used
to coming out very quickly with just one iteration. But now it's
completely gone.

At the same time, I do seem to observe a slight impact on performance
when multiple threads are used, but I guess that is expected, given that
a spin lock is added to protect the TLB sync.

Great work and thanks for the fix!

Ray

> 
> From bbf3737c29e3d18f539998a66f42878ac91cde97 Mon Sep 17 00:00:00 2001
> From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> Date: Thu, 6 Jul 2017 15:55:48 +0100
> Subject: [PATCH] iommu/arm-smmu: Reintroduce locking around TLB sync
>  operations
> 
> Commit 523d7423e21b ("iommu/arm-smmu: Remove io-pgtable spinlock")
> removed the locking used to serialise map/unmap calls into the io-pgtable
> code from the ARM SMMU driver. This is good for performance, but opens
> us up to a nasty race with TLB syncs because the TLB sync register is
> shared within a context bank (or even globally for stage-2 on SMMUv1).
> 
> There are two cases to consider:
> 
>   1. A CPU can be spinning on the completion of a TLB sync, take an
>      interrupt which issues a subsequent TLB sync, and then report a
>      timeout on return from the interrupt.
> 
>   2. A CPU can be spinning on the completion of a TLB sync, but other
>      CPUs can continuously issue additional TLB syncs in such a way that
>      the backoff logic reports a timeout.
> 
> Rather than fix this by spinning for completion of prior TLB syncs before
> issuing a new one (which may suffer from fairness issues on large systems),
> instead reintroduce locking around TLB sync operations in the ARM SMMU
> driver.
> 
> Fixes: 523d7423e21b ("iommu/arm-smmu: Remove io-pgtable spinlock")
> Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Reported-by: Ray Jui <ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index b446183b3015..770abd247f40 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -400,6 +400,8 @@ struct arm_smmu_device {
>  
>  	u32				cavium_id_base; /* Specific to Cavium */
>  
> +	spinlock_t			global_sync_lock;
> +
>  	/* IOMMU core code handle */
>  	struct iommu_device		iommu;
>  };
> @@ -436,7 +438,7 @@ struct arm_smmu_domain {
>  	struct arm_smmu_cfg		cfg;
>  	enum arm_smmu_domain_stage	stage;
>  	struct mutex			init_mutex; /* Protects smmu pointer */
> -	spinlock_t			cb_lock; /* Serialises ATS1* ops */
> +	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
>  	struct iommu_domain		domain;
>  };
>  
> @@ -602,9 +604,12 @@ static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu,
>  static void arm_smmu_tlb_sync_global(struct arm_smmu_device *smmu)
>  {
>  	void __iomem *base = ARM_SMMU_GR0(smmu);
> +	unsigned long flags;
>  
> +	spin_lock_irqsave(&smmu->global_sync_lock, flags);
>  	__arm_smmu_tlb_sync(smmu, base + ARM_SMMU_GR0_sTLBGSYNC,
>  			    base + ARM_SMMU_GR0_sTLBGSTATUS);
> +	spin_unlock_irqrestore(&smmu->global_sync_lock, flags);
>  }
>  
>  static void arm_smmu_tlb_sync_context(void *cookie)
> @@ -612,9 +617,12 @@ static void arm_smmu_tlb_sync_context(void *cookie)
>  	struct arm_smmu_domain *smmu_domain = cookie;
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  	void __iomem *base = ARM_SMMU_CB(smmu, smmu_domain->cfg.cbndx);
> +	unsigned long flags;
>  
> +	spin_lock_irqsave(&smmu_domain->cb_lock, flags);
>  	__arm_smmu_tlb_sync(smmu, base + ARM_SMMU_CB_TLBSYNC,
>  			    base + ARM_SMMU_CB_TLBSTATUS);
> +	spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
>  }
>  
>  static void arm_smmu_tlb_sync_vmid(void *cookie)
> @@ -1925,6 +1933,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>  
>  	smmu->num_mapping_groups = size;
>  	mutex_init(&smmu->stream_map_mutex);
> +	spin_lock_init(&smmu->global_sync_lock);
>  
>  	if (smmu->version < ARM_SMMU_V2 || !(id & ID0_PTFS_NO_AARCH32)) {
>  		smmu->features |= ARM_SMMU_FEAT_FMT_AARCH32_L;
> 
