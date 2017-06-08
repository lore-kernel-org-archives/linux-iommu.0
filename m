From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 1/8] iommu/io-pgtable-arm-v7s: Check table PTEs more precisely
Date: Thu,  8 Jun 2017 12:52:00 +0100
Message-ID: <769fe7c1a4d3a4165943b1a0c1443be3508d224c.1496921366.git.robin.murphy@arm.com>
References: <cover.1496921366.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1496921366.git.robin.murphy@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: will.deacon@arm.com, joro@8bytes.org
Cc: salil.mehta@huawei.com, sunil.goutham@cavium.com, iommu@lists.linux-foundation.org, ray.jui@broadcom.com, linux-arm-kernel@lists.infradead.org, linu.cherian@cavium.com, nwatters@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

Whilst we don't support the PXN bit at all, so should never encounter a
level 1 section or supersection PTE with it set, it would still be wise
to check both table type bits to resolve any theoretical ambiguity.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 8d6ca28c3e1f..a490db032c51 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -92,7 +92,8 @@
 #define ARM_V7S_PTE_TYPE_CONT_PAGE	0x1
 
 #define ARM_V7S_PTE_IS_VALID(pte)	(((pte) & 0x3) != 0)
-#define ARM_V7S_PTE_IS_TABLE(pte, lvl)	(lvl == 1 && ((pte) & ARM_V7S_PTE_TYPE_TABLE))
+#define ARM_V7S_PTE_IS_TABLE(pte, lvl) \
+	((lvl) == 1 && (((pte) & 0x3) == ARM_V7S_PTE_TYPE_TABLE))
 
 /* Page table bits */
 #define ARM_V7S_ATTR_XN(lvl)		BIT(4 * (2 - (lvl)))
-- 
2.12.2.dirty
