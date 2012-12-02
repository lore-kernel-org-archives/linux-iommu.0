From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/2] iommu/amd: Remove obsolete comment
Date: Sun,  2 Dec 2012 16:06:14 +0100
Message-ID: <1354460774-2936-2-git-send-email-joro@8bytes.org>
References: <1354460774-2936-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1354460774-2936-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
List-Id: iommu@lists.linux-foundation.org

The AMD IOMMU driver only uses the page-sizes it gets from
IOMMU core and uses the appropriate page-size. So this
comment is not necessary.

Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/amd_iommu.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 98d74ab..c1c74e0 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -57,16 +57,6 @@
  * physically contiguous memory regions it is mapping into page sizes
  * that we support.
  *
- * Traditionally the IOMMU core just handed us the mappings directly,
- * after making sure the size is an order of a 4KiB page and that the
- * mapping has natural alignment.
- *
- * To retain this behavior, we currently advertise that we support
- * all page sizes that are an order of 4KiB.
- *
- * If at some point we'd like to utilize the IOMMU core's new behavior,
- * we could change this to advertise the real page sizes we support.
- *
  * 512GB Pages are not supported due to a hardware bug
  */
 #define AMD_IOMMU_PGSIZES	((~0xFFFUL) & ~(2ULL << 38))
-- 
1.7.9.5
