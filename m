Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871076;
	b=b2si4Q5d7Omgt+G1AInvC51fdkGtxflAyMG2yj6bxbYCq9LJ9rh/ei6SfwjTKZck/XYI
	 beAIp07Yf3K2UbgisMjOwyzZfhF5ZJgRdn3R1Zz4diGsPbGvalIyi2/eFUQRQhkvFyIeb
	 bv2mIgh2abjr/3j188L+301OWpg45B1hu1kLBbWl5ZSlwbOtPmOrGjZUQlzJKnt2Y6oYA
	 2VcEIXv0ymIfGXUpBCeoUzJH/VI2VwBQJSkv2lX978qq0oiFpKSgA0N9+74KxAVEpqZdq
	 2WsbEsbLiZ9owtSykLIy+6M+25JporgNiephWz+swZEPjDvARdx6VLIsa4rgJgmaNwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871076;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=7qw/jbqYMhQwmmzrHE2jFWlPhyq4Q/EDuXNQRu9q/eM=;
	b=ign/D+HOLoRpm9VPfRUGgzj8MpRgFFTG/6UStLFHchAdsj8bd4pngTm1uG3Qdxfh4B8r
	 7qagryie4wYTzhM/ZpXvChwoK1X3ASomCyHdIhUmxZKEd34WaRlIoURoJeEhwabWtnuYo
	 aRaHLFxi99oiqrz0wUMiDAbQ0b+KcnYpNw9QKkRq78yC8gBANIosVg21WB1+y4W9kVPmu
	 fUqBDqZWKammcoxlvUf2h8n4HFU3VrsaMU3RKMC3jKl7oDYJtcptUcTVZFBw4dBGH1tis
	 mRLJ+Cc7/1uyWHHcXkW8g6O5qG+SVZI2a4Q93M0c1isRNfgEE0T5hZQ0rHtZKRkmXOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nrAmiDqL;
	arc=none smtp.remote-ip=115.124.30.112
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D940606A328
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 09:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D940606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nrAmiDqL
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793871071; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7qw/jbqYMhQwmmzrHE2jFWlPhyq4Q/EDuXNQRu9q/eM=;
	b=nrAmiDqLj2ZwgZBNVabFnvHzEWDy944kmieeFD2nilxoh3S3kL6GA5BOx0W/2Au+e+Qthxvseeyl4F2IasfhdsXPChr/iT8lOK8/xIDHV47ToEaLdnUkkMt0zH+pKcC5NdIVVrL1VWwAoyG6m/NlUKmfSUlXakwlm8S3BLVGPnQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0XE8E6wI_1793871068;
Received: from 30.221.134.206(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XE8E6wI_1793871068 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Nov 2026 17:31:09 +0800
Message-ID: <f88f0dd4-a961-4735-80c8-64ae834aad5b@linux.alibaba.com>
Date: Thu, 5 Nov 2026 17:31:07 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Restore three-stage vector cleanup for IR
 affinity migration
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>,
 joro@8bytes.org, vasant.hegde@amd.com, will@kernel.org,
 robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, thomas.lendacky@amd.com,
 joerg.roedel@amd.com
Cc: "Shu, Ming" <Ming.Shu@amd.com>, "Shukla, Santosh"
 <Santosh.Shukla@amd.com>, x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, seanjc@google.com,
 binbin.wu@linxu.intel.com, sstabellini@kernel.org, jgross@suse.com,
 LKML <linux-kernel@vger.kernel.org>
References: <20261015042347.1823813-1-guanghuifeng@linux.alibaba.com>
 <54db5f22-ba63-433d-b98d-d6dc6b17b27f@amd.com>
From: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <54db5f22-ba63-433d-b98d-d6dc6b17b27f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/10/20 10:36, Suthikulpanit, Suravee 写道:
> Hi Guanghui,
> 
> On 10/15/2026 11:23 AM, Guanghui Feng wrote:
>> From: Guanghui Feng <guanghui.fgh@linux.alibaba.com>
>>
>> AMD IOMMU specification (Rev 3.10) does not define interrupt message
>> draining semantics for INVALIDATE_INTERRUPT_TABLE + COMPLETION_WAIT.
>> This creates a race between vector_schedule_cleanup() and in-flight MSI
>> messages still transiting the Data Fabric after IRTE modification.
>>
>> Intel VT-d is architecturally safe due to explicit interrupt draining
>> guarantees.  VT-d spec Section 6.5.5 states:
>>
>>    "An interrupt request is considered drained when the interrupt is
>>     accepted by the processor Local xAPIC (for fixed and lowest priority
>>     delivery mode interrupts this means the interrupt is at least
>>     recorded in the Local xAPIC Interrupt Request Register (IRR))."
>>
>>    "Interrupt draining is performed by remapping hardware after Interrupt
>>     Entry Cache (IEC) invalidation requests.  For IEC invalidations
>>     submitted through the queued invalidation interface, interrupt
>>     draining must be completed before the next Invalidation Wait
>>     Descriptor is completed by hardware."
>>
>>    "For index-selective IEC invalidation requests, hardware only
>>     guarantees draining of non-committed interrupt requests referencing
>>     interrupt indexes specified in the invalidation request."
>>
>> Additionally, Section 6.5.2.8 (IEC Invalidate Descriptor) mandates:
>>
>>    "As part of IEC invalidation, hardware must drain interrupt requests
>>     that are already processed by the remapping hardware, but queued
>>     within the Root-Complex to be delivered to the processor."
>>
>> Therefore when qi_flush_iec() + qi_submit_sync() returns (Wait Descriptor
>> reports QI_DONE), all non-committed interrupt messages referencing the
>> invalidated IRTE index are guaranteed to have been delivered to the
>> target LAPIC IRR.  The subsequent vector_schedule_cleanup() is safe
>> because is_vector_pending(prev_vector) will always observe the drained
>> message in IRR, causing the cleanup timer to rearm until the interrupt
>> is properly serviced.
>>
>> In contrast, AMD IOMMU spec Section 2.4.5 defines
>> INVALIDATE_INTERRUPT_TABLE only as:
>>
>>    "instructs the IOMMU to invalidate all cached interrupt information
>>     for the device"
>>
>> with no completion condition, no drain semantics, and no ordering
>> guarantee for previously-remapped interrupt messages.  Section 2.4.11.2
>> ("Invalidation Commands Interaction Requirements") limits the completion
>> guarantee exclusively to DMA transactions:
>>
>>    "Invalidation commands are considered complete only when the IOMMU can
>>     ensure there are no DMA transactions in flight anywhere in the system
>>     fabric that relied on translation cache contents prior to
>>     invalidation."
>>
>> The words "drain", "drained", or "draining" appear zero times in the
>> entire AMD IOMMU specification (Rev 3.10, 48882-PUB, Feb 2025) in
>> connection with interrupt messages.
>>
>> Consequently, iommu_flush_irt_and_complete() returning does NOT guarantee
>> that old (vector, destination) interrupt messages have been delivered to
>> the previous CPU's LAPIC IRR.  The immediate vector_schedule_cleanup()
>> after IRTE modification races with in-flight messages on the Data Fabric:
>> the cleanup timer reads IRR clear (message still in transit), calls
>> free_moved_vector(), then the message arrives at the old CPU hitting
>> VECTOR_UNUSED -- producing "No irq handler for vector" and permanently
>> losing an edge-triggered MSI.
> 
> Please describe the scenario you encountered to reproduce this issue.
> 
>> Fix by restoring three-stage cleanup semantics for the normal
>> (guest_mode=0) path:
>>
>>   1. Change amd_ir_chip.irq_ack from apic_ack_irq to apic_ack_edge,
>>      which calls irq_complete_move().  This ensures cleanup is only
>>      scheduled when the new vector first arrives at the new CPU --
>>      providing a natural delay (device interrupt period + PCIe transit +
>>      IOMMU translation + Data Fabric delivery) that far exceeds any
>>      residual in-flight message transit time.
>>
>>   2. Remove the unconditional vector_schedule_cleanup() from
>>      amd_ir_set_affinity() for the IRTE-modified path.
>>
>>   3. For guest_mode=1 (AVIC/guest interrupt virtualization), the IRTE
>>      is not modified and no host-vector interrupt will arrive (interrupts
>>      are delivered to the vAPIC backing page instead).  Retain direct
>>      vector_schedule_cleanup() in this case to prevent move_in_progress
>>      from permanently blocking future affinity changes.
> 
> Please describe the permanently blocking scenario.
> 
>> The combination of stage-2 natural delay and stage-3 IRR gating
>> (is_vector_pending + timer rearm) provides robust protection against
>> the AMD-specific lack of interrupt drain guarantee.
> 
> Adding some arbitary delay does not necessary guarantee the delivery 
> before clearing the old vector.
> 

Agreed.  There is actually a second weakness in the timer approach that
is independent of the AMD drain question, which I should have called
out.  The per-CPU cleanup timer is shared by all irqs whose prev_cpu is
that CPU.  In __vector_schedule_cleanup():

     hlist_add_head(&apicd->clist, &cl->head);
     if (!timer_pending(&cl->timer)) {
         cl->timer.expires = jiffies + 1;
         add_timer_on(&cl->timer, cpu);
     }

When the timer is already pending, a newly-migrated irq is only added
to the list; expires is NOT reset.  So if several irqs migrate off the
same CPU within one jiffy (irqbalance rebalancing, or a VM with
multiple passthrough devices whose vCPU moves), the later irqs get a
progressively shorter effective delay -- approaching 0:

     irq A migrates at T0        -> arms timer, expires = T0 + 1
     irq B migrates at T0 + 0.5  -> timer pending, ~0.5 jiffy left
     irq C migrates at T0 + 0.9  -> timer pending, ~0.1 jiffy left

At T0+1 the timer walks the list and calls is_vector_pending() per
entry.  is_vector_pending() only reads the local IRR/PIR; it cannot see
a message still in flight.  For irq C the observation window is ~0.1
jiffy, so a stale message not yet in IRR leads to free_moved_vector()
and a later VECTOR_UNUSED hit.

This delay compression is a structural property of sharing one timer
across concurrent migrations -- it applies regardless of vendor drain
semantics.

The three-stage change is immune to it because cleanup is armed by an
event, not by "IRTE write + delay": irq_complete_move() only fires when
the NEW vector's first interrupt actually reaches the new CPU (via
apic_ack_edge).  By causality the new message was produced after the
IRTE change while any stale message was produced before it and entered
the fabric earlier.  So once the new message has completed the full
device->PCIe->IOMMU->fabric->new-CPU path and is being acked, every
earlier stale message has had ample time to reach the old CPU.  Even if
the shared timer then fires with ~0 delay, is_vector_pending() on the
old CPU either sees the stale vector still in IRR (rearm) or sees it
already serviced (safe to free).  There is more less "in flight but IRR 
empty" window.

In short: the timer relies on "delay >= fabric transit" (probabilistic,
compressible toward 0); the three-stage relies on event ordering
(deterministic, unaffected by timer sharing).




>> Intel VT-d, Hyper-V, and UV platforms are not modified as Intel is
>> architecturally safe per the spec guarantees cited above.
>>
>> Fixes: 5478844b12d3 ("iommu/amd: Move interrupt remapping to its own 
>> file")
> 
> Is this the correct commit? I could not find this commit. Could you 
> please provide link to the commit?
> 
>> Signed-off-by: Guanghui Feng <guanghui.fgh@linux.alibaba.com>
>> ---
>>   drivers/iommu/amd/amd_iommu_types.h |  2 +-
>>   drivers/iommu/amd/iommu.c           | 46 +++++++++++++++++++++--------
>>   2 files changed, 34 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/ 
>> amd_iommu_types.h
>> index 8241ef922519..35024e3f5b90 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -1037,7 +1037,7 @@ struct amd_irte_ops {
>>       void (*prepare)(void *, u32, bool, u8, u32, int);
>>       void (*activate)(struct amd_iommu *iommu, void *, u16, u16);
>>       void (*deactivate)(struct amd_iommu *iommu, void *, u16, u16);
>> -    void (*set_affinity)(struct amd_iommu *iommu, void *, u16, u16, 
>> u8, u32);
>> +    bool (*set_affinity)(struct amd_iommu *iommu, void *, u16, u16, 
>> u8, u32);
>>       void *(*get)(struct irq_remap_table *, int);
>>       void (*set_allocated)(struct irq_remap_table *, int);
>>       bool (*is_allocated)(struct irq_remap_table *, int);
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 56262f6b1f70..60e769384e8b 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -3634,7 +3634,7 @@ static void irte_ga_deactivate(struct amd_iommu 
>> *iommu, void *entry, u16 devid,
>>       modify_irte_ga(iommu, devid, index, irte);
>>   }
>> -static void irte_set_affinity(struct amd_iommu *iommu, void *entry, 
>> u16 devid, u16 index,
>> +static bool irte_set_affinity(struct amd_iommu *iommu, void *entry, 
>> u16 devid, u16 index,
>>                     u8 vector, u32 dest_apicid)
>>   {
>>       union irte *irte = (union irte *) entry;
>> @@ -3642,9 +3642,11 @@ static void irte_set_affinity(struct amd_iommu 
>> *iommu, void *entry, u16 devid, u
>>       irte->fields.vector = vector;
>>       irte->fields.destination = dest_apicid;
>>       modify_irte(iommu, devid, index, irte);
>> +
>> +    return true;
> 
> This blindly return true regardless of the return value from 
> modify_irte_ga.
> 
>>   }
>> -static void irte_ga_set_affinity(struct amd_iommu *iommu, void 
>> *entry, u16 devid, u16 index,
>> +static bool irte_ga_set_affinity(struct amd_iommu *iommu, void 
>> *entry, u16 devid, u16 index,
>>                    u8 vector, u32 dest_apicid)
>>   {
>>       struct irte_ga *irte = (struct irte_ga *) entry;
>> @@ -3656,7 +3658,11 @@ static void irte_ga_set_affinity(struct 
>> amd_iommu *iommu, void *entry, u16 devid
>>           irte->hi.fields.destination =
>>                       APICID_TO_IRTE_DEST_HI(dest_apicid);
>>           modify_irte_ga(iommu, devid, index, irte);
>> +
>> +        return true;
>>       }
>> +
>> +    return false;
> 
> This blindly return true regardless of the return value from 
> modify_irte_ga.
> 
>>   }
>>   #define IRTE_ALLOCATED (~1U)
>> @@ -3933,7 +3939,7 @@ static void irq_remapping_free(struct irq_domain 
>> *domain, unsigned int virq,
>>       irq_domain_free_irqs_common(domain, virq, nr_irqs);
>>   }
>> -static void amd_ir_update_irte(struct irq_data *irqd, struct 
>> amd_iommu *iommu,
>> +static bool amd_ir_update_irte(struct irq_data *irqd, struct 
>> amd_iommu *iommu,
>>                      struct amd_ir_data *ir_data,
>>                      struct irq_2_irte *irte_info,
>>                      struct irq_cfg *cfg);
>> @@ -4153,7 +4159,7 @@ static int amd_ir_set_vcpu_affinity(struct 
>> irq_data *data, void *info)
>>   }
>> -static void amd_ir_update_irte(struct irq_data *irqd, struct 
>> amd_iommu *iommu,
>> +static bool amd_ir_update_irte(struct irq_data *irqd, struct 
>> amd_iommu *iommu,
>>                      struct amd_ir_data *ir_data,
>>                      struct irq_2_irte *irte_info,
>>                      struct irq_cfg *cfg)
>> @@ -4163,9 +4169,9 @@ static void amd_ir_update_irte(struct irq_data 
>> *irqd, struct amd_iommu *iommu,
>>        * Atomically updates the IRTE with the new destination, vector
>>        * and flushes the interrupt entry cache.
>>        */
>> -    iommu->irte_ops->set_affinity(iommu, ir_data->entry, irte_info- 
>> >devid,
>> -                      irte_info->index, cfg->vector,
>> -                      cfg->dest_apicid);
>> +    return iommu->irte_ops->set_affinity(iommu, ir_data->entry, 
>> irte_info->devid,
>> +                         irte_info->index, cfg->vector,
>> +                         cfg->dest_apicid);
>>   }
>>   static int amd_ir_set_affinity(struct irq_data *data,
>> @@ -4176,6 +4182,7 @@ static int amd_ir_set_affinity(struct irq_data 
>> *data,
>>       struct irq_cfg *cfg = irqd_cfg(data);
>>       struct irq_data *parent = data->parent_data;
>>       struct amd_iommu *iommu = ir_data->iommu;
>> +    bool irte_modified;
>>       int ret;
>>       if (!iommu)
>> @@ -4185,13 +4192,26 @@ static int amd_ir_set_affinity(struct irq_data 
>> *data,
>>       if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
>>           return ret;
>> -    amd_ir_update_irte(data, iommu, ir_data, irte_info, cfg);
>> +    irte_modified = amd_ir_update_irte(data, iommu, ir_data, 
>> irte_info, cfg);
>> +
>>       /*
>> -     * After this point, all the interrupts will start arriving
>> -     * at the new destination. So, time to cleanup the previous
>> -     * vector allocation.
>> +     * If the IRTE was actually modified (guest_mode == 0), rely on the
>> +     * three-stage cleanup: apic_ack_edge() calls irq_complete_move() 
>> when
>> +     * the new vector first arrives at the new CPU, which then schedules
>> +     * the cleanup of the previous vector allocation.  This avoids a 
>> race
>> +     * where in-flight MSI messages, still on the Data Fabric after the
>> +     * IRT invalidation because the AMD-Vi specification provides no
>> +     * interrupt drain guarantee, arrive after the old vector has been
>> +     * freed.
>> +     *
>> +     * If the IRTE was NOT modified (guest_mode == 1), no in-flight
>> +     * messages exist for the host vector and the new host vector will
>> +     * never receive an interrupt (those go to the vAPIC backing page
>> +     * instead).  Schedule the cleanup directly to prevent
>> +     * move_in_progress from getting permanently stuck.
>>        */
>> -    vector_schedule_cleanup(cfg);
>> +    if (!irte_modified)
>> +        vector_schedule_cleanup(cfg);
> 
> The !irte_modified is really checking guest_mode == 0 before calling 
> vector_schedule_cleanup(). The name is misleading. I also do not see how 
> this resolves the issue instead of calling vector_schedule_cleanup() 
> unconditionally.
> 
>>       return IRQ_SET_MASK_OK_DONE;
>>   }
>> @@ -4205,7 +4225,7 @@ static void ir_compose_msi_msg(struct irq_data 
>> *irq_data, struct msi_msg *msg)
>>   static struct irq_chip amd_ir_chip = {
>>       .name            = "AMD-IR",
>> -    .irq_ack        = apic_ack_irq,
>> +    .irq_ack        = apic_ack_edge,
> 
> The apic_ack_edge() basically calls __vector_schedule_cleanup() before 
> apic_ack_irq() on the new cpu, which should have already been called 
> during irq_set_affinity() and clears the move_in_progress. So, the 
> apic_ack_edge() would not be calling __vector_schedule_cleanup(). I do 
> not see how this would make a different.
> 
>  From AMD IOMMU hardware standpoint,
> 
> 1. The IOMMU considers the interrupt "done" at the point the write 
> completes at the fabric level (i.e. when the upstream posted write is 
> accepted). There is no round-trip back from the CPU APIC.
> 
> 2. When SW issues an interrupt table invalidation followed by 
> COMPLETION_WAIT, the IOMMU must drain all in-flight interrupt before 
> acknowledging the COMPLETION_WAIT. This ensures any stale IRTE data has 
> been flushed before the invalidation is considered complete from the 
> software's perspective.
> 
> 3. The time to drainthe data fabric should be much less than the 1- 
> jiffie during the vector_schedule_cleanup().
> 
> Regards,
> 
> Suravee

I'd like to answer this together with a broader point, because it gets
at why I think the three-stage model is the right fix rather than an
arbitrary delay.

First, the mechanics: the patch has two changes that must be taken
together.  Change removes the unconditional vector_schedule_cleanup()
from amd_ir_set_affinity() for guest_mode=0.  With that removal,
move_in_progress is no longer cleared during irq_set_affinity(); it
stays set until the new vector's first interrupt reaches the new CPU,
where apic_ack_edge() -> irq_complete_move() schedules cleanup.
Without this change, apic_ack_edge() would indeed be a no-op as you
describe.

Second, and more importantly: the three-stage model is not something
this patch invents -- it is already the default for every non-IR x86
interrupt path.  All of these defer cleanup to irq_complete_move() via
their ack/eoi callback and do NOT call vector_schedule_cleanup() in
set_affinity:

     - non-IR MSI/MSI-X       : lapic_controller, apic_ack_edge
     - non-IR IOAPIC level    : ioapic_chip (IRQCHIP_MOVE_DEFERRED),
                                ioapic_ack_level -> irq_complete_move
     - non-IR IOAPIC edge     : ioapic_chip -> apic_ack_edge
     - HPET MSI               : hpet_msi_controller -> apic_ack_edge
     - DMAR MSI               : dmar_msi_controller -> apic_ack_edge
     - Hyper-V PCI MSI (non-IR): hv_pci_msi_controller -> apic_ack_edge
     - AMD IOMMU self irq     : intcapxt_controller -> apic_ack_edge

The IR paths are the exception: because their .irq_ack is apic_ack_irq
(which lacks irq_complete_move), the three-stage trigger can never fire
from the interrupt path, so they were forced to call
vector_schedule_cleanup() directly in set_affinity -- collapsing to a
two-stage model.  apic_ack_edge is simply
"irq_complete_move + apic_ack_irq"; it is the standard ack already used
by lapic_controller for all direct MSI.  So this patch does not add a
new mechanism -- it makes AMD IR consistent with the model IOAPIC and
MSI have used for years, whose -EBUSY gating, IRR rearm fallback, and
free_irq double-slot cleanup are all pre-existing infrastructure.

The safety difference is that the three-stage model relies on event
ordering rather than a delay.  irq_complete_move() only fires when the
NEW vector's first interrupt actually reaches the new CPU.  By causality
the new message was produced after the IRTE change, while any stale
message was produced before it and entered the fabric earlier.  So once
the new message has completed the full device->PCIe->IOMMU->fabric->
new-CPU path and is being acked, every earlier stale message has had
ample time to reach the old CPU.  Even if the shared timer then fires
with ~0 delay, is_vector_pending() on the old CPU either sees the stale
vector still in IRR (rearm) or sees it already serviced (safe to free).
There is no "in flight but IRR empty" window, and no dependence on how
long the delay happens to be.

In short: the two-stage timer relies on "delay >= fabric transit"
(probabilistic, compressible toward 0); the three-stage model relies on
event ordering (deterministic), and is what the rest of x86 already
does.


> 
>>       .irq_set_affinity    = amd_ir_set_affinity,
>>       .irq_set_vcpu_affinity    = amd_ir_set_vcpu_affinity,
>>       .irq_compose_msi_msg    = ir_compose_msi_msg,

