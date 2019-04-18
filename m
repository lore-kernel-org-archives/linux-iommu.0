From: Julien Grall <julien.grall@arm.com>
Subject: [PATCH 1/7] genirq/msi: Add a new field in msi_desc to store an IOMMU cookie
Date: Thu, 18 Apr 2019 18:26:05 +0100
Message-ID: <20190418172611.21561-2-julien.grall@arm.com>
References: <20190418172611.21561-1-julien.grall@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190418172611.21561-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: logang@deltatee.com, douliyangs@gmail.com, miquel.raynal@bootlin.com, marc.zyngier@arm.com, jason@lakedaemon.net, tglx@linutronix.de, joro@8bytes.org, robin.murphy@arm.com, bigeasy@linutronix.de, linux-rt-users@vger.kernel.org, Julien Grall <julien.grall@arm.com>
List-Id: iommu@lists.linux-foundation.org

When an MSI doorbell is located downstream of an IOMMU, it is required
to swizzle the physical address with an appropriately-mapped IOVA for any
device attached to one of our DMA ops domain.

At the moment, the allocation of the mapping may be done when composing
the message. However, the composing may be done in non-preemtible
context while the allocation requires to be called from preemptible
context.

A follow-up patch will split the current logic in two functions
requiring to keep an IOMMU cookie per MSI.

This patch introduces a new field in msi_desc to store an IOMMU cookie
when CONFIG_IOMMU_DMA is selected.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 include/linux/msi.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 7e9b81c3b50d..d7907feef1bb 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -77,6 +77,9 @@ struct msi_desc {
 	struct device			*dev;
 	struct msi_msg			msg;
 	struct irq_affinity_desc	*affinity;
+#ifdef CONFIG_IOMMU_DMA
+	const void			*iommu_cookie;
+#endif
 
 	union {
 		/* PCI MSI/X specific data */
-- 
2.11.0
