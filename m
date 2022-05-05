Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D12C433EF
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 23:58:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 25F8540C02;
	Thu,  5 May 2022 23:58:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2vmuDgmDiK8u; Thu,  5 May 2022 23:58:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 93EF240BE5;
	Thu,  5 May 2022 23:58:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BAFC7C0086;
	Thu,  5 May 2022 23:57:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 178FAC002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EA72B60B6A
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LSg4QNGOxkPQ for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 23:57:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2E14460BAC
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651795071; x=1683331071;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=TyPidIU9s9JbwJNwvFvgLrTu4E+Y5y97BFEdQg2cUk8=;
 b=PwFmaKMwMC+WKB4rFPcyZTa5lJaWAnzfH+Ht/SfSFTtVeuADJ6kF+JSt
 c+RK+wCu75/ZOeSblS8MN8d5z5m5Q8Y4gz6jqK+o0ykVbEQVgUMdJ9QjH
 FoWmSar9wBBWBuoWMOfYmPiOlfR+83o7KYYJHdUQfhZ46m1Bt4yEzdnyR
 1w8UOQTv7E78Vti8wTgQdrhRmh/ZHooIoTuGT2C3sdRrQ19tLGuiSEk25
 1yM8sPmDZD4hUPGk4czSJkFC8gC13CNOwYiHkCb5+/aX/1EI8HO/A5bJ6
 uzhUkgW3LQHtXguErqTGzT32va1pX1BrtwrT4fvpiiK4HFxu32b7/41Bd g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="293496335"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="293496335"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 16:57:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="694914380"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:50 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org
Subject: [PATCH v6 15/29] x86/hpet: Add helper function
 hpet_set_comparator_periodic()
Date: Thu,  5 May 2022 16:59:54 -0700
Message-Id: <20220506000008.30892-16-ricardo.neri-calderon@linux.intel.com>
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

Programming an HPET channel as periodic requires setting the
HPET_TN_SETVAL bit in the channel configuration. Plus, the comparator
register must be written twice (once for the comparator value and once for
the periodic value). Since this programming might be needed in several
places (e.g., the HPET clocksource and the HPET-based hardlockup detector),
add a helper function for this purpose.

A helper function hpet_set_comparator_oneshot() could also be implemented.
However, such function would only program the comparator register and the
function would be quite small. Hence, it is better to not bloat the code
with such an obvious function.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Originally-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
When programming the HPET channel in periodic mode, a udelay(1) between
the two successive writes to HPET_Tn_CMP was introduced in commit
e9e2cdb41241 ("[PATCH] clockevents: i386 drivers"). The commit message
does not give any reason for such delay. The hardware specification does
not seem to require it. The refactoring in this patch simply carries such
delay.
---
Changes since v5:
 * None

Changes since v4:
 * Implement function only for periodic mode. This removed extra logic to
   to use a non-zero period value as a proxy for periodic mode
   programming. (Thomas)
 * Added a comment on the history of the udelay() when programming the
   channel in periodic mode. (Ashok)

Changes since v3:
 * Added back a missing hpet_writel() for time configuration.

Changes since v2:
 *  Introduced this patch.

Changes since v1:
 * N/A
---
 arch/x86/include/asm/hpet.h |  2 ++
 arch/x86/kernel/hpet.c      | 49 ++++++++++++++++++++++++++++---------
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index be9848f0883f..486e001413c7 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -74,6 +74,8 @@ extern void hpet_disable(void);
 extern unsigned int hpet_readl(unsigned int a);
 extern void hpet_writel(unsigned int d, unsigned int a);
 extern void force_hpet_resume(void);
+extern void hpet_set_comparator_periodic(int channel, unsigned int cmp,
+					 unsigned int period);
 
 #ifdef CONFIG_HPET_EMULATE_RTC
 
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 47678e7927ff..2c6713b40921 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -294,6 +294,39 @@ static void hpet_enable_legacy_int(void)
 	hpet_legacy_int_enabled = true;
 }
 
+/**
+ * hpet_set_comparator_periodic() - Helper function to set periodic channel
+ * @channel:	The HPET channel
+ * @cmp:	The value to be written to the comparator/accumulator
+ * @period:	Number of ticks per period
+ *
+ * Helper function for updating comparator, accumulator and period values.
+ *
+ * In periodic mode, HPET needs HPET_TN_SETVAL to be set before writing
+ * to the Tn_CMP to update the accumulator. Then, HPET needs a second
+ * write (with HPET_TN_SETVAL cleared) to Tn_CMP to set the period.
+ * The HPET_TN_SETVAL bit is automatically cleared after the first write.
+ *
+ * This function takes a 1 microsecond delay. However, this function is supposed
+ * to be called only once (or when reprogramming the timer) as it deals with a
+ * periodic timer channel.
+ *
+ * See the following documents:
+ *   - Intel IA-PC HPET (High Precision Event Timers) Specification
+ *   - AMD-8111 HyperTransport I/O Hub Data Sheet, Publication # 24674
+ */
+void hpet_set_comparator_periodic(int channel, unsigned int cmp, unsigned int period)
+{
+	unsigned int v = hpet_readl(HPET_Tn_CFG(channel));
+
+	hpet_writel(v | HPET_TN_SETVAL, HPET_Tn_CFG(channel));
+
+	hpet_writel(cmp, HPET_Tn_CMP(channel));
+
+	udelay(1);
+	hpet_writel(period, HPET_Tn_CMP(channel));
+}
+
 static int hpet_clkevt_set_state_periodic(struct clock_event_device *evt)
 {
 	unsigned int channel = clockevent_to_channel(evt)->num;
@@ -306,19 +339,11 @@ static int hpet_clkevt_set_state_periodic(struct clock_event_device *evt)
 	now = hpet_readl(HPET_COUNTER);
 	cmp = now + (unsigned int)delta;
 	cfg = hpet_readl(HPET_Tn_CFG(channel));
-	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_SETVAL |
-	       HPET_TN_32BIT;
+	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_32BIT;
 	hpet_writel(cfg, HPET_Tn_CFG(channel));
-	hpet_writel(cmp, HPET_Tn_CMP(channel));
-	udelay(1);
-	/*
-	 * HPET on AMD 81xx needs a second write (with HPET_TN_SETVAL
-	 * cleared) to T0_CMP to set the period. The HPET_TN_SETVAL
-	 * bit is automatically cleared after the first write.
-	 * (See AMD-8111 HyperTransport I/O Hub Data Sheet,
-	 * Publication # 24674)
-	 */
-	hpet_writel((unsigned int)delta, HPET_Tn_CMP(channel));
+
+	hpet_set_comparator_periodic(channel, cmp, (unsigned int)delta);
+
 	hpet_start_counter();
 	hpet_print_config();
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
