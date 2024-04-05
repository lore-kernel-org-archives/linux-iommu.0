Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22758179941
	for <iommu@lists.linux.dev>; Fri,  5 Apr 2024 22:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712356016; cv=none; b=M+H8Bap5w/FAgELrNKE9BHobizFIdfLmexatKc/MrsS4X7/iJMdyatQWSo6TBeci2mMPJtMl78qS9YoQCM4CgP2Xrkz6G7Px1jsyRb5IZQEKNlUGB/8naxro2LG+smuVtC1+WfWgADASmT1FyfS5bwn43IgtQQ6ElZRHD+zuPjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712356016; c=relaxed/simple;
	bh=ZGWBCczfujdRtFbtPKsDRo5XDo8fcTnRO3bkTJQexVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mqMpxgjIv05FfjcTtLHBUUwgjc3dt8/I5hJw3JIwxKhPOhkUIoPc0FsrTj4dibWuewbXBro+uIgTLfe0CsFx5tE4te3hjWOisStjCJGlfmsI1amftZn/CfaO7hmUx8chhKr8Xlufi4UDstnuHLxdGT6/TrQAzXyG7NUkN6pMXwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XHtD6pB0; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XHtD6pB0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712356015; x=1743892015;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZGWBCczfujdRtFbtPKsDRo5XDo8fcTnRO3bkTJQexVw=;
  b=XHtD6pB0MYFyzN45EAURMotDCPTAnNmwGppoOz+VHyLk4szxH7tpLVoB
   zcusysWIHcgxVEUtffzMpHyd4mBe2uAAXzZuNnYTG9/U4goDRlEt594zo
   R39Jw2/gpiDW+wONmyVw7OSGx7wn61BiDOZd1WdEh2xEfW9gpMxv6luvj
   5B3e4cbgJ0q3R8XDUVjIkdb+C1Qkx/xlqXvPXZFocU16kIsIPiJSZPRjz
   tC/tfOx/CqGb9jrbCGNzeUKi05Nnimu1mcZuXYnyZSpB9cFCxiTeHM2vg
   r4VUEsfJU7mNI4ODqWszaYHc/GFoXDkTznaio8SfpbryZa3X6x4VZIHZG
   g==;
X-CSE-ConnectionGUID: Bm1AxAkJQYWtnj7obv4jWQ==
X-CSE-MsgGUID: 7NCaQp5DReSdpScxyKMzKQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="19062851"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19062851"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 15:26:54 -0700
X-CSE-ConnectionGUID: dqE0TdDNQ62K5gm9q66mFQ==
X-CSE-MsgGUID: icfEMMlNRoyitei5C2xCcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="23928356"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa004.fm.intel.com with ESMTP; 05 Apr 2024 15:26:52 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	X86 Kernel <x86@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	iommu@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Borislav Petkov" <bp@alien8.de>,
	"Ingo Molnar" <mingo@redhat.com>
Cc: Paul Luse <paul.e.luse@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jens Axboe <axboe@kernel.dk>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	maz@kernel.org,
	seanjc@google.com,
	"Robin Murphy" <robin.murphy@arm.com>,
	jim.harris@samsung.com,
	a.manzanares@samsung.com,
	"Bjorn Helgaas" <helgaas@kernel.org>,
	guang.zeng@intel.com,
	robert.hoo.linux@gmail.com,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 13/13] iommu/vt-d: Enable posted mode for device MSIs
Date: Fri,  5 Apr 2024 15:31:10 -0700
Message-Id: <20240405223110.1609888-14-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240405223110.1609888-1-jacob.jun.pan@linux.intel.com>
References: <20240405223110.1609888-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With posted MSI feature enabled on the CPU side, iommu interrupt
remapping table entries (IRTEs) for device MSI/x can be allocated,
activated, and programed in posted mode. This means that IRTEs are
linked with their respective PIDs of the target CPU.

Handlers for the posted MSI notification vector will de-multiplex
device MSI handlers. CPU notifications are coalesced if interrupts
arrive at a high frequency.

Excluding the following:
- legacy devices IOAPIC, HPET (may be needed for booting, not a source
of high MSIs)
- VT-d's own IRQs (not remappable).

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

---
v2: Fold in helper function for retrieving PID address
v1: Added a warning if the effective affinity mask is not set up
---
 drivers/iommu/intel/irq_remapping.c | 69 +++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index fa719936b44e..ac5f9e83943b 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -19,6 +19,7 @@
 #include <asm/cpu.h>
 #include <asm/irq_remapping.h>
 #include <asm/pci-direct.h>
+#include <asm/posted_intr.h>
 
 #include "iommu.h"
 #include "../irq_remapping.h"
@@ -49,6 +50,7 @@ struct irq_2_iommu {
 	u16 sub_handle;
 	u8  irte_mask;
 	enum irq_mode mode;
+	bool posted_msi;
 };
 
 struct intel_ir_data {
@@ -1118,6 +1120,14 @@ static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
 	irte->redir_hint = 1;
 }
 
+static void prepare_irte_posted(struct irte *irte)
+{
+	memset(irte, 0, sizeof(*irte));
+
+	irte->present = 1;
+	irte->p_pst = 1;
+}
+
 struct irq_remap_ops intel_irq_remap_ops = {
 	.prepare		= intel_prepare_irq_remapping,
 	.enable			= intel_enable_irq_remapping,
@@ -1126,6 +1136,47 @@ struct irq_remap_ops intel_irq_remap_ops = {
 	.enable_faulting	= enable_drhd_fault_handling,
 };
 
+#ifdef CONFIG_X86_POSTED_MSI
+
+static phys_addr_t get_pi_desc_addr(struct irq_data *irqd)
+{
+	int cpu = cpumask_first(irq_data_get_effective_affinity_mask(irqd));
+
+	if (WARN_ON(cpu >= nr_cpu_ids))
+		return 0;
+
+	return __pa(per_cpu_ptr(&posted_interrupt_desc, cpu));
+}
+
+static void intel_ir_reconfigure_irte_posted(struct irq_data *irqd)
+{
+	struct intel_ir_data *ir_data = irqd->chip_data;
+	struct irte *irte = &ir_data->irte_entry;
+	struct irte irte_pi;
+	u64 pid_addr;
+
+	pid_addr = get_pi_desc_addr(irqd);
+
+	if (!pid_addr) {
+		pr_warn("Failed to setup IRQ %d for posted mode", irqd->irq);
+		return;
+	}
+
+	memset(&irte_pi, 0, sizeof(irte_pi));
+
+	/* The shared IRTE already be set up as posted during alloc_irte */
+	dmar_copy_shared_irte(&irte_pi, irte);
+
+	irte_pi.pda_l = (pid_addr >> (32 - PDA_LOW_BIT)) & ~(-1UL << PDA_LOW_BIT);
+	irte_pi.pda_h = (pid_addr >> 32) & ~(-1UL << PDA_HIGH_BIT);
+
+	modify_irte(&ir_data->irq_2_iommu, &irte_pi);
+}
+
+#else
+static inline void intel_ir_reconfigure_irte_posted(struct irq_data *irqd) {}
+#endif
+
 static void intel_ir_reconfigure_irte(struct irq_data *irqd, bool force)
 {
 	struct intel_ir_data *ir_data = irqd->chip_data;
@@ -1139,8 +1190,9 @@ static void intel_ir_reconfigure_irte(struct irq_data *irqd, bool force)
 	irte->vector = cfg->vector;
 	irte->dest_id = IRTE_DEST(cfg->dest_apicid);
 
-	/* Update the hardware only if the interrupt is in remapped mode. */
-	if (force || ir_data->irq_2_iommu.mode == IRQ_REMAPPING)
+	if (ir_data->irq_2_iommu.posted_msi)
+		intel_ir_reconfigure_irte_posted(irqd);
+	else if (force || ir_data->irq_2_iommu.mode == IRQ_REMAPPING)
 		modify_irte(&ir_data->irq_2_iommu, irte);
 }
 
@@ -1194,7 +1246,7 @@ static int intel_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 	struct intel_ir_data *ir_data = data->chip_data;
 	struct vcpu_data *vcpu_pi_info = info;
 
-	/* stop posting interrupts, back to remapping mode */
+	/* stop posting interrupts, back to the default mode */
 	if (!vcpu_pi_info) {
 		modify_irte(&ir_data->irq_2_iommu, &ir_data->irte_entry);
 	} else {
@@ -1320,6 +1372,11 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
 		break;
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
+		if (posted_msi_supported()) {
+			prepare_irte_posted(irte);
+			data->irq_2_iommu.posted_msi = 1;
+		}
+
 		set_msi_sid(irte,
 			    pci_real_dma_dev(msi_desc_to_pci_dev(info->desc)));
 		break;
@@ -1407,7 +1464,11 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
 
 		irq_data->hwirq = (index << 16) + i;
 		irq_data->chip_data = ird;
-		irq_data->chip = &intel_ir_chip;
+		if (posted_msi_supported() &&
+			((info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI) || (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSIX)))
+			irq_data->chip = &intel_ir_chip_post_msi;
+		else
+			irq_data->chip = &intel_ir_chip;
 		intel_irq_remapping_prepare_irte(ird, irq_cfg, info, index, i);
 		irq_set_status_flags(virq + i, IRQ_MOVE_PCNTXT);
 	}
-- 
2.25.1

