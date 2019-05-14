Return-Path: <SRS0=TkeE=TO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF275C04AB4
	for <iommu@archiver.kernel.org>; Tue, 14 May 2019 14:04:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE2A62166E
	for <iommu@archiver.kernel.org>; Tue, 14 May 2019 14:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2A62166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AE592E93;
	Tue, 14 May 2019 14:03:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9F8F2E70
	for <iommu@lists.linux-foundation.org>;
	Tue, 14 May 2019 14:03:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DAEF987A
	for <iommu@lists.linux-foundation.org>;
	Tue, 14 May 2019 14:03:00 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	14 May 2019 07:02:59 -0700
X-ExtLoop1: 1
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
	by fmsmga005.fm.intel.com with ESMTP; 14 May 2019 07:02:59 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@suse.de>
Subject: [RFC PATCH v3 12/21] watchdog/hardlockup/hpet: Adjust timer
	expiration on the number of monitored CPUs
Date: Tue, 14 May 2019 07:02:05 -0700
Message-Id: <1557842534-4266-13-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ashok Raj <ashok.raj@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	David Rientjes <rientjes@google.com>, Andi Kleen <andi.kleen@intel.com>,
	Waiman Long <longman@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, Don Zickus <dzickus@redhat.com>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>, Ricardo Neri <ricardo.neri@intel.com>,
	Byungchul Park <byungchul.park@lge.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Tony Luck <tony.luck@intel.com>,
	Babu Moger <babu.moger@oracle.com>, Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Jacob Pan <jacob.jun.pan@intel.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Colin Ian King <colin.king@canonical.com>,
	Andrew Morton <akpm@linux-foundation.org>
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

Each CPU should be monitored for hardlockups every watchdog_thresh seconds.
Since all the CPUs in the system are monitored by the same timer and the
timer interrupt is rotated among the monitored CPUs, the timer must expire
every watchdog_thresh/N seconds; where N is the number of monitored CPUs.
Use the new member of struct hld_data, ticks_per_cpu, to store the
aforementioned quantity.

The ticks-per-CPU quantity is updated every time the number of monitored
CPUs changes: when the watchdog is enabled or disabled for a specific CPU.
If the timer is used in periodic mode, it needs to be adjusted to reflect
the new expected expiration.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Babu Moger <babu.moger@oracle.com>
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
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/hpet.h         |  1 +
 arch/x86/kernel/watchdog_hld_hpet.c | 46 +++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index 31fc27508cf3..64acacce095d 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -114,6 +114,7 @@ struct hpet_hld_data {
 	bool		has_periodic;
 	u32		num;
 	u64		ticks_per_second;
+	u64		ticks_per_cpu;
 	u32		handling_cpu;
 	u32		enabled_cpus;
 	struct msi_msg	msi_msg;
diff --git a/arch/x86/kernel/watchdog_hld_hpet.c b/arch/x86/kernel/watchdog_hld_hpet.c
index c20b378b8c0c..9a3431a54616 100644
--- a/arch/x86/kernel/watchdog_hld_hpet.c
+++ b/arch/x86/kernel/watchdog_hld_hpet.c
@@ -44,6 +44,13 @@ static void kick_timer(struct hpet_hld_data *hdata, bool force)
 	 * are able to update the comparator before the counter reaches such new
 	 * value.
 	 *
+	 * Each CPU must be monitored every watch_thresh seconds. Since the
+	 * timer targets one CPU at a time, it must expire every
+	 *
+	 *        ticks_per_cpu = watch_thresh * ticks_per_second /enabled_cpus
+	 *
+	 * as computed in update_ticks_per_cpu().
+	 *
 	 * Let it wrap around if needed.
 	 */
 
@@ -51,10 +58,10 @@ static void kick_timer(struct hpet_hld_data *hdata, bool force)
 		return;
 
 	if (hdata->has_periodic)
-		period = watchdog_thresh * hdata->ticks_per_second;
+		period = watchdog_thresh * hdata->ticks_per_cpu;
 
 	count = hpet_readl(HPET_COUNTER);
-	new_compare = count + watchdog_thresh * hdata->ticks_per_second;
+	new_compare = count + watchdog_thresh * hdata->ticks_per_cpu;
 	hpet_set_comparator(hdata->num, (u32)new_compare, (u32)period);
 }
 
@@ -233,6 +240,27 @@ static int setup_hpet_irq(struct hpet_hld_data *hdata)
 	return ret;
 }
 
+/**
+ * update_ticks_per_cpu() - Update the number of HPET ticks per CPU
+ * @hdata:     struct with the timer's the ticks-per-second and CPU mask
+ *
+ * From the overall ticks-per-second of the timer, compute the number of ticks
+ * after which the timer should expire to monitor each CPU every watch_thresh
+ * seconds. The ticks-per-cpu quantity is computed using the number of CPUs that
+ * the watchdog currently monitors.
+ */
+static void update_ticks_per_cpu(struct hpet_hld_data *hdata)
+{
+	u64 temp = hdata->ticks_per_second;
+
+	/* Only update if there are monitored CPUs. */
+	if (!hdata->enabled_cpus)
+		return;
+
+	do_div(temp, hdata->enabled_cpus);
+	hdata->ticks_per_cpu = temp;
+}
+
 /**
  * hardlockup_detector_hpet_enable() - Enable the hardlockup detector
  * @cpu:	CPU Index in which the watchdog will be enabled.
@@ -245,13 +273,23 @@ void hardlockup_detector_hpet_enable(unsigned int cpu)
 {
 	cpumask_set_cpu(cpu, to_cpumask(hld_data->cpu_monitored_mask));
 
-	if (!hld_data->enabled_cpus++) {
+	hld_data->enabled_cpus++;
+	update_ticks_per_cpu(hld_data);
+
+	if (hld_data->enabled_cpus == 1) {
 		hld_data->handling_cpu = cpu;
 		update_msi_destid(hld_data);
 		/* Force timer kick when detector is just enabled */
 		kick_timer(hld_data, true);
 		enable_timer(hld_data);
 	}
+
+	/*
+	 * When in periodic mode, we only kick the timer here. Hence,
+	 * as there are now more CPUs to monitor, we need to adjust the
+	 * periodic expiration.
+	 */
+	kick_timer(hld_data, hld_data->has_periodic);
 }
 
 /**
@@ -267,6 +305,8 @@ void hardlockup_detector_hpet_disable(unsigned int cpu)
 	cpumask_clear_cpu(cpu, to_cpumask(hld_data->cpu_monitored_mask));
 	hld_data->enabled_cpus--;
 
+	update_ticks_per_cpu(hld_data);
+
 	if (hld_data->handling_cpu != cpu)
 		return;
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
