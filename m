Return-Path: <SRS0=TkeE=TO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A2AC04AB4
	for <iommu@archiver.kernel.org>; Tue, 14 May 2019 14:04:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E4421537
	for <iommu@archiver.kernel.org>; Tue, 14 May 2019 14:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E4421537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8EF4CE9D;
	Tue, 14 May 2019 14:03:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CA2D6E3D
	for <iommu@lists.linux-foundation.org>;
	Tue, 14 May 2019 14:03:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2BE14881
	for <iommu@lists.linux-foundation.org>;
	Tue, 14 May 2019 14:03:02 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	14 May 2019 07:03:00 -0700
X-ExtLoop1: 1
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
	by fmsmga005.fm.intel.com with ESMTP; 14 May 2019 07:03:00 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@suse.de>
Subject: [RFC PATCH v3 16/21] x86/watchdog: Add a shim hardlockup detector
Date: Tue, 14 May 2019 07:02:09 -0700
Message-Id: <1557842534-4266-17-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>,
	Clemens Ladisch <clemens@ladisch.de>,
	Ricardo Neri <ricardo.neri@intel.com>, Mimi Zohar <zohar@linux.ibm.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ashok Raj <ashok.raj@intel.com>, x86@kernel.org,
	Andi Kleen <andi.kleen@intel.com>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Stephane Eranian <eranian@google.com>, Tony Luck <tony.luck@intel.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Nayna Jain <nayna@linux.ibm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

The generic hardlockup detector is based on perf. It also provides a set
of weak stubs that CPU architectures can override. Add a shim hardlockup
detector for x86 that selects between perf and hpet implementations.

Specifically, this shim implementation is needed for the HPET-based
hardlockup detector; it can also be used for future implementations.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Nayna Jain <nayna@linux.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/Kconfig.debug         |  4 ++
 arch/x86/kernel/Makefile       |  1 +
 arch/x86/kernel/watchdog_hld.c | 78 ++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)
 create mode 100644 arch/x86/kernel/watchdog_hld.c

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 376a5db81aec..0d9e11eb070c 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -169,11 +169,15 @@ config IOMMU_LEAK
 config HAVE_MMIOTRACE_SUPPORT
 	def_bool y
 
+config X86_HARDLOCKUP_DETECTOR
+	bool
+
 config X86_HARDLOCKUP_DETECTOR_HPET
 	bool "Use HPET Timer for Hard Lockup Detection"
 	select SOFTLOCKUP_DETECTOR
 	select HARDLOCKUP_DETECTOR
 	select HARDLOCKUP_DETECTOR_CORE
+	select X86_HARDLOCKUP_DETECTOR
 	depends on HPET_TIMER && HPET && X86_64
 	help
 	  Say y to enable a hardlockup detector that is driven by an High-
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index f9222769d84b..f89a259931f7 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -106,6 +106,7 @@ obj-$(CONFIG_VM86)		+= vm86_32.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
+obj-$(CONFIG_X86_HARDLOCKUP_DETECTOR) += watchdog_hld.o
 obj-$(CONFIG_X86_HARDLOCKUP_DETECTOR_HPET) += watchdog_hld_hpet.o
 obj-$(CONFIG_APB_TIMER)		+= apb_timer.o
 
diff --git a/arch/x86/kernel/watchdog_hld.c b/arch/x86/kernel/watchdog_hld.c
new file mode 100644
index 000000000000..c2512d4c79c5
--- /dev/null
+++ b/arch/x86/kernel/watchdog_hld.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A shim hardlockup detector. It overrides the weak stubs of the generic
+ * implementation to select between the perf- or the hpet-based implementation.
+ *
+ * Copyright (C) Intel Corporation 2019
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
+	if (detector_type == X86_HARDLOCKUP_DETECTOR_PERF) {
+		hardlockup_detector_perf_enable();
+		return 0;
+	}
+
+	if (detector_type == X86_HARDLOCKUP_DETECTOR_HPET) {
+		hardlockup_detector_hpet_enable(cpu);
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
+void watchdog_nmi_disable(unsigned int cpu)
+{
+	if (detector_type == X86_HARDLOCKUP_DETECTOR_PERF) {
+		hardlockup_detector_perf_disable();
+		return;
+	}
+
+	if (detector_type == X86_HARDLOCKUP_DETECTOR_HPET) {
+		hardlockup_detector_hpet_disable(cpu);
+		return;
+	}
+}
+
+int __init watchdog_nmi_probe(void)
+{
+	int ret;
+
+	/*
+	 * Try first with the HPET hardlockup detector. It will only
+	 * succeed if selected at build time and the nmi_watchdog
+	 * command-line parameter is configured. This ensure that the
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
+	return ret;
+}
+
+void watchdog_nmi_stop(void)
+{
+	/* Only the HPET lockup detector defines a stop function. */
+	if (detector_type == X86_HARDLOCKUP_DETECTOR_HPET)
+		hardlockup_detector_hpet_stop();
+}
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
