From: Wanpeng Li <kernellwp@gmail.com>
Subject: [PATCH] iommu/vt-d: Fix modify_irte NULL pointer
Date: Mon, 22 Aug 2016 20:23:09 +0800
Message-ID: <1471868589-3909-1-git-send-email-wanpeng.li@hotmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: Wanpeng Li <wanpeng.li@hotmail.com>, Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: iommu@lists.linux-foundation.org

From: Wanpeng Li <wanpeng.li@hotmail.com>

native_smp_prepare_cpus
  -> default_setup_apic_routing
    -> enable_IR_x2apic
      -> irq_remapping_prepare
        -> intel_prepare_irq_remapping
          -> parse_ioapics_under_ir   => return 0
		    -> ir_parse_ioapic_hpet_scope
		      -> ir_parse_one_ioapic_scope 	
          -> intel_setup_irq_remapping		  

IR table is setup even if noapic boot parameter is added.

As a result:

    BUG: unable to handle kernel NULL pointer dereference at           (null)
    IP: [<ffffffff8d5a5e58>] modify_irte+0x58/0x140
    PGD 209638067 PUD 2105f4067 PMD 0 
    Oops: 0000 [#1] SMP
    RIP: 0010:[<ffffffff8d5a5e58>]  [<ffffffff8d5a5e58>] modify_irte+0x58/0x140
    Call Trace:
     intel_ir_set_affinity+0xa3/0xb0
     msi_domain_set_affinity+0x21/0x70
     ? __irq_set_affinity+0x34/0x70
     irq_do_set_affinity+0x1d/0x70
     irq_set_affinity_locked+0xc2/0x100
     __irq_set_affinity+0x47/0x70
     write_irq_affinity.isra.7+0xcc/0xf0
     irq_affinity_proc_write+0x19/0x20
     proc_reg_write+0x3d/0x70
     ? rcu_sync_lockdep_assert+0x2f/0x60
     __vfs_write+0x28/0x120
     ? percpu_down_read+0x5c/0xa0
     ? __sb_start_write+0xca/0xe0
     ? __sb_start_write+0xca/0xe0
     vfs_write+0xb5/0x1b0
     SyS_write+0x49/0xa0
     do_syscall_64+0x81/0x220
     entry_SYSCALL64_slow_path+0x25/0x25
    RIP  [<ffffffff8d5a5e58>] modify_irte+0x58/0x140
     RSP <ffff8e9ad01b7c78>
    CR2: 0000000000000000
    
irqbalance is running at the end of booting and changes the irq affinity, 
then irte is flushed. We should not have MSI and such if apic is disabled. 
This patch fix it by return -ENODEV if apic is disabled in order to avoid 
to setup ir table for ioapic.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
---
 drivers/iommu/intel_irq_remapping.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index ac59692..f1cb7c6 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -854,6 +854,9 @@ static int ir_parse_one_ioapic_scope(struct acpi_dmar_device_scope *scope,
 	count = (scope->length - sizeof(struct acpi_dmar_device_scope))
 		/ sizeof(struct acpi_dmar_pci_path);
 
+	if (skip_ioapic_setup)
+		return -ENODEV;
+
 	while (--count > 0) {
 		/*
 		 * Access PCI directly due to the PCI
-- 
1.9.1
