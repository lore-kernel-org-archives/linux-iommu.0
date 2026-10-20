Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491823;
	b=TM0fcI1gdUSlEJT7PWUaAfk+3YNxs/kgsF4VXFnlTYsD3CXc1QX7HEhhJvzQLn7CLzEN
	 h4V1B00Ko0Pb7BSuu6VCXWqNuIqeGsoIbTqAQtqHfkEWKEflzzrr9+yxaPGjebrKfRVo1
	 wslAKH2fXG5I2ivl2+SyWZXQG2dczDHp/u8YkgY4DJt6PDp5jbGSz564foDWhir4xpokX
	 2mg1Rj/xBCL+d9P/OGH3p0wPwKl5d1iKqfL/sR4lEK0PzDnT8mWo+GVsvkf1oyctNA5hz
	 /5Up7llFIGih76ZF5tecJvdi4+dIZ4+J8b0dMiSRNzlRSd0oxcTF/Jsf21yBgTyDnNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491823;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=cSnoUA90mlUxekQeFc68BHLZAlrA5o2so5aosOLuylE=;
	b=jr/cCz1llUKj/tIcAmOR0grgL58KTqarEUcyG8eghwxuPsGXPXtVDsILtMFwjQdUVQtb
	 4+StB9g8rwLiH9wXyprjOUEb38oX2CHMD+RzuhcoSHl6K11xdtZUaauW/fo71FoVWIKsF
	 ZTqlE4ZTFi8mByI9HA0wqJB4EnhKgt00yk9KMOBRkFNw4dANb3sV7dE8i2OEJ8uFY5YtH
	 uLDt9SxOy3riTET5CdG3lFCkmjWmpzWJF0cJogDvINgWcbOsivLVgXdmU4fwXAPdy03WE
	 eV5McMjI/FszCCjr74rhUsX2WiWvbJK4eUoivLks7ocSWIznvWE7JYCAhG17O/DZ8hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=S+Wr5QTa;
	arc=none smtp.remote-ip=115.124.30.133
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17226606A323
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 10:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17226606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=S+Wr5QTa
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792491818; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cSnoUA90mlUxekQeFc68BHLZAlrA5o2so5aosOLuylE=;
	b=S+Wr5QTasdqVTdcWRj4TDgZJJpmaz9u5SXU4gIMiHXGaut6VhNE6oYgxMEkYtaHZD9OQLbptkLyM2jAcBYiWkNDPYmAAZIWwgi1w0axo+M0pKn2EFjBwZXc9Oeg0xjdRTRCu1Yk7q2H4JbVrC1aH0ubul3zPY/JsBYNgjuxZcM4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XDD4wPh_1792491816;
Received: from 30.221.134.80(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XDD4wPh_1792491816 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 20 Oct 2026 18:23:37 +0800
Message-ID: <f55c7a60-521a-4a46-aae8-60dd9286c003@linux.alibaba.com>
Date: Tue, 20 Oct 2026 18:23:35 +0800
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
 robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: "Shu, Ming" <Ming.Shu@amd.com>, "Shukla, Santosh" <Santosh.Shukla@amd.com>
References: <20261015042347.1823813-1-guanghuifeng@linux.alibaba.com>
 <54db5f22-ba63-433d-b98d-d6dc6b17b27f@amd.com>
From: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <54db5f22-ba63-433d-b98d-d6dc6b17b27f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thank you for the detailed review and the hardware clarification.

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

We observed this on kernel 5.10 in a virtualization shared-instance
deployment:

- Guest uses VFIO passthrough devices (NVMe, NIC) with IOMMU interrupt
   remapping enabled (non-posted mode, guest_mode=0).
- Interrupts are delivered via KVM irqfd/eventfd software injection
   path, not hardware posted interrupts.
- When a vCPU is migrated to a different physical CPU (scheduler
   balancing or NUMA-aware placement), may adjusts the associated
   device interrupt affinity to follow the vCPU's new pCPU via
   irq_set_affinity -> amd_ir_set_affinity.
- During this affinity migration, the device continues generating MSI
   at high rate.  We observe intermittent "do_IRQ: X.Y No irq handler
   for vector" messages

Note: kernel 5.10 does not contain commit bdc1dad299bb ("x86/vector:
Replace IRQ_MOVE_CLEANUP_VECTOR with a timer callback").  In 5.10,
the cleanup path uses send_cleanup_vector() which sends an IPI
(IRQ_MOVE_CLEANUP_VECTOR) directly to the old CPU.  The IPI arrives
and runs sysvec_irq_move_cleanup() almost immediately -- providing
even less delay than the timer-based approach in newer kernels.
This makes the race window significantly wider on 5.10.

Commit bdc1dad299bb already recognized and partially mitigated this
class of issue by:
   - Replacing the immediate IPI with a per-CPU timer (jiffies+1)
   - Adding is_vector_pending() IRR check before freeing


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

When guest_mode=1 (AVIC), irte_ga_set_affinity() does not modify the
IRTE (guarded by "if (!irte->lo.fields_remap.guest_mode)").  However,
the parent domain (apic_set_affinity) has already allocated a new host
vector and set move_in_progress=1.  Since the IRTE still points to
the guest vAPIC backing page, no interrupt will ever arrive at the
host with the new vector, so irq_complete_move() will never fire.

Without vector_schedule_cleanup() in this path, move_in_progress stays
set permanently.  Subsequent calls to assign_vector_locked() check:

     if (apicd->move_in_progress || !hlist_unhashed(&apicd->clist))
         return -EBUSY;

This causes all future affinity changes for this IRQ to fail with
-EBUSY, which irq_move_masked_irq() handles by re-setting
IRQD_SETAFFINITY_PENDING -- but since no interrupt arrives on the
host to trigger __irq_move_irq(), the pending request is never
processed.  The IRQ's affinity becomes permanently stuck.


> 
>> The combination of stage-2 natural delay and stage-3 IRR gating
>> (is_vector_pending + timer rearm) provides robust protection against
>> the AMD-specific lack of interrupt drain guarantee.
> 
> Adding some arbitary delay does not necessary guarantee the delivery 
> before clearing the old vector.
> 
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

I believe there may be a misunderstanding.  The patch has two parts
that work together as a pair:

   Part (1): Change .irq_ack to apic_ack_edge (adds irq_complete_move)
   Part (2): REMOVE the unconditional vector_schedule_cleanup() from
             amd_ir_set_affinity() for the guest_mode=0 path

With part (2), move_in_progress is NOT cleared during
irq_set_affinity() anymore.  It remains set until the new vector
first arrives at the new CPU and apic_ack_edge() -> irq_complete_move()
fires. both changes are required together.

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

- COMPLETION_WAIT guarantees all in-flight interrupts are drained
   before software proceeds (point 2).
- The drain time is well within 1 jiffy (point 3).
- The timer + is_vector_pending() IRR check from bdc1dad299bb
   provides additional safety margin.

With this understanding, we agree that mainline kernels (containing
bdc1dad299bb) are safe without this patch.

> 
>>       .irq_set_affinity    = amd_ir_set_affinity,
>>       .irq_set_vcpu_affinity    = amd_ir_set_vcpu_affinity,
>>       .irq_compose_msi_msg    = ir_compose_msi_msg,

