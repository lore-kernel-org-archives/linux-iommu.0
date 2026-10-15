Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3213921C6
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 04:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792038253; cv=none; b=CoNnQBW0SucQhzN6+2dAye4tVP6WJD61PcvnOqTiZW1CMQMz9XC/7YsGZ2aW8GIpDaCvD66tkAVnCxTTw2HxlvfIs/B/brEafFQjmIS+eAfHiAo9EqX9TebhJAsrHbcqaBZ7vC8andcpTWhwkye7ueVwicyB1QqrJJeu6kgCs8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792038253; c=relaxed/simple;
	bh=HBsRSDytGP1ixAALMZ5BxVYMOlkdn2lfW2SfQbXtfR4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YddWdlxmMC000uemiWykNxRObrSkoqE1jXaNe3XVfgNNq/lTZhxmK5tQH1hKpgAr4Awn7RqdQ/QpLBVKZe7X2wfQBABYdL7vpLJwrQn1fPdeOPmyxlNUYgBGM2/U/Aj0CEHZYgVxkOWrUxRInNDEu0wbU0Ycn+lyvOc/2TxgGr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=v/CsGVII; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="v/CsGVII"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792038245; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=uSfhX7WAmylRzrNtrWoK1R7H9Xh+c4oQUQrMJZhdohI=;
	b=v/CsGVIIAKTvJxJsbcqCNWh0B+ixzMfa7D+ClhzryHhyhH7mL6Oq4eDyoXKahYE0RwHNYcTe8V9QIUYzEzxgzMXvACgezDQQoVUQ9c5kiKYUE57efmwXb6cEKangKLEL3EyRlkBLj1/ZbmJaKBw1NCpxmF32nh29Q9b4enFiPiE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0XCqWEQv_1792038228;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XCqWEQv_1792038228 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 15 Oct 2026 12:24:05 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/amd: Restore three-stage vector cleanup for IR affinity migration
Date: Thu, 15 Oct 2026 12:23:47 +0800
Message-ID: <20261015042347.1823813-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guanghui Feng <guanghui.fgh@linux.alibaba.com>

AMD IOMMU specification (Rev 3.10) does not define interrupt message
draining semantics for INVALIDATE_INTERRUPT_TABLE + COMPLETION_WAIT.
This creates a race between vector_schedule_cleanup() and in-flight MSI
messages still transiting the Data Fabric after IRTE modification.

Intel VT-d is architecturally safe due to explicit interrupt draining
guarantees.  VT-d spec Section 6.5.5 states:

  "An interrupt request is considered drained when the interrupt is
   accepted by the processor Local xAPIC (for fixed and lowest priority
   delivery mode interrupts this means the interrupt is at least
   recorded in the Local xAPIC Interrupt Request Register (IRR))."

  "Interrupt draining is performed by remapping hardware after Interrupt
   Entry Cache (IEC) invalidation requests.  For IEC invalidations
   submitted through the queued invalidation interface, interrupt
   draining must be completed before the next Invalidation Wait
   Descriptor is completed by hardware."

  "For index-selective IEC invalidation requests, hardware only
   guarantees draining of non-committed interrupt requests referencing
   interrupt indexes specified in the invalidation request."

Additionally, Section 6.5.2.8 (IEC Invalidate Descriptor) mandates:

  "As part of IEC invalidation, hardware must drain interrupt requests
   that are already processed by the remapping hardware, but queued
   within the Root-Complex to be delivered to the processor."

Therefore when qi_flush_iec() + qi_submit_sync() returns (Wait Descriptor
reports QI_DONE), all non-committed interrupt messages referencing the
invalidated IRTE index are guaranteed to have been delivered to the
target LAPIC IRR.  The subsequent vector_schedule_cleanup() is safe
because is_vector_pending(prev_vector) will always observe the drained
message in IRR, causing the cleanup timer to rearm until the interrupt
is properly serviced.

In contrast, AMD IOMMU spec Section 2.4.5 defines
INVALIDATE_INTERRUPT_TABLE only as:

  "instructs the IOMMU to invalidate all cached interrupt information
   for the device"

with no completion condition, no drain semantics, and no ordering
guarantee for previously-remapped interrupt messages.  Section 2.4.11.2
("Invalidation Commands Interaction Requirements") limits the completion
guarantee exclusively to DMA transactions:

  "Invalidation commands are considered complete only when the IOMMU can
   ensure there are no DMA transactions in flight anywhere in the system
   fabric that relied on translation cache contents prior to
   invalidation."

The words "drain", "drained", or "draining" appear zero times in the
entire AMD IOMMU specification (Rev 3.10, 48882-PUB, Feb 2025) in
connection with interrupt messages.

Consequently, iommu_flush_irt_and_complete() returning does NOT guarantee
that old (vector, destination) interrupt messages have been delivered to
the previous CPU's LAPIC IRR.  The immediate vector_schedule_cleanup()
after IRTE modification races with in-flight messages on the Data Fabric:
the cleanup timer reads IRR clear (message still in transit), calls
free_moved_vector(), then the message arrives at the old CPU hitting
VECTOR_UNUSED -- producing "No irq handler for vector" and permanently
losing an edge-triggered MSI.

Fix by restoring three-stage cleanup semantics for the normal
(guest_mode=0) path:

 1. Change amd_ir_chip.irq_ack from apic_ack_irq to apic_ack_edge,
    which calls irq_complete_move().  This ensures cleanup is only
    scheduled when the new vector first arrives at the new CPU --
    providing a natural delay (device interrupt period + PCIe transit +
    IOMMU translation + Data Fabric delivery) that far exceeds any
    residual in-flight message transit time.

 2. Remove the unconditional vector_schedule_cleanup() from
    amd_ir_set_affinity() for the IRTE-modified path.

 3. For guest_mode=1 (AVIC/guest interrupt virtualization), the IRTE
    is not modified and no host-vector interrupt will arrive (interrupts
    are delivered to the vAPIC backing page instead).  Retain direct
    vector_schedule_cleanup() in this case to prevent move_in_progress
    from permanently blocking future affinity changes.

The combination of stage-2 natural delay and stage-3 IRR gating
(is_vector_pending + timer rearm) provides robust protection against
the AMD-specific lack of interrupt drain guarantee.

Intel VT-d, Hyper-V, and UV platforms are not modified as Intel is
architecturally safe per the spec guarantees cited above.

Fixes: 5478844b12d3 ("iommu/amd: Move interrupt remapping to its own file")
Signed-off-by: Guanghui Feng <guanghui.fgh@linux.alibaba.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/iommu.c           | 46 +++++++++++++++++++++--------
 2 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 8241ef922519..35024e3f5b90 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -1037,7 +1037,7 @@ struct amd_irte_ops {
 	void (*prepare)(void *, u32, bool, u8, u32, int);
 	void (*activate)(struct amd_iommu *iommu, void *, u16, u16);
 	void (*deactivate)(struct amd_iommu *iommu, void *, u16, u16);
-	void (*set_affinity)(struct amd_iommu *iommu, void *, u16, u16, u8, u32);
+	bool (*set_affinity)(struct amd_iommu *iommu, void *, u16, u16, u8, u32);
 	void *(*get)(struct irq_remap_table *, int);
 	void (*set_allocated)(struct irq_remap_table *, int);
 	bool (*is_allocated)(struct irq_remap_table *, int);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 56262f6b1f70..60e769384e8b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3634,7 +3634,7 @@ static void irte_ga_deactivate(struct amd_iommu *iommu, void *entry, u16 devid,
 	modify_irte_ga(iommu, devid, index, irte);
 }
 
-static void irte_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid, u16 index,
+static bool irte_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid, u16 index,
 			      u8 vector, u32 dest_apicid)
 {
 	union irte *irte = (union irte *) entry;
@@ -3642,9 +3642,11 @@ static void irte_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid, u
 	irte->fields.vector = vector;
 	irte->fields.destination = dest_apicid;
 	modify_irte(iommu, devid, index, irte);
+
+	return true;
 }
 
-static void irte_ga_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid, u16 index,
+static bool irte_ga_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid, u16 index,
 				 u8 vector, u32 dest_apicid)
 {
 	struct irte_ga *irte = (struct irte_ga *) entry;
@@ -3656,7 +3658,11 @@ static void irte_ga_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid
 		irte->hi.fields.destination =
 					APICID_TO_IRTE_DEST_HI(dest_apicid);
 		modify_irte_ga(iommu, devid, index, irte);
+
+		return true;
 	}
+
+	return false;
 }
 
 #define IRTE_ALLOCATED (~1U)
@@ -3933,7 +3939,7 @@ static void irq_remapping_free(struct irq_domain *domain, unsigned int virq,
 	irq_domain_free_irqs_common(domain, virq, nr_irqs);
 }
 
-static void amd_ir_update_irte(struct irq_data *irqd, struct amd_iommu *iommu,
+static bool amd_ir_update_irte(struct irq_data *irqd, struct amd_iommu *iommu,
 			       struct amd_ir_data *ir_data,
 			       struct irq_2_irte *irte_info,
 			       struct irq_cfg *cfg);
@@ -4153,7 +4159,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 }
 
 
-static void amd_ir_update_irte(struct irq_data *irqd, struct amd_iommu *iommu,
+static bool amd_ir_update_irte(struct irq_data *irqd, struct amd_iommu *iommu,
 			       struct amd_ir_data *ir_data,
 			       struct irq_2_irte *irte_info,
 			       struct irq_cfg *cfg)
@@ -4163,9 +4169,9 @@ static void amd_ir_update_irte(struct irq_data *irqd, struct amd_iommu *iommu,
 	 * Atomically updates the IRTE with the new destination, vector
 	 * and flushes the interrupt entry cache.
 	 */
-	iommu->irte_ops->set_affinity(iommu, ir_data->entry, irte_info->devid,
-				      irte_info->index, cfg->vector,
-				      cfg->dest_apicid);
+	return iommu->irte_ops->set_affinity(iommu, ir_data->entry, irte_info->devid,
+					     irte_info->index, cfg->vector,
+					     cfg->dest_apicid);
 }
 
 static int amd_ir_set_affinity(struct irq_data *data,
@@ -4176,6 +4182,7 @@ static int amd_ir_set_affinity(struct irq_data *data,
 	struct irq_cfg *cfg = irqd_cfg(data);
 	struct irq_data *parent = data->parent_data;
 	struct amd_iommu *iommu = ir_data->iommu;
+	bool irte_modified;
 	int ret;
 
 	if (!iommu)
@@ -4185,13 +4192,26 @@ static int amd_ir_set_affinity(struct irq_data *data,
 	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
 		return ret;
 
-	amd_ir_update_irte(data, iommu, ir_data, irte_info, cfg);
+	irte_modified = amd_ir_update_irte(data, iommu, ir_data, irte_info, cfg);
+
 	/*
-	 * After this point, all the interrupts will start arriving
-	 * at the new destination. So, time to cleanup the previous
-	 * vector allocation.
+	 * If the IRTE was actually modified (guest_mode == 0), rely on the
+	 * three-stage cleanup: apic_ack_edge() calls irq_complete_move() when
+	 * the new vector first arrives at the new CPU, which then schedules
+	 * the cleanup of the previous vector allocation.  This avoids a race
+	 * where in-flight MSI messages, still on the Data Fabric after the
+	 * IRT invalidation because the AMD-Vi specification provides no
+	 * interrupt drain guarantee, arrive after the old vector has been
+	 * freed.
+	 *
+	 * If the IRTE was NOT modified (guest_mode == 1), no in-flight
+	 * messages exist for the host vector and the new host vector will
+	 * never receive an interrupt (those go to the vAPIC backing page
+	 * instead).  Schedule the cleanup directly to prevent
+	 * move_in_progress from getting permanently stuck.
 	 */
-	vector_schedule_cleanup(cfg);
+	if (!irte_modified)
+		vector_schedule_cleanup(cfg);
 
 	return IRQ_SET_MASK_OK_DONE;
 }
@@ -4205,7 +4225,7 @@ static void ir_compose_msi_msg(struct irq_data *irq_data, struct msi_msg *msg)
 
 static struct irq_chip amd_ir_chip = {
 	.name			= "AMD-IR",
-	.irq_ack		= apic_ack_irq,
+	.irq_ack		= apic_ack_edge,
 	.irq_set_affinity	= amd_ir_set_affinity,
 	.irq_set_vcpu_affinity	= amd_ir_set_vcpu_affinity,
 	.irq_compose_msi_msg	= ir_compose_msi_msg,
-- 
2.43.7

