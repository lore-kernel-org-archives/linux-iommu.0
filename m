From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 1/3] iommu/fsl: Fix PAMU window size check.
Date: Tue, 24 Jun 2014 19:27:15 +0530
Message-ID: <1403618237-26248-2-git-send-email-Varun.Sethi@freescale.com>
References: <1403618237-26248-1-git-send-email-Varun.Sethi@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1403618237-26248-1-git-send-email-Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

is_power_of_2 requires an unsigned long parameter which would
lead to truncation of 64 bit values on 32 bit architectures.

__ffs also expects an unsigned long parameter thus won't work
for 64 bit values on 32 bit architectures.

Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/iommu/fsl_pamu.c        |    8 ++++----
 drivers/iommu/fsl_pamu_domain.c |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index b99dd88..bb446d7 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -170,10 +170,10 @@ int pamu_disable_liodn(int liodn)
 static unsigned int map_addrspace_size_to_wse(phys_addr_t addrspace_size)
 {
 	/* Bug if not a power of 2 */
-	BUG_ON(!is_power_of_2(addrspace_size));
+	BUG_ON((addrspace_size & (addrspace_size - 1)));
 
 	/* window size is 2^(WSE+1) bytes */
-	return __ffs(addrspace_size) - 1;
+	return fls64(addrspace_size) - 2;
 }
 
 /* Derive the PAACE window count encoding for the subwindow count */
@@ -351,7 +351,7 @@ int pamu_config_ppaace(int liodn, phys_addr_t win_addr, phys_addr_t win_size,
 	struct paace *ppaace;
 	unsigned long fspi;
 
-	if (!is_power_of_2(win_size) || win_size < PAMU_PAGE_SIZE) {
+	if ((win_size & (win_size - 1)) || win_size < PAMU_PAGE_SIZE) {
 		pr_debug("window size too small or not a power of two %llx\n", win_size);
 		return -EINVAL;
 	}
@@ -464,7 +464,7 @@ int pamu_config_spaace(int liodn, u32 subwin_cnt, u32 subwin,
 		return -ENOENT;
 	}
 
-	if (!is_power_of_2(subwin_size) || subwin_size < PAMU_PAGE_SIZE) {
+	if ((subwin_size & (subwin_size - 1)) || subwin_size < PAMU_PAGE_SIZE) {
 		pr_debug("subwindow size out of range, or not a power of 2\n");
 		return -EINVAL;
 	}
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 93072ba..3dd0b8e 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -301,7 +301,7 @@ static int check_size(u64 size, dma_addr_t iova)
 	 * Size must be a power of two and at least be equal
 	 * to PAMU page size.
 	 */
-	if (!is_power_of_2(size) || size < PAMU_PAGE_SIZE) {
+	if ((size & (size - 1)) || size < PAMU_PAGE_SIZE) {
 		pr_debug("%s: size too small or not a power of two\n", __func__);
 		return -EINVAL;
 	}
-- 
1.7.9.5
