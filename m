Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40794428
	for <iommu@lists.linux.dev>; Sun, 12 Nov 2023 04:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k4WxtbIl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699762333; x=1731298333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZRkqYyrDq8K80kW7DHz3TYCS29krPawHw58dDr57YPY=;
  b=k4WxtbIl2KIdOPxERyLF4eWIVO0x93MUjzUvLKnGfvzwHuSj4bpxAKI4
   wSZ/ISWK5U8dXV+D5rDzh2d8xpK/OQYwQjdf2uG05rokir0TK8C5p4caL
   hmxzFP1D7843GxY5kjZYjlPwbDdC3vSn4KJ5KycBok4wg5X0g5p6SMiVQ
   PdLFPmBdyPh1n23B/8hkTWUvrfYg59k4G5M1ymF7EP5tI9K7PxsZq6QyK
   HJw1Wui52MF73VZEXfSheF7T+lTpqm1oaWb0DuOdtrxf8T8ULSzWU+o6h
   /IaP49wPUbZbPF7DAOlGZUY+to7kR094TVxbV7TvDi6f1ekqiX3n0XkRY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="476533934"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="476533934"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 20:12:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="713936764"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="713936764"
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
Subject: [PATCH RFC 09/13] x86/irq: Install posted MSI notification handler
Date: Sat, 11 Nov 2023 20:16:39 -0800
Message-Id: <20231112041643.2868316-10-jacob.jun.pan@linux.intel.com>
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

All MSI vectors are multiplexed into a single notification vector when
posted MSI is enabled. It is the responsibility of the notification
vector handler to demultiplex MSI vectors. In this handler, for each
pending bit, MSI vector handlers are dispatched without IDT delivery.

For example, the interrupt flow will change as follows:
(3 MSIs of different vectors arrive in a a high frequency burst)

BEFORE:
interrupt(MSI)
    irq_enter()
    handler() /* EOI */
    irq_exit()
        process_softirq()
interrupt(MSI)
    irq_enter()
    handler() /* EOI */
    irq_exit()
        process_softirq()
interrupt(MSI)
    irq_enter()
    handler() /* EOI */
    irq_exit()
        process_softirq()

AFTER:
interrupt /* Posted MSI notification vector */
    irq_enter()
	atomic_xchg(PIR)
	handler()
	handler()
	handler()
	pi_clear_on()
    apic_eoi()
    irq_exit()
        process_softirq()

Except for the leading MSI, CPU notifications are skipped/coalesced.

For MSIs arrive at a low frequency, the demultiplexing loop does not
wait for more interrupts to coalesce. Therefore, there's no additional
latency other than the processing time.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/include/asm/hardirq.h  |  3 ++
 arch/x86/include/asm/idtentry.h |  3 ++
 arch/x86/kernel/idt.c           |  3 ++
 arch/x86/kernel/irq.c           | 91 +++++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+)

diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index 72c6a084dba3..6c8daa7518eb 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -44,6 +44,9 @@ typedef struct {
 	unsigned int irq_hv_reenlightenment_count;
 	unsigned int hyperv_stimer0_count;
 #endif
+#ifdef CONFIG_X86_POSTED_MSI
+	unsigned int posted_msi_notification_count;
+#endif
 } ____cacheline_aligned irq_cpustat_t;
 
 DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 05fd175cec7d..f756e761e7c0 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -644,6 +644,9 @@ DECLARE_IDTENTRY_SYSVEC(ERROR_APIC_VECTOR,		sysvec_error_interrupt);
 DECLARE_IDTENTRY_SYSVEC(SPURIOUS_APIC_VECTOR,		sysvec_spurious_apic_interrupt);
 DECLARE_IDTENTRY_SYSVEC(LOCAL_TIMER_VECTOR,		sysvec_apic_timer_interrupt);
 DECLARE_IDTENTRY_SYSVEC(X86_PLATFORM_IPI_VECTOR,	sysvec_x86_platform_ipi);
+# ifdef CONFIG_X86_POSTED_MSI
+DECLARE_IDTENTRY_SYSVEC(POSTED_MSI_NOTIFICATION_VECTOR,	sysvec_posted_msi_notification);
+# endif
 #endif
 
 #ifdef CONFIG_SMP
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index b786d48f5a0f..d5840d777469 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -159,6 +159,9 @@ static const __initconst struct idt_data apic_idts[] = {
 # endif
 	INTG(SPURIOUS_APIC_VECTOR,		asm_sysvec_spurious_apic_interrupt),
 	INTG(ERROR_APIC_VECTOR,			asm_sysvec_error_interrupt),
+# ifdef CONFIG_X86_POSTED_MSI
+	INTG(POSTED_MSI_NOTIFICATION_VECTOR,	asm_sysvec_posted_msi_notification),
+# endif
 #endif
 };
 
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 0bffe8152385..786c2c8330f4 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -183,6 +183,13 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "%10u ",
 			   irq_stats(j)->kvm_posted_intr_wakeup_ipis);
 	seq_puts(p, "  Posted-interrupt wakeup event\n");
+#endif
+#ifdef CONFIG_X86_POSTED_MSI
+	seq_printf(p, "%*s: ", prec, "PMN");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ",
+			   irq_stats(j)->posted_msi_notification_count);
+	seq_puts(p, "  Posted MSI notification event\n");
 #endif
 	return 0;
 }
@@ -351,6 +358,90 @@ void intel_posted_msi_init(void)
 	this_cpu_write(posted_interrupt_desc.nv, POSTED_MSI_NOTIFICATION_VECTOR);
 	this_cpu_write(posted_interrupt_desc.ndst, this_cpu_read(x86_cpu_to_apicid));
 }
+
+static __always_inline inline void handle_pending_pir(struct pi_desc *pid, struct pt_regs *regs)
+{
+	int i, vec = FIRST_EXTERNAL_VECTOR;
+	u64 pir_copy[4];
+
+	/*
+	 * Make a copy of PIR which contains IRQ pending bits for vectors,
+	 * then invoke IRQ handlers for each pending vector.
+	 * If any new interrupts were posted while we are processing, will
+	 * do again before allowing new notifications. The idea is to
+	 * minimize the number of the expensive notifications if IRQs come
+	 * in a high frequency burst.
+	 */
+	for (i = 0; i < 4; i++)
+		pir_copy[i] = raw_atomic64_xchg((atomic64_t *)&pid->pir_l[i], 0);
+
+	/*
+	 * Ideally, we should start from the high order bits set in the PIR
+	 * since each bit represents a vector. Higher order bit position means
+	 * the vector has higher priority. But external vectors are allocated
+	 * based on availability not priority.
+	 *
+	 * EOI is included in the IRQ handlers call to apic_ack_irq, which
+	 * allows higher priority system interrupt to get in between.
+	 */
+	for_each_set_bit_from(vec, (unsigned long *)&pir_copy[0], 256)
+		call_irq_handler(vec, regs);
+
+}
+
+/*
+ * Performance data shows that 3 is good enough to harvest 90+% of the benefit
+ * on high IRQ rate workload.
+ * Alternatively, could make this tunable, use 3 as default.
+ */
+#define MAX_POSTED_MSI_COALESCING_LOOP 3
+
+/*
+ * For MSIs that are delivered as posted interrupts, the CPU notifications
+ * can be coalesced if the MSIs arrive in high frequency bursts.
+ */
+DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi_notification)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+	struct pi_desc *pid;
+	int i = 0;
+
+	pid = this_cpu_ptr(&posted_interrupt_desc);
+
+	inc_irq_stat(posted_msi_notification_count);
+	irq_enter();
+
+	while (i++ < MAX_POSTED_MSI_COALESCING_LOOP) {
+		handle_pending_pir(pid, regs);
+
+		/*
+		 * If there are new interrupts posted in PIR, do again. If
+		 * nothing pending, no need to wait for more interrupts.
+		 */
+		if (is_pir_pending(pid))
+			continue;
+		else
+			break;
+	}
+
+	/*
+	 * Clear outstanding notification bit to allow new IRQ notifications,
+	 * do this last to maximize the window of interrupt coalescing.
+	 */
+	pi_clear_on(pid);
+
+	/*
+	 * There could be a race of PI notification and the clearing of ON bit,
+	 * process PIR bits one last time such that handling the new interrupts
+	 * are not delayed until the next IRQ.
+	 */
+	if (unlikely(is_pir_pending(pid)))
+		handle_pending_pir(pid, regs);
+
+	apic_eoi();
+	irq_exit();
+	set_irq_regs(old_regs);
+}
 #endif /* X86_POSTED_MSI */
 
 #ifdef CONFIG_HOTPLUG_CPU
-- 
2.25.1

