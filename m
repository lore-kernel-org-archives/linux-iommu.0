From: Anup Patel <anup.patel@broadcom.com>
Subject: [PATCH 4/5] vfio: Allow No-IOMMU mode for IOMMUs with bypass capability
Date: Wed, 19 Jul 2017 15:03:57 +0530
Message-ID: <1500456838-18405-5-git-send-email-anup.patel@broadcom.com>
References: <1500456838-18405-1-git-send-email-anup.patel@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500456838-18405-1-git-send-email-anup.patel@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Baptiste Reynal <b.reynal@virtualopensystems.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Anup Patel <anup.patel@broadcom.com>
List-Id: iommu@lists.linux-foundation.org

Not allowing No-IOMMU mode for devices already having
iommu_ops on their bus is little conservative.

We now have IOMMU (such as ARM SMMU) which can bypass
transcations for which IOMMU domain is not configured
hence No-IOMMU mode should not be allowed when iommu_ops
are available and IOMMU_CAP_BYPASS is not available.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/vfio/vfio.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 330d505..61f3807 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -124,11 +124,18 @@ struct iommu_group *vfio_iommu_group_get(struct device *dev)
 #ifdef CONFIG_VFIO_NOIOMMU
 	/*
 	 * With noiommu enabled, an IOMMU group will be created for a device
-	 * that doesn't already have one and doesn't have an iommu_ops on their
-	 * bus.  We set iommudata simply to be able to identify these groups
+	 * that:
+	 * 1. Doesn't already have IOMMU group
+	 * 2. Doesn't have an iommu_ops on their bus
+	 * 3. Doesn't have transaction bypass capability if iommu_ops
+	 * is available on their bus
+	 *
+	 * We set iommudata simply to be able to identify these groups
 	 * as special use and for reclamation later.
 	 */
-	if (group || !noiommu || iommu_present(dev->bus))
+	if (group || !noiommu ||
+	    (iommu_present(dev->bus) &&
+	     !iommu_capable(dev->bus, IOMMU_CAP_BYPASS)))
 		return group;
 
 	group = iommu_group_alloc();
-- 
2.7.4
