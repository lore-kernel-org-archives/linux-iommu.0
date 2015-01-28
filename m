From: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
Subject: [PATCH 06/26] iommu/fsl: Fix checkpatch type LEADING_SPACE
Date: Wed, 28 Jan 2015 08:34:38 -0600
Message-ID: <1422455698-3074-7-git-send-email-Emilian.Medve@Freescale.com>
References: <1422455698-3074-1-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422455698-3074-1-git-send-email-Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, Varun.Sethi-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org
Cc: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

WARNING:LEADING_SPACE: please, no spaces at the start of a line
+       return __ffs(subwindow_cnt) - 1;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
+                (PAACE_ATM_WINDOW_XLATE | PAACE_ATM_PAGE_XLATE)$

Signed-off-by: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
---
 drivers/iommu/fsl_pamu.c | 4 ++--
 drivers/iommu/fsl_pamu.h | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index df6007c..ccdc5e5 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -169,8 +169,8 @@ static unsigned int map_addrspace_size_to_wse(phys_addr_t addrspace_size)
 /* Derive the PAACE window count encoding for the subwindow count */
 static unsigned int map_subwindow_cnt_to_wce(u32 subwindow_cnt)
 {
-       /* window count is 2^(WCE+1) bytes */
-       return __ffs(subwindow_cnt) - 1;
+	/* window count is 2^(WCE+1) bytes */
+	return __ffs(subwindow_cnt) - 1;
 }
 
 /*
diff --git a/drivers/iommu/fsl_pamu.h b/drivers/iommu/fsl_pamu.h
index a7794b5..52a91af 100644
--- a/drivers/iommu/fsl_pamu.h
+++ b/drivers/iommu/fsl_pamu.h
@@ -200,8 +200,7 @@ struct pamu_mmap_regs {
 #define PAACE_ATM_NO_XLATE      0x00
 #define PAACE_ATM_WINDOW_XLATE  0x01
 #define PAACE_ATM_PAGE_XLATE    0x02
-#define PAACE_ATM_WIN_PG_XLATE  \
-                (PAACE_ATM_WINDOW_XLATE | PAACE_ATM_PAGE_XLATE)
+#define PAACE_ATM_WIN_PG_XLATE  (PAACE_ATM_WINDOW_XLATE | PAACE_ATM_PAGE_XLATE)
 #define PAACE_OTM_NO_XLATE      0x00
 #define PAACE_OTM_IMMEDIATE     0x01
 #define PAACE_OTM_INDEXED       0x02
-- 
2.2.2
