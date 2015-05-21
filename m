From: Feng Wu <feng.wu@intel.com>
Subject: [v6 0/8] Add VT-d Posted-Interrupts support - IOMMU part
Date: Thu, 21 May 2015 14:59:07 +0800
Message-ID: <1432191555-3516-1-git-send-email-feng.wu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, dwmw2@infradead.org
Cc: tglx@linutronix.de, jiang.liu@linux.intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Feng Wu <feng.wu@intel.com>
List-Id: iommu@lists.linux-foundation.org

VT-d Posted-Interrupts is an enhancement to CPU side Posted-Interrupt.
With VT-d Posted-Interrupts enabled, external interrupts from
direct-assigned devices can be delivered to guests without VMM
intervention when guest is running in non-root mode.

You can find the VT-d Posted-Interrtups Spec. in the following URL:
http://www.intel.com/content/www/us/en/intelligent-systems/intel-technology/vt-directed-io-spec.html

This series was part of http://thread.gmane.org/gmane.linux.kernel.iommu/7708. To make things clear, send out IOMMU part here.

This patch-set is based on the lastest x86/apic branch of tip tree.

Divide the whole series which contain multiple components into three parts:
- Prerequisite changes to irq subsystem (already merged in tip tree x86/apic branch)
- IOMMU part (in this series)
- KVM and VFIO parts (will send out this part once the first two parts are accepted)

v5->v6:
* Extend 'struct irte' for VT-d Posted-Interrupts, combine remapped
and posted mode into one irte structure.

v4->v5:
* Abstract modify_irte() to accept two format of irte.

v3->v4:
* Change capability to a int variant flags instead of a function call.
* Add hotplug case for VT-d PI.


Feng Wu (7):
  iommu: Add new member capability to struct irq_remap_ops
  iommu, x86: Implement irq_set_vcpu_affinity for intel_ir_chip
  iommu, x86: No need to migrating irq for VT-d Posted-Interrupts
  iommu, x86: Add cap_pi_support() to detect VT-d PI capability
  iommu, x86: Setup Posted-Interrupts capability for Intel iommu
  iommu, x86: define irq_remapping_cap()
  iommu, x86: Properly handler PI for IOMMU hotplug

Thomas Gleixner (1):
  iommu: dmar: Extend struct irte for VT-d Posted-Interrupts

 arch/x86/include/asm/irq_remapping.h | 11 ++++++
 drivers/iommu/intel_irq_remapping.c  | 77 +++++++++++++++++++++++++++++++++++-
 drivers/iommu/irq_remapping.c        | 11 ++++++
 drivers/iommu/irq_remapping.h        |  6 +++
 include/linux/dmar.h                 | 70 +++++++++++++++++++++++++-------
 include/linux/intel-iommu.h          |  1 +
 6 files changed, 160 insertions(+), 16 deletions(-)

-- 
2.1.0
