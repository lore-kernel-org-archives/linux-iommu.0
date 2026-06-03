Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2073AD511
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499927; cv=none; b=FGIX1bBDSZX0gVH3o/VtmwXp57oCViI5KrFT36pTG9jcSPYhv8fix3yJJ0c7Hqhr9UyTZ0al0FK9Z7rp8NjaY5dVoXWzxT4fb+Y44Eqw5rvafKb5N63fC6XQhT8VlBvBNOWTBoVM+71H7KsBIdpk2CE4Z6+QinNyeGVXup8hu9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499927; c=relaxed/simple;
	bh=48mjsitOr3Z/m7oLuZcBEFl3hR3k2gCTIjH3KGTtgeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYZf80OhUZW4j40x5wYYRttdwilGBBUxxTnpe//z8oLn1hUol74ei8UCgD0LVFw4jxMmCReANzNZl5BEY2T+muMdwA4yJmIIBkNkQMdkzJ9pSFToTzgEycxU0G3AJlqckyWB4GkpvxsA4r09V/mh8Jjrz2M9XNmiDYr4vPfXSpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Li35YIm1; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Li35YIm1"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780499922; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=bNxex+pO0MrYJpvCBggj4Mk1SXXB71J1utBey15cQ0s=;
	b=Li35YIm1TdCOVdK7wejcGydlm2Lw2Jflmwz1H7WHN6I49ZbSlQbD2DlRHoqflUQZu0YNY52xDN9xLyIICP50ayy+Jm7C9XHcGTu+EQA6JZ4QKQpN96LibRBoywk84/3ayPEuR4PS3JBfyXzxQw+0mFfJz19QJ85CoN1wJDAA3wk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X47fR16_1780499920;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X47fR16_1780499920 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 23:18:40 +0800
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
Subject: [PATCH v3 02/32] iommu/io-pgtable-arm: introduce iova_to_phys_length in io_pgtable_ops
Date: Wed,  3 Jun 2026 23:17:34 +0800
Message-ID: <20260603151804.1963871-3-guanghuifeng@linux.alibaba.com>
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

Add iova_to_phys_length to struct io_pgtable_ops alongside iova_to_phys.
Implement in ARM LPAE backend: returns ARM_LPAE_BLOCK_SIZE at the resolved level.
The old iova_to_phys is kept as a thin wrapper for backward compat.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/io-pgtable-arm.c | 23 +++++++++++++++++++++--
 include/linux/io-pgtable.h     |  7 +++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 0208e5897c29..f33a86fa0f6c 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -731,8 +731,21 @@ static int visit_iova_to_phys(struct io_pgtable_walk_data *walk_data, int lvl,
 	return 0;
 }
 
+static phys_addr_t arm_lpae_iova_to_phys_length(struct io_pgtable_ops *ops,
+						 unsigned long iova,
+						 size_t *mapped_length);
+
 static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 					 unsigned long iova)
+{
+	phys_addr_t phys = arm_lpae_iova_to_phys_length(ops, iova, NULL);
+
+	return (phys == PHYS_ADDR_MAX) ? 0 : phys;
+}
+
+static phys_addr_t arm_lpae_iova_to_phys_length(struct io_pgtable_ops *ops,
+						 unsigned long iova,
+						 size_t *mapped_length)
 {
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	struct iova_to_phys_data d;
@@ -742,13 +755,18 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 		.addr = iova,
 		.end = iova + 1,
 	};
+	size_t block_size;
 	int ret;
 
 	ret = __arm_lpae_iopte_walk(data, &walk_data, data->pgd, data->start_level);
 	if (ret)
-		return 0;
+		return PHYS_ADDR_MAX;
+
+	block_size = ARM_LPAE_BLOCK_SIZE(d.lvl, data);
+	if (mapped_length)
+		*mapped_length = block_size;
 
-	iova &= (ARM_LPAE_BLOCK_SIZE(d.lvl, data) - 1);
+	iova &= (block_size - 1);
 	return iopte_to_paddr(d.pte, data) | iova;
 }
 
@@ -948,6 +966,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 		.map_pages	= arm_lpae_map_pages,
 		.unmap_pages	= arm_lpae_unmap_pages,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
+		.iova_to_phys_length	= arm_lpae_iova_to_phys_length,
 		.read_and_clear_dirty = arm_lpae_read_and_clear_dirty,
 		.pgtable_walk	= arm_lpae_pgtable_walk,
 	};
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index e19872e37e06..42bcdd309b88 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -203,6 +203,10 @@ struct arm_lpae_io_pgtable_walk_data {
  * @map_pages:    Map a physically contiguous range of pages of the same size.
  * @unmap_pages:  Unmap a range of virtually contiguous pages of the same size.
  * @iova_to_phys: Translate iova to physical address.
+ * @iova_to_phys_length: Translate iova to physical address and return the
+ *			  remaining mapped length from iova to the end of the
+ *			  mapping entry via @mapped_length. If @mapped_length is
+ *			  NULL, only the physical address is returned.
  * @pgtable_walk: (optional) Perform a page table walk for a given iova.
  * @read_and_clear_dirty: Record dirty info per IOVA. If an IOVA is dirty,
  *			  clear its dirty state from the PTE unless the
@@ -220,6 +224,9 @@ struct io_pgtable_ops {
 			      struct iommu_iotlb_gather *gather);
 	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
 				    unsigned long iova);
+	phys_addr_t (*iova_to_phys_length)(struct io_pgtable_ops *ops,
+					   unsigned long iova,
+					   size_t *mapped_length);
 	int (*pgtable_walk)(struct io_pgtable_ops *ops, unsigned long iova, void *wd);
 	int (*read_and_clear_dirty)(struct io_pgtable_ops *ops,
 				    unsigned long iova, size_t size,
-- 
2.43.7

