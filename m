From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 1/8] iommu/io-pgtable-arm-v7s: Check table PTEs more
	precisely
Date: Thu, 22 Jun 2017 16:53:50 +0100
Message-ID: <769fe7c1a4d3a4165943b1a0c1443be3508d224c.1498145008.git.robin.murphy@arm.com>
References: <cover.1498145008.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1498145008.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: sunil.goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Whilst we don't support the PXN bit at all, so should never encounter a
level 1 section or supersection PTE with it set, it would still be wise
to check both table type bits to resolve any theoretical ambiguity.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v2: No change

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
