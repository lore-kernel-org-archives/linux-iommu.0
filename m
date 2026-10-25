Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792935033;
	b=RflrcoP+CEhONc1MDvuwiw8GmWJiUrf6SW+JyRJn4V0scXEkqxQ9ObtHHV0ZsWXq5Gd+
	 DaLAG1rki6PMPOgwe9BGKR2k6VwNvRajwtBYSLhG5+dRYIE22HKPfbxuZ4lDJf4O1pi6D
	 ln1CmnkXDuABjvTpncZxHvpI4/kRnDAMM+5MU+V1b6AmR+DR/g03xwgx59WrEk2gcT+Cn
	 QJi0FNpY7keU3Hn6ZzhoJEcGkDIr+YEv4emBuaJ3ii0OAUd6x131F5G/H4QXDECeOP2ZV
	 IMgcM2Zv3GAH3ZKDwGS5adhGAtuv+eUyUPlSBE/DoNfKLyE17sb+2mCtTlz4gxxYQVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792935033;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/vkV3+4Cb8UAzcre2euQRS6FXnY2cF6zop3hRFO/Chw=;
	b=c4Bo0isd/1gWp5X7rmCK5Dg4gZtbkuTGxzMch4Dcs/vpcmExKSUecR2gGAjBT9+qzBhG
	 gOC9eoHVj6YNkMD+p/kp6Ujleti3bLU16XvllYkOCfKDeALJTbHXZeM66Yvdy9VTc6Pl+
	 pwHsioaRUiohDL5WNRg1j+pa9j7rsovp6tCdlLC18eTXlPBkm86Jse8d57ERDlra57Hmt
	 I3l5D4uC0JE1ygxbhRRoj/KGpDXBajaa4ovJNuZUf2g/Ijsr2ZgywyDnDBj0FZB/Trghz
	 rG90JiP5p5rs+DaMaXat0hNSU/fv6hE4Kt96ZxcbFwZHqfCWmyoYzoTjVQYlhQ4SELg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LCVu117t;
	arc=none smtp.remote-ip=115.124.30.110
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB1B606A328
	for <iommu@lists.linux.dev>; Sun, 25 Oct 2026 13:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAB1B606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LCVu117t
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792935022; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=/vkV3+4Cb8UAzcre2euQRS6FXnY2cF6zop3hRFO/Chw=;
	b=LCVu117t8m3DEgxzNknj7XPmE2zIMh0tOv5Pvpt2eE8nCVJ4AjqbS/wnvcT8NT5S/pYMppBkEadjScEp1D7+Hp7+P6nRMgIAe+5nwB5ztdyh4Yr3vjVlBama2GUS9hbDotQ1HCFeEyS4XqwmwctRfQ3QUQm93Nn1GIZ3xVEzO54=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XDQQjMj_1792935021;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XDQQjMj_1792935021 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 25 Oct 2026 21:30:21 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: jgg@ziepe.ca
Cc: alex@shazbot.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	kevin.tian@intel.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	will@kernel.org
Subject: [PATCH v4 1/2] iommu: Add iommu_for_each_pci_mmio_window() iterator
Date: Sun, 25 Oct 2026 21:29:59 +0800
Message-ID: <20261025133000.205508-2-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261025133000.205508-1-guanghuifeng@linux.alibaba.com>
References: <20261022193359.GF3381610@ziepe.ca>
 <20261025133000.205508-1-guanghuifeng@linux.alibaba.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a callback-based iterator that walks a PCI device's host bridge
MMIO windows and invokes a caller-supplied function with each window's
bus address range.  This consolidates the bridge window enumeration
logic into a single shared algorithm in the IOMMU core.

Refactor iova_reserve_pci_windows() to use the new iterator, replacing
its open-coded resource_list_for_each_entry loop.  The callback approach
avoids intermediate allocations: the DMA path's callback directly calls
reserve_iova() with the computed PFN range, maintaining the same
zero-allocation overhead as the original open-coded loop.

Using a callback rather than returning a linked list of iommu_resv_region
entries eliminates size_t truncation risk on 32-bit PAE systems (the
callback receives phys_addr_t start/end directly) and removes the need
for allocation failure cleanup paths.

Note: commit cd2c9fcf5c66 ("iommu/dma: Move PCI window region reservation back into dma specific path.")
intentionally keeps PCI window reservation out of the IOMMU group-level
reserved region API.  This iterator respects that boundary: it does not
inject windows into iommu_get_group_resv_regions().

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/dma-iommu.c  | 29 ++++++++++++++++------
 drivers/iommu/iommu-priv.h | 25 +++++++++++++++++++
 drivers/iommu/iommu.c      | 51 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 68ee57800fef..d4e4a4c90d8b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -37,6 +37,7 @@
 
 #include "dma-iommu.h"
 #include "iommu-pages.h"
+#include "iommu-priv.h"
 
 struct iommu_dma_msi_page {
 	struct list_head	list;
@@ -504,6 +505,20 @@ static int iommu_dma_ranges_sort(void *priv, const struct list_head *a,
 	return res_a->res->start > res_b->res->start;
 }
 
+struct iova_pci_resv_data {
+	struct iova_domain *iovad;
+};
+
+static int iova_reserve_pci_window_fn(phys_addr_t start, phys_addr_t end,
+				      void *data)
+{
+	struct iova_pci_resv_data *d = data;
+
+	reserve_iova(d->iovad, iova_pfn(d->iovad, start),
+		     iova_pfn(d->iovad, end));
+	return 0;
+}
+
 static int iova_reserve_pci_windows(struct pci_dev *dev,
 		struct iova_domain *iovad)
 {
@@ -511,15 +526,13 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
 	struct resource_entry *window;
 	unsigned long lo, hi;
 	phys_addr_t start = 0, end;
+	struct iova_pci_resv_data data = { .iovad = iovad };
+	int ret;
 
-	resource_list_for_each_entry(window, &bridge->windows) {
-		if (resource_type(window->res) != IORESOURCE_MEM)
-			continue;
-
-		lo = iova_pfn(iovad, window->res->start - window->offset);
-		hi = iova_pfn(iovad, window->res->end - window->offset);
-		reserve_iova(iovad, lo, hi);
-	}
+	ret = iommu_for_each_pci_mmio_window(dev, iova_reserve_pci_window_fn,
+					     &data);
+	if (ret)
+		return ret;
 
 	/* Get reserved DMA windows from host bridge */
 	list_sort(NULL, &bridge->dma_ranges, iommu_dma_ranges_sort);
diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index aaffad5854fc..36a2e4691455 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -123,4 +123,29 @@ static inline void iommu_debug_init(void)
 
 #endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
 
+struct pci_dev;
+
+/**
+ * iommu_pci_mmio_window_fn_t - callback for host bridge MMIO window iteration
+ * @start: First PCI bus address of the window (inclusive)
+ * @end: Last PCI bus address of the window (inclusive)
+ * @data: Opaque pointer from iommu_for_each_pci_mmio_window() caller
+ *
+ * Return: 0 to continue iteration, negative errno to stop and propagate.
+ */
+typedef int (*iommu_pci_mmio_window_fn_t)(phys_addr_t start, phys_addr_t end,
+					  void *data);
+
+#ifdef CONFIG_PCI
+int iommu_for_each_pci_mmio_window(struct pci_dev *dev,
+				   iommu_pci_mmio_window_fn_t fn, void *data);
+#else
+static inline int iommu_for_each_pci_mmio_window(struct pci_dev *dev,
+						 iommu_pci_mmio_window_fn_t fn,
+						 void *data)
+{
+	return 0;
+}
+#endif /* CONFIG_PCI */
+
 #endif /* __LINUX_IOMMU_PRIV_H */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cd1bca7ede9a..ec66118d13e9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -945,6 +945,57 @@ iommu_insert_device_resv_regions(struct list_head *dev_resv_regions,
 	return ret;
 }
 
+#ifdef CONFIG_PCI
+/**
+ * iommu_for_each_pci_mmio_window - iterate over PCI host bridge MMIO windows
+ * @dev: PCI device whose host bridge to scan
+ * @fn: callback invoked with each window's bus address range
+ * @data: opaque pointer passed to @fn
+ *
+ * Walks the MEM windows of @dev's PCI host bridge and invokes
+ * @fn(start, end, data) for each one, where start and end are PCI bus
+ * addresses (inclusive).  Iteration stops early if @fn returns non-zero,
+ * and that value is propagated to the caller.
+ *
+ * This provides a zero-allocation way for both the DMA IOVA layer and
+ * iommufd to enumerate the same host bridge window information using a
+ * shared algorithm.
+ *
+ * Note: commit cd2c9fcf5c66 ("iommu/dma: Move PCI window region reservation back into dma specific path.")
+ * intentionally keeps PCI window reservation out of the IOMMU group-level
+ * reserved region API.  This iterator respects that boundary: it does not
+ * inject windows into iommu_get_group_resv_regions().
+ *
+ * Return: 0 on success, negative errno on failure (including from @fn).
+ */
+int iommu_for_each_pci_mmio_window(struct pci_dev *dev,
+				   iommu_pci_mmio_window_fn_t fn, void *data)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
+	struct resource_entry *window;
+
+	if (!bridge)
+		return -ENODEV;
+
+	resource_list_for_each_entry(window, &bridge->windows) {
+		phys_addr_t start, end;
+		int ret;
+
+		if (resource_type(window->res) != IORESOURCE_MEM)
+			continue;
+
+		start = window->res->start - window->offset;
+		end = window->res->end - window->offset;
+
+		ret = fn(start, end, data);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_for_each_pci_mmio_window);
+#endif /* CONFIG_PCI */
+
 int iommu_get_group_resv_regions(struct iommu_group *group,
 				 struct list_head *head)
 {
-- 
2.43.7

