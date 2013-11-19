From: Bharat Bhushan <r65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 6/9 v2] powerpc: pci: Extend msi iova page setup to arch
	specific
Date: Tue, 19 Nov 2013 10:47:10 +0530
Message-ID: <1384838233-24847-7-git-send-email-Bharat.Bhushan@freescale.com>
References: <1384838233-24847-1-git-send-email-Bharat.Bhushan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1384838233-24847-1-git-send-email-Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org, stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch extend the interface to arch specific code for setting
msi iova address for a msi page. Machine specific code is not yet
implemented.

Signed-off-by: Bharat Bhushan <bharat.bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
v2
 - new patch

 arch/powerpc/include/asm/machdep.h |    2 ++
 arch/powerpc/kernel/msi.c          |   10 ++++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 8d1b787..e87b806 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -132,6 +132,8 @@ struct machdep_calls {
 	/* Returns the requested region's address and size */
 	int		(*msi_get_region)(int region_num,
 					  struct msi_region *region);
+	int		(*msi_set_iova)(struct pci_dev *pdev, int region_num,
+					dma_addr_t iova, bool set);
 #endif
 
 	void		(*restart)(char *cmd);
diff --git a/arch/powerpc/kernel/msi.c b/arch/powerpc/kernel/msi.c
index 1a67787..e2bd555 100644
--- a/arch/powerpc/kernel/msi.c
+++ b/arch/powerpc/kernel/msi.c
@@ -13,6 +13,16 @@
 
 #include <asm/machdep.h>
 
+int arch_msi_set_iova(struct pci_dev *pdev, int region_num,
+		      dma_addr_t iova, bool set)
+{
+	if (ppc_md.msi_set_iova) {
+		pr_debug("msi: Using platform get_region_count routine.\n");
+		return ppc_md.msi_set_iova(pdev, region_num, iova, set);
+	}
+	return 0;
+}
+
 int arch_msi_get_region_count(void)
 {
 	if (ppc_md.msi_get_region_count) {
-- 
1.7.0.4
