From: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
Subject: [PATCH 19/26] iommu/fsl: Fix some comments alignment
Date: Wed, 28 Jan 2015 08:34:51 -0600
Message-ID: <1422455698-3074-20-git-send-email-Emilian.Medve@Freescale.com>
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

Signed-off-by: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
---
 drivers/iommu/fsl_pamu.c        | 24 ++++++++++++------------
 drivers/iommu/fsl_pamu_domain.c |  6 +++---
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index dc3955f..ba5d1e0 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -35,7 +35,7 @@
 #define make64(high, low) (((u64)(high) << 32) | (low))
 
 struct pamu_isr_data {
-	void __iomem *pamu_reg_base;	/* Base address of PAMU regs*/
+	void __iomem *pamu_reg_base;	/* Base address of PAMU regs */
 	unsigned int count;		/* The number of PAMUs */
 };
 
@@ -49,7 +49,7 @@ static struct ome *omt __initdata;
  * "fsl,qoriq-device-config-2.0" corresponds to T4 & B4
  * SOCs. For the older SOCs "fsl,qoriq-device-config-1.0"
  * string would be used.
-*/
+ */
 static const struct of_device_id guts_device_ids[] __initconst = {
 	{ .compatible = "fsl,qoriq-device-config-1.0", },
 	{ .compatible = "fsl,qoriq-device-config-2.0", },
@@ -63,7 +63,7 @@ static const struct of_device_id guts_device_ids[] __initconst = {
  * "fsl,b4860-l3-cache-controller" corresponds to B4 &
  * "fsl,p4080-l3-cache-controller" corresponds to other,
  * SOCs.
-*/
+ */
 static const struct of_device_id l3_device_ids[] = {
 	{ .compatible = "fsl,t4240-l3-cache-controller", },
 	{ .compatible = "fsl,b4860-l3-cache-controller", },
@@ -231,7 +231,7 @@ static struct paace *pamu_get_spaace(struct paace *paace, u32 wnum)
  * If no SPAACE entry is available or the allocator can not reserve the required
  * number of contiguous entries function returns ULONG_MAX indicating a failure.
  *
-*/
+ */
 static unsigned long pamu_get_fspi_and_allocate(u32 subwin_cnt)
 {
 	unsigned long spaace_addr;
@@ -494,11 +494,11 @@ int pamu_config_spaace(int liodn, u32 subwin_cnt, u32 subwin,
 }
 
 /**
-* get_ome_index() - Returns the index in the operation mapping table
-*                   for device.
-* @*omi_index: pointer for storing the index value
-*
-*/
+ * get_ome_index() - Returns the index in the operation mapping table
+ *                   for device.
+ * @*omi_index: pointer for storing the index value
+ *
+ */
 void get_ome_index(u32 *omi_index, struct device *dev)
 {
 	if (of_device_is_compatible(dev->of_node, "fsl,qman-portal"))
@@ -610,7 +610,7 @@ static void __init setup_qbman_paace(struct paace *ppaace, int  paace_type)
 	case QMAN_PORTAL_PAACE:
 		set_bf(ppaace->impl_attr, PAACE_IA_OTM, PAACE_OTM_INDEXED);
 		ppaace->op_encode.index_ot.omi = OMI_QMAN;
-		/*Set DQRR and Frame stashing for the L3 cache */
+		/* Set DQRR and Frame stashing for the L3 cache */
 		set_bf(ppaace->impl_attr, PAACE_IA_CID, get_stash_id(PAMU_ATTR_CACHE_L3, 0));
 		break;
 	case BMAN_PAACE:
@@ -937,7 +937,7 @@ static int __init create_csd(phys_addr_t phys, size_t size, u32 csd_port_id)
 	}
 
 	if (i == 0 || i == num_laws) {
-		/* This should never happen*/
+		/* This should never happen */
 		ret = -ENOENT;
 		goto error;
 	}
@@ -1163,7 +1163,7 @@ static int __init fsl_pamu_probe(struct platform_device *pdev)
 
 	iounmap(guts_regs);
 
-	/* Enable DMA for the LIODNs in the device tree*/
+	/* Enable DMA for the LIODNs in the device tree */
 
 	setup_liodns();
 
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 51a6750..eea2212 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -285,7 +285,7 @@ static int check_size(u64 size, dma_addr_t iova)
 		return -EINVAL;
 	}
 
-	/* iova must be page size aligned*/
+	/* iova must be page size aligned */
 	if (iova & (size - 1)) {
 		pr_debug("Address is not aligned with window size\n");
 		return -EINVAL;
@@ -779,7 +779,7 @@ static int configure_domain_stash(struct fsl_dma_domain *dma_domain, void *data)
 	return ret;
 }
 
-/* Configure domain dma state i.e. enable/disable DMA*/
+/* Configure domain dma state i.e. enable/disable DMA */
 static int configure_domain_dma_state(struct fsl_dma_domain *dma_domain, bool enable)
 {
 	struct device_domain_info *info;
@@ -876,7 +876,7 @@ static  bool check_pci_ctl_endpt_part(struct pci_controller *pci_ctl)
 	/* Check the PCI controller version number by readding BRR1 register */
 	version = in_be32(pci_ctl->cfg_addr + (PCI_FSL_BRR1 >> 2));
 	version &= PCI_FSL_BRR1_VER;
-	/* If PCI controller version is >= 0x204 we can partition endpoints*/
+	/* If PCI controller version is >= 0x204 we can partition endpoints */
 	if (version >= 0x204)
 		return 1;
 
-- 
2.2.2
