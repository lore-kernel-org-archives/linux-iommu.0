From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 03/55] iommu/vt-d: Add name to irq chip
Date: Tue, 20 Jun 2017 01:37:03 +0200
Message-ID: <20170619235443.431939968@linutronix.de>
References: <20170619233700.547167146@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=iommu-vt-d--Add-name-to-irq-chip.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Add the missing name, so debugging will work proper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
---
 drivers/iommu/intel_irq_remapping.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -1205,10 +1205,11 @@ static int intel_ir_set_vcpu_affinity(st
 }
 
 static struct irq_chip intel_ir_chip = {
-	.irq_ack = ir_ack_apic_edge,
-	.irq_set_affinity = intel_ir_set_affinity,
-	.irq_compose_msi_msg = intel_ir_compose_msi_msg,
-	.irq_set_vcpu_affinity = intel_ir_set_vcpu_affinity,
+	.name			= "INTEL-IR",
+	.irq_ack		= ir_ack_apic_edge,
+	.irq_set_affinity	= intel_ir_set_affinity,
+	.irq_compose_msi_msg	= intel_ir_compose_msi_msg,
+	.irq_set_vcpu_affinity	= intel_ir_set_vcpu_affinity,
 };
 
 static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
