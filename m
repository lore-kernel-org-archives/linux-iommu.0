Return-Path: <SRS0=TkeE=TO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82C2C04AB7
	for <iommu@archiver.kernel.org>; Tue, 14 May 2019 14:04:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9481021537
	for <iommu@archiver.kernel.org>; Tue, 14 May 2019 14:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9481021537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6286BE9B;
	Tue, 14 May 2019 14:03:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6D0FDE3D
	for <iommu@lists.linux-foundation.org>;
	Tue, 14 May 2019 14:03:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D60F283A
	for <iommu@lists.linux-foundation.org>;
	Tue, 14 May 2019 14:03:01 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	14 May 2019 07:03:00 -0700
X-ExtLoop1: 1
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
	by fmsmga005.fm.intel.com with ESMTP; 14 May 2019 07:02:59 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@suse.de>
Subject: [RFC PATCH v3 15/21] watchdog/hardlockup/hpet: Only enable the HPET
	watchdog via a boot parameter
Date: Tue, 14 May 2019 07:02:08 -0700
Message-Id: <1557842534-4266-16-git-send-email-ricardo.neri-calderon@linux.intel.com>
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

Keep the HPET-based hardlockup detector disabled unless explicitly enabled
via a command-line argument. If such parameter is not given, the
initialization of the hpet-based hardlockup detector fails and the NMI
watchdog will fallback to use the perf-based implementation.

Given that __setup("nmi_watchdog=") is already used to control the behavior
of the NMI watchdog (via hardlockup_panic_setup()), it cannot be used to
control of the hpet-based implementation. Instead, use a new
early_param("nmi_watchdog").

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
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

--
checkpatch gives the following warning:

CHECK: __setup appears un-documented -- check Documentation/admin-guide/kernel-parameters.rst
+__setup("nmi_watchdog=", hardlockup_detector_hpet_setup);

This is a false-positive as the option nmi_watchdog is already
documented. The option is re-evaluated in this file as well.
---
 .../admin-guide/kernel-parameters.txt         |  8 ++++++-
 arch/x86/kernel/watchdog_hld_hpet.c           | 22 +++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fd03e2b629bb..3c42205b469c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2801,7 +2801,7 @@
 			Format: [state][,regs][,debounce][,die]
 
 	nmi_watchdog=	[KNL,BUGS=X86] Debugging features for SMP kernels
-			Format: [panic,][nopanic,][num]
+			Format: [panic,][nopanic,][num,][hpet]
 			Valid num: 0 or 1
 			0 - turn hardlockup detector in nmi_watchdog off
 			1 - turn hardlockup detector in nmi_watchdog on
@@ -2811,6 +2811,12 @@
 			please see 'nowatchdog'.
 			This is useful when you use a panic=... timeout and
 			need the box quickly up again.
+			When hpet is specified, the NMI watchdog will be driven
+			by an HPET timer, if available in the system. Otherwise,
+			it falls back to the default implementation (perf or
+			architecture-specific). Specifying hpet has no effect
+			if the NMI watchdog is not enabled (either at build time
+			or via the command line).
 
 			These settings can be accessed at runtime via
 			the nmi_watchdog and hardlockup_panic sysctls.
diff --git a/arch/x86/kernel/watchdog_hld_hpet.c b/arch/x86/kernel/watchdog_hld_hpet.c
index 6f1f540cfee9..90680a8cf9fc 100644
--- a/arch/x86/kernel/watchdog_hld_hpet.c
+++ b/arch/x86/kernel/watchdog_hld_hpet.c
@@ -350,6 +350,28 @@ void hardlockup_detector_hpet_stop(void)
 	disable_timer(hld_data);
 }
 
+/**
+ * hardlockup_detector_hpet_setup() - Parse command-line parameters
+ * @str:	A string containing the kernel command line
+ *
+ * Parse the nmi_watchdog parameter from the kernel command line. If
+ * selected by the user, use this implementation to detect hardlockups.
+ */
+static int __init hardlockup_detector_hpet_setup(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (parse_option_str(str, "hpet"))
+		hardlockup_use_hpet = true;
+
+	if (!nmi_watchdog_user_enabled && hardlockup_use_hpet)
+		pr_warn("Selecting HPET NMI watchdog has no effect with NMI watchdog disabled\n");
+
+	return 0;
+}
+early_param("nmi_watchdog", hardlockup_detector_hpet_setup);
+
 /**
  * hardlockup_detector_hpet_init() - Initialize the hardlockup detector
  *
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
