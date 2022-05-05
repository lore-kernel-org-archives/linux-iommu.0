Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579A7C433F5
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 23:57:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B54883E65;
	Thu,  5 May 2022 23:57:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AtkhNYqnnVbm; Thu,  5 May 2022 23:57:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F2E1083F21;
	Thu,  5 May 2022 23:57:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0921EC0086;
	Thu,  5 May 2022 23:57:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 265D5C002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D5A1660C02
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dHWjhuHtj1AZ for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 23:57:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 437F560BAC
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651795070; x=1683331070;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=60YeowQrYtVQTC/Y9/6aG1nPAySkU1vh5niJqWVSb28=;
 b=ZOorTvO9dHQHTMvXBCbVtvybQVKqbF/l/zHOx1faZdvvzGjgY1Qpe5P+
 tn+ULiwpYAU1U1XSJAg51GlWYle6BbOSqH8TQaScy7+uXeYFf1EQLeM5H
 HLGTLd+ebGgiOBZWd2ytKWRabLoqPu+KqpSSK1ajwV9uBiD9KOrZ6dCwJ
 AfOcKCzVb8giY9IVBxjK/QBXCeL4noHnObJks64j3FR525QmcU1TcBc+o
 kJ5uT5qePp209Ia3R1LX7QJQ+Lpbj/JlHCBCzcyF2XJmHir5luTlriliq
 q4Q9ThFcq+rYW87W0HJSzCrXin3ta9ZLTCzqjc8waIk/h6hp6ciMewB/k Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="293496329"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="293496329"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 16:57:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="694914372"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:49 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org
Subject: [PATCH v6 13/29] iommu/amd: Compose MSI messages for NMI irqs in
 non-IR format
Date: Thu,  5 May 2022 16:59:52 -0700
Message-Id: <20220506000008.30892-14-ricardo.neri-calderon@linux.intel.com>
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

If NMIPass is enabled in a device's DTE, the IOMMU lets NMI interrupt
messages pass through unmapped. Therefore, the contents of the MSI
message, not an IRTE, determine how and where the NMI is delivered.

Since the IOMMU driver owns the MSI message of the NMI irq, compose
it using the non-interrupt-remapping format. Also, let descendant
irqchips write the MSI as appropriate for the device.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 * Introduced this patch

Changes since v4:
 * N/A

Changes since v3:
 * N/A

Changes since v2:
 * N/A

Changes since v1:
 * N/A
---
 drivers/iommu/amd/iommu.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4d7421b6858d..6e07949b3e2a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3111,7 +3111,16 @@ static void irq_remapping_prepare_irte(struct amd_ir_data *data,
 	case X86_IRQ_ALLOC_TYPE_HPET:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		fill_msi_msg(&data->msi_entry, irte_info->index);
+		if (irq_cfg->delivery_mode == APIC_DELIVERY_MODE_NMI)
+			/*
+			 * The IOMMU lets NMIs pass through unmapped. Thus, the
+			 * MSI message, not the IRTE, determines the irq
+			 * configuration. Since we own the MSI message,
+			 * compose it. Descendant irqchips will write it.
+			 */
+			__irq_msi_compose_msg(irq_cfg, &data->msi_entry, true);
+		else
+			fill_msi_msg(&data->msi_entry, irte_info->index);
 		break;
 
 	default:
@@ -3509,6 +3518,18 @@ static int amd_ir_set_affinity(struct irq_data *data,
 	 */
 	send_cleanup_vector(cfg);
 
+	/*
+	 * When the delivery mode of an irq is NMI, the IOMMU lets the NMI
+	 * interrupt messages pass through unmapped. Hence, changes in the
+	 * destination are to be reflected in the NMI message itself, not the
+	 * IRTE. Thus, descendant irqchips must set the affinity and compose
+	 * write the MSI message.
+	 *
+	 * Also, NMIs do not have an associated vector. No need for cleanup.
+	 */
+	if (cfg->delivery_mode == APIC_DELIVERY_MODE_NMI)
+		return IRQ_SET_MASK_OK;
+
 	return IRQ_SET_MASK_OK_DONE;
 }
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
