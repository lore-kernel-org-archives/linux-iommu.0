Return-Path: <SRS0=CTmu=TY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AD5C282DE
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 01:18:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B175217F9
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 01:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B175217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2ECC911A1;
	Fri, 24 May 2019 01:16:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0757AFD4
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 01:16:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A045481A
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 01:16:44 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 May 2019 18:16:39 -0700
X-ExtLoop1: 1
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
	by fmsmga008.fm.intel.com with ESMTP; 23 May 2019 18:16:38 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@suse.de>
Subject: [RFC PATCH v4 19/21] iommu/vt-d: Rework prepare_irte() to support
	per-irq delivery mode
Date: Thu, 23 May 2019 18:16:21 -0700
Message-Id: <1558660583-28561-20-git-send-email-ricardo.neri-calderon@linux.intel.com>
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

A recent change introduced a new member to struct irq_cfg to specify the
delivery mode of an interrupt. Supporting the configuration of the
delivery mode would require adding a third argument to prepare_irte().
Instead, simply take a pointer to a irq_cfg data structure as a the only
argument.

Internally, configure the delivery mode of the Interrupt Remapping Table
Entry as specified in the irq_cfg data structure and not as the APIC
setting.

This change does not change the existing behavior, as the delivery mode
of the APIC is used to configure irq_cfg data structure.

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
 drivers/iommu/intel_irq_remapping.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 4160aa9f3f80..2e61eaca7d7e 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -1072,7 +1072,7 @@ static int reenable_irq_remapping(int eim)
 	return -1;
 }
 
-static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
+static void prepare_irte(struct irte *irte, struct irq_cfg *irq_cfg)
 {
 	memset(irte, 0, sizeof(*irte));
 
@@ -1086,9 +1086,9 @@ static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
 	 * irq migration in the presence of interrupt-remapping.
 	*/
 	irte->trigger_mode = 0;
-	irte->dlvry_mode = apic->irq_delivery_mode;
-	irte->vector = vector;
-	irte->dest_id = IRTE_DEST(dest);
+	irte->dlvry_mode = irq_cfg->delivery_mode;
+	irte->vector = irq_cfg->vector;
+	irte->dest_id = IRTE_DEST(irq_cfg->dest_apicid);
 	irte->redir_hint = 1;
 }
 
@@ -1265,7 +1265,7 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
 	struct irte *irte = &data->irte_entry;
 	struct msi_msg *msg = &data->msi_entry;
 
-	prepare_irte(irte, irq_cfg->vector, irq_cfg->dest_apicid);
+	prepare_irte(irte, irq_cfg);
 	switch (info->type) {
 	case X86_IRQ_ALLOC_TYPE_IOAPIC:
 		/* Set source-id of interrupt request */
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
