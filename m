Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3120DC433FE
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 23:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0924760B74;
	Thu,  5 May 2022 23:58:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZZzumJSMq6E8; Thu,  5 May 2022 23:58:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8DABD60BAC;
	Thu,  5 May 2022 23:58:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF348C0086;
	Thu,  5 May 2022 23:58:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10A28C002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:58:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0A28561103
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZCnVPmjSu0oI for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 23:57:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 53EBD60BAC
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651795075; x=1683331075;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=yC1VMzzaD0T/TLg0eVxuSiZa3kBrYQyg8Df/Iv+75Oc=;
 b=eT6ixjSbu7lYBRIKGYfd6UL7JugNtt1qDMPtKjZ/arjs5h3ruYq+uzX/
 ELyLAtS/VMUTS0XjYirSmgMPic+6p+tcb8T2Ae6W8GfmoIJsZU1sPAwA9
 wOKxPbwQQCqED7tDlO72eFbRdokGRXt1Zc3KxfuLUoC5UPCgHe8U22BBT
 BYBz6T/yGqdtCDnZxl1yeE7nQbkZqk4djMXw09a2bslfSrCMHKUl7nLEX
 KaNZfBx3hnk5kEynnOFQNEYqcMgYYzCZfhIOcXVWac/bD2Qx+60Z7gO5N
 LyIj06NYIQFL6IHbRKSH9fqfv5LMpq9F/Ugk4ZDsj4tehFfiEB/dLaleT A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="293496361"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="293496361"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 16:57:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="694914432"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:54 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org
Subject: [PATCH v6 23/29] x86/watchdog/hardlockup/hpet: Determine if HPET
 timer caused NMI
Date: Thu,  5 May 2022 17:00:02 -0700
Message-Id: <20220506000008.30892-24-ricardo.neri-calderon@linux.intel.com>
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

It is not possible to determine the source of a non-maskable interrupt
(NMI) in x86. When dealing with an HPET channel, the only direct method to
determine whether it caused an NMI would be to read the Interrupt Status
register.

However, reading HPET registers is slow and, therefore, not to be done
while in NMI context. Furthermore, status is not available if the HPET
channel is programmed to deliver an MSI interrupt.

An indirect manner to infer if an incoming NMI was caused by the HPET
channel of the detector is to use the time-stamp counter (TSC). Compute the
value that the TSC is expected to have at the next interrupt of the HPET
channel and compare it with the value it has when the interrupt does
happen. If the actual value falls within a small error window, assume
that the HPET channel of the detector is the source of the NMI.

Let tsc_delta be the difference between the value the TSC has now and the
value it will have when the next HPET channel interrupt happens. Define the
error window as a percentage of tsc_delta.

Below is a table that characterizes the error in the error in the expected
TSC value when the HPET channel fires on a variety of systems. It presents
the error as a percentage of tsc_delta and in microseconds.

The table summarizes the error of 4096 interrupts of the HPET channel
collected after the system has been up for 5 minutes as well as since boot.

The maximum observed error on any system is 0.045%. When the error since
boot is considered, the maximum observed error is 0.198%.

To find the most common error value, the collected data is grouped into
buckets of 0.000001 percentage points of the error and 10ns, respectively.
The most common error on any system is of 0.01317%

Allow a maximum error that is twice as big the maximum error observed in
these experiments: 0.4%

watchdog_thresh     1s                10s                 60s
Error wrt
expected
TSC value     %        us         %        us        %        us

AMD EPYC 7742 64-Core Processor
Abs max
since boot 0.04517   451.74    0.00171   171.04   0.00034   201.89
Abs max    0.04517   451.74    0.00171   171.04   0.00034   201.89
Mode       0.00002     0.18    0.00002     2.07  -0.00003   -19.20

Intel(R) Xeon(R) CPU E7-8890 - INTEL_FAM6_HASWELL_X
abs max
since boot 0.00811    81.15    0.00462   462.40   0.00014    81.65
Abs max    0.00811    81.15    0.00084    84.31   0.00014    81.65
Mode      -0.00422   -42.16   -0.00043   -42.50  -0.00007   -40.40

Intel(R) Xeon(R) Platinum 8170M - INTEL_FAM6_SKYLAKE_X
Abs max
since boot 0.10530  1053.04    0.01324  1324.27   0.00407  2443.25
Abs max    0.01166   116.59    0.00114   114.11   0.00024   143.47
Mode      -0.01023  -102.32   -0.00103  -102.44  -0.00022  -132.38

Intel(R) Xeon(R) CPU E5-2699A v4 - INTEL_FAM6_BROADSWELL_X
Abs max
since boot 0.00010    99.34    0.00099    98.83   0.00016    97.50
Abs max    0.00010    99.34    0.00099    98.83   0.00016    97.50
Mode      -0.00007   -74.29   -0.00074   -73.99  -0.00012   -73.12

Intel(R) Xeon(R) Gold 5318H - INTEL_FAM6_COOPERLAKE_X
Abs max
since boot 0.11262  1126.17    0.01109  1109.17   0.00409  2455.73
Abs max    0.01073   107.31    0.00109   109.02   0.00019   115.34
Mode      -0.00953   -95.26   -0.00094   -93.63  -0.00015   -90.42

Intel(R) Xeon(R) Platinum 8360Y - INTEL_FAM6_ICELAKE_X
Abs max
since boot 0.19853  1985.30    0.00784   783.53  -0.00017  -104.77
Abs max    0.01550   155.02    0.00158   157.56   0.00020   117.74
Mode      -0.01317  -131.65   -0.00136  -136.42  -0.00018  -105.06

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Suggested-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
NOTE: The error characterization data is repetead here from the cover
letter.
---
Changes since v5:
 * Reworked is_hpet_hld_interrupt() to reduce indentation.
 * Use time_in_range64() to compare the actual TSC value vs the expected
   value. This makes it more readable. (Tony)
 * Reduced the error window of the expected TSC value at the time of the
   HPET channel expiration.
 * Described better the heuristics used to determine if the HPET channel
   caused the NMI. (Tony)
 * Added a table to characterize the error in the expected TSC value when
   the HPET channel fires.
 * Removed references to groups of monitored CPUs. Instead, use tsc_khz
   directly.

Changes since v4:
 * Compute the TSC expected value at the next HPET interrupt based on the
   number of monitored packages and not the number of monitored CPUs.

Changes since v3:
 * None

Changes since v2:
 * Reworked condition to check if the expected TSC value is within the
   error margin to avoid an unnecessary conditional. (Peter Zijlstra)
 * Removed TSC error margin from struct hld_data; use a global variable
   instead. (Peter Zijlstra)

Changes since v1:
 * Introduced this patch.
---
 arch/x86/include/asm/hpet.h         |  3 ++
 arch/x86/kernel/watchdog_hld_hpet.c | 54 +++++++++++++++++++++++++++--
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index c88901744848..af0a504b5cff 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -113,6 +113,8 @@ static inline int is_hpet_enabled(void) { return 0; }
  * @channel:			HPET channel assigned to the detector
  * @channe_priv:		Private data of the assigned channel
  * @ticks_per_second:		Frequency of the HPET timer
+ * @tsc_next:			Estimated value of the TSC at the next
+ *				HPET timer interrupt
  * @irq:			IRQ number assigned to the HPET channel
  * @handling_cpu:		CPU handling the HPET interrupt
  * @monitored_cpumask:		CPUs monitored by the hardlockup detector
@@ -124,6 +126,7 @@ struct hpet_hld_data {
 	u32			channel;
 	struct hpet_channel	*channel_priv;
 	u64			ticks_per_second;
+	u64			tsc_next;
 	int			irq;
 	u32			handling_cpu;
 	cpumask_var_t		monitored_cpumask;
diff --git a/arch/x86/kernel/watchdog_hld_hpet.c b/arch/x86/kernel/watchdog_hld_hpet.c
index 9fc7ac2c5059..3effdbf29095 100644
--- a/arch/x86/kernel/watchdog_hld_hpet.c
+++ b/arch/x86/kernel/watchdog_hld_hpet.c
@@ -34,6 +34,7 @@
 
 static struct hpet_hld_data *hld_data;
 static bool hardlockup_use_hpet;
+static u64 tsc_next_error;
 
 extern struct static_key_false apic_use_ipi_shorthand;
 
@@ -59,10 +60,39 @@ static void __init setup_hpet_channel(struct hpet_hld_data *hdata)
  * Reprogram the timer to expire within watchdog_thresh seconds in the future.
  * If the timer supports periodic mode, it is not kicked unless @force is
  * true.
+ *
+ * Also, compute the expected value of the time-stamp counter at the time of
+ * expiration as well as a deviation from the expected value.
  */
 static void kick_timer(struct hpet_hld_data *hdata, bool force)
 {
-	u64 new_compare, count, period = 0;
+	u64 tsc_curr, tsc_delta, new_compare, count, period = 0;
+
+	tsc_curr = rdtsc();
+
+	/*
+	 * Compute the delta between the value of the TSC now and the value
+	 * it will have the next time the HPET channel fires.
+	 */
+	tsc_delta = watchdog_thresh * tsc_khz * 1000L;
+	hdata->tsc_next = tsc_curr + tsc_delta;
+
+	/*
+	 * Define an error window between the expected TSC value and the actual
+	 * value it will have the next time the HPET channel fires. Define this
+	 * error as percentage of tsc_delta.
+	 *
+	 * The systems that have been tested so far exhibit an error of 0.05%
+	 * of the expected TSC value once the system is up and running. Systems
+	 * that refine tsc_khz exhibit a larger initial error up to 0.2%.
+	 *
+	 * To be safe, allow a maximum error of ~0.4%. This error value can be
+	 * computed by left-shifting tsc_delta by 8 positions. Shift 9
+	 * positions to calculate half the error. When the HPET channel fires,
+	 * check if the actual TSC value is in the range
+	 *  [tsc_next - (tsc_next_error / 2), tsc_next + (tsc_next_error / 2)]
+	 */
+	tsc_next_error = tsc_delta >> 9;
 
 	/* Kick the timer only when needed. */
 	if (!force && hdata->has_periodic)
@@ -126,12 +156,32 @@ static void enable_timer(struct hpet_hld_data *hdata)
  * is_hpet_hld_interrupt() - Check if an HPET timer caused the interrupt
  * @hdata:	A data structure with the timer instance to enable
  *
+ * Checking whether the HPET was the source of this NMI is not possible.
+ * Determining the sources of NMIs is not possible. Furthermore, we have
+ * programmed the HPET channel for MSI delivery, which does not have a
+ * status bit. Also, reading HPET registers is slow.
+ *
+ * Instead, we just assume that any NMI delivered within a time window
+ * of when the HPET was expected to fire probably came from the HPET.
+ *
+ * The window is estimated using the TSC counter. Check the comments in
+ * kick_timer() for details on the size of the time window.
+ *
  * Returns:
  * True if the HPET watchdog timer caused the interrupt. False otherwise.
  */
 static bool is_hpet_hld_interrupt(struct hpet_hld_data *hdata)
 {
-	return false;
+	u64 tsc_curr, tsc_curr_min, tsc_curr_max;
+
+	if (smp_processor_id() != hdata->handling_cpu)
+		return false;
+
+	tsc_curr = rdtsc();
+	tsc_curr_min = tsc_curr - tsc_next_error;
+	tsc_curr_max = tsc_curr + tsc_next_error;
+
+	return time_in_range64(hdata->tsc_next, tsc_curr_min, tsc_curr_max);
 }
 
 /**
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
