Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268B1C433F5
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 23:58:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF65D84090;
	Thu,  5 May 2022 23:58:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y7_0CpOxLcWg; Thu,  5 May 2022 23:58:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9459E84064;
	Thu,  5 May 2022 23:58:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E75DC0032;
	Thu,  5 May 2022 23:58:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B806C0087
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:58:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E08A1610D7
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 25OMr3STba37 for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 23:57:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1E42960B77
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651795073; x=1683331073;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=/O+HEX9RnyO8ZBUK3lK021eADBWVL0Yl8Mx87L868do=;
 b=IZLOt5kIdtlgiXY7R1amgQf8xVzDSJdWurYbdMNo4cWdClNVPNTbf57+
 ZA3mUARf4Zel47yVUbMgCNJxzVUto6hBaZnnjECg0pA9P7gJRTBbP/jgh
 +WYoMaFYzVUpS13eh/dSBSZvr90kk3nh229/AILS7Vz8QBouGY7IPjRu4
 1gxzjQRAipkJepSrRQ6Fs1IPleqxiI8gMRE2gjX6zC+MrMd1ROv5sgJqt
 gxGBwCMcR6HcB5sxi2lf0CuzzthD2f05WyYXCNeHPG2RAtCaEhNoq+jKI
 /3i/lAJYlG/+x2eS7xy+YNKCskHRMpFK2yY/Cte6UPXU8VMmKJAQJai9r Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="293496345"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="293496345"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 16:57:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="694914406"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:52 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org
Subject: [PATCH v6 19/29] watchdog/hardlockup: Decouple the hardlockup
 detector from perf
Date: Thu,  5 May 2022 16:59:58 -0700
Message-Id: <20220506000008.30892-20-ricardo.neri-calderon@linux.intel.com>
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

The current default implementation of the hardlockup detector assumes that
it is implemented using perf events. However, the hardlockup detector can
be driven by other sources of non-maskable interrupts (e.g., a properly
configured timer).

Group and wrap in #ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF all the code
specific to perf: create and manage perf events, stop and start the perf-
based detector.

The generic portion of the detector (monitor the timers' thresholds, check
timestamps and detect hardlockups as well as the implementation of
arch_touch_nmi_watchdog()) is now selected with the new intermediate config
symbol CONFIG_HARDLOCKUP_DETECTOR_CORE.

The perf-based implementation of the detector selects the new intermediate
symbol. Other implementations should do the same.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 * None

Changes since v4:
 * None

Changes since v3:
 * Squashed into this patch a previous patch to make
   arch_touch_nmi_watchdog() part of the core detector code.

Changes since v2:
 * Undid split of the generic hardlockup detector into a separate file.
   (Thomas Gleixner)
 * Added a new intermediate symbol CONFIG_HARDLOCKUP_DETECTOR_CORE to
   select generic parts of the detector (Paul E. McKenney,
   Thomas Gleixner).

Changes since v1:
 * Make the generic detector code with CONFIG_HARDLOCKUP_DETECTOR.
---
 include/linux/nmi.h   |  5 ++++-
 kernel/Makefile       |  2 +-
 kernel/watchdog_hld.c | 32 ++++++++++++++++++++------------
 lib/Kconfig.debug     |  4 ++++
 4 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 1b68f48ad440..cf12380e51b3 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -94,8 +94,11 @@ static inline void hardlockup_detector_disable(void) {}
 # define NMI_WATCHDOG_SYSCTL_PERM	0444
 #endif
 
-#if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
+#if defined(CONFIG_HARDLOCKUP_DETECTOR_CORE)
 extern void arch_touch_nmi_watchdog(void);
+#endif
+
+#if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
 extern void hardlockup_detector_perf_stop(void);
 extern void hardlockup_detector_perf_restart(void);
 extern void hardlockup_detector_perf_disable(void);
diff --git a/kernel/Makefile b/kernel/Makefile
index 847a82bfe0e3..27e75b735ef7 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -95,7 +95,7 @@ obj-$(CONFIG_FAIL_FUNCTION) += fail_function.o
 obj-$(CONFIG_KGDB) += debug/
 obj-$(CONFIG_DETECT_HUNG_TASK) += hung_task.o
 obj-$(CONFIG_LOCKUP_DETECTOR) += watchdog.o
-obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF) += watchdog_hld.o
+obj-$(CONFIG_HARDLOCKUP_DETECTOR_CORE) += watchdog_hld.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RELAY) += relay.o
 obj-$(CONFIG_SYSCTL) += utsname_sysctl.o
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index b352e507b17f..bb6435978c46 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -22,12 +22,8 @@
 
 static DEFINE_PER_CPU(bool, hard_watchdog_warn);
 static DEFINE_PER_CPU(bool, watchdog_nmi_touch);
-static DEFINE_PER_CPU(struct perf_event *, watchdog_ev);
-static DEFINE_PER_CPU(struct perf_event *, dead_event);
-static struct cpumask dead_events_mask;
 
 static unsigned long hardlockup_allcpu_dumped;
-static atomic_t watchdog_cpus = ATOMIC_INIT(0);
 
 notrace void arch_touch_nmi_watchdog(void)
 {
@@ -98,14 +94,6 @@ static inline bool watchdog_check_timestamp(void)
 }
 #endif
 
-static struct perf_event_attr wd_hw_attr = {
-	.type		= PERF_TYPE_HARDWARE,
-	.config		= PERF_COUNT_HW_CPU_CYCLES,
-	.size		= sizeof(struct perf_event_attr),
-	.pinned		= 1,
-	.disabled	= 1,
-};
-
 void inspect_for_hardlockups(struct pt_regs *regs)
 {
 	if (__this_cpu_read(watchdog_nmi_touch) == true) {
@@ -157,6 +145,24 @@ void inspect_for_hardlockups(struct pt_regs *regs)
 	return;
 }
 
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
+#undef pr_fmt
+#define pr_fmt(fmt) "NMI perf watchdog: " fmt
+
+static DEFINE_PER_CPU(struct perf_event *, watchdog_ev);
+static DEFINE_PER_CPU(struct perf_event *, dead_event);
+static struct cpumask dead_events_mask;
+
+static atomic_t watchdog_cpus = ATOMIC_INIT(0);
+
+static struct perf_event_attr wd_hw_attr = {
+	.type		= PERF_TYPE_HARDWARE,
+	.config		= PERF_COUNT_HW_CPU_CYCLES,
+	.size		= sizeof(struct perf_event_attr),
+	.pinned		= 1,
+	.disabled	= 1,
+};
+
 /* Callback function for perf event subsystem */
 static void watchdog_overflow_callback(struct perf_event *event,
 				       struct perf_sample_data *data,
@@ -298,3 +304,5 @@ int __init hardlockup_detector_perf_init(void)
 	}
 	return ret;
 }
+
+#endif /* CONFIG_HARDLOCKUP_DETECTOR_PERF */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 55b9acb2f524..1640532cdc6a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1079,9 +1079,13 @@ config BOOTPARAM_SOFTLOCKUP_PANIC_VALUE
 	default 0 if !BOOTPARAM_SOFTLOCKUP_PANIC
 	default 1 if BOOTPARAM_SOFTLOCKUP_PANIC
 
+config HARDLOCKUP_DETECTOR_CORE
+	bool
+
 config HARDLOCKUP_DETECTOR_PERF
 	bool
 	select SOFTLOCKUP_DETECTOR
+	select HARDLOCKUP_DETECTOR_CORE
 
 #
 # Enables a timestamp based low pass filter to compensate for perf based
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
