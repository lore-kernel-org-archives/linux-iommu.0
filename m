From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 2/3] xtensa: remove ZONE_DMA
Date: Thu, 20 Sep 2018 19:15:39 +0200
Message-ID: <20180920171540.2657-3-hch@lst.de>
References: <20180920171540.2657-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180920171540.2657-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

ZONE_DMA is intended for magic < 32-bit pools (usually ISA DMA), which
isn't required on xtensa.  Move all the non-highmem memory into
ZONE_NORMAL instead to match other architectures.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/xtensa/Kconfig   | 3 ---
 arch/xtensa/mm/init.c | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 516694937b7a..9a7c654a7654 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-config ZONE_DMA
-	def_bool y
-
 config XTENSA
 	def_bool y
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
diff --git a/arch/xtensa/mm/init.c b/arch/xtensa/mm/init.c
index 34aead7dcb48..b385e6b73065 100644
--- a/arch/xtensa/mm/init.c
+++ b/arch/xtensa/mm/init.c
@@ -71,7 +71,7 @@ void __init zones_init(void)
 {
 	/* All pages are DMA-able, so we put them all in the DMA zone. */
 	unsigned long zones_size[MAX_NR_ZONES] = {
-		[ZONE_DMA] = max_low_pfn - ARCH_PFN_OFFSET,
+		[ZONE_NORMAL] = max_low_pfn - ARCH_PFN_OFFSET,
 #ifdef CONFIG_HIGHMEM
 		[ZONE_HIGHMEM] = max_pfn - max_low_pfn,
 #endif
-- 
2.18.0
