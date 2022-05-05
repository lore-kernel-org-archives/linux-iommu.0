Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F29AC43217
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 23:58:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12A59610BF;
	Thu,  5 May 2022 23:58:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id evFQMNXMpYx3; Thu,  5 May 2022 23:58:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D800A60C07;
	Thu,  5 May 2022 23:57:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83372C0083;
	Thu,  5 May 2022 23:57:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 117D6C002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AEE5660C07
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tqkCwDa7vOHS for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 23:57:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C53F660B6A
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651795069; x=1683331069;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=3xUpwlx5TiZjojK61Skg6W12+8Hy6giKnPG/YThYLqA=;
 b=SzxrFZ4cLiiZSa2YBvH08MIiMgL7bgUpuevRSGTspfiS7BXkeKhEvSXD
 jAChdKkXsEbK28qgPNLpRNYFKypT+60fXllrElSttfQRzj31YHOw80R7u
 wMQtidspo2R3Oso9c65uESa5Ty8LqarAe2UvxGqzIKwINFXsNhDqUzw6t
 5x+iLnZpJmuCPKISJiIRCRqlZyRbV2xljqO97j65ZkP4FCYzknYIqNhr4
 NW2wgSL/tim/xBy4z7sTBlTFPfXM9y5Jk6ucaCkYzR+thelaetXlp6pod
 W/z1i0iGVpo+2JiXs+wTPcSLEncetDG1mg+YLk8b/IzPkfRsqiE7IqYI/ A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="293496326"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="293496326"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 16:57:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="694914367"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:49 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org
Subject: [PATCH v6 12/29] iommu/amd: Enable NMIPass when allocating an NMI irq
Date: Thu,  5 May 2022 16:59:51 -0700
Message-Id: <20220506000008.30892-13-ricardo.neri-calderon@linux.intel.com>
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

As per the AMD I/O Virtualization Technology (IOMMU) Specification, the
AMD IOMMU only remaps fixed and arbitrated MSIs. NMIs are controlled
by the NMIPass bit of a Device Table Entry. When set, the IOMMU passes
through NMI interrupt messages unmapped. Otherwise, they are aborted.

Furthermore, Section 2.2.5 Table 19 states that the IOMMU will also
abort NMIs when the destination mode is logical.

Update the NMIPass setting of a device's DTE when an NMI irq is being
allocated. Only do so when the destination mode of the APIC is not
logical.

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
 drivers/iommu/amd/iommu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a1ada7bff44e..4d7421b6858d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3156,6 +3156,15 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 	    info->type != X86_IRQ_ALLOC_TYPE_PCI_MSIX)
 		return -EINVAL;
 
+	if (info->flags & X86_IRQ_ALLOC_AS_NMI) {
+		/* Only one IRQ per NMI */
+		if (nr_irqs != 1)
+			return -EINVAL;
+
+		/* NMIs are aborted when the destination mode is logical. */
+		if (apic->dest_mode_logical)
+			return -EPERM;
+	}
 	/*
 	 * With IRQ remapping enabled, don't need contiguous CPU vectors
 	 * to support multiple MSI interrupts.
@@ -3208,6 +3217,15 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 		goto out_free_parent;
 	}
 
+	if (info->flags & X86_IRQ_ALLOC_AS_NMI) {
+		struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
+
+		if (!get_dev_entry_bit(devid, DEV_ENTRY_NMI_PASS)) {
+			set_dev_entry_bit(devid, DEV_ENTRY_NMI_PASS);
+			iommu_flush_dte(iommu, devid);
+		}
+	}
+
 	for (i = 0; i < nr_irqs; i++) {
 		irq_data = irq_domain_get_irq_data(domain, virq + i);
 		cfg = irq_data ? irqd_cfg(irq_data) : NULL;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
