Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7FA47799B
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 10:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789987193; cv=none; b=U5pxTjut+Wx31Y4+vPgRQAms5sLWyGNDJ4FCBsES7EpdYzuPSGILaw6SUvPLuEbo9coN/nviGb21aHb1lVK4uCwsgH01eQTQRfpY/7ZGPg7XlI5jUvYucegVrQNhmDvQd0UHwqhWLFzFxrdcK+Z1SgayqmsnJ7Bh+2uLzVcU68Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789987193; c=relaxed/simple;
	bh=KB7GsklcK37m0ccOYMXUdW7TrashQmGmn6pEMM9sqJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEFzFh1QTqexWa3zavHLNi4UBZeLMHLaNtn5uPusGRlSsMyZcroR0WYRSH5yqkBJe4v13qArKrVECE4PXQbHeCLAjXvaINlEJMbkTuQkZsQItFHxGuU0aM96g/uovg8nZNhqoazwK+Q8XyUJ/jqTJEtuZuGo7PdWCqlKu/vDzWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LaS0Alvx; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LaS0Alvx"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789987179; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qSNppozumsEbPMUAPAntUOPdiTplSobFRAFYxzo9F9o=;
	b=LaS0Alvx0xEFXxHyo5XyShqOx5nqZ6/ZG8U1qGmgprFBsbNbqPo0/GSldfHfgmCFEcxF+xd+IKkiLkHE+bqs7F3z8JEa4AtehvoWTX8SzBfLelxn9WyVXeJG0A81Wzmx8Qofi5+7ftRIIK9CemVKOVMyz/W2yq3ki0cpq48L6gE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XBMvKgU_1789987177;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XBMvKgU_1789987177 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 21 Sep 2026 18:39:38 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: jgg@ziepe.ca,
	kevin.tian@intel.com,
	alex@shazbot.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] iommu: Reserve PCI host bridge MMIO windows in group reserved regions
Date: Mon, 21 Sep 2026 18:39:21 +0800
Message-ID: <20260921103922.1113752-2-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260921103922.1113752-1-guanghuifeng@linux.alibaba.com>
References: <20260921070234.897736-1-guanghuifeng@linux.alibaba.com>
 <20260921103922.1113752-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DMA IOVA layer reserves PCI host bridge MMIO windows via
iova_reserve_pci_windows() to prevent IOVA allocations from
overlapping with those address ranges.  As commit fade1ec055dc
("iommu/dma: Avoid PCI host bridge windows") explains, a host
bridge may interpret addresses falling within its MMIO windows as
peer-to-peer DMA, leading to faults, data corruption, or DMA
transactions being misrouted to the wrong PCIe device.

However, VFIO type1 obtains reserved regions through
iommu_get_group_resv_regions() and reports the available IOVA
ranges to userspace via VFIO_IOMMU_GET_INFO.  Previously
iommu_get_group_resv_regions() only returned IOMMU driver-level
reserved regions (RMRR, Unity Maps, MSI regions, etc.) and did
not include PCI host bridge MMIO windows.  This allowed userspace
to choose IOVA addresses that overlap with bridge windows.

The problem is especially dangerous when a device sits behind a
PCIe switch and ACS Upstream Forwarding is not fully enabled: the
switch may route DMA TLPs as peer-to-peer traffic to other
downstream devices instead of forwarding them upstream to the
root complex for IOMMU translation.

Fix this by:

  - Introducing iommu_get_pci_resv_windows(), a common helper
    that walks a PCI host bridge's MMIO windows and creates
    IOMMU_RESV_RESERVED region entries for each one.

  - Calling iommu_resv_pci_windows() from
    iommu_get_group_resv_regions() so that all group-level
    consumers (VFIO type1, sysfs reserved_regions) automatically
    receive the PCI window reservations.

  - Refactoring iova_reserve_pci_windows() to reuse
    iommu_get_pci_resv_windows(), eliminating the duplicated
    bridge window enumeration logic.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/dma-iommu.c  | 17 +++++---
 drivers/iommu/iommu-priv.h | 11 +++++
 drivers/iommu/iommu.c      | 85 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 58c624513cd4..c97622826d9d 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -37,6 +37,7 @@
 
 #include "dma-iommu.h"
 #include "iommu-pages.h"
+#include "iommu-priv.h"
 
 struct iommu_dma_msi_page {
 	struct list_head	list;
@@ -508,17 +509,23 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
 		struct iova_domain *iovad)
 {
 	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
+	struct iommu_resv_region *region, *next;
 	struct resource_entry *window;
 	unsigned long lo, hi;
 	phys_addr_t start = 0, end;
+	LIST_HEAD(pci_windows);
+	int ret;
 
-	resource_list_for_each_entry(window, &bridge->windows) {
-		if (resource_type(window->res) != IORESOURCE_MEM)
-			continue;
+	ret = iommu_get_pci_resv_windows(dev, &pci_windows);
+	if (ret)
+		return ret;
 
-		lo = iova_pfn(iovad, window->res->start - window->offset);
-		hi = iova_pfn(iovad, window->res->end - window->offset);
+	list_for_each_entry_safe(region, next, &pci_windows, list) {
+		lo = iova_pfn(iovad, region->start);
+		hi = iova_pfn(iovad, region->start + region->length - 1);
 		reserve_iova(iovad, lo, hi);
+		list_del(&region->list);
+		kfree(region);
 	}
 
 	/* Get reserved DMA windows from host bridge */
diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index aaffad5854fc..bc7fab0c827e 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -123,4 +123,15 @@ static inline void iommu_debug_init(void)
 
 #endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
 
+#ifdef CONFIG_PCI
+struct pci_dev;
+int iommu_get_pci_resv_windows(struct pci_dev *dev, struct list_head *head);
+#else
+static inline int iommu_get_pci_resv_windows(struct pci_dev *dev,
+					     struct list_head *head)
+{
+	return 0;
+}
+#endif /* CONFIG_PCI */
+
 #endif /* __LINUX_IOMMU_PRIV_H */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cd1bca7ede9a..b77e9818e4a4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -945,6 +945,84 @@ iommu_insert_device_resv_regions(struct list_head *dev_resv_regions,
 	return ret;
 }
 
+#ifdef CONFIG_PCI
+/**
+ * iommu_get_pci_resv_windows - collect PCI host bridge MMIO windows as
+ *                               reserved regions
+ * @dev: PCI device whose host bridge to scan
+ * @head: list head to append iommu_resv_region entries to
+ *
+ * Walks the MMIO windows of @dev's PCI host bridge and inserts an
+ * IOMMU_RESV_RESERVED region for each one using iommu_insert_resv_region(),
+ * keeping the entries sorted by start address and merging overlapping
+ * regions of the same type.  On success the inserted entries are appended
+ * to @head and the caller must free them with kfree() when done.  On
+ * failure any entries built so far are freed internally and @head is left
+ * unmodified.
+ *
+ * Returns 0 on success, negative errno on failure.
+ */
+int iommu_get_pci_resv_windows(struct pci_dev *dev, struct list_head *head)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
+	struct iommu_resv_region *region, *next;
+	struct resource_entry *window;
+	LIST_HEAD(resv_windows);
+	int ret;
+
+	resource_list_for_each_entry(window, &bridge->windows) {
+		struct iommu_resv_region tmp = {
+			.type = IOMMU_RESV_RESERVED,
+		};
+
+		if (resource_type(window->res) != IORESOURCE_MEM)
+			continue;
+
+		tmp.start = window->res->start - window->offset;
+		tmp.length = window->res->end - window->res->start + 1;
+
+		ret = iommu_insert_resv_region(&tmp, &resv_windows);
+		if (ret)
+			goto err_free;
+	}
+
+	list_splice_tail(&resv_windows, head);
+	return 0;
+
+err_free:
+	list_for_each_entry_safe(region, next, &resv_windows, list) {
+		list_del(&region->list);
+		kfree(region);
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_get_pci_resv_windows);
+
+/*
+ * Reserve PCI host bridge MMIO windows as IOMMU_RESV_RESERVED regions.
+ * This prevents IOVA allocations from overlapping with PCI MMIO address
+ * ranges, which could cause PCIe switches to misroute DMA transactions.
+ *
+ * All PCI devices within the same IOMMU group share the same host bridge,
+ * so we only need to find the first PCI device.
+ *
+ * Caller must hold group->mutex.
+ */
+static int iommu_resv_pci_windows(struct iommu_group *group,
+				  struct list_head *head)
+{
+	struct group_device *gdev;
+
+	for_each_group_device(group, gdev) {
+		if (!dev_is_pci(gdev->dev))
+			continue;
+		return iommu_get_pci_resv_windows(to_pci_dev(gdev->dev),
+						  head);
+	}
+	return 0;
+}
+#endif /* CONFIG_PCI */
+
 int iommu_get_group_resv_regions(struct iommu_group *group,
 				 struct list_head *head)
 {
@@ -969,6 +1047,13 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
 		if (ret)
 			break;
 	}
+
+	/* Reserve PCI host bridge MMIO windows to prevent IOVA conflicts */
+#ifdef CONFIG_PCI
+	if (!ret)
+		ret = iommu_resv_pci_windows(group, head);
+#endif
+
 	mutex_unlock(&group->mutex);
 	return ret;
 }
-- 
2.43.7

