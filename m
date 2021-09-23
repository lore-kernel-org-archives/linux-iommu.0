Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B474C4332F
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 17:43:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1875B6109E
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 17:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1875B6109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ECC55606AE;
	Thu, 23 Sep 2021 17:43:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YgFb3Dvu-c3c; Thu, 23 Sep 2021 17:43:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 95E1D60B97;
	Thu, 23 Sep 2021 17:43:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86690C0030;
	Thu, 23 Sep 2021 17:43:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C64B8C000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 17:27:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5279B4000B
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 17:26:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BpQbFNnieF-Q for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 17:26:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 97CBA40117
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 17:26:55 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="223933662"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; d="scan'208";a="223933662"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 10:26:55 -0700
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; d="scan'208";a="704832548"
Received: from unknown (HELO bad-guy.kumite) ([10.252.132.140])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 10:26:54 -0700
From: Ben Widawsky <ben.widawsky@intel.com>
To: linux-cxl@vger.kernel.org
Subject: [PATCH v2 5/9] cxl/pci: Make more use of cxl_register_map
Date: Thu, 23 Sep 2021 10:26:43 -0700
Message-Id: <20210923172647.72738-6-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923172647.72738-1-ben.widawsky@intel.com>
References: <20210923172647.72738-1-ben.widawsky@intel.com>
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

The structure exists to pass around information about register mapping.
Using it more extensively cleans up many existing functions.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/cxl.h |  1 +
 drivers/cxl/pci.c | 36 +++++++++++++++++-------------------
 2 files changed, 18 insertions(+), 19 deletions(-)

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
index bbbacbc94fbf..5eaf2736f779 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -306,35 +306,36 @@ static int cxl_pci_setup_mailbox(struct cxl_mem *cxlm)
 	return 0;
 }
 
-static void __iomem *cxl_pci_map_regblock(struct cxl_mem *cxlm,
-					  u8 bar, u64 offset)
+static int cxl_pci_map_regblock(struct cxl_mem *cxlm, struct cxl_register_map *map)
 {
-	void __iomem *addr;
+	int bar = map->barno;
 	struct device *dev = cxlm->dev;
 	struct pci_dev *pdev = to_pci_dev(dev);
+	resource_size_t offset = map->block_offset;
 
 	/* Basic sanity check that BAR is big enough */
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
@@ -360,9 +361,9 @@ static int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)
 	return 0;
 }
 
-static int cxl_probe_regs(struct cxl_mem *cxlm, void __iomem *base,
-			  struct cxl_register_map *map)
+static int cxl_probe_regs(struct cxl_mem *cxlm, struct cxl_register_map *map)
 {
+	void __iomem *base = map->base + map->block_offset;
 	struct cxl_component_reg_map *comp_map;
 	struct cxl_device_reg_map *dev_map;
 	struct device *dev = cxlm->dev;
@@ -487,7 +488,6 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
 
 	for (i = 0; i < ARRAY_SIZE(types); i++) {
 		struct cxl_register_map map;
-		void __iomem *base;
 
 		rc = find_register_block(pdev, types[i], &map);
 		if (rc) {
@@ -498,14 +498,12 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
 			break;
 		}
 
-		base = cxl_pci_map_regblock(cxlm, map.barno, map.block_offset);
-		if (!base) {
-			rc = -ENOMEM;
+		rc = cxl_pci_map_regblock(cxlm, &map);
+		if (rc)
 			break;
-		}
 
-		rc = cxl_probe_regs(cxlm, base + map.block_offset, &map);
-		cxl_pci_unmap_regblock(cxlm, base);
+		rc = cxl_probe_regs(cxlm, &map);
+		cxl_pci_unmap_regblock(cxlm, &map);
 		if (rc)
 			break;
 
-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
