Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.86
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792683980;
	b=oMxLUpo1zli7eXh0h61ANEMwaCxE8gQ3grlH3ututuryGJMpbHgpgkI5ckMCu5QM50vv
	 +aKtJ/Z7nBQ6D5jrPY8rHx/6g8LLQvOnLL8ssXwXb5S5G9BRq4DqbYX2OzkIKIkT6vLCA
	 yBJgtQ55rA925pqdTaF80DePy2ScOmsQD+uC3J4eFBo5pl04/SnqmdXEC0q9kBs06uz7r
	 f9B6IEVjREQW4AF+nCD375K7hHnxEeCk7KcQD6sOCviyeIkHBmwPw7ExC/KcpE7evcDEH
	 Z9fsSM9urLHOQBt9jkJ5iXD60jtPWXeIrs/TqyY0/eDp6swcwvQ+lIGSaNcODlXJ2bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683980;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=awem1wxMbcyoRN7ubasIU3CaNIFuN7/ulyonZUTWZ4k=;
	b=3cBVYdQdaYQ6PAnyvUfyF23i2VfVsoOm5fW9oSqEC85AyLsyVoQETH+y/g5R2k5cVkR8
	 kdHXTPD4GTsoq9w5GA4vm5zaO+FJh/4nLAScXyJ5ErGnB9W19k0f5HPYtyaaoBzTok0Ab
	 AMs+k2WBOcKP8Mdrdknu/vTVX9BFg67Cp1pzse0Kho0O0viS/cxj4Xhdr0SVYP5bKNqO2
	 jb7BhSoJm/lwVrO0B563c9MAQCYuEr0ipRKjIODQE/EzblGRggyy1Sa0MX7M1KKR1d7NN
	 PYXfNs5eAmTifid0ohXWfMa8tYSosnX4dgytWpflugeadBxAF3CRO6e27kX+KbVd50g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="MN/0h1wr";
	arc=none smtp.remote-ip=91.218.175.86
Received: from mta0.migadu.com (out-86.mta0.migadu.com [91.218.175.86])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3460C606A31E
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 15:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3460C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MN/0h1wr
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=+Zvwp7hLV/ADvXBOoul5gX9Gn2k4qOEGVrRqgWa9+gc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792683977; v=1; x=1793288777;
 b=MN/0h1wrhfPzbrIvz4ys54KKaKEQt2MVwyzomN0P7fCWpjn4gfWRB0GEfy6HOXm0v5WqvjO6
 v5BUwoHkqNEOlhMDalV/BzNOn+7KOV/3Yw/jpg3DT5rCDn8bGfby+IJ8eAPWac/AFkuz7Pre4bU
 Nlnk2MLZPaLhVzcUdgcXEdZI=
X-Envelope-To: iommu@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id ae35e2396c30716c;
	Thu, 22 Oct 2026 15:46:17 +0000
X-Mizu-Trace-ID: ae35e2396c30716c
X-Migadu-Flow: FLOW_OUT
From: Andrew Jones <andrew.jones@linux.dev>
To: linux-riscv@lists.infradead.org,
	iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	tomasz.jeznach@linux.dev,
	jgg@ziepe.ca,
	jgg@nvidia.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	anup@brainfault.org,
	tglx@kernel.org,
	kevin.tian@intel.com,
	fangyu.yu@linux.alibaba.com,
	nutty.liu@hotmail.com
Subject: [PATCH v7 1/5] iommu/dma: Prepare MSI physical address lists
Date: Thu, 22 Oct 2026 17:45:59 +0200
Message-ID: <20261022154603.1374754-2-andrew.jones@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022154603.1374754-1-andrew.jones@linux.dev>
References: <20261022154603.1374754-1-andrew.jones@linux.dev>
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

IMSIC affinity changes need every possible target mapped. Introduce
iommu_dma_sw_msi_list() to cache one contiguous IOVA range base for
a list of targets.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
---
 drivers/iommu/dma-iommu.c | 77 +++++++++++++++++++++++++++++++++++----
 drivers/iommu/dma-iommu.h | 10 +++++
 2 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 1f624f241ac1..1046b19be584 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -59,6 +59,8 @@ struct iommu_dma_options {
 struct iommu_dma_cookie {
 	struct iova_domain iovad;
 	struct list_head msi_page_list;
+	/* Base IOVA of the complete MSI target list */
+	dma_addr_t msi_list_iova;
 	/* Flush queue */
 	union {
 		struct iova_fq *single_fq;
@@ -2204,13 +2206,42 @@ static struct list_head *cookie_msi_pages(const struct iommu_domain *domain)
 	}
 }
 
+static dma_addr_t iommu_dma_alloc_msi_iova(struct device *dev, struct iommu_domain *domain,
+					   const phys_addr_t *phys_addrs,
+					   unsigned int nr_addrs, size_t granule)
+{
+	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
+	size_t size = nr_addrs * granule;
+	dma_addr_t iova;
+	unsigned int i;
+
+	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
+	if (!iova)
+		return 0;
+
+	for (i = 0; i < nr_addrs; i++) {
+		if (iommu_map(domain, iova + i * granule, phys_addrs[i], granule,
+			      prot, GFP_KERNEL))
+			goto out_unmap;
+	}
+	return iova;
+
+out_unmap:
+	if (i) {
+		size_t mapped = i * granule;
+
+		WARN_ON_ONCE(iommu_unmap(domain, iova, mapped) != mapped);
+	}
+	iommu_dma_free_iova(domain, iova, size, NULL);
+	return 0;
+}
+
 static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 		phys_addr_t msi_addr, struct iommu_domain *domain)
 {
 	struct list_head *msi_page_list = cookie_msi_pages(domain);
 	struct iommu_dma_msi_page *msi_page;
 	dma_addr_t iova;
-	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 	size_t size = cookie_msi_granule(domain);
 	static DEFINE_MUTEX(msi_prepare_lock);
 
@@ -2235,21 +2266,16 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	if (!msi_page)
 		return NULL;
 
-	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
+	iova = iommu_dma_alloc_msi_iova(dev, domain, &msi_addr, 1, size);
 	if (!iova)
 		goto out_free_page;
 
-	if (iommu_map(domain, iova, msi_addr, size, prot, GFP_KERNEL))
-		goto out_free_iova;
-
 	INIT_LIST_HEAD(&msi_page->list);
 	msi_page->phys = msi_addr;
 	msi_page->iova = iova;
 	list_add(&msi_page->list, msi_page_list);
 	return msi_page;
 
-out_free_iova:
-	iommu_dma_free_iova(domain, iova, size, NULL);
 out_free_page:
 	kfree(msi_page);
 	return NULL;
@@ -2271,6 +2297,43 @@ int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 	return 0;
 }
 
+/*
+ * All calls for a DMA domain must supply the same complete target list.
+ * The group mutex serializes creation and reuse of the cached mapping.
+ */
+int iommu_dma_sw_msi_list(struct iommu_domain *domain, struct msi_desc *desc,
+			  const phys_addr_t *phys_addrs, unsigned int nr_addrs,
+			  size_t granule)
+{
+	struct device *dev = msi_desc_to_dev(desc);
+	struct iommu_dma_cookie *cookie;
+	unsigned int i;
+
+	iommu_group_mutex_assert(dev);
+	if (domain->cookie_type != IOMMU_COOKIE_DMA_IOVA)
+		return -EOPNOTSUPP;
+
+	cookie = domain->iova_cookie;
+	if (granule < PAGE_SIZE || granule != cookie->iovad.granule)
+		return -EOPNOTSUPP;
+	if (!nr_addrs || nr_addrs > SIZE_MAX / granule)
+		return -EINVAL;
+
+	if (!cookie->msi_list_iova) {
+		for (i = 0; i < nr_addrs; i++)
+			if (!IS_ALIGNED(phys_addrs[i], granule))
+				return -EINVAL;
+
+		cookie->msi_list_iova = iommu_dma_alloc_msi_iova(dev, domain, phys_addrs,
+								 nr_addrs, granule);
+		if (!cookie->msi_list_iova)
+			return -ENOMEM;
+	}
+
+	msi_desc_set_iommu_msi_iova(desc, cookie->msi_list_iova, ilog2(granule));
+	return 0;
+}
+
 static int iommu_dma_init(void)
 {
 	if (is_kdump_kernel())
diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
index 040d00252563..2a36ed736910 100644
--- a/drivers/iommu/dma-iommu.h
+++ b/drivers/iommu/dma-iommu.h
@@ -21,6 +21,9 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
 int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 		     phys_addr_t msi_addr);
+int iommu_dma_sw_msi_list(struct iommu_domain *domain, struct msi_desc *desc,
+			  const phys_addr_t *phys_addrs, unsigned int nr_addrs,
+			  size_t granule);
 
 extern bool iommu_dma_forcedac;
 
@@ -59,5 +62,12 @@ static inline int iommu_dma_sw_msi(struct iommu_domain *domain,
 	return -ENODEV;
 }
 
+static inline int iommu_dma_sw_msi_list(struct iommu_domain *domain, struct msi_desc *desc,
+					const phys_addr_t *phys_addrs, unsigned int nr_addrs,
+					size_t granule)
+{
+	return -ENODEV;
+}
+
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __DMA_IOMMU_H */
-- 
2.56.0

