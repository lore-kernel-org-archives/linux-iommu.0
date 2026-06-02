Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77203F4DF1
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397246; cv=none; b=UDhr2wl9/daZzqpC38koJt2arS9FFBRwlhIJUXcWzH4fMcjvPhHL3ENdOy5xEHs9x4h3uwu+kc0cb6k81jqIhFIlpk+85yi74dWMvweGBosj0RRBNr/ayY1ExRL6u1mqehTTBcHAuVAkWkFU+q6nfdAEgbBvIYGYRYKsoWVZA5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397246; c=relaxed/simple;
	bh=PagqwuURg6QVN0GrgNjlzYiRes/u+xXO+F6V0jHmYzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMeADZuW+RrYqouhLRMUcgXzOEaQTQ3PLR9LYN9DI+RCtoj1wCR7oRiI8BYqtdMB4w+AUWFKeWWi6hzFdamyNwu/qhFAeb/7F9WseZAP6GvR9cvJV6eCIsjBvTNPHKgsmF4o6keR86Dke3SKiSlRM8ej8idrp8dp0QsKAo56tSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ihGLi8gI; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ihGLi8gI"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780397242; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=C15FwabaXicb3m5vf4ClTn8uJ1VB2DMgTV11Lw9ohJo=;
	b=ihGLi8gIiW1yBmCCnFiA546N2d5LHtMsAHblI3+5TirKzUHd3xcj/2ykZtkIMUvQe7qxD71xjiSh21s9+In9XPMJ1UxNkfsAhwMy2IilEMjzuSjPeFCQodoMFa/vF00lR2HIbIinPGc8k1xfD6UpPDWJZKNc7SbYxOMO/lVpmOw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X44E9AA_1780397237;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X44E9AA_1780397237 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 18:47:18 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: adrian.larumbe@collabora.com,
	airlied@gmail.com,
	alex@shazbot.org,
	baolu.lu@linux.intel.com,
	boris.brezillon@collabora.com,
	dri-devel@lists.freedesktop.org,
	dwmw2@infradead.org,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
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
Cc: alikernel-developer@linux.alibaba.com
Subject: [PATCH v2 30/30] iommu: remove iova_to_phys from domain_ops and io_pgtable_ops
Date: Tue,  2 Jun 2026 18:46:37 +0800
Message-ID: <20260602104637.1219810-31-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
References: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that all drivers implement iova_to_phys_length and all callers
have migrated, remove the deprecated interfaces:

- Remove .iova_to_phys from struct iommu_domain_ops
- Remove .iova_to_phys from struct io_pgtable_ops
- Remove fallback path in iommu_iova_to_phys_length()
- iommu_iova_to_phys() remains as a thin wrapper calling _length with NULL

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/iommu.c      | 12 ++----------
 include/linux/io-pgtable.h |  3 ---
 include/linux/iommu.h      |  3 ---
 3 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1b1aaa53dd16..84893d4c7c60 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2554,7 +2554,7 @@ EXPORT_SYMBOL_GPL(iommu_detach_group);
  * Like iommu_iova_to_phys() but additionally returns the page size of the
  * PTE mapping at @iova through @mapped_length.
  *
- * Return: The physical address for the given IOVA, or PHYS_ADDR_MAX if no translation.
+ * Return: The physical address for the given IOVA, or 0 if no translation.
  */
 phys_addr_t iommu_iova_to_phys_length(struct iommu_domain *domain,
 				       dma_addr_t iova,
@@ -2566,16 +2566,8 @@ phys_addr_t iommu_iova_to_phys_length(struct iommu_domain *domain,
 	if (domain->type == IOMMU_DOMAIN_IDENTITY)
 		return iova;
 
-	if (!domain->ops->iova_to_phys_length) {
-		/* Fallback to legacy iova_to_phys without length info */
-		if (domain->ops->iova_to_phys) {
-			phys_addr_t phys = domain->ops->iova_to_phys(domain, iova);
-			if (phys && mapped_length)
-				*mapped_length = PAGE_SIZE;
-			return phys ? phys : PHYS_ADDR_MAX;
-		}
+	if (!domain->ops->iova_to_phys_length)
 		return PHYS_ADDR_MAX;
-	}
 
 	return domain->ops->iova_to_phys_length(domain, iova, mapped_length);
 }
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 42bcdd309b88..c595f5b51e61 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -202,7 +202,6 @@ struct arm_lpae_io_pgtable_walk_data {
  *
  * @map_pages:    Map a physically contiguous range of pages of the same size.
  * @unmap_pages:  Unmap a range of virtually contiguous pages of the same size.
- * @iova_to_phys: Translate iova to physical address.
  * @iova_to_phys_length: Translate iova to physical address and return the
  *			  remaining mapped length from iova to the end of the
  *			  mapping entry via @mapped_length. If @mapped_length is
@@ -222,8 +221,6 @@ struct io_pgtable_ops {
 	size_t (*unmap_pages)(struct io_pgtable_ops *ops, unsigned long iova,
 			      size_t pgsize, size_t pgcount,
 			      struct iommu_iotlb_gather *gather);
-	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
-				    unsigned long iova);
 	phys_addr_t (*iova_to_phys_length)(struct io_pgtable_ops *ops,
 					   unsigned long iova,
 					   size_t *mapped_length);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 19da84c2922c..ca585647180b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -746,7 +746,6 @@ struct iommu_ops {
  *                         array->entry_num to report the number of handled
  *                         invalidation requests. The driver data structure
  *                         must be defined in include/uapi/linux/iommufd.h
- * @iova_to_phys: translate iova to physical address
  * @iova_to_phys_length: translate iova to physical address and additionally
  *                       return the page size of the PTE mapping at @iova
  *                       through @mapped_length.
@@ -777,8 +776,6 @@ struct iommu_domain_ops {
 	int (*cache_invalidate_user)(struct iommu_domain *domain,
 				     struct iommu_user_data_array *array);
 
-	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain,
-				    dma_addr_t iova);
 	phys_addr_t (*iova_to_phys_length)(struct iommu_domain *domain,
 					    dma_addr_t iova,
 					    size_t *mapped_length);
-- 
2.43.7

