Return-Path: <SRS0=TkeE=TO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C130C04AB6
	for <iommu@archiver.kernel.org>; Tue, 14 May 2019 14:03:42 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AE65216E3
	for <iommu@archiver.kernel.org>; Tue, 14 May 2019 14:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE65216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 95056E6E;
	Tue, 14 May 2019 14:03:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 84D86E4C
	for <iommu@lists.linux-foundation.org>;
	Tue, 14 May 2019 14:02:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AEE0687A
	for <iommu@lists.linux-foundation.org>;
	Tue, 14 May 2019 14:02:58 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	14 May 2019 07:02:57 -0700
X-ExtLoop1: 1
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
	by fmsmga005.fm.intel.com with ESMTP; 14 May 2019 07:02:57 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@suse.de>
Subject: [RFC PATCH v3 07/21] watchdog/hardlockup: Define a generic function
	to detect hardlockups
Date: Tue, 14 May 2019 07:02:00 -0700
Message-Id: <1557842534-4266-8-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ricardo Neri <ricardo.neri@intel.com>,
	Stephane Eranian <eranian@google.com>, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Ashok Raj <ashok.raj@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>, Andi Kleen <andi.kleen@intel.com>,
	Don Zickus <dzickus@redhat.com>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>, Babu Moger <Babu.Moger@amd.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Colin Ian King <colin.king@canonical.com>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
	"David S. Miller" <davem@davemloft.net>
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

The procedure to detect hardlockups is independent of the underlying
mechanism that generates the non-maskable interrupt used to drive the
detector. Thus, it can be put in a separate, generic function. In this
manner, it can be invoked by various implementations of the NMI watchdog.

For this purpose, move the bulk of watchdog_overflow_callback() to the
new function inspect_for_hardlockups(). This function can then be called
from the applicable NMI handlers.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Babu Moger <Babu.Moger@amd.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 include/linux/nmi.h   |  1 +
 kernel/watchdog_hld.c | 18 +++++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 9003e29cde46..5a8b19749769 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -212,6 +212,7 @@ extern int proc_watchdog_thresh(struct ctl_table *, int ,
 				void __user *, size_t *, loff_t *);
 extern int proc_watchdog_cpumask(struct ctl_table *, int,
 				 void __user *, size_t *, loff_t *);
+void inspect_for_hardlockups(struct pt_regs *regs);
 
 #ifdef CONFIG_HAVE_ACPI_APEI_NMI
 #include <asm/nmi.h>
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582c..b352e507b17f 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -106,14 +106,8 @@ static struct perf_event_attr wd_hw_attr = {
 	.disabled	= 1,
 };
 
-/* Callback function for perf event subsystem */
-static void watchdog_overflow_callback(struct perf_event *event,
-				       struct perf_sample_data *data,
-				       struct pt_regs *regs)
+void inspect_for_hardlockups(struct pt_regs *regs)
 {
-	/* Ensure the watchdog never gets throttled */
-	event->hw.interrupts = 0;
-
 	if (__this_cpu_read(watchdog_nmi_touch) == true) {
 		__this_cpu_write(watchdog_nmi_touch, false);
 		return;
@@ -163,6 +157,16 @@ static void watchdog_overflow_callback(struct perf_event *event,
 	return;
 }
 
+/* Callback function for perf event subsystem */
+static void watchdog_overflow_callback(struct perf_event *event,
+				       struct perf_sample_data *data,
+				       struct pt_regs *regs)
+{
+	/* Ensure the watchdog never gets throttled */
+	event->hw.interrupts = 0;
+	inspect_for_hardlockups(regs);
+}
+
 static int hardlockup_detector_event_create(void)
 {
 	unsigned int cpu = smp_processor_id();
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
