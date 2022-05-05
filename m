Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279EDC433FE
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 23:57:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7B3B610FD;
	Thu,  5 May 2022 23:57:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uzE7BnRYqo_8; Thu,  5 May 2022 23:57:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C05AD610BF;
	Thu,  5 May 2022 23:57:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A76A2C0032;
	Thu,  5 May 2022 23:57:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1502FC002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3EF5160B77
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v4IgGK2F2cqr for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 23:57:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D969A60BAC
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651795068; x=1683331068;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=5M26CnkIjGrveCxZY+LFQe6aJhW+irvkad9bEfjWjOs=;
 b=AhyXibySsPZX3P2X0Bg0KSWte5pTlqBDVvAn3+O5RxNn52mqv3xMqKpK
 217yEXKy8WNBRxEuScRiMT0P+wMOfQznelRc1kJO3Whv9+l3vgh1yvNoG
 35sn8gyKAU2bI9mDzYo/zTvA9ntpFbMoOxDxlbmcNcCfAceozt2eZuRnk
 anEK+wrmpQ+h3DdWcUHZs4EkcumUc8O7Hzgq0N5nM6idg/rXBhuflh6/n
 Q2RnMdgn427O8DxyzkqbAwarFYxzTid4WPgN2CMAX8+sPJwWxTpbq3Tut
 Rag+c9iT9Q4biOhy+pnz/Mca2dM3rRjoIS8zL6jaWQlv19TKXhH3D2StV A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="293496321"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="293496321"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 16:57:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="694914357"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:48 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org
Subject: [PATCH v6 10/29] iommu/vt-d: Implement minor tweaks for NMI irqs
Date: Thu,  5 May 2022 16:59:49 -0700
Message-Id: <20220506000008.30892-11-ricardo.neri-calderon@linux.intel.com>
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

The Intel IOMMU interrupt remapping driver already programs correctly the
delivery mode of individual irqs as per their irq_data. Improve handling
of NMIs. Allow only one irq per NMI. Also, it is not necessary to cleanup
irq vectors after updating affinity. NMIs do not have associated vectors.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 * Introduced this patch.

Changes since v4:
 * N/A

Changes since v3:
 * N/A

Changes since v2:
 * N/A

Changes since v1:
 * N/A
---
 drivers/iommu/intel/irq_remapping.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index fb2d71bea98d..791a9331e257 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1198,8 +1198,12 @@ intel_ir_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	 * After this point, all the interrupts will start arriving
 	 * at the new destination. So, time to cleanup the previous
 	 * vector allocation.
+	 *
+	 * Do it only for non-NMI irqs. NMIs don't have associated
+	 * vectors.
 	 */
-	send_cleanup_vector(cfg);
+	if (cfg->delivery_mode != APIC_DELIVERY_MODE_NMI)
+		send_cleanup_vector(cfg);
 
 	return IRQ_SET_MASK_OK_DONE;
 }
@@ -1352,6 +1356,9 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
 	if (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI)
 		info->flags &= ~X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
 
+	if ((info->flags & X86_IRQ_ALLOC_AS_NMI) && nr_irqs != 1)
+		return -EINVAL;
+
 	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
 	if (ret < 0)
 		return ret;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
