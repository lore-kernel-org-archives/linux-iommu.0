Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87D239B947
	for <iommu@lists.linux.dev>; Sun,  4 Oct 2026 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131288; cv=none; b=mSF+wq2hu8yIj1oDgG9NUjFkvVX3uCENRnPqklr8qZeUZjXfN1P3mrgqBiwr3tUBAqP/oirYT2A6yMyGGIn4CPMGzTGCA+VAPTEb4PeOGr3miyJT59TMW/7Mot+COexNnlOvw5W7DsKgRGebv+RQOJJM57StIm9Paw/4GNcPoVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131288; c=relaxed/simple;
	bh=6JhFOSzDBz498SVVIXzQUcHOXuvxrUCXtfUrR9WXqXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVxUUH1RJaOIphKKvmTFXF2aAEOGaNdMXAGVWalPqgQCVvhEWoWkp6vvXo5F5iKwaDu+jPWYPAb4xu4cUWStNYyIOMJSjXk9kYChkl9ZmmyXDPGBJH6Q3Vr/abNd1cPxpvVT1+CYMb7FZi1i2hroSDTSGZPSq5dWQhUWzN2E2AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=abPzSSfF; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="abPzSSfF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791131277; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=b3pihz/2uGlCKNqilY+Zn7blSFGVNUKQTRQLSRlrA+8=;
	b=abPzSSfFOJplujgQMLv1OkuQdUZow13Cd0q/rtS8vcwtiEoxdf14hvV53g+f83mZPEVrdC2uy9k6zkgjkDECdGzK3IjMyUZDvqw5rIV7qNVQM7RDmMFHm4Ew1olA12KiCbel0NL37rIfMpUtO12jeffCUZM5VBnjQft09RDeIko=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0XC2deBc_1791130957;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XC2deBc_1791130957 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 05 Oct 2026 00:22:38 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: jgg@ziepe.ca
Cc: alex@shazbot.org,
	guanghuifeng@linux.alibaba.com,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	kevin.tian@intel.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	will@kernel.org
Subject: [PATCH v3 1/2] iommu: Add iommu_get_pci_resv_windows() helper
Date: Mon,  5 Oct 2026 00:22:12 +0800
Message-ID: <20261004162213.3787623-2-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261004162213.3787623-1-guanghuifeng@linux.alibaba.com>
References: <20260921115513.GK11599@ziepe.ca>
 <20261004162213.3787623-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a common helper that walks a PCI device's host bridge MMIO windows
and returns them as IOMMU_RESV_RESERVED regions in a list.  This
provides a reusable interface for subsystems that need visibility into
PCI host bridge MMIO address ranges, such as iommufd which wants to
expose these ranges to userspace for opt-in IOVA avoidance.

The helper builds its results in a local list using
iommu_insert_resv_region() so entries are sorted by start address and
overlapping same-type regions are merged.  On allocation failure the
partial list is freed internally, leaving the caller's list head
unmodified.

Note: commit cd2c9fcf5c66 ("iommu/dma: Move PCI window region reservation back into dma specific path.")
intentionally keeps PCI window reservation out of the IOMMU group-level
reserved region API.  This helper respects that boundary: it does not
inject windows into iommu_get_group_resv_regions().  Consumers that need
this information call the helper directly.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/iommu-priv.h | 12 ++++++++
 drivers/iommu/iommu.c      | 57 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index aaffad5854fc..17f2234dabd4 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -123,4 +123,16 @@ static inline void iommu_debug_init(void)
 
 #endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
 
+struct pci_dev;
+
+#ifdef CONFIG_PCI
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
index cd1bca7ede9a..25bc99114e1e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -945,6 +945,63 @@ iommu_insert_device_resv_regions(struct list_head *dev_resv_regions,
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
+	if (!bridge)
+		return -ENODEV;
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
+#endif /* CONFIG_PCI */
+
 int iommu_get_group_resv_regions(struct iommu_group *group,
 				 struct list_head *head)
 {
-- 
2.43.7

