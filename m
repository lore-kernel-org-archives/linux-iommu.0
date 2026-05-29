Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5D2352031
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 07:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780038594; cv=none; b=UIizf/pPsQaa/in+4yLpW0SDdFSFytcJpkyTH3wM8JdUzbWQFAuhsnya8oRnexWPristKfGgO/hvWfnOXzX3oO27xzh6ZP1GV/4YuwcwhaebPkIcLnEgoRxUwedW/xBX3zlJTrX/uG6IKR4dxNa9HpqkHVMrISEn9a0eaJF1QfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780038594; c=relaxed/simple;
	bh=mcDPQ10OhT5h2kEYG1dHSv6QYaJYoPvImMxULNHllTY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TVZEcEI9T6eMPZ5rFxqzjnPN8F0uLXVGjFQ2MXBq/XMP73GILGBZTp1Fu8fhPcs33HylklhJVfg+Zfs3QJVq0pIy8qAF0K7W6o06UVX9BZ83LRVDwyIjCX8gjiIS5/uSBT0wTmh7RGFMtmB91oU2Q2wivHE7g9zOHZsLQquspIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=S4XF418F; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="S4XF418F"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780038583; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=AfOoAZRsoTHl03d+h7HBqGhrZdH7nmpYogtqIGY7Tdc=;
	b=S4XF418FqbAl/+2vTh80Nr1jlFL7rTAdCnMX222/vsSzI7+ESpTcTW/8aWjKKrSZlhUGRYiOrh9iZNaeAf08g/AZlbLHqSZnSF0ssBJXCpRmrlHmS4tx8n+I8TebQxprOkRwkfkh1mwyaQrBXWBkhOfRAbbIAufGJ26PgnGKhiM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X3oeHbx_1780038572;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X3oeHbx_1780038572 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 29 May 2026 15:09:42 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	alex@shazbot.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	skhawaja@google.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [RFC PATCH] Optimize VFIO and IOMMU mapping traversal
Date: Fri, 29 May 2026 15:09:32 +0800
Message-ID: <20260529070932.2632907-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In VFIO, vfio_unmap_unpin requires performing iommu unmap and mm
unpin on the address space. However, VFIO doesn't record the PHY
address corresponding to iova, but instead obtains the iova-PHY
mapping through iommu_iommu_iova_to_phys.

In IOMMU, under conditions such as address alignment, it prioritizes
mapping iova-PHY based on bigpages. Therefore, during the
vfio_unmap_unpin process, traversal can be performed at the
granularity of the IOMMU map, reducing the number of
iommu_iova_to_phys queries and significantly improving conversion
efficiency.

Therefore, an iommu_iova_to_pgsize implementation is added to the
IOMMU driver to return the pagesize used for the iova mapping.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Signed-off-by: Shiqiang Zhang <shiyu.zsq@linux.alibaba.com>
Signed-off-by: Simon Guo <wei.guo.simon@linux.alibaba.com>
---
 drivers/iommu/amd/iommu.c           |  2 ++
 drivers/iommu/generic_pt/iommu_pt.h | 53 +++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.c         |  2 ++
 drivers/iommu/iommu.c               | 25 ++++++++++++++
 drivers/vfio/vfio_iommu_type1.c     | 17 +++++++--
 include/linux/generic_pt/iommu.h    |  4 +++
 include/linux/iommu.h               |  3 ++
 7 files changed, 104 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 57dc8fabc7d9..36ffeb96c454 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2662,6 +2662,7 @@ static const struct pt_iommu_driver_ops amd_hw_driver_ops_v1 = {
 
 static const struct iommu_domain_ops amdv1_ops = {
 	IOMMU_PT_DOMAIN_OPS(amdv1),
+	IOMMU_PT_PGSIZE_OPS(amdv1),
 	.iotlb_sync_map = amd_iommu_iotlb_sync_map,
 	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
 	.iotlb_sync = amd_iommu_iotlb_sync,
@@ -2740,6 +2741,7 @@ static struct iommu_domain *amd_iommu_domain_alloc_paging_v1(struct device *dev,
 
 static const struct iommu_domain_ops amdv2_ops = {
 	IOMMU_PT_DOMAIN_OPS(x86_64),
+	IOMMU_PT_PGSIZE_OPS(x86_64),
 	.iotlb_sync_map = amd_iommu_iotlb_sync_map,
 	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
 	.iotlb_sync = amd_iommu_iotlb_sync,
diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index dc91fb4e2f61..de861d8b6ce2 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -199,6 +199,59 @@ phys_addr_t DOMAIN_NS(iova_to_phys)(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(iova_to_phys), "GENERIC_PT_IOMMU");
 
+static __always_inline int __do_iova_to_pgsize(struct pt_range *range,
+					       void *arg, unsigned int level,
+					       struct pt_table_p *table,
+					       pt_level_fn_t descend_fn)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	size_t *pgsize = arg;
+
+	switch (pt_load_single_entry(&pts)) {
+	case PT_ENTRY_EMPTY:
+		return -ENOENT;
+	case PT_ENTRY_TABLE:
+		return pt_descend(&pts, arg, descend_fn);
+	case PT_ENTRY_OA:
+		*pgsize = BIT(pt_entry_oa_lg2sz(&pts));
+		return 0;
+	}
+	return -ENOENT;
+}
+PT_MAKE_LEVELS(__iova_to_pgsize, __do_iova_to_pgsize);
+
+/**
+ * iova_to_pgsize() - Return the page size of the mapping at the given IOVA
+ * @domain: Table to query
+ * @iova: IO virtual address to query
+ *
+ * Walk the IOMMU page table to determine the actual page size of the PTE
+ * entry that maps the given IOVA.
+ *
+ * Context: The caller must hold a read range lock that includes @iova.
+ *
+ * Return: The page size in bytes, or 0 if there is no translation.
+ */
+size_t DOMAIN_NS(iova_to_pgsize)(struct iommu_domain *domain,
+				 dma_addr_t iova)
+{
+	struct pt_iommu *iommu_table =
+		container_of(domain, struct pt_iommu, domain);
+	struct pt_range range;
+	size_t pgsize;
+	int ret;
+
+	ret = make_range(common_from_iommu(iommu_table), &range, iova, 1);
+	if (ret)
+		return 0;
+
+	ret = pt_walk_range(&range, __iova_to_pgsize, &pgsize);
+	if (ret)
+		return 0;
+	return pgsize;
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(iova_to_pgsize), "GENERIC_PT_IOMMU");
+
 struct pt_iommu_dirty_args {
 	struct iommu_dirty_bitmap *dirty;
 	unsigned int flags;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4d0e65bc131d..f992162cfa67 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3890,6 +3890,7 @@ static struct iommu_domain identity_domain = {
 
 const struct iommu_domain_ops intel_fs_paging_domain_ops = {
 	IOMMU_PT_DOMAIN_OPS(x86_64),
+	IOMMU_PT_PGSIZE_OPS(x86_64),
 	.attach_dev = intel_iommu_attach_device,
 	.set_dev_pasid = intel_iommu_set_dev_pasid,
 	.iotlb_sync_map = intel_iommu_iotlb_sync_map,
@@ -3901,6 +3902,7 @@ const struct iommu_domain_ops intel_fs_paging_domain_ops = {
 
 const struct iommu_domain_ops intel_ss_paging_domain_ops = {
 	IOMMU_PT_DOMAIN_OPS(vtdss),
+	IOMMU_PT_PGSIZE_OPS(vtdss),
 	.attach_dev = intel_iommu_attach_device,
 	.set_dev_pasid = intel_iommu_set_dev_pasid,
 	.iotlb_sync_map = intel_iommu_iotlb_sync_map,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d1a9e713d3a0..e27f26bc1851 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2557,6 +2557,31 @@ phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 }
 EXPORT_SYMBOL_GPL(iommu_iova_to_phys);
 
+/**
+ * iommu_iova_to_pgsize - Get the page size of the mapping at a given IOVA
+ * @domain: IOMMU domain to query
+ * @iova: IO virtual address to query
+ *
+ * Walk the IOMMU page table to determine the actual page size of the PTE
+ * entry that maps the given IOVA. This reflects the real mapping granularity,
+ * not an inferred value from alignment.
+ *
+ * Returns the page size in bytes, or 0 if the mapping doesn't exist or the
+ * domain doesn't support this query.
+ */
+size_t iommu_iova_to_pgsize(struct iommu_domain *domain, dma_addr_t iova)
+{
+	if (domain->type == IOMMU_DOMAIN_IDENTITY ||
+	    domain->type == IOMMU_DOMAIN_BLOCKED)
+		return 0;
+
+	if (!domain->ops->iova_to_pgsize)
+		return 0;
+
+	return domain->ops->iova_to_pgsize(domain, iova);
+}
+EXPORT_SYMBOL_GPL(iommu_iova_to_pgsize);
+
 static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
 			   phys_addr_t paddr, size_t size, size_t *count)
 {
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index c8151ba54de3..bf918a93a159 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1177,7 +1177,7 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 
 	iommu_iotlb_gather_init(&iotlb_gather);
 	while (pos < dma->size) {
-		size_t unmapped, len;
+		size_t unmapped, len, pgsize;
 		phys_addr_t phys, next;
 		dma_addr_t iova = dma->iova + pos;
 
@@ -1191,11 +1191,24 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 		 * To optimize for fewer iommu_unmap() calls, each of which
 		 * may require hardware cache flushing, try to find the
 		 * largest contiguous physical memory chunk to unmap.
+		 *
+		 * Query the actual IOMMU PTE mapping granularity at this IOVA
+		 * to determine the guaranteed contiguous range. Use only the
+		 * remaining portion within the current PTE from our position,
+		 * in case we start from the middle of a large page mapping.
 		 */
-		for (len = PAGE_SIZE; pos + len < dma->size; len += PAGE_SIZE) {
+		pgsize = iommu_iova_to_pgsize(domain->domain, iova);
+		if (!pgsize)
+			pgsize = PAGE_SIZE;
+		len = pgsize - (iova & (pgsize - 1));
+		for (; pos + len < dma->size; len += pgsize) {
 			next = iommu_iova_to_phys(domain->domain, iova + len);
 			if (next != phys + len)
 				break;
+			pgsize = iommu_iova_to_pgsize(domain->domain,
+						      iova + len);
+			if (!pgsize)
+				pgsize = PAGE_SIZE;
 		}
 
 		/*
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index dd0edd02a48a..2f30ae73a9eb 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -251,6 +251,8 @@ struct pt_iommu_cfg {
 #define IOMMU_PROTOTYPES(fmt)                                                  \
 	phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *domain, \
 						  dma_addr_t iova);            \
+	size_t pt_iommu_##fmt##_iova_to_pgsize(struct iommu_domain *domain,    \
+					       dma_addr_t iova);               \
 	int pt_iommu_##fmt##_read_and_clear_dirty(                             \
 		struct iommu_domain *domain, unsigned long iova, size_t size,  \
 		unsigned long flags, struct iommu_dirty_bitmap *dirty);        \
@@ -272,6 +274,8 @@ struct pt_iommu_cfg {
  */
 #define IOMMU_PT_DOMAIN_OPS(fmt)                        \
 	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys
+#define IOMMU_PT_PGSIZE_OPS(fmt)                        \
+	.iova_to_pgsize = &pt_iommu_##fmt##_iova_to_pgsize
 #define IOMMU_PT_DIRTY_OPS(fmt) \
 	.read_and_clear_dirty = &pt_iommu_##fmt##_read_and_clear_dirty
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e587d4ac4d33..d04dc7dcfb1e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -776,6 +776,8 @@ struct iommu_domain_ops {
 
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain,
 				    dma_addr_t iova);
+	size_t (*iova_to_pgsize)(struct iommu_domain *domain,
+				 dma_addr_t iova);
 
 	bool (*enforce_cache_coherency)(struct iommu_domain *domain);
 	int (*set_pgtable_quirks)(struct iommu_domain *domain,
@@ -930,6 +932,7 @@ extern ssize_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 			    struct scatterlist *sg, unsigned int nents,
 			    int prot, gfp_t gfp);
 extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova);
+extern size_t iommu_iova_to_pgsize(struct iommu_domain *domain, dma_addr_t iova);
 extern void iommu_set_fault_handler(struct iommu_domain *domain,
 			iommu_fault_handler_t handler, void *token);
 
-- 
2.43.7

