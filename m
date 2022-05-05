Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBE3C43217
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 23:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EEFC960D93;
	Thu,  5 May 2022 23:58:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8bmV7XlCwnyH; Thu,  5 May 2022 23:58:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D762A610BF;
	Thu,  5 May 2022 23:58:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 199D1C0086;
	Thu,  5 May 2022 23:58:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D10BC002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:58:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C1A060D93
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aw-Dg2AFUY_b for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 23:57:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A475660B74
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651795068; x=1683331068;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=UTXQyhtYGmsXw7bhN7zaVr8NO2RbQS3Z18S2QU+fmiU=;
 b=TkI3ErVa6E/wKXrJYGclIEF1FH1S5CUIRMYL1lZMY5p+TVmH1q5lFewn
 TBjoeTC5BiOnqGqxpdZ1h1daVDO0yjulB0yfx2IopzC5aHe8qZy8XBZXD
 5KA2NES34fu286S2yrXQvjZ+jRACv61L0VDgWREvg/A7YdpF0H6jUDCa8
 OHBWOnw8xQTLdQ/erkb9KdQ4BgalN6cDWkWp5TF7gT72hKCojAk+P6z83
 M67YjC8m8+1c71SLYvIn2tIUfmTIdViKuxciAhpiGWuyoLnJIB2g6If6d
 4KhG0Pb4xfNmgITcAnO/PyQ/j5kW2KIP5nXcYhUQJPwwXBknpcA52UWwv w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="293496314"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="293496314"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 16:57:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="694914350"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:47 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org
Subject: [PATCH v6 08/29] iommu/vt-d: Rework prepare_irte() to support per-IRQ
 delivery mode
Date: Thu,  5 May 2022 16:59:47 -0700
Message-Id: <20220506000008.30892-9-ricardo.neri-calderon@linux.intel.com>
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

struct irq_cfg::delivery_mode specifies the delivery mode of each IRQ
separately. Configuring the delivery mode of an IRTE would require adding
a third argument to prepare_irte(). Instead, simply take a pointer to the
irq_cfg for which an IRTE is being configured. This change does not cause
functional changes.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 * Only change the signature of prepare_irte(). A separate patch changes
   the setting of the delivery_mode.

Changes since v4:
 * None

Changes since v3:
 * None

Changes since v2:
 * None

Changes since v1:
 * Introduced this patch.
---
 drivers/iommu/intel/irq_remapping.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index d2764a71f91a..66d37186ec28 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1111,7 +1111,7 @@ void intel_irq_remap_add_device(struct dmar_pci_notify_info *info)
 	dev_set_msi_domain(&info->dev->dev, map_dev_to_ir(info->dev));
 }
 
-static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
+static void prepare_irte(struct irte *irte, struct irq_cfg *irq_cfg)
 {
 	memset(irte, 0, sizeof(*irte));
 
@@ -1126,8 +1126,8 @@ static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
 	*/
 	irte->trigger_mode = 0;
 	irte->dlvry_mode = apic->delivery_mode;
-	irte->vector = vector;
-	irte->dest_id = IRTE_DEST(dest);
+	irte->vector = irq_cfg->vector;
+	irte->dest_id = IRTE_DEST(irq_cfg->dest_apicid);
 
 	/*
 	 * When using the destination mode of physical APICID, only the
@@ -1278,8 +1278,7 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
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
