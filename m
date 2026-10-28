Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793171964;
	b=KACsxTPXb5jlAQ4HCyz3BExbzXge4LUFlaZIKDzGcT7eJlQZFPW+5NVN1IraZzRbd95f
	 nek5Sb6A9xkR2mOFRx1Ogx+V4pKUkxiJHDIqaNOYYG14B0345qs8wU9MQ7l9ixprmcVeL
	 //XLLhBr9kMSDmROIqnJuO8BhscSxbQVUHiIphHQc7/m65XBWKAIlIiYi+bc28oF8P7Bj
	 Oz81fNZDnBwn3Mo/P72TcGLXh5gLAGpJFHdXKsoS2QereSsBKMoQ/6ijagP6lK06KjN3/
	 7GYapK+Pv+ExmJzslCrzPafiYjgecEEtLjslmFbqbQcp6gSAmjF8zTpU3mSduP28uQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171964;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+KnwYo2XdWjMn4cLtFXsc7wNn/LqJ2SyRK+sPxYoWIM=;
	b=hG1ojOck3gmB9PKBAN/Dsv8jElS0LeJKXFlEVUpCkrajy3Qed+Ag/wyYqQs920FlyzBd
	 Ou8UufZRqfPyspTuMZJhrhTa1dnb+sWPt+/crMPxy0dIikSX9ftquhZy9ZP/VIVkvwxir
	 nHrfT6fMUoyndDE+AeJ+DeywEH3kluePwSA8Sj9ZVDjpXirVFRMeVsYJautSWdz4raHv+
	 o2Bz8YoLQ1Im0USrtFPxBMSKFO5FmYswmADkIPdYjNCwOMH/tT7aDhcX98iwtqRhUKpUr
	 exBO2/TC/+H04G6GZT/vl0wwQYkyUYn/uzWxmjvvnejMvL3xfs0xejBsY++5zkgW9vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nN4kXCjp;
	arc=none smtp.remote-ip=115.124.30.111
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7DC606A31E
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 07:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC7DC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nN4kXCjp
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793171961; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+KnwYo2XdWjMn4cLtFXsc7wNn/LqJ2SyRK+sPxYoWIM=;
	b=nN4kXCjpahx5G00cCIKcwpG8XsTq8vlEY2TKHaWeVbTCUb6heXtyEXskkeJK1JYyApbZ5yk0bHFhsbWYNH4nae556gf4gic80STSiW2UHsNq/yVjevkx0uintMGAXA7d5GMtnZEwai+F1yq09lMQ4z8wNi2lATxQTYizlc+8gDI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XDg7jl6_1793171960;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XDg7jl6_1793171960 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Oct 2026 15:19:20 +0800
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
Subject: [PATCH v5 1/3] iommu: Add iommu_for_each_pci_mmio_window() iterator
Date: Wed, 28 Oct 2026 15:19:04 +0800
Message-ID: <20261028071906.2325378-2-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261028071906.2325378-1-guanghuifeng@linux.alibaba.com>
References: <20261027183418.GJ1685504@ziepe.ca>
 <20261028071906.2325378-1-guanghuifeng@linux.alibaba.com>
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

