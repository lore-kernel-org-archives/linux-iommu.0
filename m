Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B439BC433F5
	for <iommu@archiver.kernel.org>; Mon,  9 May 2022 10:16:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 61505405D7;
	Mon,  9 May 2022 10:16:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IEbFroA_Qg82; Mon,  9 May 2022 10:16:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2DE8640499;
	Mon,  9 May 2022 10:16:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17A3CC0039;
	Mon,  9 May 2022 10:16:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A6A3C002D
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 10:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1AF6F81B10
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 10:16:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2rFuAB0neX0P for <iommu@lists.linux-foundation.org>;
 Mon,  9 May 2022 10:16:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2B21D81A58
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 10:16:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C0E61063;
 Mon,  9 May 2022 03:16:13 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3D4073F66F;
 Mon,  9 May 2022 03:16:12 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org,
	bhelgaas@google.com,
	robh@kernel.org
Subject: [PATCH v2] iommu/dma: Explicitly sort PCI DMA windows
Date: Mon,  9 May 2022 11:16:08 +0100
Message-Id: <35661036a7e4160850895f9b37f35408b6a29f2f.1652091160.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.35.3.dirty
MIME-Version: 1.0
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

Originally, creating the dma_ranges resource list in pre-sorted fashion
was the simplest and most efficient way to enforce the order required by
iova_reserve_pci_windows(). However since then at least one PCI host
driver is now re-sorting the list for its own probe-time processing,
which doesn't seem entirely unreasonable, so that basic assumption no
longer holds. Make iommu-dma robust and get the sort order it needs by
explicitly sorting, which means we can also save the effort at creation
time and just build the list in whatever natural order the DT had.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Clean up now-unused local variable

 drivers/iommu/dma-iommu.c | 13 ++++++++++++-
 drivers/pci/of.c          |  8 +-------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 09f6e1c0f9c0..d05538af4fe9 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -20,6 +20,7 @@
 #include <linux/iommu.h>
 #include <linux/iova.h>
 #include <linux/irq.h>
+#include <linux/list_sort.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
@@ -414,6 +415,15 @@ static int cookie_init_hw_msi_region(struct iommu_dma_cookie *cookie,
 	return 0;
 }
 
+static int iommu_dma_ranges_sort(void *priv, const struct list_head *a,
+		const struct list_head *b)
+{
+	struct resource_entry *res_a = list_entry(a, typeof(*res_a), node);
+	struct resource_entry *res_b = list_entry(b, typeof(*res_b), node);
+
+	return res_a->res->start > res_b->res->start;
+}
+
 static int iova_reserve_pci_windows(struct pci_dev *dev,
 		struct iova_domain *iovad)
 {
@@ -432,6 +442,7 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
 	}
 
 	/* Get reserved DMA windows from host bridge */
+	list_sort(NULL, &bridge->dma_ranges, iommu_dma_ranges_sort);
 	resource_list_for_each_entry(window, &bridge->dma_ranges) {
 		end = window->res->start - window->offset;
 resv_iova:
@@ -440,7 +451,7 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
 			hi = iova_pfn(iovad, end);
 			reserve_iova(iovad, lo, hi);
 		} else if (end < start) {
-			/* dma_ranges list should be sorted */
+			/* DMA ranges should be non-overlapping */
 			dev_err(&dev->dev,
 				"Failed to reserve IOVA [%pa-%pa]\n",
 				&start, &end);
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index cb2e8351c2cc..8f0ebaf9ae85 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -369,7 +369,6 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
 
 	dev_dbg(dev, "Parsing dma-ranges property...\n");
 	for_each_of_pci_range(&parser, &range) {
-		struct resource_entry *entry;
 		/*
 		 * If we failed translation or got a zero-sized region
 		 * then skip this range
@@ -393,12 +392,7 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
 			goto failed;
 		}
 
-		/* Keep the resource list sorted */
-		resource_list_for_each_entry(entry, ib_resources)
-			if (entry->res->start > res->start)
-				break;
-
-		pci_add_resource_offset(&entry->node, res,
+		pci_add_resource_offset(ib_resources, res,
 					res->start - range.pci_addr);
 	}
 
-- 
2.35.3.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
