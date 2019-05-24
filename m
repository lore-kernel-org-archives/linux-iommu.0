Return-Path: <SRS0=CTmu=TY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F225C282DD
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 01:18:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 304B5217F9
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 01:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304B5217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E8817105F;
	Fri, 24 May 2019 01:16:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E051F114E
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 01:16:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 33E306C5
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 01:16:45 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 May 2019 18:16:39 -0700
X-ExtLoop1: 1
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
	by fmsmga008.fm.intel.com with ESMTP; 23 May 2019 18:16:39 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@suse.de>
Subject: [RFC PATCH v4 21/21] x86/watchdog/hardlockup/hpet: Support interrupt
	remapping
Date: Thu, 23 May 2019 18:16:23 -0700
Message-Id: <1558660583-28561-22-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>,
	Ricardo Neri <ricardo.neri@intel.com>,
	Stephane Eranian <eranian@google.com>, Wincy Van <fanwenyi0529@gmail.com>,
	Ashok Raj <ashok.raj@intel.com>, x86@kernel.org,
	Andi Kleen <andi.kleen@intel.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Juergen Gross <jgross@suse.com>, Tony Luck <tony.luck@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Jacob Pan <jacob.jun.pan@intel.com>,
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

When interrupt remapping is enabled in the system, the MSI interrupt
message must follow a special format the IOMMU can understand. Hence,
utilize the functionality provided by the IOMMU driver for such purpose.

The first step is to determine whether interrupt remapping is enabled
by looking for the existence of an interrupt remapping domain. If it
exists, let the IOMMU driver compose the MSI message for us. The hard-
lockup detector is still responsible of writing the message in the
HPET FSB route register.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wincy Van <fanwenyi0529@gmail.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/kernel/watchdog_hld_hpet.c | 33 ++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/watchdog_hld_hpet.c b/arch/x86/kernel/watchdog_hld_hpet.c
index 76eed714a1cb..a266439fdb9e 100644
--- a/arch/x86/kernel/watchdog_hld_hpet.c
+++ b/arch/x86/kernel/watchdog_hld_hpet.c
@@ -20,6 +20,7 @@
 #include <linux/hpet.h>
 #include <linux/slab.h>
 #include <asm/msidef.h>
+#include <asm/irq_remapping.h>
 #include <asm/hpet.h>
 
 static struct hpet_hld_data *hld_data;
@@ -117,6 +118,25 @@ static bool is_hpet_wdt_interrupt(struct hpet_hld_data *hdata)
 	return false;
 }
 
+/** irq_remapping_enabled() - Detect if interrupt remapping is enabled
+ * @hdata:	A data structure with the HPET block id
+ *
+ * Determine if the HPET block that the hardlockup detector is under
+ * the remapped interrupt domain.
+ *
+ * Returns: True interrupt remapping is enabled. False otherwise.
+ */
+static bool irq_remapping_enabled(struct hpet_hld_data *hdata)
+{
+	struct irq_alloc_info info;
+
+	init_irq_alloc_info(&info, NULL);
+	info.type = X86_IRQ_ALLOC_TYPE_HPET;
+	info.hpet_id = hdata->blockid;
+
+	return !!irq_remapping_get_ir_irq_domain(&info);
+}
+
 /**
  * compose_msi_msg() - Populate address and data fields of an MSI message
  * @hdata:	A data strucure with the message to populate
@@ -161,6 +181,9 @@ static int update_msi_destid(struct hpet_hld_data *hdata)
 {
 	u32 destid;
 
+	if (irq_remapping_enabled(hdata))
+		return hld_hpet_intremap_activate_irq(hdata);
+
 	hdata->msi_msg.address_lo &= ~MSI_ADDR_DEST_ID_MASK;
 	destid = apic->calc_dest_apicid(hdata->handling_cpu);
 	hdata->msi_msg.address_lo |= MSI_ADDR_DEST_ID(destid);
@@ -217,9 +240,17 @@ static int hardlockup_detector_nmi_handler(unsigned int type,
  */
 static int setup_irq_msi_mode(struct hpet_hld_data *hdata)
 {
+	s32 ret;
 	u32 v;
 
-	compose_msi_msg(hdata);
+	if (irq_remapping_enabled(hdata)) {
+		ret = hld_hpet_intremap_alloc_irq(hdata);
+		if (ret)
+			return ret;
+	} else {
+		compose_msi_msg(hdata);
+	}
+
 	hpet_writel(hdata->msi_msg.data, HPET_Tn_ROUTE(hdata->num));
 	hpet_writel(hdata->msi_msg.address_lo, HPET_Tn_ROUTE(hdata->num) + 4);
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
