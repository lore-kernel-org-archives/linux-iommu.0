Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01E169304
	for <iommu@lists.linux.dev>; Fri,  1 Mar 2024 07:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709277570; cv=none; b=lqhZwqZ3mYfIHMgHVQMn+2j0MK9mpQEm4IYbJKTu4YWeJKdhgv0rBhW1hidHcgxVIN+q2IKi0Y0dL0DUXzeHaqMg2q5wLl42GnVQR9RsgyzJiU72EfnvnC7loUL1xvo6raKPvbjbjW8T5X4kULLlsYVmFOvYT7fF4YuRhlCYpyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709277570; c=relaxed/simple;
	bh=8uclGvYnwgBo+pRR0QCV8T4jAbEr7kN0Zz+U0UsWlqU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DYavvVBV1kHSxB2O/vvPv8m26aGwlqhXv4lAEzKTlKgrEJLJwlt0YVXxpcB2UatNMQzs/VboZSizo61f8U6cZzAONhfxpH40VGANwDFto/fSs+WpOVUDUmAe1aT2TZrMPFnEwYWZEST1EX1xncUB20axwdgpeuN6Z5ibsSscOAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pfP7CLvZ; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pfP7CLvZ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709277559; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=lKxH1wti4AEphZSbDiXy/K+c1q2VHgxihXjjl65ACMw=;
	b=pfP7CLvZjHbfv1T/HVBLRe6tsFlZ12vm7Po/YKcmvNO01gOZe+ruJOGmOqfUI0lkgB9aUZVhz6oy8n0FDmRLNDLsx23Jmt/4f6MvGmfrB92/jqLRsqYvdZzyN1aYYYJQy4+kef1U69hlB8AapBDn1loetzd/WqkI4TcgUwEiF3g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W1ZHnHc_1709277558;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W1ZHnHc_1709277558)
          by smtp.aliyun-inc.com;
          Fri, 01 Mar 2024 15:19:19 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	iommu@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Zelin Deng <zelin.deng@linux.alibaba.com>
Subject: [RFC] dma-mapping: introduce dma_can_skip_unmap()
Date: Fri,  1 Mar 2024 15:19:18 +0800
Message-Id: <20240301071918.64631-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: d1edb4657402
Content-Transfer-Encoding: 8bit

In a typical workflow, we first perform a dma map on an address to
obtain a dma address, followed by a dma unmap on that address. Generally,
this process works without issues. However, under certain circumstances,
we require additional resources to manage these dma addresses. For
instance, in layered architectures, we pass the dma address to another
module, but retrieving it back from that module can present some
challenges. In such cases, we must allocate extra resources to manage
these dma addresses.

However, considering that many times the dma unmap operation is actually
a no-op, if we know in advance that unmap is not necessary, we can save
on these extra management overheads. Moreover, we can directly skip the
dma unmap operation. This would be advantageous.

This tries to resolve the problem of patchset:

 http://lore.kernel.org/all/20240225032330-mutt-send-email-mst@kernel.org

For a single packet, virtio-net may submit 1-19 dma addresses to virtio
core. If the virtio-net maintains the dma addresses will waste too much
memory when the unmap is not necessary. If the virtio-net retrieves the
dma addresses of the packet from the virtio core, we need to hold the 19
dma addresses by one call. And the net drivers maintain the dma is the
future. So we hope to check the unmap is necessary or not.

Co-developed-by: Zelin Deng <zelin.deng@linux.alibaba.com>
Signed-off-by: Zelin Deng <zelin.deng@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/iommu/dma-iommu.c   | 11 +++++++++++
 include/linux/dma-map-ops.h |  1 +
 include/linux/dma-mapping.h |  5 +++++
 kernel/dma/mapping.c        | 23 +++++++++++++++++++++++
 4 files changed, 40 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 50ccc4f1ef81..8c661a0e1111 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1706,6 +1706,16 @@ static size_t iommu_dma_opt_mapping_size(void)
 	return iova_rcache_range();
 }
 
+static bool iommu_dma_opt_can_skip_unmap(struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+
+	if (domain->type == IOMMU_DOMAIN_IDENTITY)
+		return true;
+	else
+		return false;
+}
+
 static const struct dma_map_ops iommu_dma_ops = {
 	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED,
 	.alloc			= iommu_dma_alloc,
@@ -1728,6 +1738,7 @@ static const struct dma_map_ops iommu_dma_ops = {
 	.unmap_resource		= iommu_dma_unmap_resource,
 	.get_merge_boundary	= iommu_dma_get_merge_boundary,
 	.opt_mapping_size	= iommu_dma_opt_mapping_size,
+	.dma_can_skip_unmap	= iommu_dma_opt_can_skip_unmap,
 };
 
 /*
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 4abc60f04209..d508fa90bc06 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -83,6 +83,7 @@ struct dma_map_ops {
 	size_t (*max_mapping_size)(struct device *dev);
 	size_t (*opt_mapping_size)(void);
 	unsigned long (*get_merge_boundary)(struct device *dev);
+	bool (*dma_can_skip_unmap)(struct device *dev);
 };
 
 #ifdef CONFIG_DMA_OPS
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 4a658de44ee9..af5d9275f8cc 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -140,6 +140,7 @@ int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs);
 bool dma_can_mmap(struct device *dev);
+bool dma_can_skip_unmap(struct device *dev);
 bool dma_pci_p2pdma_supported(struct device *dev);
 int dma_set_mask(struct device *dev, u64 mask);
 int dma_set_coherent_mask(struct device *dev, u64 mask);
@@ -249,6 +250,10 @@ static inline bool dma_can_mmap(struct device *dev)
 {
 	return false;
 }
+static inline bool dma_can_skip_unmap(struct device *dev)
+{
+	return false;
+}
 static inline bool dma_pci_p2pdma_supported(struct device *dev)
 {
 	return false;
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 58db8fd70471..99a81932820b 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -445,6 +445,29 @@ bool dma_can_mmap(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dma_can_mmap);
 
+/**
+ * dma_can_skip_unmap - check if unmap can be skipped
+ * @dev: device to check
+ *
+ * Returns %true if @dev supports direct map or dma_can_skip_unmap() return true.
+ */
+bool dma_can_skip_unmap(struct device *dev)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (is_swiotlb_force_bounce(dev))
+		return false;
+
+	if (dma_map_direct(dev, ops))
+		return true;
+
+	if (ops->dma_can_skip_unmap)
+		return ops->dma_can_skip_unmap(dev);
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(dma_can_skip_unmap);
+
 /**
  * dma_mmap_attrs - map a coherent DMA allocation into user space
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
-- 
2.32.0.3.g01195cf9f

