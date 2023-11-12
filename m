Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A041F8C0F
	for <iommu@lists.linux.dev>; Sun, 12 Nov 2023 04:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WmnuHT/6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699762338; x=1731298338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BmEOk8548DeJZDcMSeMiFjR9mep2QMzw5DJH2sJXQNs=;
  b=WmnuHT/63WmDsx5aauuF6hmkwAfxTpCdDZSP2AkP3jdxrn9X3AwDVYye
   AppD/cgRBGMYLthxLdPkn4qqitzeNUoJyr7r3nH0dJX8OBZvsr1Btggja
   TVjy/vmhJJ9S9de1fgfSKohXdGVrU3o3JK++53GeDr+OEp4WzOu/7wkoK
   GvP//17raZQHgexXKEagQT6rffuhjK6Lj9c8kwYQuuSrydQzMc2Z0E/VJ
   oxEFRf2Z0nHiUIVnOAmARUmKLreeemPGc5QPBKv2n2xuGaUBRK4ULtFie
   HPYX9NRv2LtBKjn1NtXHns2xIxvRUc1ttThTzcOka94ksf/mvE6bH9FgD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="476533972"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="476533972"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 20:12:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="713936770"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="713936770"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.116])
  by orsmga003.jf.intel.com with ESMTP; 11 Nov 2023 20:12:09 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	X86 Kernel <x86@kernel.org>,
	iommu@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Borislav Petkov" <bp@alien8.de>,
	"Ingo Molnar" <mingo@redhat.com>
Cc: Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	maz@kernel.org,
	peterz@infradead.org,
	seanjc@google.com,
	"Robin Murphy" <robin.murphy@arm.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH RFC 11/13] iommu/vt-d: Add an irq_chip for posted MSIs
Date: Sat, 11 Nov 2023 20:16:41 -0800
Message-Id: <20231112041643.2868316-12-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With posted MSIs, end of interrupt is handled by the notification
handler. Each MSI handler does not go through local APIC IRR, ISR
processing. There's no need to do apic_eoi() in those handlers.

Add a new acpi_ack_irq_no_eoi() for the posted MSI IR chip. At runtime
the call trace looks like:

__sysvec_posted_msi_notification() {
  irq_chip_ack_parent() {
    apic_ack_irq_no_eoi();
  }
  handle_irq_event() {
    handle_irq_event_percpu() {
       driver_handler()
    }
  }

IO-APIC IR is excluded the from posted MSI, we need to make sure it
still performs EOI.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/include/asm/apic.h         |  1 +
 arch/x86/kernel/apic/io_apic.c      |  2 +-
 arch/x86/kernel/apic/vector.c       |  5 ++++
 drivers/iommu/intel/irq_remapping.c | 38 ++++++++++++++++++++++++++++-
 4 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 5af4ec1a0f71..a88015d5638b 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -485,6 +485,7 @@ static inline void apic_setup_apic_calls(void) { }
 #endif /* CONFIG_X86_LOCAL_APIC */
 
 extern void apic_ack_irq(struct irq_data *data);
+extern void apic_ack_irq_no_eoi(struct irq_data *data);
 
 static inline bool lapic_vector_set_in_irr(unsigned int vector)
 {
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 00da6cf6b07d..ca398ee9075b 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1993,7 +1993,7 @@ static struct irq_chip ioapic_ir_chip __read_mostly = {
 	.irq_startup		= startup_ioapic_irq,
 	.irq_mask		= mask_ioapic_irq,
 	.irq_unmask		= unmask_ioapic_irq,
-	.irq_ack		= irq_chip_ack_parent,
+	.irq_ack		= apic_ack_irq,
 	.irq_eoi		= ioapic_ir_ack_level,
 	.irq_set_affinity	= ioapic_set_affinity,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 14fc33cfdb37..01223ac4f57a 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -911,6 +911,11 @@ void apic_ack_irq(struct irq_data *irqd)
 	apic_eoi();
 }
 
+void apic_ack_irq_no_eoi(struct irq_data *irqd)
+{
+	irq_move_irq(irqd);
+}
+
 void apic_ack_edge(struct irq_data *irqd)
 {
 	irq_complete_move(irqd_cfg(irqd));
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 29b9e55dcf26..f2870d3c8313 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1233,6 +1233,42 @@ static struct irq_chip intel_ir_chip = {
 	.irq_set_vcpu_affinity	= intel_ir_set_vcpu_affinity,
 };
 
+/*
+ * With posted MSIs, all vectors are multiplexed into a single notification
+ * vector. Devices MSIs are then dispatched in a demux loop where
+ * EOIs can be coalesced as well.
+ *
+ * IR chip "INTEL-IR-POST" does not do EOI on ACK instead letting posted
+ * interrupt notification handler to perform EOI.
+ *
+ * For the example below, 3 MSIs are coalesced in one CPU notification. Only
+ * one apic_eoi() is needed.
+ *
+ * __sysvec_posted_msi_notification() {
+ * irq_enter()
+ *	handle_edge_irq()
+ *		irq_chip_ack_parent()
+ *			apic_ack_irq_no_eoi()
+ *		handle_irq()
+ *	handle_edge_irq()
+ *		irq_chip_ack_parent()
+ *			apic_ack_irq_no_eoi()
+ *		handle_irq()
+ *	handle_edge_irq()
+ *		irq_chip_ack_parent()
+ *			apic_ack_irq_no_eoi()
+ *		handle_irq()
+ *	apic_eoi()
+ * irq_exit()
+ */
+static struct irq_chip intel_ir_chip_post_msi = {
+	.name			= "INTEL-IR-POST",
+	.irq_ack		= apic_ack_irq_no_eoi,
+	.irq_set_affinity	= intel_ir_set_affinity,
+	.irq_compose_msi_msg	= intel_ir_compose_msi_msg,
+	.irq_set_vcpu_affinity	= intel_ir_set_vcpu_affinity,
+};
+
 static void fill_msi_msg(struct msi_msg *msg, u32 index, u32 subhandle)
 {
 	memset(msg, 0, sizeof(*msg));
@@ -1361,7 +1397,7 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
 
 		irq_data->hwirq = (index << 16) + i;
 		irq_data->chip_data = ird;
-		irq_data->chip = &intel_ir_chip;
+		irq_data->chip = posted_msi_supported() ? &intel_ir_chip_post_msi : &intel_ir_chip;
 		intel_irq_remapping_prepare_irte(ird, irq_cfg, info, index, i);
 		irq_set_status_flags(virq + i, IRQ_MOVE_PCNTXT);
 	}
-- 
2.25.1

