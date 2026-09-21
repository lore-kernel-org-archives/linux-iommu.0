Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3333ACEED
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 07:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789974181; cv=none; b=mhOElJlh2pxJaSFd6mfu3e2o4XlVhgFo4GBpGDMz8xjBmvvok9TmwgFxRq6g1ayEpOuHaHHp/yw+z1HeehfGhkkV+1SzwyMyjseUyrjLKwHlifVrimWU7wg3Vjm9d5eUAZwpKEA15i9OiNLEKLBuFoiff5zP8dPF9CpSGC352VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789974181; c=relaxed/simple;
	bh=3U4Ovp0ynC0fulSiroEpUMxha2GMqQD2AFLocjFCzrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KxrN1lqGsiL5Q7aY8G9l1jzu/y9wyZ6RKkFjvPEkxVLac5HSRopkJBQoKW/mLvOfjTIKSoHRCkU3GoyTSzaxL4DJ9KdzUXJVFalvmUJg3HNNQ1hs+/htN8jTkjLsCoaEdpIrVsigcqceXzN8L1frZDo5ebEcMZFSzSdEsGz12AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LaAPZWcT; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LaAPZWcT"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789974170; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8ymtIVnhU6dCbTrVvPdPOmUpJ0Opv2VSNX9iXSB+xPQ=;
	b=LaAPZWcTxu2YdScOPfRXxbPppW42TFN6D4nfINo/1DXUXdSZK25MR6BAPH1OcAoCd8h1vehQux7AdbIm5+9Ni84yrRv59W5BLZRgmw2pWAa398Ii/8wX9DqYUF4cJ+zvIsyu+MA+QIXThI0hQ9WH7nL+m4XtU6wqvF8Y9kIsEGA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0XBJEbq-_1789974154;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XBJEbq-_1789974154 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 21 Sep 2026 15:02:49 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	alex@shazbot.org,
	kvm@vger.kernel.org
Subject: [PATCH] iommu: Reserve PCI host bridge MMIO windows in group reserved regions
Date: Mon, 21 Sep 2026 15:02:34 +0800
Message-ID: <20260921070234.897736-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
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
 drivers/iommu/dma-iommu.c  | 21 +++++++----
 drivers/iommu/iommu-priv.h | 11 ++++++
 drivers/iommu/iommu.c      | 73 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 58c624513cd4..bccb53043462 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -37,6 +37,7 @@
 
 #include "dma-iommu.h"
 #include "iommu-pages.h"
+#include "iommu-priv.h"
 
 struct iommu_dma_msi_page {
 	struct list_head	list;
@@ -508,18 +509,26 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
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
 
-		lo = iova_pfn(iovad, window->res->start - window->offset);
-		hi = iova_pfn(iovad, window->res->end - window->offset);
-		reserve_iova(iovad, lo, hi);
+	list_for_each_entry_safe(region, next, &pci_windows, list) {
+		if (!ret) {
+			lo = iova_pfn(iovad, region->start);
+			hi = iova_pfn(iovad, region->start + region->length - 1);
+			reserve_iova(iovad, lo, hi);
+		}
+		list_del(&region->list);
+		kfree(region);
 	}
+	if (ret)
+		return ret;
 
 	/* Get reserved DMA windows from host bridge */
 	list_sort(NULL, &bridge->dma_ranges, iommu_dma_ranges_sort);
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
index cd1bca7ede9a..de675ed27753 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -945,6 +945,72 @@ iommu_insert_device_resv_regions(struct list_head *dev_resv_regions,
 	return ret;
 }
 
+#ifdef CONFIG_PCI
+/**
+ * iommu_get_pci_resv_windows - collect PCI host bridge MMIO windows as
+ *                               reserved regions
+ * @dev: PCI device whose host bridge to scan
+ * @head: list head to append iommu_resv_region entries to
+ *
+ * Walks the MMIO windows of @dev's PCI host bridge and creates an
+ * IOMMU_RESV_RESERVED region for each one.  The caller must free the
+ * returned entries with kfree() when done.
+ *
+ * Returns 0 on success, negative errno on failure.
+ */
+int iommu_get_pci_resv_windows(struct pci_dev *dev, struct list_head *head)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
+	struct resource_entry *window;
+
+	resource_list_for_each_entry(window, &bridge->windows) {
+		struct iommu_resv_region *region;
+		phys_addr_t start;
+		size_t length;
+
+		if (resource_type(window->res) != IORESOURCE_MEM)
+			continue;
+
+		start = window->res->start - window->offset;
+		length = window->res->end - window->res->start + 1;
+
+		region = iommu_alloc_resv_region(start, length, 0,
+						 IOMMU_RESV_RESERVED,
+						 GFP_KERNEL);
+		if (!region)
+			return -ENOMEM;
+
+		list_add_tail(&region->list, head);
+	}
+	return 0;
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
@@ -969,6 +1035,13 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
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

