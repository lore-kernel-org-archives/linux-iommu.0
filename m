Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673C7C4332F
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 23:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B72D419BB;
	Thu,  5 May 2022 23:58:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FP2jpsZqxfTY; Thu,  5 May 2022 23:58:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5C718419E4;
	Thu,  5 May 2022 23:58:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15313C0081;
	Thu,  5 May 2022 23:58:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 143BDC002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:58:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5C05F60BAC
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cPL9p_PmuZ0T for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 23:57:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A04AA610A7
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651795076; x=1683331076;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=NgL6S1cr5J9GxlUSQa9DYNpqQacM6MNmaOCrW38i9fU=;
 b=hLBkm7i/JtjsAAUy8h7kviP4o8V9fyJApb1FcR94cj99v7598Nlymp+V
 a27pSzhN3w4lMN/UXR4VlNFczMFoop8bMPde13/0T3oUZ7bhTNzjs8esb
 8Uy1a/KDlWjL2sFicPKMG2exCxoKfsccURNot4oWBmtrqe6rf0tbDE25y
 hwZQcHMVKkMEHpaCASrf6iS/xnpWP0z/CN6KgDCfT8uggEwThtDCqzaCe
 U9r4qcIZv/1/9y5DSigsaMNcHFDm3KCLPZaquSLVVdSQCFrcsAgIobh8/
 uUZYTsmep3oaLxeHaCDmggUSbhKiL6vCPh10ZHONEYDVFgQCGt3EUQtW8 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="293496375"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="293496375"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 16:57:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="694914448"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:55 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org
Subject: [PATCH v6 26/29] x86/watchdog: Add a shim hardlockup detector
Date: Thu,  5 May 2022 17:00:05 -0700
Message-Id: <20220506000008.30892-27-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 Ricardo Neri <ricardo.neri@intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Tony Luck <tony.luck@intel.com>, Nicholas Piggin <npiggin@gmail.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The generic hardlockup detector is based on perf. It also provides a set
of weak functions that CPU architectures can override. Add a shim
hardlockup detector for x86 that overrides such functions and can
select between perf and HPET implementations of the detector.

For clarity, add the intermediate Kconfig symbol X86_HARDLOCKUP_DETECTOR
that is selected whenever the core of the hardlockup detector is
selected.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 * Added watchdog_nmi_start() to be used when tsc_khz is recalibrated.
 * Always build the x86-specific hardlockup detector shim; not only
   when the HPET-based detector is selected.
 * Corrected a typo in comment in watchdog_nmi_probe() (Ani)
 * Removed useless local ret variable in watchdog_nmi_enable(). (Ani)

Changes since v4:
 * Use a switch to enable and disable the various available detectors.
   (Andi)

Changes since v3:
 * Fixed style in multi-line comment. (Randy Dunlap)

Changes since v2:
 * Pass cpu number as argument to hardlockup_detector_[enable|disable].
   (Thomas Gleixner)

Changes since v1:
 * Introduced this patch: Added an x86-specific shim hardlockup
   detector. (Nicholas Piggin)
---
 arch/x86/Kconfig.debug         |  3 ++
 arch/x86/kernel/Makefile       |  2 +
 arch/x86/kernel/watchdog_hld.c | 85 ++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 arch/x86/kernel/watchdog_hld.c

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index bc34239589db..599001157847 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -6,6 +6,9 @@ config TRACE_IRQFLAGS_NMI_SUPPORT
 config EARLY_PRINTK_USB
 	bool
 
+config X86_HARDLOCKUP_DETECTOR
+	def_bool y if HARDLOCKUP_DETECTOR_CORE
+
 config X86_VERBOSE_BOOTUP
 	bool "Enable verbose x86 bootup info messages"
 	default y
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index c700b00a2d86..af3d54e4c836 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -114,6 +114,8 @@ obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_VM86)		+= vm86_32.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
+obj-$(CONFIG_X86_HARDLOCKUP_DETECTOR) += watchdog_hld.o
+
 obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
 obj-$(CONFIG_X86_HARDLOCKUP_DETECTOR_HPET) += watchdog_hld_hpet.o
 
diff --git a/arch/x86/kernel/watchdog_hld.c b/arch/x86/kernel/watchdog_hld.c
new file mode 100644
index 000000000000..ef11f0af4ef5
--- /dev/null
+++ b/arch/x86/kernel/watchdog_hld.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A shim hardlockup detector. It overrides the weak stubs of the generic
+ * implementation to select between the perf- or the hpet-based implementation.
+ *
+ * Copyright (C) Intel Corporation 2022
+ */
+
+#include <linux/nmi.h>
+#include <asm/hpet.h>
+
+enum x86_hardlockup_detector {
+	X86_HARDLOCKUP_DETECTOR_PERF,
+	X86_HARDLOCKUP_DETECTOR_HPET,
+};
+
+static enum __read_mostly x86_hardlockup_detector detector_type;
+
+int watchdog_nmi_enable(unsigned int cpu)
+{
+	switch (detector_type) {
+	case X86_HARDLOCKUP_DETECTOR_PERF:
+		hardlockup_detector_perf_enable();
+		break;
+	case X86_HARDLOCKUP_DETECTOR_HPET:
+		hardlockup_detector_hpet_enable(cpu);
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+void watchdog_nmi_disable(unsigned int cpu)
+{
+	switch (detector_type) {
+	case X86_HARDLOCKUP_DETECTOR_PERF:
+		hardlockup_detector_perf_disable();
+		break;
+	case X86_HARDLOCKUP_DETECTOR_HPET:
+		hardlockup_detector_hpet_disable(cpu);
+		break;
+	}
+}
+
+int __init watchdog_nmi_probe(void)
+{
+	int ret;
+
+	/*
+	 * Try first with the HPET hardlockup detector. It will only
+	 * succeed if selected at build time and requested in the
+	 * nmi_watchdog command-line parameter. This ensures that the
+	 * perf-based detector is used by default, if selected at
+	 * build time.
+	 */
+	ret = hardlockup_detector_hpet_init();
+	if (!ret) {
+		detector_type = X86_HARDLOCKUP_DETECTOR_HPET;
+		return ret;
+	}
+
+	ret = hardlockup_detector_perf_init();
+	if (!ret) {
+		detector_type = X86_HARDLOCKUP_DETECTOR_PERF;
+		return ret;
+	}
+
+	return 0;
+}
+
+void watchdog_nmi_stop(void)
+{
+	/* Only the HPET lockup detector defines a stop function. */
+	if (detector_type == X86_HARDLOCKUP_DETECTOR_HPET)
+		hardlockup_detector_hpet_stop();
+}
+
+void watchdog_nmi_start(void)
+{
+	/* Only the HPET lockup detector defines a start function. */
+	if (detector_type == X86_HARDLOCKUP_DETECTOR_HPET)
+		hardlockup_detector_hpet_start();
+}
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
