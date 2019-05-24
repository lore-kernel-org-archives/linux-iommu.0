Return-Path: <SRS0=CTmu=TY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B85C282E1
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 01:16:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C9FD2184E
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 01:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9FD2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5D02DF4D;
	Fri, 24 May 2019 01:16:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 514F8F1D
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 01:16:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 84B85F4
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 01:16:37 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 May 2019 18:16:35 -0700
X-ExtLoop1: 1
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
	by fmsmga008.fm.intel.com with ESMTP; 23 May 2019 18:16:35 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@suse.de>
Subject: [RFC PATCH v4 06/21] x86/hpet: Configure the timer used by the
	hardlockup detector
Date: Thu, 23 May 2019 18:16:08 -0700
Message-Id: <1558660583-28561-7-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
	Ashok Raj <ashok.raj@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>, Clemens Ladisch <clemens@ladisch.de>,
	linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
	Ricardo Neri <ricardo.neri@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	iommu@lists.linux-foundation.org, Tony Luck <tony.luck@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi.kleen@intel.com>,
	Philippe Ombredanne <pombredanne@nexb.com>
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

Implement the initial configuration of the timer to be used by the
hardlockup detector. Return a data structure with a description of the
timer; this information is subsequently used by the hardlockup detector.

Only provide the timer if it supports Front Side Bus interrupt delivery.
This condition greatly simplifies the implementation of the detector.
Specifically, it helps to avoid the complexities of routing the interrupt
via the IO-APIC (e.g., potential race conditions that arise from re-
programming the IO-APIC in NMI context).

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/hpet.h | 13 +++++++++++++
 arch/x86/kernel/hpet.c      | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index 6f099e2781ce..20abdaa5372d 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -109,6 +109,19 @@ extern void hpet_set_comparator(int num, unsigned int cmp, unsigned int period);
 
 #endif /* CONFIG_HPET_EMULATE_RTC */
 
+#ifdef CONFIG_X86_HARDLOCKUP_DETECTOR_HPET
+struct hpet_hld_data {
+	bool		has_periodic;
+	u32		num;
+	u64		ticks_per_second;
+};
+
+extern struct hpet_hld_data *hpet_hardlockup_detector_assign_timer(void);
+#else
+static inline struct hpet_hld_data *hpet_hardlockup_detector_assign_timer(void)
+{ return NULL; }
+#endif /* CONFIG_X86_HARDLOCKUP_DETECTOR_HPET */
+
 #else /* CONFIG_HPET_TIMER */
 
 static inline int hpet_enable(void) { return 0; }
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index ff0250831786..5f9209949fc7 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -171,6 +171,41 @@ do {								\
 		_hpet_print_config(__func__, __LINE__);	\
 } while (0)
 
+#ifdef CONFIG_X86_HARDLOCKUP_DETECTOR_HPET
+struct hpet_hld_data *hpet_hardlockup_detector_assign_timer(void)
+{
+	struct hpet_hld_data *hdata;
+	u64 temp;
+	u32 cfg;
+
+	cfg = hpet_readl(HPET_Tn_CFG(HPET_WD_TIMER_NR));
+
+	if (!(cfg & HPET_TN_FSB_CAP))
+		return NULL;
+
+	hdata = kzalloc(sizeof(*hdata), GFP_KERNEL);
+	if (!hdata)
+		return NULL;
+
+	if (cfg & HPET_TN_PERIODIC_CAP)
+		hdata->has_periodic = true;
+
+	hdata->num = HPET_WD_TIMER_NR;
+
+	cfg = hpet_readl(HPET_PERIOD);
+
+	/*
+	 * hpet_get_ticks_per_sec() expects the contents of the general
+	 * capabilities register. The period is in the 32 most significant
+	 * bits.
+	 */
+	temp = (u64)cfg << HPET_COUNTER_CLK_PERIOD_SHIFT;
+	hdata->ticks_per_second = hpet_get_ticks_per_sec(temp);
+
+	return hdata;
+}
+#endif /* CONFIG_X86_HARDLOCKUP_DETECTOR_HPET */
+
 /*
  * When the hpet driver (/dev/hpet) is enabled, we need to reserve
  * timer 0 and timer 1 in case of RTC emulation. Timer 2 is reserved in case
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
