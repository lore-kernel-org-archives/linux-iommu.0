Return-Path: <SRS0=4008=J7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51F3C433B4
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 19:11:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836C6613DC
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 19:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836C6613DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CFA560B6F;
	Tue,  4 May 2021 19:11:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w5mXP9Logl0K; Tue,  4 May 2021 19:11:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2F216079C;
	Tue,  4 May 2021 19:11:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEAFAC000D;
	Tue,  4 May 2021 19:11:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 465BDC0019
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 19:11:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2B6FF846CF
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 19:11:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y9mTAP4BhPRm for <iommu@lists.linux-foundation.org>;
 Tue,  4 May 2021 19:11:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 31429846D1
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 19:11:42 +0000 (UTC)
IronPort-SDR: pGdN0ltZGY/aJr6gM2SZ//YsXWT3gR+5P6h9eCoby9id7OB24XpvaeAErfhQvIAuLDHQg8sl69
 DNRdVIYroJTw==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="197675496"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; d="scan'208";a="197675496"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2021 12:11:41 -0700
IronPort-SDR: L+c1poPB/6U0UrTibGWyGf6yG6X42kx+7mMI6iJsAfAi+PloL+6GLUjp0nmMu6l3ZK7X6CUq1A
 GWav4vbSnuow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; d="scan'208";a="396245307"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by fmsmga007.fm.intel.com with ESMTP; 04 May 2021 12:11:41 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [RFC PATCH v5 7/7] x86/watchdog/hardlockup/hpet: Support interrupt
 remapping
Date: Tue,  4 May 2021 12:10:49 -0700
Message-Id: <20210504191049.22661-8-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210504191049.22661-1-ricardo.neri-calderon@linux.intel.com>
References: <20210504191049.22661-1-ricardo.neri-calderon@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Ashok Raj <ashok.raj@intel.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org,
 woodhouse@osuosl.org, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, Ricardo Neri <ricardo.neri@intel.com>,
 iommu@lists.linux-foundation.org, Jacob Pan <jacob.jun.pan@intel.com>,
 Andi Kleen <andi.kleen@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@suse.de>, David Woodhouse <dwmw2@infradead.org>,
 Ingo Molnar <mingo@kernel.org>
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

When interrupt remapping is enabled in the system, the MSI interrupt
address and data fields must follow a special format that the IOMMU
defines.

However, the HPET hardlockup detector must rely on the interrupt
subsystem to have the interrupt remapping drivers allocate, activate,
and set the affinity of HPET timer interrupt. Hence, it must use
request_irq() to use such functionality.

In x86 there is not an IRQF_NMI flag to indicate to the interrupt
subsystem the delivery mode of the interrupt. A previous changset added
functionality to detect the interrupt of the HPET hardlockup detector
and fixup the delivery mode accordingly.

Also, since request_irq() is used, a non-NMI interrupt handler must be
defined. Even if it is not needed.

When Interrupt Remapping is enabled, use the new facility to ensure
interrupt is plumbed properly to work with interrupt remapping.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: David Woodhouse <dwmw2@infradead.org> (supporter:INTEL IOMMU (VT-d))
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com> (supporter:INTEL IOMMU (VT-d))
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: iommu@lists.linux-foundation.org (open list:INTEL IOMMU (VT-d))
Cc: x86@kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v4:
 * Use request_irq() to obtain an IRTE for the HPET hardlockup detector
   instead of the custom interfaces previously implemented in the
   interrupt remapping drivers.
 * Simplified detection of interrupt remapping by checking the parent
   of the HPET irq domain.
 * Stopped using the HPET magic fields of struct irq_alloc_info. They
   were removed in commit 2bf1e7bcedb8 ("x86/msi: Consolidate HPET
   allocation")
 * Rephrased commit message for clarity. (Ashok)
 * Clarified error message of non-NMI handler. (Ashok)

Changes since v3:
 * None

Changes since v2:
 * None

Changes since v1:
 * Introduced this patch. Added custom functions in the Intel IOMMU driver
   to allocate an IRTE for the HPET hardlockup detector.
---
 arch/x86/include/asm/hpet.h         |  2 ++
 arch/x86/kernel/hpet.c              |  3 ++
 arch/x86/kernel/watchdog_hld_hpet.c | 48 +++++++++++++++++++++++++----
 3 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index 5bf675970d4b..d130285ddc96 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -109,6 +109,7 @@ extern void hpet_unregister_irq_handler(rtc_irq_handler handler);
  * @tsc_ticks_per_group:	TSC ticks that must elapse for each group of
  *				monitored CPUs.
  * @irq:			IRQ number assigned to the HPET channel
+ * @int_remap_enabled:		True if interrupt remapping is enabled
  * @handling_cpu:		CPU handling the HPET interrupt
  * @pkgs_per_group:		Number of physical packages in a group of CPUs
  *				receiving an IPI
@@ -133,6 +134,7 @@ struct hpet_hld_data {
 	u64		tsc_next;
 	u64		tsc_ticks_per_group;
 	int		irq;
+	bool		intr_remap_enabled;
 	u32		handling_cpu;
 	u32		pkgs_per_group;
 	u32		nr_groups;
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 3e43e0f348b8..ff4abdef5e15 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -1464,6 +1464,9 @@ struct hpet_hld_data *hpet_hld_get_timer(void)
 	if (!hpet_domain)
 		goto err;
 
+	if (hpet_domain->parent != x86_vector_domain)
+		hld_data->intr_remap_enabled = true;
+
 	hc->mode = HPET_MODE_NMI_WATCHDOG;
 	irq = hpet_assign_irq(hpet_domain, hc, hc->num);
 	if (irq <= 0)
diff --git a/arch/x86/kernel/watchdog_hld_hpet.c b/arch/x86/kernel/watchdog_hld_hpet.c
index 3fd2405b31fa..265641d001ac 100644
--- a/arch/x86/kernel/watchdog_hld_hpet.c
+++ b/arch/x86/kernel/watchdog_hld_hpet.c
@@ -176,6 +176,14 @@ static int update_msi_destid(struct hpet_hld_data *hdata)
 {
 	u32 destid;
 
+	if (hdata->intr_remap_enabled) {
+		int ret;
+
+		ret = irq_set_affinity(hdata->irq,
+				       cpumask_of(hdata->handling_cpu));
+		return ret;
+	}
+
 	destid = apic->calc_dest_apicid(hdata->handling_cpu);
 	/*
 	 * HPET only supports a 32-bit MSI address register. Thus, only
@@ -393,26 +401,52 @@ static int hardlockup_detector_nmi_handler(unsigned int type,
 	return NMI_DONE;
 }
 
+/*
+ * When interrupt remapping is enabled, we request the irq for the detector
+ * using request_irq() and then we fixup the delivery mode to NMI using
+ * is_hpet_irq_hardlockup_detector(). If the latter fails, we will see a non-
+ * NMI interrupt.
+ *
+ */
+static irqreturn_t hardlockup_detector_irq_handler(int irq, void *data)
+{
+	pr_err_once("Received a non-NMI interrupt. The HLD detector always uses NMIs!\n");
+	return IRQ_HANDLED;
+}
+
 /**
  * setup_irq_msi_mode() - Configure the timer to deliver an MSI interrupt
  * @data:	Data associated with the instance of the HPET timer to configure
  *
  * Configure the HPET timer to deliver interrupts via the Front-
  * Side Bus.
+ *
+ * Returns:
+ * 0 success. An error code if setup was unsuccessful.
  */
-static void setup_irq_msi_mode(struct hpet_hld_data *hdata)
+static int setup_irq_msi_mode(struct hpet_hld_data *hdata)
 {
+	s32 ret;
 	u32 v;
 
-	compose_msi_msg(hdata);
-	hpet_writel(hdata->msi_msg.data, HPET_Tn_ROUTE(hdata->channel));
-	hpet_writel(hdata->msi_msg.address_lo,
-		    HPET_Tn_ROUTE(hdata->channel) + 4);
+	if (hdata->intr_remap_enabled) {
+		ret = request_irq(hld_data->irq, hardlockup_detector_irq_handler,
+				  IRQF_TIMER, "hpet_hld", hld_data);
+		if (ret)
+			return ret;
+	} else {
+		compose_msi_msg(hdata);
+		hpet_writel(hdata->msi_msg.data, HPET_Tn_ROUTE(hdata->channel));
+		hpet_writel(hdata->msi_msg.address_lo,
+			    HPET_Tn_ROUTE(hdata->channel) + 4);
+	}
 
 	v = hpet_readl(HPET_Tn_CFG(hdata->channel));
 	v |= HPET_TN_FSB;
 
 	hpet_writel(v, HPET_Tn_CFG(hdata->channel));
+
+	return 0;
 }
 
 /**
@@ -430,7 +464,9 @@ static int setup_hpet_irq(struct hpet_hld_data *hdata)
 {
 	int ret;
 
-	setup_irq_msi_mode(hdata);
+	ret = setup_irq_msi_mode(hdata);
+	if (ret)
+		return ret;
 
 	ret = register_nmi_handler(NMI_WATCHDOG,
 				   hardlockup_detector_nmi_handler, 0,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
