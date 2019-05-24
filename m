Return-Path: <SRS0=CTmu=TY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C6EC282E1
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 01:18:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 801DB217F9
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 01:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801DB217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CA1001127;
	Fri, 24 May 2019 01:16:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0EE05F3E
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 01:16:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3B7866C5
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 01:16:41 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 May 2019 18:16:36 -0700
X-ExtLoop1: 1
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
	by fmsmga008.fm.intel.com with ESMTP; 23 May 2019 18:16:36 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@suse.de>
Subject: [RFC PATCH v4 10/21] watchdog/hardlockup: Add function to enable NMI
	watchdog on all allowed CPUs at once
Date: Thu, 23 May 2019 18:16:12 -0700
Message-Id: <1558660583-28561-11-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Alexei Starovoitov <ast@kernel.org>, Stephane Eranian <eranian@google.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>, Ashok Raj <ashok.raj@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	David Rientjes <rientjes@google.com>, Andi Kleen <andi.kleen@intel.com>,
	Waiman Long <longman@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Don Zickus <dzickus@redhat.com>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>, Ricardo Neri <ricardo.neri@intel.com>,
	Byungchul Park <byungchul.park@lge.com>, Babu Moger <Babu.Moger@amd.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Tony Luck <tony.luck@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
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

When there are more than one implementation of the NMI watchdog, there may
be situations in which switching from one to another is needed (e.g., if
the time-stamp counter becomes unstable, the HPET-based NMI watchdog can
no longer be used.

The perf-based implementation of the hardlockup detector makes use of
various per-CPU variables which are accessed via this_cpu operations.
Hence, each CPU needs to enable its own NMI watchdog if using the perf
implementation.

Add functionality to switch from one NMI watchdog to another and do it
from each allowed CPU.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
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
Cc: Byungchul Park <byungchul.park@lge.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 include/linux/nmi.h |  2 ++
 kernel/watchdog.c   | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index e5f1a86e20b7..6d828334348b 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -83,9 +83,11 @@ static inline void reset_hung_task_detector(void) { }
 
 #if defined(CONFIG_HARDLOCKUP_DETECTOR)
 extern void hardlockup_detector_disable(void);
+extern void hardlockup_start_all(void);
 extern unsigned int hardlockup_panic;
 #else
 static inline void hardlockup_detector_disable(void) {}
+static inline void hardlockup_start_all(void) {}
 #endif
 
 #if defined(CONFIG_HAVE_NMI_WATCHDOG) || defined(CONFIG_HARDLOCKUP_DETECTOR)
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 7f9e7b9306fe..be589001200a 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -566,6 +566,21 @@ int lockup_detector_offline_cpu(unsigned int cpu)
 	return 0;
 }
 
+static int hardlockup_start_fn(void *data)
+{
+	watchdog_nmi_enable(smp_processor_id());
+	return 0;
+}
+
+void hardlockup_start_all(void)
+{
+	int cpu;
+
+	cpumask_copy(&watchdog_allowed_mask, &watchdog_cpumask);
+	for_each_cpu(cpu, &watchdog_allowed_mask)
+		smp_call_on_cpu(cpu, hardlockup_start_fn, NULL, false);
+}
+
 static void lockup_detector_reconfigure(void)
 {
 	cpus_read_lock();
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
