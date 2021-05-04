Return-Path: <SRS0=4008=J7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFDFC433ED
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 19:11:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE93C613C5
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 19:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE93C613C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4DB51405C1;
	Tue,  4 May 2021 19:11:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3sBCOqM2gOET; Tue,  4 May 2021 19:11:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1A8AE405B5;
	Tue,  4 May 2021 19:11:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AD10C002A;
	Tue,  4 May 2021 19:11:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AE45C000D
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 19:11:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D1848414F1
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 19:11:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pwULvwom6HSj for <iommu@lists.linux-foundation.org>;
 Tue,  4 May 2021 19:11:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DF967414FA
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 19:11:41 +0000 (UTC)
IronPort-SDR: 1BYwxRBXdZcYCvVsWgsYOGOqXEbtMufTC+aREsZfwI8l62pu0f6dhpSqjAv2XeztDJSoGK6wV3
 KGlrPhwq5wDw==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="197675486"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; d="scan'208";a="197675486"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2021 12:11:40 -0700
IronPort-SDR: IK6bB7wYh6Fq1z+4b4l2CKAy6AQJOKFWjnU47QxqU+svFLNmNZdKBQJpGpTG2XWFRYHsFlmidk
 XI2OCd794ozw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; d="scan'208";a="396245287"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by fmsmga007.fm.intel.com with ESMTP; 04 May 2021 12:11:40 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [RFC PATCH v5 3/7] iommu/vt-d: Rework prepare_irte() to support
 per-irq delivery mode
Date: Tue,  4 May 2021 12:10:45 -0700
Message-Id: <20210504191049.22661-4-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210504191049.22661-1-ricardo.neri-calderon@linux.intel.com>
References: <20210504191049.22661-1-ricardo.neri-calderon@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
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

A previous changeset introduced a new member to struct irq_cfg to specify
the delivery mode of an interrupt. Supporting the configuration of the
delivery mode would require adding a third argument to prepare_irte().
Instead, simply take a pointer to an irq_cfg data structure as the only
argument.

Always configure the delivery mode of the Interrupt Remapping Table
Entry using the values specified in the irq_cfg data structure.

This change does not change the existing behavior, as the delivery mode
of the APIC is used to configure the irq_cfg of each irq.

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
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v4:
 * None

Changes since v3:
 * None

Changes since v2:
 * None

Changes since v1:
 * Introduced this patch.
---
 drivers/iommu/intel/irq_remapping.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 611ef5243cb6..daa5df53db59 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1104,7 +1104,7 @@ void intel_irq_remap_add_device(struct dmar_pci_notify_info *info)
 	dev_set_msi_domain(&info->dev->dev, map_dev_to_ir(info->dev));
 }
 
-static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
+static void prepare_irte(struct irte *irte, struct irq_cfg *irq_cfg)
 {
 	memset(irte, 0, sizeof(*irte));
 
@@ -1118,9 +1118,9 @@ static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
 	 * irq migration in the presence of interrupt-remapping.
 	*/
 	irte->trigger_mode = 0;
-	irte->dlvry_mode = apic->delivery_mode;
-	irte->vector = vector;
-	irte->dest_id = IRTE_DEST(dest);
+	irte->dlvry_mode = irq_cfg->delivery_mode;
+	irte->vector = irq_cfg->vector;
+	irte->dest_id = IRTE_DEST(irq_cfg->dest_apicid);
 	irte->redir_hint = 1;
 }
 
@@ -1261,8 +1261,7 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
 {
 	struct irte *irte = &data->irte_entry;
 
-	prepare_irte(irte, irq_cfg->vector, irq_cfg->dest_apicid);
-
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
