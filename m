Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26C63D333A
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499934; cv=none; b=kC3UKL+PmdX4fyZ2C9uKgH4tMDMfV42wWahkdnicX4x3GU5AL+z/7nbSqD9se8/t6Fqd0cvpofYWME7zTT/SAyei8kgJpr3UKYOAC0zdowMutn2jcFEY+F4CLMu6NwCu1eGNtJWil5RZYo0p3DTxCiypm0+glaWdKAgGE4f0lgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499934; c=relaxed/simple;
	bh=YqTLlp4rQ5N80NTs3rOrlqQxzoKiBhSW5JW4kktMGXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6dqUDDawezsoOe48tHl5kFf11h0bDC84H089RvjGcC8Dg1JdxOJ74hyXHi/7f9DlKoNcXk9VglOL5DjppQ1ZuLGXmlT8+vx0rRxr8q6hwtlS+nRSXnAXceHBgYx2I40ukjG6HIm/kUocbX2YpuT6UDwO2XpG/LjruSB7sik7K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=c9wDNKVy; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="c9wDNKVy"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780499924; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=5K9kQ+7O2to9AMrCCxHb12XQWSw4xjjz1YrQKtCPM08=;
	b=c9wDNKVyh6CUp50BD1q43dV2vGm9+vjuQod3i5xEQ7UuVXL+7fVS787uSqpSpXjWfUGO0GyHXPuozT300VndBfxM2oh6AY+SauiX/jPVya6YXR/aHjdByi1Za46iXWPyyVnGZ9BhvxSwMU3hUjgUA59OO7IShh0KbLSzcFtwNAQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X47fR1m_1780499922;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X47fR1m_1780499922 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 23:18:42 +0800
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
Subject: [PATCH v3 04/32] iommu/io-pgtable-dart: introduce iova_to_phys_length in io_pgtable_ops
Date: Wed,  3 Jun 2026 23:17:36 +0800
Message-ID: <20260603151804.1963871-5-guanghuifeng@linux.alibaba.com>
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

Implement iova_to_phys_length in DART backend: returns pgsize from
cfg.pgsize_bitmap (single fixed page size). The old iova_to_phys is kept
as a thin wrapper.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/io-pgtable-dart.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/io-pgtable-dart.c b/drivers/iommu/io-pgtable-dart.c
index cbc5d6aa2daa..2dac21a578a7 100644
--- a/drivers/iommu/io-pgtable-dart.c
+++ b/drivers/iommu/io-pgtable-dart.c
@@ -333,29 +333,46 @@ static size_t dart_unmap_pages(struct io_pgtable_ops *ops, unsigned long iova,
 	return i * pgsize;
 }
 
+static phys_addr_t dart_iova_to_phys_length(struct io_pgtable_ops *ops,
+					    unsigned long iova,
+					    size_t *mapped_length);
+
 static phys_addr_t dart_iova_to_phys(struct io_pgtable_ops *ops,
-					 unsigned long iova)
+				     unsigned long iova)
+{
+	phys_addr_t phys = dart_iova_to_phys_length(ops, iova, NULL);
+
+	return (phys == PHYS_ADDR_MAX) ? 0 : phys;
+}
+
+static phys_addr_t dart_iova_to_phys_length(struct io_pgtable_ops *ops,
+					    unsigned long iova,
+					    size_t *mapped_length)
 {
 	struct dart_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	dart_iopte pte, *ptep;
+	size_t pgsize;
 
 	ptep = dart_get_last(data, iova);
 
 	/* Valid L2 IOPTE pointer? */
 	if (!ptep)
-		return 0;
+		return PHYS_ADDR_MAX;
 
 	ptep += dart_get_last_index(data, iova);
 
 	pte = READ_ONCE(*ptep);
 	/* Found translation */
 	if (pte) {
-		iova &= (data->iop.cfg.pgsize_bitmap - 1);
+		pgsize = data->iop.cfg.pgsize_bitmap;
+		if (mapped_length)
+			*mapped_length = pgsize;
+		iova &= (pgsize - 1);
 		return iopte_to_paddr(pte, data) | iova;
 	}
 
 	/* Ran out of page tables to walk */
-	return 0;
+	return PHYS_ADDR_MAX;
 }
 
 static struct dart_io_pgtable *
@@ -397,9 +414,10 @@ dart_alloc_pgtable(struct io_pgtable_cfg *cfg)
 	data->bits_per_level = bits_per_level;
 
 	data->iop.ops = (struct io_pgtable_ops) {
-		.map_pages	= dart_map_pages,
-		.unmap_pages	= dart_unmap_pages,
-		.iova_to_phys	= dart_iova_to_phys,
+		.map_pages		= dart_map_pages,
+		.unmap_pages		= dart_unmap_pages,
+		.iova_to_phys		= dart_iova_to_phys,
+		.iova_to_phys_length	= dart_iova_to_phys_length,
 	};
 
 	return data;
-- 
2.43.7

