From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [v3 12/26] KVM: Initialize VT-d Posted-Interrupts Descriptor
Date: Fri, 12 Dec 2014 23:14:46 +0800
Message-ID: <1418397300-10870-13-git-send-email-feng.wu@intel.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1418397300-10870-1-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch initializes the VT-d Posted-Interrupts Descriptor.

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 arch/x86/kvm/vmx.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 0b1383e..66ca275 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -45,6 +45,7 @@
 #include <asm/perf_event.h>
 #include <asm/debugreg.h>
 #include <asm/kexec.h>
+#include <asm/irq_remapping.h>
 
 #include "trace.h"
 
@@ -4433,6 +4434,30 @@ static void ept_set_mmio_spte_mask(void)
 	kvm_mmu_set_mmio_spte_mask((0x3ull << 62) | 0x6ull);
 }
 
+static void pi_desc_init(struct vcpu_vmx *vmx)
+{
+	unsigned int dest;
+
+	if (!irq_remapping_cap(IRQ_POSTING_CAP))
+		return;
+
+	/*
+	 * Initialize Posted-Interrupt Descriptor
+	 */
+
+	pi_clear_sn(&vmx->pi_desc);
+	vmx->pi_desc.nv = POSTED_INTR_VECTOR;
+
+	/* Physical mode for Notificaiton Event */
+	vmx->pi_desc.ndm = 0;
+	dest = cpu_physical_id(vmx->vcpu.cpu);
+
+	if (x2apic_enabled())
+		vmx->pi_desc.ndst = dest;
+	else
+		vmx->pi_desc.ndst = (dest << 8) & 0xFF00;
+}
+
 /*
  * Sets up the vmcs for emulated real mode.
  */
@@ -4476,6 +4501,8 @@ static int vmx_vcpu_setup(struct vcpu_vmx *vmx)
 
 		vmcs_write64(POSTED_INTR_NV, POSTED_INTR_VECTOR);
 		vmcs_write64(POSTED_INTR_DESC_ADDR, __pa((&vmx->pi_desc)));
+
+		pi_desc_init(vmx);
 	}
 
 	if (ple_gap) {
-- 
1.9.1
