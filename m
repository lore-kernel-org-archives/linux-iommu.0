Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564213438B2
	for <iommu@lists.linux.dev>; Sun, 31 May 2026 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780220222; cv=none; b=LDG15YetT1ZMggr7evKAitBMAVMZP0Mm60QIarGDkeEYBfjYZtzAqxlKx5kvExPRI+rhISmzBiPSbWRlLXWxAaJZDK0DiyPDop7ZcZTId2/hQLgeV4dl3oai+lm2kBoaLyI500QGBf4nMyeGU4AcTHctnAODDIYe3Kw4AnabjgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780220222; c=relaxed/simple;
	bh=iLQcwMf/oi8dHVQcgWWjIA6zHLhoK4I+57Up6+nLYJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIOmROiS7qws7IaYtrZLvTY4E30pMo2wltsOZxbbdkvUIScSarm7uZZS0KoVIlV+OQEURoNzNYYkfbAPiBl+9g3d/cAFX7lkiqzU9FP/bmLvKISNo1XQTxBPXjXAU/EYcswd3xhxNWHZDtriwXTWAv0wwdO57isrouCfz/5q4Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nOa4AsRY; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nOa4AsRY"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780220211; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ar0N90nh7aOdbVxftACZsIGW+S3DboQEhi1itlPEca8=;
	b=nOa4AsRYPIlSQmTF7ipwiiT7K/euo6c6Io9nBzdf5OQqr8Fpef4pn1EMYT7VZr7+Ag0zWq//YR+/S48I5Eu284BaaOG9cJHIuaSv8IspJJ8Ra1EdRxCvWLtt8b2+zb85fxkifFiBTeYSNMG2G/A+jIophHActe09QOUw9LX8S0Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0X3tRVpJ_1780220209;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X3tRVpJ_1780220209 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 31 May 2026 17:36:49 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: boris.brezillon@collabora.com,
	robh@kernel.org,
	steven.price@arm.com,
	adrian.larumbe@collabora.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	liviu.dudau@arm.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	alex@shazbot.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	suravee.suthikulpanit@amd.com,
	dwmw2@infradead.org
Cc: xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com,
	shiyu.zsq@linux.alibaba.com,
	wei.guo.simon@linux.alibaba.com
Subject: [PATCH 3/9] iommu/generic_pt: implement iova_to_phys_length
Date: Sun, 31 May 2026 17:36:31 +0800
Message-ID: <20260531093637.3893199-4-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the Generic Page Table framework to implement iova_to_phys_length.
Use pt_entry_oa_lg2sz() to determine PTE block size. Update
IOMMU_PT_DOMAIN_OPS macro to set .iova_to_phys_length.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Acked-by: Shiqiang Zhang <shiyu.zsq@linux.alibaba.com>
Acked-by: Simon Guo <wei.guo.simon@linux.alibaba.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 49 ++++++++++++++++++-----------
 include/linux/generic_pt/iommu.h    | 13 ++++----
 2 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index dc91fb4e2f61..b4213b4947f2 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -145,13 +145,18 @@ static inline unsigned int compute_best_pgsize(struct pt_state *pts,
 				      pts->range->va, pts->range->last_va, oa);
 }
 
-static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
-					     unsigned int level,
-					     struct pt_table_p *table,
-					     pt_level_fn_t descend_fn)
+struct iova_to_phys_length_data {
+	pt_oaddr_t phys;
+	size_t length;
+};
+
+static __always_inline int __do_iova_to_phys_length(struct pt_range *range,
+					       void *arg, unsigned int level,
+					       struct pt_table_p *table,
+					       pt_level_fn_t descend_fn)
 {
 	struct pt_state pts = pt_init(range, level, table);
-	pt_oaddr_t *res = arg;
+	struct iova_to_phys_length_data *data = arg;
 
 	switch (pt_load_single_entry(&pts)) {
 	case PT_ENTRY_EMPTY:
@@ -159,45 +164,51 @@ static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
 	case PT_ENTRY_TABLE:
 		return pt_descend(&pts, arg, descend_fn);
 	case PT_ENTRY_OA:
-		*res = pt_entry_oa_exact(&pts);
+		data->phys = pt_entry_oa_exact(&pts);
+		data->length = BIT(pt_entry_oa_lg2sz(&pts));
 		return 0;
 	}
 	return -ENOENT;
 }
-PT_MAKE_LEVELS(__iova_to_phys, __do_iova_to_phys);
+PT_MAKE_LEVELS(__iova_to_phys_length, __do_iova_to_phys_length);
 
 /**
- * iova_to_phys() - Return the output address for the given IOVA
+ * iova_to_phys_length() - Translate IOVA returning both phys and page size
  * @domain: Table to query
  * @iova: IO virtual address to query
+ * @mapped_length: Output for the PTE page size in bytes
  *
- * Determine the output address from the given IOVA. @iova may have any
- * alignment, the returned physical will be adjusted with any sub page offset.
+ * Walk the IOMMU page table to translate @iova to a physical address while
+ * also returning the page size of the PTE entry through @mapped_length.
+ * This combines iova_to_phys and page size query into a single page table walk.
  *
  * Context: The caller must hold a read range lock that includes @iova.
  *
- * Return: 0 if there is no translation for the given iova.
+ * Return: The physical address, or 0 if there is no translation.
  */
-phys_addr_t DOMAIN_NS(iova_to_phys)(struct iommu_domain *domain,
-				    dma_addr_t iova)
+phys_addr_t DOMAIN_NS(iova_to_phys_length)(struct iommu_domain *domain,
+					    dma_addr_t iova,
+					    size_t *mapped_length)
 {
 	struct pt_iommu *iommu_table =
 		container_of(domain, struct pt_iommu, domain);
 	struct pt_range range;
-	pt_oaddr_t res;
+	struct iova_to_phys_length_data data;
 	int ret;
 
 	ret = make_range(common_from_iommu(iommu_table), &range, iova, 1);
 	if (ret)
-		return ret;
+		return 0;
 
-	ret = pt_walk_range(&range, __iova_to_phys, &res);
-	/* PHYS_ADDR_MAX would be a better error code */
+	ret = pt_walk_range(&range, __iova_to_phys_length, &data);
 	if (ret)
 		return 0;
-	return res;
+
+	if (mapped_length)
+		*mapped_length = data.length;
+	return data.phys;
 }
-EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(iova_to_phys), "GENERIC_PT_IOMMU");
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(iova_to_phys_length), "GENERIC_PT_IOMMU");
 
 struct pt_iommu_dirty_args {
 	struct iommu_dirty_bitmap *dirty;
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index dd0edd02a48a..859b853e9dc7 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -249,8 +249,9 @@ struct pt_iommu_cfg {
 
 /* Generate the exported function signatures from iommu_pt.h */
 #define IOMMU_PROTOTYPES(fmt)                                                  \
-	phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *domain, \
-						  dma_addr_t iova);            \
+	phys_addr_t pt_iommu_##fmt##_iova_to_phys_length(			\
+		struct iommu_domain *domain, dma_addr_t iova,			\
+		size_t *mapped_length);						\
 	int pt_iommu_##fmt##_read_and_clear_dirty(                             \
 		struct iommu_domain *domain, unsigned long iova, size_t size,  \
 		unsigned long flags, struct iommu_dirty_bitmap *dirty);        \
@@ -267,11 +268,11 @@ struct pt_iommu_cfg {
 	IOMMU_PROTOTYPES(fmt)
 
 /*
- * A driver uses IOMMU_PT_DOMAIN_OPS to populate the iommu_domain_ops for the
- * iommu_pt
+ * A driver uses IOMMU_PT_DOMAIN_OPS to populate the iommu_domain_ops for
+ * the iommu_pt
  */
-#define IOMMU_PT_DOMAIN_OPS(fmt)                        \
-	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys
+#define IOMMU_PT_DOMAIN_OPS(fmt)					\
+	.iova_to_phys_length = &pt_iommu_##fmt##_iova_to_phys_length
 #define IOMMU_PT_DIRTY_OPS(fmt) \
 	.read_and_clear_dirty = &pt_iommu_##fmt##_read_and_clear_dirty
 
-- 
2.43.7

