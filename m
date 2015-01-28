From: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
Subject: [PATCH 18/26] iommu/fsl: Fix checkpatch type PARENTHESIS_ALIGNMENT
Date: Wed, 28 Jan 2015 08:34:50 -0600
Message-ID: <1422455698-3074-19-git-send-email-Emilian.Medve@Freescale.com>
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

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+               set_bf(paace->addr_bitfields, PAACE_AF_V,
+                        PAACE_V_INVALID);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+               set_bf(paace->addr_bitfields, PAACE_AF_AP,
+                        PAACE_AP_PERMS_DENIED);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+       set_bf(ppaace->addr_bitfields, PPAACE_AF_WSE,
+               map_addrspace_size_to_wse(win_size));

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+                       pr_debug("can't find next-level-cache at %s\n",
+                               node->full_name);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+       out_be32((u32 *)(pamu_reg_base + PAMU_PICS),
+                       PAMU_ACCESS_VIOLATION_ENABLE);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+                       set_bf(ppaace->impl_attr, PAACE_IA_ATM,
+                               PAACE_ATM_NO_XLATE);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+                       set_bf(ppaace->addr_bitfields, PAACE_AF_AP,
+                               PAACE_AP_PERMS_ALL);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+                       pr_emerg("AVA=%016llx\n", make64(in_be32(p + PAMU_AVAH),
+                               in_be32(p + PAMU_AVAL)));

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+                       pr_emerg("POEA=%016llx\n", make64(in_be32(p + PAMU_POEAH),
+                               in_be32(p + PAMU_POEAL)));

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+                       phys = make64(in_be32(p + PAMU_POEAH),
+                               in_be32(p + PAMU_POEAL));

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+               setup_one_pamu(pamu_reg_base, pamu_reg_off, ppaact_phys,
+                                spaact_phys, omt_phys);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+       fsl_pamu_domain_cache = kmem_cache_create("fsl_pamu_domain",
+                                        sizeof(struct fsl_dma_domain),

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+       iommu_devinfo_cache = kmem_cache_create("iommu_devinfo",
+                                        sizeof(struct device_domain_info),

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+               pr_debug("PAACE configuration failed for liodn %d\n",
+                       liodn);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+static int update_liodn_stash(int liodn, struct fsl_dma_domain *dma_domain,
+                                u32 val)

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+static int pamu_set_liodn(int liodn, struct device *dev,
+                          struct fsl_dma_domain *dma_domain,

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+static phys_addr_t fsl_pamu_iova_to_phys(struct iommu_domain *domain,
+                                           dma_addr_t iova)

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+       if ((iova < domain->geometry.aperture_start) ||
+               iova > (domain->geometry.aperture_end))

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+               ret = pamu_set_liodn(info->liodn, info->dev, dma_domain,
+                                     geom_attr, win_cnt);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+static int handle_attach_device(struct fsl_dma_domain *dma_domain,
+                                struct device *dev, const u32 *liodn,

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+                       pr_debug("Invalid liodn %d, attach device failed for %s\n",
+                               liodn[i], dev->of_node->full_name);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+                       ret = pamu_set_liodn(liodn[i], dev, dma_domain,
+                                             &domain->geometry,

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+               ret = handle_attach_device(dma_domain, dev,
+                                        liodn, liodn_cnt);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+static void fsl_pamu_detach_device(struct iommu_domain *domain,
+                                     struct device *dev)

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+       if (check_size(geom_size, geom_attr->aperture_start) ||
+               !geom_attr->force_aperture) {

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+       memcpy(&dma_domain->dma_stash, stash_attr,
+                sizeof(struct pamu_stash_attribute));

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+       list_for_each_entry(info, &dma_domain->devices,
+                                link) {

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+static int fsl_pamu_set_domain_attr(struct iommu_domain *domain,
+                                enum iommu_attr attr_type, void *data)

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+static int fsl_pamu_get_domain_attr(struct iommu_domain *domain,
+                                enum iommu_attr attr_type, void *data)

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+       ret = pamu_set_domain_geometry(dma_domain, &domain->geometry,
+                               ((w_count > 1) ? w_count : 0));

Signed-off-by: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
---
 drivers/iommu/fsl_pamu.c        | 29 +++++++++---------
 drivers/iommu/fsl_pamu_domain.c | 67 +++++++++++++++++++----------------------
 2 files changed, 46 insertions(+), 50 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index e46c75f..dc3955f 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -302,11 +302,10 @@ int pamu_disable_spaace(int liodn, u32 subwin)
 		paace = pamu_get_spaace(paace, subwin - 1);
 		if (!paace)
 			return -ENOENT;
-		set_bf(paace->addr_bitfields, PAACE_AF_V,
-			 PAACE_V_INVALID);
+		set_bf(paace->addr_bitfields, PAACE_AF_V, PAACE_V_INVALID);
 	} else {
 		set_bf(paace->addr_bitfields, PAACE_AF_AP,
-			 PAACE_AP_PERMS_DENIED);
+		       PAACE_AP_PERMS_DENIED);
 	}
 
 	mb();
@@ -354,7 +353,7 @@ int pamu_config_ppaace(int liodn, phys_addr_t win_addr, phys_addr_t win_size,
 
 	/* window size is 2^(WSE+1) bytes */
 	set_bf(ppaace->addr_bitfields, PPAACE_AF_WSE,
-		map_addrspace_size_to_wse(win_size));
+	       map_addrspace_size_to_wse(win_size));
 
 	pamu_init_ppaace(ppaace);
 
@@ -568,7 +567,7 @@ found_cpu_node:
 		prop = of_get_property(node, "next-level-cache", 0);
 		if (!prop) {
 			pr_debug("can't find next-level-cache at %s\n",
-				node->full_name);
+				 node->full_name);
 			of_node_put(node);
 			return ~(u32)0;  /* can't traverse any further */
 		}
@@ -712,7 +711,7 @@ static int __init setup_one_pamu(unsigned long pamu_reg_base, unsigned long pamu
 	 */
 
 	out_be32((u32 *)(pamu_reg_base + PAMU_PICS),
-			PAMU_ACCESS_VIOLATION_ENABLE);
+		 PAMU_ACCESS_VIOLATION_ENABLE);
 	out_be32(pc, PAMU_PC_PE | PAMU_PC_OCE | PAMU_PC_SPCC | PAMU_PC_PPCC);
 	return 0;
 }
@@ -742,9 +741,9 @@ static void __init setup_liodns(void)
 			ppaace->wbah = 0;
 			set_bf(ppaace->addr_bitfields, PPAACE_AF_WBAL, 0);
 			set_bf(ppaace->impl_attr, PAACE_IA_ATM,
-				PAACE_ATM_NO_XLATE);
+			       PAACE_ATM_NO_XLATE);
 			set_bf(ppaace->addr_bitfields, PAACE_AF_AP,
-				PAACE_AP_PERMS_ALL);
+			       PAACE_AP_PERMS_ALL);
 			if (of_device_is_compatible(node, "fsl,qman-portal"))
 				setup_qbman_paace(ppaace, QMAN_PORTAL_PAACE);
 			if (of_device_is_compatible(node, "fsl,qman"))
@@ -777,14 +776,16 @@ irqreturn_t pamu_av_isr(int irq, void *arg)
 			pr_emerg("POES2=%08x\n", in_be32(p + PAMU_POES2));
 			pr_emerg("AVS1=%08x\n", avs1);
 			pr_emerg("AVS2=%08x\n", in_be32(p + PAMU_AVS2));
-			pr_emerg("AVA=%016llx\n", make64(in_be32(p + PAMU_AVAH),
-				in_be32(p + PAMU_AVAL)));
+			pr_emerg("AVA=%016llx\n",
+				 make64(in_be32(p + PAMU_AVAH),
+					in_be32(p + PAMU_AVAL)));
 			pr_emerg("UDAD=%08x\n", in_be32(p + PAMU_UDAD));
-			pr_emerg("POEA=%016llx\n", make64(in_be32(p + PAMU_POEAH),
-				in_be32(p + PAMU_POEAL)));
+			pr_emerg("POEA=%016llx\n",
+				 make64(in_be32(p + PAMU_POEAH),
+					in_be32(p + PAMU_POEAL)));
 
 			phys = make64(in_be32(p + PAMU_POEAH),
-				in_be32(p + PAMU_POEAL));
+				      in_be32(p + PAMU_POEAL));
 
 			/* Assume that POEA points to a PAACE */
 			if (phys) {
@@ -1150,7 +1151,7 @@ static int __init fsl_pamu_probe(struct platform_device *pdev)
 
 		pamu_reg_base = (unsigned long)pamu_regs + pamu_reg_off;
 		setup_one_pamu(pamu_reg_base, pamu_reg_off, ppaact_phys,
-				 spaact_phys, omt_phys);
+			       spaact_phys, omt_phys);
 		/* Disable PAMU bypass for this PAMU */
 		pamubypenr &= ~pamu_counter;
 	}
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 3e7954a..51a6750 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -36,21 +36,20 @@ static DEFINE_SPINLOCK(device_domain_lock);
 static int __init iommu_init_mempool(void)
 {
 	fsl_pamu_domain_cache = kmem_cache_create("fsl_pamu_domain",
-					 sizeof(struct fsl_dma_domain),
-					 0,
-					 SLAB_HWCACHE_ALIGN,
-
-					 NULL);
+						  sizeof(struct fsl_dma_domain),
+						  0,
+						  SLAB_HWCACHE_ALIGN,
+						  NULL);
 	if (!fsl_pamu_domain_cache) {
 		pr_debug("Couldn't create fsl iommu_domain cache\n");
 		return -ENOMEM;
 	}
 
 	iommu_devinfo_cache = kmem_cache_create("iommu_devinfo",
-					 sizeof(struct device_domain_info),
-					 0,
-					 SLAB_HWCACHE_ALIGN,
-					 NULL);
+						sizeof(struct device_domain_info),
+						0,
+						SLAB_HWCACHE_ALIGN,
+						NULL);
 	if (!iommu_devinfo_cache) {
 		pr_debug("Couldn't create devinfo cache\n");
 		kmem_cache_destroy(fsl_pamu_domain_cache);
@@ -139,8 +138,7 @@ static int map_win(int liodn, struct fsl_dma_domain *dma_domain)
 				 0, wnd->prot);
 	spin_unlock_irqrestore(&iommu_lock, flags);
 	if (ret)
-		pr_debug("PAACE configuration failed for liodn %d\n",
-			liodn);
+		pr_debug("PAACE configuration failed for liodn %d\n", liodn);
 
 	return ret;
 }
@@ -194,7 +192,7 @@ static int update_liodn(int liodn, struct fsl_dma_domain *dma_domain, u32 wnd_nr
 }
 
 static int update_liodn_stash(int liodn, struct fsl_dma_domain *dma_domain,
-				 u32 val)
+			      u32 val)
 {
 	int ret = 0, i;
 	unsigned long flags;
@@ -222,9 +220,9 @@ static int update_liodn_stash(int liodn, struct fsl_dma_domain *dma_domain,
 
 /* Set the geometry parameters for a LIODN */
 static int pamu_set_liodn(int liodn, struct device *dev,
-			   struct fsl_dma_domain *dma_domain,
-			   struct iommu_domain_geometry *geom_attr,
-			   u32 win_cnt)
+			  struct fsl_dma_domain *dma_domain,
+			  struct iommu_domain_geometry *geom_attr,
+			  u32 win_cnt)
 {
 	phys_addr_t window_addr, window_size;
 	phys_addr_t subwin_size;
@@ -381,12 +379,12 @@ static void attach_device(struct fsl_dma_domain *dma_domain, int liodn, struct d
 }
 
 static phys_addr_t fsl_pamu_iova_to_phys(struct iommu_domain *domain,
-					    dma_addr_t iova)
+					 dma_addr_t iova)
 {
 	struct fsl_dma_domain *dma_domain = domain->priv;
 
 	if ((iova < domain->geometry.aperture_start) ||
-		iova > (domain->geometry.aperture_end))
+	    iova > (domain->geometry.aperture_end))
 		return 0;
 
 	return get_phys_addr(dma_domain, iova);
@@ -441,7 +439,7 @@ static int pamu_set_domain_geometry(struct fsl_dma_domain *dma_domain,
 
 	list_for_each_entry(info, &dma_domain->devices, link) {
 		ret = pamu_set_liodn(info->liodn, info->dev, dma_domain,
-				      geom_attr, win_cnt);
+				     geom_attr, win_cnt);
 		if (ret)
 			break;
 	}
@@ -602,8 +600,8 @@ static int fsl_pamu_window_enable(struct iommu_domain *domain, u32 wnd_nr,
  * and window mappings.
  */
 static int handle_attach_device(struct fsl_dma_domain *dma_domain,
-				 struct device *dev, const u32 *liodn,
-				 int num)
+				struct device *dev, const u32 *liodn,
+				int num)
 {
 	unsigned long flags;
 	struct iommu_domain *domain = dma_domain->iommu_domain;
@@ -615,7 +613,7 @@ static int handle_attach_device(struct fsl_dma_domain *dma_domain,
 		/* Ensure that LIODN value is valid */
 		if (liodn[i] >= PAACE_NUMBER_ENTRIES) {
 			pr_debug("Invalid liodn %d, attach device failed for %s\n",
-				liodn[i], dev->of_node->full_name);
+				 liodn[i], dev->of_node->full_name);
 			ret = -EINVAL;
 			break;
 		}
@@ -630,8 +628,7 @@ static int handle_attach_device(struct fsl_dma_domain *dma_domain,
 			u32 win_cnt = dma_domain->win_cnt > 1 ? dma_domain->win_cnt : 0;
 
 			ret = pamu_set_liodn(liodn[i], dev, dma_domain,
-					      &domain->geometry,
-					      win_cnt);
+					     &domain->geometry, win_cnt);
 			if (ret)
 				break;
 			if (dma_domain->mapped) {
@@ -678,8 +675,7 @@ static int fsl_pamu_attach_device(struct iommu_domain *domain,
 	liodn = of_get_property(dev->of_node, "fsl,liodn", &len);
 	if (liodn) {
 		liodn_cnt = len / sizeof(u32);
-		ret = handle_attach_device(dma_domain, dev,
-					 liodn, liodn_cnt);
+		ret = handle_attach_device(dma_domain, dev, liodn, liodn_cnt);
 	} else {
 		pr_debug("missing fsl,liodn property at %s\n",
 			 dev->of_node->full_name);
@@ -690,7 +686,7 @@ static int fsl_pamu_attach_device(struct iommu_domain *domain,
 }
 
 static void fsl_pamu_detach_device(struct iommu_domain *domain,
-				      struct device *dev)
+				   struct device *dev)
 {
 	struct fsl_dma_domain *dma_domain = domain->priv;
 	const u32 *prop;
@@ -734,10 +730,10 @@ static  int configure_domain_geometry(struct iommu_domain *domain, void *data)
 	 * DMA outside of the geometry.
 	 */
 	if (check_size(geom_size, geom_attr->aperture_start) ||
-		!geom_attr->force_aperture) {
-			pr_debug("Invalid PAMU geometry attributes\n");
-			return -EINVAL;
-		}
+	    !geom_attr->force_aperture) {
+		pr_debug("Invalid PAMU geometry attributes\n");
+		return -EINVAL;
+	}
 
 	spin_lock_irqsave(&dma_domain->domain_lock, flags);
 	if (dma_domain->enabled) {
@@ -766,7 +762,7 @@ static int configure_domain_stash(struct fsl_dma_domain *dma_domain, void *data)
 	spin_lock_irqsave(&dma_domain->domain_lock, flags);
 
 	memcpy(&dma_domain->dma_stash, stash_attr,
-		 sizeof(struct pamu_stash_attribute));
+	       sizeof(struct pamu_stash_attribute));
 
 	dma_domain->stash_id = get_stash_id(stash_attr->cache,
 					    stash_attr->cpu);
@@ -799,8 +795,7 @@ static int configure_domain_dma_state(struct fsl_dma_domain *dma_domain, bool en
 	}
 
 	dma_domain->enabled = enable;
-	list_for_each_entry(info, &dma_domain->devices,
-				 link) {
+	list_for_each_entry(info, &dma_domain->devices, link) {
 		ret = (enable) ? pamu_enable_liodn(info->liodn) :
 			pamu_disable_liodn(info->liodn);
 		if (ret)
@@ -813,7 +808,7 @@ static int configure_domain_dma_state(struct fsl_dma_domain *dma_domain, bool en
 }
 
 static int fsl_pamu_set_domain_attr(struct iommu_domain *domain,
-				 enum iommu_attr attr_type, void *data)
+				    enum iommu_attr attr_type, void *data)
 {
 	struct fsl_dma_domain *dma_domain = domain->priv;
 	int ret = 0;
@@ -838,7 +833,7 @@ static int fsl_pamu_set_domain_attr(struct iommu_domain *domain,
 }
 
 static int fsl_pamu_get_domain_attr(struct iommu_domain *domain,
-				 enum iommu_attr attr_type, void *data)
+				    enum iommu_attr attr_type, void *data)
 {
 	struct fsl_dma_domain *dma_domain = domain->priv;
 	int ret = 0;
@@ -1034,7 +1029,7 @@ static int fsl_pamu_set_windows(struct iommu_domain *domain, u32 w_count)
 	}
 
 	ret = pamu_set_domain_geometry(dma_domain, &domain->geometry,
-				((w_count > 1) ? w_count : 0));
+				       ((w_count > 1) ? w_count : 0));
 	if (!ret) {
 		kfree(dma_domain->win_arr);
 		dma_domain->win_arr = kcalloc(w_count,
-- 
2.2.2
