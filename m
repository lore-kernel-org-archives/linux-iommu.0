Return-Path: <SRS0=TkeE=TO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD280C04AB4
	for <iommu@archiver.kernel.org>; Tue, 14 May 2019 14:04:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9955B21537
	for <iommu@archiver.kernel.org>; Tue, 14 May 2019 14:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9955B21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 72FE7E90;
	Tue, 14 May 2019 14:03:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 37BB1E60
	for <iommu@lists.linux-foundation.org>;
	Tue, 14 May 2019 14:03:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4B464880
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
Subject: [RFC PATCH v3 05/21] x86/hpet: Reserve timer for the HPET hardlockup
	detector
Date: Tue, 14 May 2019 07:01:58 -0700
Message-Id: <1557842534-4266-6-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Tony Luck <tony.luck@intel.com>, Ashok Raj <ashok.raj@intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	x86@kernel.org, Clemens Ladisch <clemens@ladisch.de>,
	linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
	Ricardo Neri <ricardo.neri@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	iommu@lists.linux-foundation.org,
	Philippe Ombredanne <pombredanne@nexb.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi.kleen@intel.com>
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

HPET timer 2 will be used to drive the HPET-based hardlockup detector.
Reserve such timer to ensure it cannot be used by user space programs or
for clock events.

When looking for MSI-capable timers for clock events, skip timer 2 if
the HPET hardlockup detector is selected.

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
 arch/x86/include/asm/hpet.h |  3 +++
 arch/x86/kernel/hpet.c      | 19 ++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index e7098740f5ee..6f099e2781ce 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -61,6 +61,9 @@
  */
 #define HPET_MIN_PERIOD		100000UL
 
+/* Timer used for the hardlockup detector */
+#define HPET_WD_TIMER_NR 2
+
 /* hpet memory map physical address */
 extern unsigned long hpet_address;
 extern unsigned long force_hpet_address;
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index c5c5fc150193..ba0a5cc075d5 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -172,7 +172,8 @@ do {								\
 
 /*
  * When the hpet driver (/dev/hpet) is enabled, we need to reserve
- * timer 0 and timer 1 in case of RTC emulation.
+ * timer 0 and timer 1 in case of RTC emulation. Timer 2 is reserved in case
+ * the HPET-based hardlockup detector is used.
  */
 #ifdef CONFIG_HPET
 
@@ -182,7 +183,7 @@ static void hpet_reserve_platform_timers(unsigned int id)
 {
 	struct hpet __iomem *hpet = hpet_virt_address;
 	struct hpet_timer __iomem *timer = &hpet->hpet_timers[2];
-	unsigned int nrtimers, i;
+	unsigned int nrtimers, i, start_timer;
 	struct hpet_data hd;
 
 	nrtimers = ((id & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT) + 1;
@@ -197,6 +198,13 @@ static void hpet_reserve_platform_timers(unsigned int id)
 	hpet_reserve_timer(&hd, 1);
 #endif
 
+	if (IS_ENABLED(CONFIG_X86_HARDLOCKUP_DETECTOR_HPET)) {
+		hpet_reserve_timer(&hd, HPET_WD_TIMER_NR);
+		start_timer = HPET_WD_TIMER_NR + 1;
+	} else {
+		start_timer = HPET_WD_TIMER_NR;
+	}
+
 	/*
 	 * NOTE that hd_irq[] reflects IOAPIC input pins (LEGACY_8254
 	 * is wrong for i8259!) not the output IRQ.  Many BIOS writers
@@ -205,7 +213,7 @@ static void hpet_reserve_platform_timers(unsigned int id)
 	hd.hd_irq[0] = HPET_LEGACY_8254;
 	hd.hd_irq[1] = HPET_LEGACY_RTC;
 
-	for (i = 2; i < nrtimers; timer++, i++) {
+	for (i = start_timer; i < nrtimers; timer++, i++) {
 		hd.hd_irq[i] = (readl(&timer->hpet_config) &
 			Tn_INT_ROUTE_CNF_MASK) >> Tn_INT_ROUTE_CNF_SHIFT;
 	}
@@ -648,6 +656,11 @@ static void hpet_msi_capability_lookup(unsigned int start_timer)
 		struct hpet_dev *hdev = &hpet_devs[num_timers_used];
 		unsigned int cfg = hpet_readl(HPET_Tn_CFG(i));
 
+		/* Do not use timer reserved for the HPET watchdog. */
+		if (IS_ENABLED(CONFIG_X86_HARDLOCKUP_DETECTOR_HPET) &&
+		    i == HPET_WD_TIMER_NR)
+			continue;
+
 		/* Only consider HPET timer with MSI support */
 		if (!(cfg & HPET_TN_FSB_CAP))
 			continue;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
