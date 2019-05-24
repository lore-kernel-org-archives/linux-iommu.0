Return-Path: <SRS0=CTmu=TY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FD5C282DD
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 01:18:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F846217F9
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 01:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F846217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 16A7F1150;
	Fri, 24 May 2019 01:16:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 761DDF2F
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 01:16:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C3EFEF4
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 01:16:42 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 May 2019 18:16:37 -0700
X-ExtLoop1: 1
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
	by fmsmga008.fm.intel.com with ESMTP; 23 May 2019 18:16:37 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@suse.de>
Subject: [RFC PATCH v4 13/21] x86/watchdog/hardlockup/hpet: Determine if HPET
	timer caused NMI
Date: Thu, 23 May 2019 18:16:15 -0700
Message-Id: <1558660583-28561-14-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>,
	Clemens Ladisch <clemens@ladisch.de>,
	Ricardo Neri <ricardo.neri@intel.com>,
	Stephane Eranian <eranian@google.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ashok Raj <ashok.raj@intel.com>, x86@kernel.org,
	Andi Kleen <andi.kleen@intel.com>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Mimi Zohar <zohar@linux.ibm.com>, Tony Luck <tony.luck@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
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

The only direct method to determine whether an HPET timer caused an
interrupt is to read the Interrupt Status register. Unfortunately,
reading HPET registers is slow and, therefore, it is not recommended to
read them while in NMI context. Furthermore, status is not available if
the interrupt is generated vi the Front Side Bus.

An indirect manner to infer if the non-maskable interrupt we see was
caused by the HPET timer is to use the time-stamp counter. Compute the
value that the time-stamp counter should have at the next interrupt of the
HPET timer. Since the hardlockup detector operates in seconds, high
precision is not needed. This implementation considers that the HPET
caused the HMI if the time-stamp counter reads the expected value -/+ 1.5%.
This value is selected as it is equivalent to 1/64 and the division can be
performed using a bit shift operation. Experimentally, the error in the
estimation is consistently less than 1%.

The computation of the expected value of the time-stamp counter must be
performed in relation to watchdog_thresh divided by the number of
monitored CPUs. This quantity is stored in tsc_ticks_per_cpu and must be
updated whenever the number of monitored CPUs changes.

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
Suggested-by: Andi Kleen <andi.kleen@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/hpet.h         |  2 ++
 arch/x86/kernel/watchdog_hld_hpet.c | 27 ++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index 64acacce095d..fd99f2390714 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -115,6 +115,8 @@ struct hpet_hld_data {
 	u32		num;
 	u64		ticks_per_second;
 	u64		ticks_per_cpu;
+	u64		tsc_next;
+	u64		tsc_ticks_per_cpu;
 	u32		handling_cpu;
 	u32		enabled_cpus;
 	struct msi_msg	msi_msg;
diff --git a/arch/x86/kernel/watchdog_hld_hpet.c b/arch/x86/kernel/watchdog_hld_hpet.c
index 74aeb0535d08..dcc50cd29374 100644
--- a/arch/x86/kernel/watchdog_hld_hpet.c
+++ b/arch/x86/kernel/watchdog_hld_hpet.c
@@ -24,6 +24,7 @@
 
 static struct hpet_hld_data *hld_data;
 static bool hardlockup_use_hpet;
+static u64 tsc_next_error;
 
 /**
  * kick_timer() - Reprogram timer to expire in the future
@@ -33,11 +34,22 @@ static bool hardlockup_use_hpet;
  * Reprogram the timer to expire within watchdog_thresh seconds in the future.
  * If the timer supports periodic mode, it is not kicked unless @force is
  * true.
+ *
+ * Also, compute the expected value of the time-stamp counter at the time of
+ * expiration as well as a deviation from the expected value. The maximum
+ * deviation is of ~1.5%. This deviation can be easily computed by shifting
+ * by 6 positions the delta between the current and expected time-stamp values.
  */
 static void kick_timer(struct hpet_hld_data *hdata, bool force)
 {
+	u64 tsc_curr, tsc_delta, new_compare, count, period = 0;
 	bool kick_needed = force || !(hdata->has_periodic);
-	u64 new_compare, count, period = 0;
+
+	tsc_curr = rdtsc();
+
+	tsc_delta = (unsigned long)watchdog_thresh * hdata->tsc_ticks_per_cpu;
+	hdata->tsc_next = tsc_curr + tsc_delta;
+	tsc_next_error = tsc_delta >> 6;
 
 	/*
 	 * Update the comparator in increments of watch_thresh seconds relative
@@ -93,6 +105,15 @@ static void enable_timer(struct hpet_hld_data *hdata)
  */
 static bool is_hpet_wdt_interrupt(struct hpet_hld_data *hdata)
 {
+	if (smp_processor_id() == hdata->handling_cpu) {
+		u64 tsc_curr;
+
+		tsc_curr = rdtsc();
+
+		return (tsc_curr - hdata->tsc_next) + tsc_next_error <
+		       2 * tsc_next_error;
+	}
+
 	return false;
 }
 
@@ -260,6 +281,10 @@ static void update_ticks_per_cpu(struct hpet_hld_data *hdata)
 
 	do_div(temp, hdata->enabled_cpus);
 	hdata->ticks_per_cpu = temp;
+
+	temp = (unsigned long)tsc_khz * 1000L;
+	do_div(temp, hdata->enabled_cpus);
+	hdata->tsc_ticks_per_cpu = temp;
 }
 
 /**
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
