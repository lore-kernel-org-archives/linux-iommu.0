Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224E43D890F
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499931; cv=none; b=Godh6l//To+j5I8ArhJTKpp/zCm0DoL7bu9rA/1dd10jOn7kjsBL9M3/7M2RI8cpRLbVVj1TiRGD2dQsJOwSlxArvvZMSr/aCrUrjfaVc13WWeItGRPCHiIUyaqpiJpGptV2/Twg8UVZ+fH3Mktm1y9XGbTBA3QKDOtH19nZkdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499931; c=relaxed/simple;
	bh=bIq9juZEAtQN8VshQ440y/z3G7luRjx1A5ifI0XHzEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbrYvQZM67hFApYbrckOqrvvXWRI/tQ3OYE5E0t2aQQdw4jvxybOd4Flf7KxSHv6Dqk+BIsyjwgwyIDy49n5XcOhdpnJ/ulDMzd4E6IeBrz4iIZjhz4s3Sel1CsaHBqH9N+1gD1hNBp3veu5Ia6H1VySyrKY+6aYUuso6cmBU5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QpB3FupK; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QpB3FupK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780499926; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=pzHjh+jwVoHwjthiqpzHxMzEqV3gkG9mTeHPbbZ5Xck=;
	b=QpB3FupKyrYow+2o2GFImvU7yUQGM82S6FC4IYziPrdGXTbC7FCBhp9RE59IA9RJg14v4K+PXnItPulhHM184OFK4geBJbYCX2Fe/aWeOzP64V0HQ52xLx8Nan9nLRkv/X4m7dlwPNIKalVFFfLxJ/BYfOd778kJ2zRBAF7f/fo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X47fR1x_1780499923;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X47fR1x_1780499923 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 23:18:43 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: jgg@ziepe.ca
Cc: adrian.larumbe@collabora.com,
	airlied@gmail.com,
	alex@shazbot.org,
	alikernel-developer@linux.alibaba.com,
	baolu.lu@linux.intel.com,
	boris.brezillon@collabora.com,
	dri-devel@lists.freedesktop.org,
	dwmw2@infradead.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	kevin.tian@intel.com,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	oliver.yang@linux.alibaba.com,
	robh@kernel.org,
	robin.murphy@arm.com,
	shiyu.zsq@linux.alibaba.com,
	steven.price@arm.com,
	suravee.suthikulpanit@amd.com,
	tzimmermann@suse.de,
	wei.guo.simon@linux.alibaba.com,
	will@kernel.org,
	xlpang@linux.alibaba.com
Subject: [PATCH v3 05/32] iommu/generic_pt: implement iova_to_phys_length
Date: Wed,  3 Jun 2026 23:17:37 +0800
Message-ID: <20260603151804.1963871-6-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
References: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
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
 drivers/iommu/generic_pt/iommu_pt.h | 84 +++++++++++++++++++++--------
 include/linux/generic_pt/iommu.h    | 13 ++---
 2 files changed, 69 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index dc91fb4e2f61..e362e819ef9c 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -145,13 +145,21 @@ static inline unsigned int compute_best_pgsize(struct pt_state *pts,
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
+	unsigned int entry_lg2sz;
+	size_t entry_sz;
+	pt_oaddr_t expected_oa;
 
 	switch (pt_load_single_entry(&pts)) {
 	case PT_ENTRY_EMPTY:
@@ -159,45 +167,77 @@ static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
 	case PT_ENTRY_TABLE:
 		return pt_descend(&pts, arg, descend_fn);
 	case PT_ENTRY_OA:
-		*res = pt_entry_oa_exact(&pts);
-		return 0;
+		break;
 	}
-	return -ENOENT;
+
+	data->phys = pt_entry_oa_exact(&pts);
+	entry_lg2sz = pt_entry_oa_lg2sz(&pts);
+	entry_sz = log2_to_int(entry_lg2sz);
+
+	/* Start with the full mapping size of the first entry */
+	data->length = entry_sz;
+
+	/* Accumulate subsequent physically contiguous entries */
+	expected_oa = pt_entry_oa(&pts) + entry_sz;
+	pts.end_index = log2_to_int(pt_num_items_lg2(&pts));
+	pt_next_entry(&pts);
+
+	while (pts.index < pts.end_index) {
+		pt_load_entry(&pts);
+		if (pts.type != PT_ENTRY_OA)
+			break;
+		if (pt_entry_oa_lg2sz(&pts) != entry_lg2sz)
+			break;
+		if (pt_entry_oa(&pts) != expected_oa)
+			break;
+		data->length += entry_sz;
+		expected_oa += entry_sz;
+		pt_next_entry(&pts);
+	}
+
+	return 0;
 }
-PT_MAKE_LEVELS(__iova_to_phys, __do_iova_to_phys);
+PT_MAKE_LEVELS(__iova_to_phys_length, __do_iova_to_phys_length);
 
 /**
- * iova_to_phys() - Return the output address for the given IOVA
+ * iova_to_phys_length() - Translate IOVA returning phys and contiguous length
  * @domain: Table to query
  * @iova: IO virtual address to query
+ * @mapped_length: Output for the total contiguous mapped length in bytes
  *
- * Determine the output address from the given IOVA. @iova may have any
- * alignment, the returned physical will be adjusted with any sub page offset.
+ * Walk the IOMMU page table to translate @iova to a physical address while
+ * also returning the total contiguous physically mapped length through
+ * @mapped_length. The function accumulates consecutive page table entries that
+ * are physically contiguous, so callers can determine the full contiguous
+ * mapping extent with a single call.
  *
  * Context: The caller must hold a read range lock that includes @iova.
  *
- * Return: 0 if there is no translation for the given iova.
+ * Return: The physical address, or PHYS_ADDR_MAX if there is no translation.
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
+		return PHYS_ADDR_MAX;
 
-	ret = pt_walk_range(&range, __iova_to_phys, &res);
-	/* PHYS_ADDR_MAX would be a better error code */
+	ret = pt_walk_range(&range, __iova_to_phys_length, &data);
 	if (ret)
-		return 0;
-	return res;
+		return PHYS_ADDR_MAX;
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

