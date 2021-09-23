Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC01EC433F5
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 17:43:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88F826124B
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 17:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 88F826124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 43BE0404BE;
	Thu, 23 Sep 2021 17:43:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PejeGxqR01gV; Thu, 23 Sep 2021 17:43:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2163E4000B;
	Thu, 23 Sep 2021 17:43:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15528C002A;
	Thu, 23 Sep 2021 17:43:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63BD5C000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 17:26:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C74F401B2
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 17:26:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nJw0wVbyvkzS for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 17:26:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B13940117
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 17:26:53 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="223933653"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; d="scan'208";a="223933653"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 10:26:52 -0700
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; d="scan'208";a="704832515"
Received: from unknown (HELO bad-guy.kumite) ([10.252.132.140])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 10:26:51 -0700
From: Ben Widawsky <ben.widawsky@intel.com>
To: linux-cxl@vger.kernel.org
Subject: [PATCH v2 0/9] cxl_pci refactor for reusability
Date: Thu, 23 Sep 2021 10:26:38 -0700
Message-Id: <20210923172647.72738-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 23 Sep 2021 17:43:10 +0000
Cc: Ben Widawsky <ben.widawsky@intel.com>, Andrew Donnellan <ajd@linux.ibm.com>,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 "David E. Box" <david.e.box@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Kan Liang <kan.liang@linux.intel.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Changes since v1 [3]:
- get_max_afu_index() updated to new interface (Dan)
- siov_find_pci_dvsec updated to new interface (Dan)
- remove unnecessary pci request/release regions with refactor (Dan)
- move @base into cxl_register_map (Dan)
- Expanded the Cc list to include other users of PCIe DVSEC. (Dan)

Three spots are not converted to use the new PCI core DVSEC helper as the
changes are non-trivial.
- find_dvsec_afu_ctrl (ocxl)
- pmt_pci_probe (David)
- intel_uncore_has_discovery_tables (Kan)

The interdiff is below. A range-diff can be generated against v1[3] if desired.
Discussion occurred partially offlist between Dan and myself. To summarize, Dan
contends that patch 4, "cxl/pci: Refactor cxl_pci_setup_regs" should either be
rewrittn, or have a precursor patch that cxl_pci will still scan all register
blocks, but only claim the specified types. While the current diff is somewhat
complex, I contend that this is unneeded churn because we can easily test this
change in our existing regression testing. It also ultimately results in a
simpler function in the cxl_port patch series when cxl_pci stops trying to map
the component register block (loop is removed entirely). A tiebreak here would
be great :-)

---

Original commit message:

Provide the ability to obtain CXL register blocks as discrete functionality.
This functionality will become useful for other CXL drivers that need access to
CXL register blocks. It is also in line with other additions to core which moves
register mapping functionality.

At the introduction of the CXL driver the only user of CXL MMIO was cxl_pci
(then known as cxl_mem). As the driver has evolved it is clear that cxl_pci will
not be the only entity that needs access to CXL MMIO. This series stops short of
moving the generalized functionality into cxl_core for the sake of getting eyes
on the important foundational bits sooner rather than later. The ultimate plan
is to move much of the code into cxl_core.

Via review of two previous patches [1] & [2] it has been suggested that the bits
which are being used for DVSEC enumeration move into PCI core. As CXL core is
soon going to require these, let's try to get the ball rolling now on making
that happen.

---

[1]: https://lore.kernel.org/linux-pci/20210913190131.xiiszmno46qie7v5@intel.com/
[2]: https://lore.kernel.org/linux-cxl/20210920225638.1729482-1-ben.widawsky@intel.com/
[3]: https://lore.kernel.org/linux-cxl/20210921220459.2437386-1-ben.widawsky@intel.com/


Ben Widawsky (9):
  cxl: Convert "RBI" to enum
  cxl/pci: Remove dev_dbg for unknown register blocks
  cxl/pci: Remove pci request/release regions
  cxl/pci: Refactor cxl_pci_setup_regs
  cxl/pci: Make more use of cxl_register_map
  PCI: Add pci_find_dvsec_capability to find designated VSEC
  cxl/pci: Use pci core's DVSEC functionality
  ocxl: Use pci core's DVSEC functionality
  iommu/vt-d: Use pci core's DVSEC functionality

 arch/powerpc/platforms/powernv/ocxl.c |   3 +-
 drivers/cxl/cxl.h                     |   1 +
 drivers/cxl/pci.c                     | 176 ++++++++++++--------------
 drivers/cxl/pci.h                     |  14 +-
 drivers/iommu/intel/iommu.c           |  15 +--
 drivers/misc/ocxl/config.c            |  13 +-
 drivers/pci/pci.c                     |  32 +++++
 include/linux/pci.h                   |   1 +
 8 files changed, 127 insertions(+), 128 deletions(-)

Interdiff against v1:
diff --git a/arch/powerpc/platforms/powernv/ocxl.c b/arch/powerpc/platforms/powernv/ocxl.c
index 9105efcf242a..28b009b46464 100644
--- a/arch/powerpc/platforms/powernv/ocxl.c
+++ b/arch/powerpc/platforms/powernv/ocxl.c
@@ -107,7 +107,8 @@ static int get_max_afu_index(struct pci_dev *dev, int *afu_idx)
 	int pos;
 	u32 val;
 
-	pos = find_dvsec_from_pos(dev, OCXL_DVSEC_FUNC_ID, 0);
+	pos = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_IBM,
+					OCXL_DVSEC_FUNC_ID);
 	if (!pos)
 		return -ESRCH;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 7d6b011dd963..3b128ce71564 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -140,6 +140,7 @@ struct cxl_device_reg_map {
 };
 
 struct cxl_register_map {
+	void __iomem *base;
 	u64 block_offset;
 	u8 reg_type;
 	u8 barno;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 040379f727ad..79d4d9b16d83 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -306,9 +306,8 @@ static int cxl_pci_setup_mailbox(struct cxl_mem *cxlm)
 	return 0;
 }
 
-static void __iomem *cxl_pci_map_regblock(struct cxl_mem *cxlm, struct cxl_register_map *map)
+static int cxl_pci_map_regblock(struct cxl_mem *cxlm, struct cxl_register_map *map)
 {
-	void __iomem *addr;
 	int bar = map->barno;
 	struct device *dev = cxlm->dev;
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -318,24 +317,25 @@ static void __iomem *cxl_pci_map_regblock(struct cxl_mem *cxlm, struct cxl_regis
 	if (pci_resource_len(pdev, bar) < offset) {
 		dev_err(dev, "BAR%d: %pr: too small (offset: %#llx)\n", bar,
 			&pdev->resource[bar], (unsigned long long)offset);
-		return IOMEM_ERR_PTR(-ENXIO);
+		return -ENXIO;
 	}
 
-	addr = pci_iomap(pdev, bar, 0);
-	if (!addr) {
+	map->base = pci_iomap(pdev, bar, 0);
+	if (!map->base) {
 		dev_err(dev, "failed to map registers\n");
-		return addr;
+		return PTR_ERR(map->base);
 	}
 
 	dev_dbg(dev, "Mapped CXL Memory Device resource bar %u @ %#llx\n",
 		bar, offset);
 
-	return addr;
+	return 0;
 }
 
-static void cxl_pci_unmap_regblock(struct cxl_mem *cxlm, void __iomem *base)
+static void cxl_pci_unmap_regblock(struct cxl_mem *cxlm, struct cxl_register_map *map)
 {
-	pci_iounmap(to_pci_dev(cxlm->dev), base);
+	pci_iounmap(to_pci_dev(cxlm->dev), map->base);
+	map->base = 0;
 }
 
 static int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)
@@ -343,10 +343,9 @@ static int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)
 	return pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL, dvsec);
 }
 
-static int cxl_probe_regs(struct cxl_mem *cxlm, void __iomem *base,
-			  struct cxl_register_map *map)
+static int cxl_probe_regs(struct cxl_mem *cxlm, struct cxl_register_map *map)
 {
-	void __iomem *offset = base + map->block_offset;
+	void __iomem *base = map->base + map->block_offset;
 	struct cxl_component_reg_map *comp_map;
 	struct cxl_device_reg_map *dev_map;
 	struct device *dev = cxlm->dev;
@@ -354,7 +353,7 @@ static int cxl_probe_regs(struct cxl_mem *cxlm, void __iomem *base,
 	switch (map->reg_type) {
 	case CXL_REGLOC_RBI_COMPONENT:
 		comp_map = &map->component_map;
-		cxl_probe_component_regs(dev, offset, comp_map);
+		cxl_probe_component_regs(dev, base, comp_map);
 		if (!comp_map->hdm_decoder.valid) {
 			dev_err(dev, "HDM decoder registers not found\n");
 			return -ENXIO;
@@ -364,7 +363,7 @@ static int cxl_probe_regs(struct cxl_mem *cxlm, void __iomem *base,
 		break;
 	case CXL_REGLOC_RBI_MEMDEV:
 		dev_map = &map->device_map;
-		cxl_probe_device_regs(dev, offset, dev_map);
+		cxl_probe_device_regs(dev, base, dev_map);
 		if (!dev_map->status.valid || !dev_map->mbox.valid ||
 		    !dev_map->memdev.valid) {
 			dev_err(dev, "registers not found: %s%s%s\n",
@@ -418,8 +417,6 @@ static int find_register_block(struct pci_dev *pdev, enum cxl_regloc_type type,
 	int regloc, i, rc = -ENODEV;
 	u32 regloc_size, regblocks;
 
-	memset(map, 0, sizeof(*map));
-
 	regloc = cxl_pci_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
 	if (!regloc)
 		return -ENXIO;
@@ -450,8 +447,6 @@ static int find_register_block(struct pci_dev *pdev, enum cxl_regloc_type type,
 		}
 	}
 
-	pci_release_mem_regions(pdev);
-
 	return rc;
 }
 
@@ -473,12 +468,8 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
 	const enum cxl_regloc_type types[] = { CXL_REGLOC_RBI_MEMDEV,
 					       CXL_REGLOC_RBI_COMPONENT };
 
-	if (pci_request_mem_regions(pdev, pci_name(pdev)))
-		return -ENODEV;
-
 	for (i = 0; i < ARRAY_SIZE(types); i++) {
 		struct cxl_register_map map;
-		void __iomem *base;
 
 		rc = find_register_block(pdev, types[i], &map);
 		if (rc) {
@@ -489,14 +480,12 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
 			break;
 		}
 
-		base = cxl_pci_map_regblock(cxlm, &map);
-		if (!base) {
-			rc = -ENOMEM;
+		rc = cxl_pci_map_regblock(cxlm, &map);
+		if (rc)
 			break;
-		}
 
-		rc = cxl_probe_regs(cxlm, base, &map);
-		cxl_pci_unmap_regblock(cxlm, base);
+		rc = cxl_probe_regs(cxlm, &map);
+		cxl_pci_unmap_regblock(cxlm, &map);
 		if (rc)
 			break;
 
@@ -507,7 +496,6 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
 		}
 	}
 
-	pci_release_mem_regions(pdev);
 	return rc;
 }
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d75f59ae28e6..30c97181f0ae 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5398,20 +5398,7 @@ static int intel_iommu_disable_sva(struct device *dev)
  */
 static int siov_find_pci_dvsec(struct pci_dev *pdev)
 {
-	int pos;
-	u16 vendor, id;
-
-	pos = pci_find_next_ext_capability(pdev, 0, 0x23);
-	while (pos) {
-		pci_read_config_word(pdev, pos + 4, &vendor);
-		pci_read_config_word(pdev, pos + 8, &id);
-		if (vendor == PCI_VENDOR_ID_INTEL && id == 5)
-			return pos;
-
-		pos = pci_find_next_ext_capability(pdev, pos, 0x23);
-	}
-
-	return 0;
+	return pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_INTEL, 5);
 }
 
 static bool

base-commit: 18f2a85f5e7db7468530be5048fee5b9cc7a8013
-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
