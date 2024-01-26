Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492545A78F
	for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 23:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706312247; cv=none; b=Bs7EE1wRPz1FbfBHFt/gQF62xKOtbvYG8LnUnp3HcVpJvKJvFRen+YgeBXJunMGlhjmMPh4UOXS+paym/92C6UQWZbAtzFViXXpZ2Yb7oM6Je701j/4KVU0WcSMj6+1K+TaIGPEL531t0fSoGDFUavW2Gm4G2jWvg1bHm7HmSfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706312247; c=relaxed/simple;
	bh=+jcfYcRgLrk4OhxkOXBPXFSpbQQeXvWOwimgSWB0zss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TdFEiq7MrOSWCHW8d98PG8/9xgrpm/nnr1eJp8jH9qNBO/G/4AMiMWBXAjF9S+LbmnVTpU1PF3vhcISh3AeqEwUdJI97C+2KyNauCzXBKBGrpiLkn2hi7VrmOL0muCiwVDOBaV07Xr0DHu5nBOC+CEttqTgJRN63q3cD+RapmQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YONCm1SP; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YONCm1SP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706312245; x=1737848245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+jcfYcRgLrk4OhxkOXBPXFSpbQQeXvWOwimgSWB0zss=;
  b=YONCm1SPo2oT0FAtVC1q6NFTgR0BwTZD9rp9HvKJmZJdcWjbke7mnJtI
   coXrgv8Sav7HH0drIILGsNmYPfzMpPGpYTSwxlU3fDpI8xZWenmFxPw2q
   4EvfnIGnEWpPj/ldTZIYoR9xwqkdyXWPDwgfnlykc+RJ3G05+NAKfN4wa
   cWFg38FN9g3R0S/vsbgRJRK4uAly3kEjTdQN4WzWk2ffM9UYDQAma2geK
   05eaN21bmjRdhCTXRR+bKFIZP5HD6ydtx+VfU+N5eU8EUnLqDr7E7zVSd
   P8duLn893+gB0wuCseL0dxF/VGFygxDB80ocLlhYJKntiUJFB6yMo1UlF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9990692"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="9990692"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 15:37:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="821290728"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="821290728"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.116])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2024 15:37:21 -0800
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
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 06/15] x86/irq: Set up per host CPU posted interrupt descriptors
Date: Fri, 26 Jan 2024 15:42:28 -0800
Message-Id: <20240126234237.547278-7-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240126234237.547278-1-jacob.jun.pan@linux.intel.com>
References: <20240126234237.547278-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

To support posted MSIs, create a posted interrupt descriptor (PID) for each
host CPU. Later on, when setting up IRQ CPU affinity, IOMMU's interrupt
remapping table entry (IRTE) will point to the physical address of the
matching CPU's PID.

Each PID is initialized with the owner CPU's physical APICID as the
destination.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/include/asm/hardirq.h     |  3 +++
 arch/x86/include/asm/posted_intr.h |  7 +++++++
 arch/x86/kernel/cpu/common.c       |  3 +++
 arch/x86/kernel/irq.c              | 16 ++++++++++++++++
 4 files changed, 29 insertions(+)

diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index 66837b8c67f1..72c6a084dba3 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -48,6 +48,9 @@ typedef struct {
 
 DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 
+#ifdef CONFIG_X86_POSTED_MSI
+DECLARE_PER_CPU_ALIGNED(struct pi_desc, posted_interrupt_desc);
+#endif
 #define __ARCH_IRQ_STAT
 
 #define inc_irq_stat(member)	this_cpu_inc(irq_stat.member)
diff --git a/arch/x86/include/asm/posted_intr.h b/arch/x86/include/asm/posted_intr.h
index 896b3462f3dd..a36cc971ea13 100644
--- a/arch/x86/include/asm/posted_intr.h
+++ b/arch/x86/include/asm/posted_intr.h
@@ -88,4 +88,11 @@ static inline bool pi_test_sn(struct pi_desc *pi_desc)
 	return test_bit(POSTED_INTR_SN, (unsigned long *)&pi_desc->control);
 }
 
+#ifdef CONFIG_X86_POSTED_MSI
+extern void intel_posted_msi_init(void);
+
+#else
+static inline void intel_posted_msi_init(void) {};
+
+#endif /* X86_POSTED_MSI */
 #endif /* _X86_POSTED_INTR_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0b97bcde70c6..9b6248e7c073 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -67,6 +67,7 @@
 #include <asm/traps.h>
 #include <asm/sev.h>
 #include <asm/tdx.h>
+#include <asm/posted_intr.h>
 
 #include "cpu.h"
 
@@ -2253,6 +2254,8 @@ void cpu_init(void)
 		barrier();
 
 		x2apic_setup();
+
+		intel_posted_msi_init();
 	}
 
 	mmgrab(&init_mm);
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 11761c124545..f6546f83d616 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -22,6 +22,8 @@
 #include <asm/desc.h>
 #include <asm/traps.h>
 #include <asm/thermal.h>
+#include <asm/posted_intr.h>
+#include <asm/irq_remapping.h>
 
 #define CREATE_TRACE_POINTS
 #include <asm/trace/irq_vectors.h>
@@ -334,6 +336,20 @@ DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_kvm_posted_intr_nested_ipi)
 }
 #endif
 
+#ifdef CONFIG_X86_POSTED_MSI
+
+/* Posted Interrupt Descriptors for coalesced MSIs to be posted */
+DEFINE_PER_CPU_ALIGNED(struct pi_desc, posted_interrupt_desc);
+
+void intel_posted_msi_init(void)
+{
+	struct pi_desc *pid = this_cpu_ptr(&posted_interrupt_desc);
+
+	pid->nv = POSTED_MSI_NOTIFICATION_VECTOR;
+	pid->ndst = this_cpu_read(x86_cpu_to_apicid);
+}
+}
+#endif /* X86_POSTED_MSI */
 
 #ifdef CONFIG_HOTPLUG_CPU
 /* A cpu has been removed from cpu_online_mask.  Reset irq affinities. */
-- 
2.25.1

