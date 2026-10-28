Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793178315;
	b=XYnfkX+0S30JQ8J3qjafEQ9dvhQ5Dh/gsOyjAzE20jNc1AkZzxHrns1f1lIL0SYcu8l3
	 hCce6BkEdfJFFp78T52wRzpTZYTksIFCVuxHVIBKWhx3mVsyKwEDOr5WstrJxJfYgH/u/
	 bcBLU4BIGMHhTULGteRh1IzekyTc8x4tHaOYE6Ro18zIstbJE0kS66KrdUYafeTh3EOLS
	 xI+tJhBWqnD+/ZKrhXHHkVBgBlPdWYbiCQAXZN0dWd/tYmW3ImrySJVezadhIQUN/1quR
	 CRj1WZFmKMiGhED/4Syxd29jdecl598Cm/AEq7XdWjsO6k/iiTwzeP2yLtl0tRp+8iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793178315;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+KnwYo2XdWjMn4cLtFXsc7wNn/LqJ2SyRK+sPxYoWIM=;
	b=Ff70L7OMQfc8Hp7tyXUTqvv9aj3rvqd2LtN9hOEWeQWqS/tOMJGThjsibip3jlGqGmqb
	 72Nsw96Mghcqcfpxhy4loufP4U4uEqOa2OTezgCFFoqXja0J86eJB6yMD74YkO74RcTAS
	 JEUmOQ6/i9oXq69uy1comQKP5HpfKoZQGUHyrrTpJww/JuTYdMSwNuzwnI+o36b0f/8YD
	 vyaG4GObqiE932mEtA9b8h4GeUnBDIBHf0zJWlJBBAC7OgUNjdImvpVhuNDT2mdK11LxE
	 7QYwPND9yU4Ey1fGYSTh4p6G5LZpM7Xhr2UAnnkw45HjCyfSfcO4odQhmP3zsJ2l/tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mvQVDf5S;
	arc=none smtp.remote-ip=115.124.30.100
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF55E606A32E
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 09:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF55E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mvQVDf5S
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793178307; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+KnwYo2XdWjMn4cLtFXsc7wNn/LqJ2SyRK+sPxYoWIM=;
	b=mvQVDf5SfYbwxdwLgZU73izynRu4d9jyeL55wIO21PgX3qh8o2fo96iceHA/nTF+cYlDQY3ejpqkL9rYPr9LZFHCGQb5N6IbAyxYSbFipYAnLcablpvFWBno1tR0X3Nm8vm47ofgdGKF1F3DO/wfuo4qcVux+2q+6tvd7D3ytAU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XDgOuF._1793178306;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XDgOuF._1793178306 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Oct 2026 17:05:06 +0800
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
Subject: [PATCH v6 1/3] iommu: Add iommu_for_each_pci_mmio_window() iterator
Date: Wed, 28 Oct 2026 17:04:51 +0800
Message-ID: <20261028090453.2392991-2-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261028090453.2392991-1-guanghuifeng@linux.alibaba.com>
References: <20261028071906.2325378-1-guanghuifeng@linux.alibaba.com>
 <20261028090453.2392991-1-guanghuifeng@linux.alibaba.com>
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
its open-coded resource_list_for_each_entry loop.  The callback
receives phys_addr_t start/end directly, so the DMA path reserves the
same ranges as before with zero intermediate allocation, and window
lengths never pass through a size_t field (which would truncate on
32-bit PAE systems).

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/dma-iommu.c  | 22 ++++++++++++++--------
 drivers/iommu/iommu-priv.h | 17 +++++++++++++++++
 drivers/iommu/iommu.c      | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 78742aeba932..5b73e71c312e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -505,6 +505,15 @@ static int iommu_dma_ranges_sort(void *priv, const struct list_head *a,
 	return res_a->res->start > res_b->res->start;
 }
 
+static int iova_reserve_pci_window_fn(phys_addr_t start, phys_addr_t end,
+				      void *data)
+{
+	struct iova_domain *iovad = data;
+
+	reserve_iova(iovad, iova_pfn(iovad, start), iova_pfn(iovad, end));
+	return 0;
+}
+
 static int iova_reserve_pci_windows(struct pci_dev *dev,
 		struct iova_domain *iovad)
 {
@@ -512,15 +521,12 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
 	struct resource_entry *window;
 	unsigned long lo, hi;
 	phys_addr_t start = 0, end;
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
+					     iovad);
+	if (ret)
+		return ret;
 
 	/* Get reserved DMA windows from host bridge */
 	list_sort(NULL, &bridge->dma_ranges, iommu_dma_ranges_sort);
diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index 1f9f886b2c10..81c5b5ce67ec 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -127,4 +127,21 @@ static inline void iommu_debug_init(void)
 
 #endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
 
+struct pci_dev;
+
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
index b486b8bbd1fc..6b0e2b08ceba 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -945,6 +945,43 @@ iommu_insert_device_resv_regions(struct list_head *dev_resv_regions,
 	return ret;
 }
 
+#ifdef CONFIG_PCI
+/**
+ * iommu_for_each_pci_mmio_window - iterate over PCI host bridge MMIO windows
+ * @dev: PCI device whose host bridge to scan
+ * @fn: callback invoked with each window's bus address range (inclusive)
+ * @data: opaque pointer passed to @fn
+ *
+ * Iteration stops early if @fn returns non-zero, and that value is
+ * propagated to the caller.
+ *
+ * Return: 0 on success, negative errno on failure (including from @fn).
+ */
+int iommu_for_each_pci_mmio_window(struct pci_dev *dev,
+				   iommu_pci_mmio_window_fn_t fn, void *data)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
+	struct resource_entry *window;
+
+	if (WARN_ON(!bridge))
+		return -ENODEV;
+
+	resource_list_for_each_entry(window, &bridge->windows) {
+		int ret;
+
+		if (resource_type(window->res) != IORESOURCE_MEM)
+			continue;
+
+		ret = fn(window->res->start - window->offset,
+			 window->res->end - window->offset, data);
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

