Return-Path: <SRS0=TkeE=TO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BF4C04AB4
	for <iommu@archiver.kernel.org>; Tue, 14 May 2019 14:05:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 449F021537
	for <iommu@archiver.kernel.org>; Tue, 14 May 2019 14:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449F021537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 06165EA3;
	Tue, 14 May 2019 14:03:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4E046C2A
	for <iommu@lists.linux-foundation.org>;
	Tue, 14 May 2019 14:03:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 70B0E83A
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
Subject: [RFC PATCH v3 17/21] x86/tsc: Switch to perf-based hardlockup
	detector if TSC become unstable
Date: Tue, 14 May 2019 07:02:10 -0700
Message-Id: <1557842534-4266-18-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ashok Raj <ashok.raj@intel.com>, Peter Zijlstra <peterz@infradead.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>, iommu@lists.linux-foundation.org,
	Andi Kleen <andi.kleen@intel.com>
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

The HPET-based hardlockup detector relies on the TSC to determine if an
observed NMI interrupt was originated by HPET timer. Hence, this detector
can no longer be used with an unstable TSC.

In such case, permanently stop the HPET-based hardlockup detector and
start the perf-based detector.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/hpet.h    | 2 ++
 arch/x86/kernel/tsc.c          | 2 ++
 arch/x86/kernel/watchdog_hld.c | 7 +++++++
 3 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index fd99f2390714..a82cbe17479d 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -128,6 +128,7 @@ extern int hardlockup_detector_hpet_init(void);
 extern void hardlockup_detector_hpet_stop(void);
 extern void hardlockup_detector_hpet_enable(unsigned int cpu);
 extern void hardlockup_detector_hpet_disable(unsigned int cpu);
+extern void hardlockup_detector_switch_to_perf(void);
 #else
 static inline struct hpet_hld_data *hpet_hardlockup_detector_assign_timer(void)
 { return NULL; }
@@ -136,6 +137,7 @@ static inline int hardlockup_detector_hpet_init(void)
 static inline void hardlockup_detector_hpet_stop(void) {}
 static inline void hardlockup_detector_hpet_enable(unsigned int cpu) {}
 static inline void hardlockup_detector_hpet_disable(unsigned int cpu) {}
+static void harrdlockup_detector_switch_to_perf(void) {}
 #endif /* CONFIG_X86_HARDLOCKUP_DETECTOR_HPET */
 
 #else /* CONFIG_HPET_TIMER */
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 8f47c4862c56..5e4b6d219bec 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1157,6 +1157,8 @@ void mark_tsc_unstable(char *reason)
 
 	clocksource_mark_unstable(&clocksource_tsc_early);
 	clocksource_mark_unstable(&clocksource_tsc);
+
+	hardlockup_detector_switch_to_perf();
 }
 
 EXPORT_SYMBOL_GPL(mark_tsc_unstable);
diff --git a/arch/x86/kernel/watchdog_hld.c b/arch/x86/kernel/watchdog_hld.c
index c2512d4c79c5..c8547c227a41 100644
--- a/arch/x86/kernel/watchdog_hld.c
+++ b/arch/x86/kernel/watchdog_hld.c
@@ -76,3 +76,10 @@ void watchdog_nmi_stop(void)
 	if (detector_type == X86_HARDLOCKUP_DETECTOR_HPET)
 		hardlockup_detector_hpet_stop();
 }
+
+void hardlockup_detector_switch_to_perf(void)
+{
+	detector_type = X86_HARDLOCKUP_DETECTOR_PERF;
+	hardlockup_detector_hpet_stop();
+	hardlockup_start_all();
+}
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
