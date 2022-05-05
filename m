Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2177C433F5
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 23:57:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6EF2D83E26;
	Thu,  5 May 2022 23:57:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4sqiVc_n0QX0; Thu,  5 May 2022 23:57:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9DF4F82BBA;
	Thu,  5 May 2022 23:57:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BE70C002D;
	Thu,  5 May 2022 23:57:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10A6AC002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0725360BC6
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NTY81QPL93gB for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 23:57:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BDE0160AD8
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651795067; x=1683331067;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=D+sZP1VTaO2AD2PX2fNF30e9SIwhyViy7LM9jGqhP5M=;
 b=bsFDga76t8yiZChb3uUw+latfT3p6I20MC2+fZHfDlCOAUBGkh1sfEnK
 kpA+4PHEQeJp2QKk2dmULVMptvy+0tugwMIlITxS1dXtNcHIr8TTLsb+R
 FBXUEP23YSB3msNH5hKY9OuEXCMmUFN26M95esj7vjiaHGZUNTdilajVW
 aOSwA/bIspzJKJ3jESRzQ4fy6uNOS+26V3UT8MoEd1NtqX7Dc3c5P6Abd
 +KzCkmzSOf+LnaKnCNi/zsWpQAxr0fqvN48Iy2djIyPkI4O3u9MiEkbCO
 iD93KjAxh94L0XD/d7VA5jJ1GHbUcusVnvr1Cxs0yOCXclfmlAgeNSQBY g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="328836894"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="328836894"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 16:57:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="694914338"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:45 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org
Subject: [PATCH v6 05/29] x86/apic/vector: Do not allocate vectors for NMIs
Date: Thu,  5 May 2022 16:59:44 -0700
Message-Id: <20220506000008.30892-6-ricardo.neri-calderon@linux.intel.com>
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

Vectors are meaningless when allocating IRQs with NMI as the delivery mode.
In such case, skip the reservation of IRQ vectors. Do it in the lowest-
level functions where the actual IRQ reservation takes place.

Since NMIs target specific CPUs, keep the functionality to find the best
CPU.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Reviewed-by: Tony Luck <tony.luck@intel.com>
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
 arch/x86/kernel/apic/vector.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 838e220e8860..11f881f45cec 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -245,11 +245,20 @@ assign_vector_locked(struct irq_data *irqd, const struct cpumask *dest)
 	if (apicd->move_in_progress || !hlist_unhashed(&apicd->clist))
 		return -EBUSY;
 
+	if (apicd->hw_irq_cfg.delivery_mode == APIC_DELIVERY_MODE_NMI) {
+		cpu = irq_matrix_find_best_cpu(vector_matrix, dest);
+		apicd->cpu = cpu;
+		vector = 0;
+		goto no_vector;
+	}
+
 	vector = irq_matrix_alloc(vector_matrix, dest, resvd, &cpu);
 	trace_vector_alloc(irqd->irq, vector, resvd, vector);
 	if (vector < 0)
 		return vector;
 	apic_update_vector(irqd, vector, cpu);
+
+no_vector:
 	apic_update_irq_cfg(irqd, vector, cpu);
 
 	return 0;
@@ -321,12 +330,22 @@ assign_managed_vector(struct irq_data *irqd, const struct cpumask *dest)
 	/* set_affinity might call here for nothing */
 	if (apicd->vector && cpumask_test_cpu(apicd->cpu, vector_searchmask))
 		return 0;
+
+	if (apicd->hw_irq_cfg.delivery_mode == APIC_DELIVERY_MODE_NMI) {
+		cpu = irq_matrix_find_best_cpu_managed(vector_matrix, dest);
+		apicd->cpu = cpu;
+		vector = 0;
+		goto no_vector;
+	}
+
 	vector = irq_matrix_alloc_managed(vector_matrix, vector_searchmask,
 					  &cpu);
 	trace_vector_alloc_managed(irqd->irq, vector, vector);
 	if (vector < 0)
 		return vector;
 	apic_update_vector(irqd, vector, cpu);
+
+no_vector:
 	apic_update_irq_cfg(irqd, vector, cpu);
 	return 0;
 }
@@ -376,6 +395,10 @@ static void x86_vector_deactivate(struct irq_domain *dom, struct irq_data *irqd)
 	if (apicd->has_reserved)
 		return;
 
+	/* NMI IRQs do not have associated vectors; nothing to do. */
+	if (apicd->hw_irq_cfg.delivery_mode == APIC_DELIVERY_MODE_NMI)
+		return;
+
 	raw_spin_lock_irqsave(&vector_lock, flags);
 	clear_irq_vector(irqd);
 	if (apicd->can_reserve)
@@ -472,6 +495,10 @@ static void vector_free_reserved_and_managed(struct irq_data *irqd)
 	trace_vector_teardown(irqd->irq, apicd->is_managed,
 			      apicd->has_reserved);
 
+	/* NMI IRQs do not have associated vectors; nothing to do. */
+	if (apicd->hw_irq_cfg.delivery_mode == APIC_DELIVERY_MODE_NMI)
+		return;
+
 	if (apicd->has_reserved)
 		irq_matrix_remove_reserved(vector_matrix);
 	if (apicd->is_managed)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
