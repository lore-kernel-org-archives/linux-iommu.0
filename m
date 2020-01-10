Return-Path: <SRS0=ishi=27=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC32C33CA3
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 23:24:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B2F8206ED
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 23:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2F8206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4CA8986C69;
	Fri, 10 Jan 2020 23:24:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6WoxUK-Xny6v; Fri, 10 Jan 2020 23:24:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8F8E786C5D;
	Fri, 10 Jan 2020 23:24:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B763C1D7D;
	Fri, 10 Jan 2020 23:24:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7618C0881
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 23:24:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9D93186C63
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 23:24:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id woOEIcYOJqiN for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jan 2020 23:24:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BDA3A86C4B
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 23:24:05 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jan 2020 15:24:05 -0800
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; d="scan'208";a="212412169"
Received: from unknown (HELO nsgsw-rhel7p6.lm.intel.com) ([10.232.116.226])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jan 2020 15:24:05 -0800
From: Jon Derrick <jonathan.derrick@intel.com>
To: <iommu@lists.linux-foundation.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v3 4/5] PCI: vmd: Stop overriding dma_map_ops
Date: Fri, 10 Jan 2020 10:21:12 -0700
Message-Id: <1578676873-6206-5-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578676873-6206-1-git-send-email-jonathan.derrick@intel.com>
References: <1578676873-6206-1-git-send-email-jonathan.derrick@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>,
 Jon Derrick <jonathan.derrick@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Devices on the VMD domain use the VMD endpoint's requester ID and have
been relying on the VMD endpoint's DMA operations. The problem with this
was that VMD domain devices would use the VMD endpoint's attributes when
doing DMA and IOMMU mapping. We can be smarter about this by only using
the VMD endpoint when mapping and providing the correct child device's
attributes during DMA operations.

This patch modifies Intel-IOMMU to check for a 'Direct DMA Alias' and
refer to it for mapping.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/iommu/intel-iommu.c    |  18 +++--
 drivers/pci/controller/Kconfig |   1 -
 drivers/pci/controller/vmd.c   | 150 -----------------------------------------
 3 files changed, 13 insertions(+), 156 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 716347e2..7ca807a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -804,14 +804,14 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
 
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pf_pdev;
+		struct pci_dev *dma_alias;
 
 		pdev = to_pci_dev(dev);
 
-#ifdef CONFIG_X86
-		/* VMD child devices currently cannot be handled individually */
-		if (is_vmd(pdev->bus))
-			return NULL;
-#endif
+		/* DMA aliased devices use the DMA alias's IOMMU */
+		dma_alias = pci_direct_dma_alias(pdev);
+		if (dma_alias)
+			pdev = dma_alias;
 
 		/* VFs aren't listed in scope tables; we need to look up
 		 * the PF instead to find the IOMMU. */
@@ -2521,6 +2521,14 @@ struct dmar_domain *find_domain(struct device *dev)
 		     dev->archdata.iommu == DUMMY_DEVICE_DOMAIN_INFO))
 		return NULL;
 
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+		struct pci_dev *dma_alias = pci_direct_dma_alias(pdev);
+
+		if (dma_alias)
+			dev = &dma_alias->dev;
+	}
+
 	/* No lock here, assumes no domain exit in normal case */
 	info = dev->archdata.iommu;
 	if (likely(info))
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index c77069c..55671429 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -239,7 +239,6 @@ config PCIE_TANGO_SMP8759
 
 config VMD
 	depends on PCI_MSI && X86_64 && SRCU
-	select X86_DEV_DMA_OPS
 	tristate "Intel Volume Management Device Driver"
 	---help---
 	  Adds support for the Intel Volume Management Device (VMD). VMD is a
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index d67ad56..fe1acb0 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -98,9 +98,6 @@ struct vmd_dev {
 	struct irq_domain	*irq_domain;
 	struct pci_bus		*bus;
 	u8			busn_start;
-
-	struct dma_map_ops	dma_ops;
-	struct dma_domain	dma_domain;
 };
 
 static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
@@ -295,151 +292,6 @@ static void vmd_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
 	.chip		= &vmd_msi_controller,
 };
 
-/*
- * VMD replaces the requester ID with its own.  DMA mappings for devices in a
- * VMD domain need to be mapped for the VMD, not the device requiring
- * the mapping.
- */
-static struct device *to_vmd_dev(struct device *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct vmd_dev *vmd = vmd_from_bus(pdev->bus);
-
-	return &vmd->dev->dev;
-}
-
-static void *vmd_alloc(struct device *dev, size_t size, dma_addr_t *addr,
-		       gfp_t flag, unsigned long attrs)
-{
-	return dma_alloc_attrs(to_vmd_dev(dev), size, addr, flag, attrs);
-}
-
-static void vmd_free(struct device *dev, size_t size, void *vaddr,
-		     dma_addr_t addr, unsigned long attrs)
-{
-	return dma_free_attrs(to_vmd_dev(dev), size, vaddr, addr, attrs);
-}
-
-static int vmd_mmap(struct device *dev, struct vm_area_struct *vma,
-		    void *cpu_addr, dma_addr_t addr, size_t size,
-		    unsigned long attrs)
-{
-	return dma_mmap_attrs(to_vmd_dev(dev), vma, cpu_addr, addr, size,
-			attrs);
-}
-
-static int vmd_get_sgtable(struct device *dev, struct sg_table *sgt,
-			   void *cpu_addr, dma_addr_t addr, size_t size,
-			   unsigned long attrs)
-{
-	return dma_get_sgtable_attrs(to_vmd_dev(dev), sgt, cpu_addr, addr, size,
-			attrs);
-}
-
-static dma_addr_t vmd_map_page(struct device *dev, struct page *page,
-			       unsigned long offset, size_t size,
-			       enum dma_data_direction dir,
-			       unsigned long attrs)
-{
-	return dma_map_page_attrs(to_vmd_dev(dev), page, offset, size, dir,
-			attrs);
-}
-
-static void vmd_unmap_page(struct device *dev, dma_addr_t addr, size_t size,
-			   enum dma_data_direction dir, unsigned long attrs)
-{
-	dma_unmap_page_attrs(to_vmd_dev(dev), addr, size, dir, attrs);
-}
-
-static int vmd_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		      enum dma_data_direction dir, unsigned long attrs)
-{
-	return dma_map_sg_attrs(to_vmd_dev(dev), sg, nents, dir, attrs);
-}
-
-static void vmd_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-			 enum dma_data_direction dir, unsigned long attrs)
-{
-	dma_unmap_sg_attrs(to_vmd_dev(dev), sg, nents, dir, attrs);
-}
-
-static void vmd_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
-				    size_t size, enum dma_data_direction dir)
-{
-	dma_sync_single_for_cpu(to_vmd_dev(dev), addr, size, dir);
-}
-
-static void vmd_sync_single_for_device(struct device *dev, dma_addr_t addr,
-				       size_t size, enum dma_data_direction dir)
-{
-	dma_sync_single_for_device(to_vmd_dev(dev), addr, size, dir);
-}
-
-static void vmd_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
-				int nents, enum dma_data_direction dir)
-{
-	dma_sync_sg_for_cpu(to_vmd_dev(dev), sg, nents, dir);
-}
-
-static void vmd_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
-				   int nents, enum dma_data_direction dir)
-{
-	dma_sync_sg_for_device(to_vmd_dev(dev), sg, nents, dir);
-}
-
-static int vmd_dma_supported(struct device *dev, u64 mask)
-{
-	return dma_supported(to_vmd_dev(dev), mask);
-}
-
-static u64 vmd_get_required_mask(struct device *dev)
-{
-	return dma_get_required_mask(to_vmd_dev(dev));
-}
-
-static void vmd_teardown_dma_ops(struct vmd_dev *vmd)
-{
-	struct dma_domain *domain = &vmd->dma_domain;
-
-	if (get_dma_ops(&vmd->dev->dev))
-		del_dma_domain(domain);
-}
-
-#define ASSIGN_VMD_DMA_OPS(source, dest, fn)	\
-	do {					\
-		if (source->fn)			\
-			dest->fn = vmd_##fn;	\
-	} while (0)
-
-static void vmd_setup_dma_ops(struct vmd_dev *vmd)
-{
-	const struct dma_map_ops *source = get_dma_ops(&vmd->dev->dev);
-	struct dma_map_ops *dest = &vmd->dma_ops;
-	struct dma_domain *domain = &vmd->dma_domain;
-
-	domain->domain_nr = vmd->sysdata.domain;
-	domain->dma_ops = dest;
-
-	if (!source)
-		return;
-	ASSIGN_VMD_DMA_OPS(source, dest, alloc);
-	ASSIGN_VMD_DMA_OPS(source, dest, free);
-	ASSIGN_VMD_DMA_OPS(source, dest, mmap);
-	ASSIGN_VMD_DMA_OPS(source, dest, get_sgtable);
-	ASSIGN_VMD_DMA_OPS(source, dest, map_page);
-	ASSIGN_VMD_DMA_OPS(source, dest, unmap_page);
-	ASSIGN_VMD_DMA_OPS(source, dest, map_sg);
-	ASSIGN_VMD_DMA_OPS(source, dest, unmap_sg);
-	ASSIGN_VMD_DMA_OPS(source, dest, sync_single_for_cpu);
-	ASSIGN_VMD_DMA_OPS(source, dest, sync_single_for_device);
-	ASSIGN_VMD_DMA_OPS(source, dest, sync_sg_for_cpu);
-	ASSIGN_VMD_DMA_OPS(source, dest, sync_sg_for_device);
-	ASSIGN_VMD_DMA_OPS(source, dest, dma_supported);
-	ASSIGN_VMD_DMA_OPS(source, dest, get_required_mask);
-	add_dma_domain(domain);
-}
-#undef ASSIGN_VMD_DMA_OPS
-
 static char __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
 				  unsigned int devfn, int reg, int len)
 {
@@ -709,7 +561,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	}
 
 	vmd_attach_resources(vmd);
-	vmd_setup_dma_ops(vmd);
 	dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
 
 	pci_scan_child_bus(vmd->bus);
@@ -824,7 +675,6 @@ static void vmd_remove(struct pci_dev *dev)
 	pci_stop_root_bus(vmd->bus);
 	pci_remove_root_bus(vmd->bus);
 	vmd_cleanup_srcu(vmd);
-	vmd_teardown_dma_ops(vmd);
 	vmd_detach_resources(vmd);
 	irq_domain_remove(vmd->irq_domain);
 }
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
