From: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
Subject: [PATCH 07/26] iommu/fsl: Fix checkpath type BRACES
Date: Wed, 28 Jan 2015 08:34:39 -0600
Message-ID: <1422455698-3074-8-git-send-email-Emilian.Medve@Freescale.com>
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

WARNING:BRACES: braces {} are not necessary for single statement blocks
+               if (!paace) {
+                       return -ENOENT;
+               }

WARNING:BRACES: braces {} are not necessary for single statement blocks
+               if (!paace) {
+                       return -ENOENT;
+               }

WARNING:BRACES: braces {} are not necessary for single statement blocks
+       if (!ppaace) {
+               return -ENOENT;
+       }

CHECK:BRACES: Blank lines aren't necessary after an open brace '{'
+{
+

CHECK:BRACES: Blank lines aren't necessary before a close brace '}'
+
+}

CHECK:BRACES: Blank lines aren't necessary before a close brace '}'
+
+}

CHECK:BRACES: Blank lines aren't necessary before a close brace '}'
+
+}

CHECK:BRACES: Blank lines aren't necessary after an open brace '{'
+       for (i = 0; i < num; i++) {
+

CHECK:BRACES: braces {} should be used on all arms of this statement
+               if (pci_ctl->parent->iommu_group) {
[...]
+               } else
[...]

Signed-off-by: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
---
 drivers/iommu/fsl_pamu.c        | 9 +++------
 drivers/iommu/fsl_pamu_domain.c | 8 ++------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index ccdc5e5..6b28dd8 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -278,9 +278,8 @@ int  pamu_update_paace_stash(int liodn, u32 subwin, u32 value)
 	}
 	if (subwin) {
 		paace = pamu_get_spaace(paace, subwin - 1);
-		if (!paace) {
+		if (!paace)
 			return -ENOENT;
-		}
 	}
 	set_bf(paace->impl_attr, PAACE_IA_CID, value);
 
@@ -301,9 +300,8 @@ int pamu_disable_spaace(int liodn, u32 subwin)
 	}
 	if (subwin) {
 		paace = pamu_get_spaace(paace, subwin - 1);
-		if (!paace) {
+		if (!paace)
 			return -ENOENT;
-		}
 		set_bf(paace->addr_bitfields, PAACE_AF_V,
 			 PAACE_V_INVALID);
 	} else {
@@ -351,9 +349,8 @@ int pamu_config_ppaace(int liodn, phys_addr_t win_addr, phys_addr_t win_size,
 	}
 
 	ppaace = pamu_get_ppaace(liodn);
-	if (!ppaace) {
+	if (!ppaace)
 		return -ENOENT;
-	}
 
 	/* window size is 2^(WSE+1) bytes */
 	set_bf(ppaace->addr_bitfields, PPAACE_AF_WSE,
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index dc38db5..080ffa4 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -35,7 +35,6 @@ static DEFINE_SPINLOCK(device_domain_lock);
 
 static int __init iommu_init_mempool(void)
 {
-
 	fsl_pamu_domain_cache = kmem_cache_create("fsl_pamu_domain",
 					 sizeof(struct fsl_dma_domain),
 					 0,
@@ -153,7 +152,6 @@ static int map_liodn(int liodn, struct fsl_dma_domain *dma_domain)
 		return map_subwins(liodn, dma_domain);
 	else
 		return map_win(liodn, dma_domain);
-
 }
 
 /* Update window/subwindow mapping for the LIODN */
@@ -380,7 +378,6 @@ static void attach_device(struct fsl_dma_domain *dma_domain, int liodn, struct d
 	if (!dev->archdata.iommu_domain)
 		dev->archdata.iommu_domain = info;
 	spin_unlock_irqrestore(&device_domain_lock, flags);
-
 }
 
 static phys_addr_t fsl_pamu_iova_to_phys(struct iommu_domain *domain,
@@ -527,7 +524,6 @@ static void fsl_pamu_window_disable(struct iommu_domain *domain, u32 wnd_nr)
 	}
 
 	spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
-
 }
 
 static int fsl_pamu_window_enable(struct iommu_domain *domain, u32 wnd_nr,
@@ -616,7 +612,6 @@ static int handle_attach_device(struct fsl_dma_domain *dma_domain,
 
 	spin_lock_irqsave(&dma_domain->domain_lock, flags);
 	for (i = 0; i < num; i++) {
-
 		/* Ensure that LIODN value is valid */
 		if (liodn[i] >= PAACE_NUMBER_ENTRIES) {
 			pr_debug("Invalid liodn %d, attach device failed for %s\n",
@@ -951,8 +946,9 @@ static struct iommu_group *get_pci_device_group(struct pci_dev *pdev)
 		if (pci_ctl->parent->iommu_group) {
 			group = get_device_iommu_group(pci_ctl->parent);
 			iommu_group_remove_device(pci_ctl->parent);
-		} else
+		} else {
 			group = get_shared_pci_device_group(pdev);
+		}
 	}
 
 	if (!group)
-- 
2.2.2
