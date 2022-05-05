Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403E6C4332F
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 23:58:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D72F610D2;
	Thu,  5 May 2022 23:58:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MMQbD1sJ62Gi; Thu,  5 May 2022 23:58:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D400E60ADE;
	Thu,  5 May 2022 23:58:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE5A4C0032;
	Thu,  5 May 2022 23:58:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1674DC002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:58:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9EB5760E7E
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rhi5jfo1sHNN for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 23:57:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D3A0360A46
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651795066; x=1683331066;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=gFAa9l6D17AE+FwqBH16mNyyvqzE44nr84f76LNdCPk=;
 b=F/LojuWSq3xkx/+OL09YRl7jAKY/5O7/8bvQpLedmMy8oZobk1l8j1cq
 9fUJU4d1Hju3Apb9a3iZn2L+EgAoirxw6lbukfRGX8ErGRF7JU+dyIcIK
 /ZKRM0B1IJ9oW+/cVWftQW7+jET+Lf7sh4JTdVR7KUjs4rdaqSx0xhyyF
 1UwVNJvug389dkAwrg1sQTC0DW0jqM+yvs2gxA7d2uA1H7APjXEwBq05T
 0RayFMBcKxR0s5H5w2CmRkt1WvG1ENXDV+NZO/g2Aj59pOrOViJEeqJQ2
 BD0M/2GfzsdoE/iYnGBP/wpycyehE9NvpOhvmFaa3Pwywg1O9QB07TbkO w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="328836874"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="328836874"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 16:57:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="694914319"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:44 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org
Subject: [PATCH v6 01/29] irq/matrix: Expose functions to allocate the best
 CPU for new vectors
Date: Thu,  5 May 2022 16:59:40 -0700
Message-Id: <20220506000008.30892-2-ricardo.neri-calderon@linux.intel.com>
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

Certain types of interrupts, such as NMI, do not have an associated vector.
They, however, target specific CPUs. Thus, when assigning the destination
CPU, it is beneficial to select the one with the lowest number of vectors.
Prepend the functions matrix_find_best_cpu_managed() and
matrix_find_best_cpu_managed() with the irq_ prefix and expose them for
IRQ controllers to use when allocating and activating vector-less IRQs.

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
 include/linux/irq.h |  4 ++++
 kernel/irq/matrix.c | 32 +++++++++++++++++++++++---------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index f92788ccdba2..9e674e73d295 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1223,6 +1223,10 @@ struct irq_matrix *irq_alloc_matrix(unsigned int matrix_bits,
 void irq_matrix_online(struct irq_matrix *m);
 void irq_matrix_offline(struct irq_matrix *m);
 void irq_matrix_assign_system(struct irq_matrix *m, unsigned int bit, bool replace);
+unsigned int irq_matrix_find_best_cpu(struct irq_matrix *m,
+				      const struct cpumask *msk);
+unsigned int irq_matrix_find_best_cpu_managed(struct irq_matrix *m,
+					      const struct cpumask *msk);
 int irq_matrix_reserve_managed(struct irq_matrix *m, const struct cpumask *msk);
 void irq_matrix_remove_managed(struct irq_matrix *m, const struct cpumask *msk);
 int irq_matrix_alloc_managed(struct irq_matrix *m, const struct cpumask *msk,
diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 1698e77645ac..810479f608f4 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -125,9 +125,16 @@ static unsigned int matrix_alloc_area(struct irq_matrix *m, struct cpumap *cm,
 	return area;
 }
 
-/* Find the best CPU which has the lowest vector allocation count */
-static unsigned int matrix_find_best_cpu(struct irq_matrix *m,
-					const struct cpumask *msk)
+/**
+ * irq_matrix_find_best_cpu() - Find the best CPU for an IRQ
+ * @m:		Matrix pointer
+ * @msk:	On which CPUs the search will be performed
+ *
+ * Find the best CPU which has the lowest vector allocation count
+ * Returns: The best CPU to use
+ */
+unsigned int irq_matrix_find_best_cpu(struct irq_matrix *m,
+				      const struct cpumask *msk)
 {
 	unsigned int cpu, best_cpu, maxavl = 0;
 	struct cpumap *cm;
@@ -146,9 +153,16 @@ static unsigned int matrix_find_best_cpu(struct irq_matrix *m,
 	return best_cpu;
 }
 
-/* Find the best CPU which has the lowest number of managed IRQs allocated */
-static unsigned int matrix_find_best_cpu_managed(struct irq_matrix *m,
-						const struct cpumask *msk)
+/**
+ * irq_matrix_find_best_cpu_managed() - Find the best CPU for a managed IRQ
+ * @m:		Matrix pointer
+ * @msk:	On which CPUs the search will be performed
+ *
+ * Find the best CPU which has the lowest number of managed IRQs allocated
+ * Returns: The best CPU to use
+ */
+unsigned int irq_matrix_find_best_cpu_managed(struct irq_matrix *m,
+					      const struct cpumask *msk)
 {
 	unsigned int cpu, best_cpu, allocated = UINT_MAX;
 	struct cpumap *cm;
@@ -292,7 +306,7 @@ int irq_matrix_alloc_managed(struct irq_matrix *m, const struct cpumask *msk,
 	if (cpumask_empty(msk))
 		return -EINVAL;
 
-	cpu = matrix_find_best_cpu_managed(m, msk);
+	cpu = irq_matrix_find_best_cpu_managed(m, msk);
 	if (cpu == UINT_MAX)
 		return -ENOSPC;
 
@@ -381,13 +395,13 @@ int irq_matrix_alloc(struct irq_matrix *m, const struct cpumask *msk,
 	struct cpumap *cm;
 
 	/*
-	 * Not required in theory, but matrix_find_best_cpu() uses
+	 * Not required in theory, but irq_matrix_find_best_cpu() uses
 	 * for_each_cpu() which ignores the cpumask on UP .
 	 */
 	if (cpumask_empty(msk))
 		return -EINVAL;
 
-	cpu = matrix_find_best_cpu(m, msk);
+	cpu = irq_matrix_find_best_cpu(m, msk);
 	if (cpu == UINT_MAX)
 		return -ENOSPC;
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
