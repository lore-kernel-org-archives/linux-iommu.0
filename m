From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 02/13] iommu/arm-smmu: Fix MSI memory attributes to match
	specification
Date: Mon,  3 Aug 2015 14:25:44 +0100
Message-ID: <1438608355-7335-3-git-send-email-will.deacon@arm.com>
References: <1438608355-7335-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1438608355-7335-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>

The MSI memory attributes in the SMMUv3 driver are from an older
revision of the spec, which doesn't match the current implementations.

Out with the old, in with the new.

Signed-off-by: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 5d2cbdab5afa..c2c1ad8915d9 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -174,14 +174,14 @@
 #define ARM_SMMU_PRIQ_IRQ_CFG2		0xdc
 
 /* Common MSI config fields */
-#define MSI_CFG0_SH_SHIFT		60
-#define MSI_CFG0_SH_NSH			(0UL << MSI_CFG0_SH_SHIFT)
-#define MSI_CFG0_SH_OSH			(2UL << MSI_CFG0_SH_SHIFT)
-#define MSI_CFG0_SH_ISH			(3UL << MSI_CFG0_SH_SHIFT)
-#define MSI_CFG0_MEMATTR_SHIFT		56
-#define MSI_CFG0_MEMATTR_DEVICE_nGnRE	(0x1 << MSI_CFG0_MEMATTR_SHIFT)
 #define MSI_CFG0_ADDR_SHIFT		2
 #define MSI_CFG0_ADDR_MASK		0x3fffffffffffUL
+#define MSI_CFG2_SH_SHIFT		4
+#define MSI_CFG2_SH_NSH			(0UL << MSI_CFG2_SH_SHIFT)
+#define MSI_CFG2_SH_OSH			(2UL << MSI_CFG2_SH_SHIFT)
+#define MSI_CFG2_SH_ISH			(3UL << MSI_CFG2_SH_SHIFT)
+#define MSI_CFG2_MEMATTR_SHIFT		0
+#define MSI_CFG2_MEMATTR_DEVICE_nGnRE	(0x1 << MSI_CFG2_MEMATTR_SHIFT)
 
 #define Q_IDX(q, p)			((p) & ((1 << (q)->max_n_shift) - 1))
 #define Q_WRP(q, p)			((p) & (1 << (q)->max_n_shift))
-- 
2.1.4
