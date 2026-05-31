Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15D4357D08
	for <iommu@lists.linux.dev>; Sun, 31 May 2026 09:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780220224; cv=none; b=HHpsh99yePvjEonpz896aT90IdjIg5RXvp4T6c2BLr7kLiQYbal89ESWm7S+b/gaUvkzSUE8jJp16T3TA2KVVnytKISNcXTFi9wmWVCvOxTuF5UfEOYuA+fiGDYikcbATE+QBqg2yRy2q134u6YejScYZWJ5fSCRtaO3vr8jjsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780220224; c=relaxed/simple;
	bh=dpZfE/1w5bMY1F/GliYe4MvlNQ04qZxnTIF0/TWqsuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOoY1hkxMXr7FkbKQIqh+4l3CDmYnla4L6pQ2PHTO9RIViRjT0GXTwT1fd9I85N8iDF7He94fv9QdHiwssgP8vNg85K7ycnJWec0oK4+fjCOsBmlhUysoHjnCdn6ve6CrpV4k5Zh7yV/6ILKfV/Y3YzNxHXFOUdZP6KtImnlF/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SYhrY8WR; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SYhrY8WR"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780220213; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=I124MUpdjyzqPwiXiO9Q5adcwpM3fxbXILO13MSKRkI=;
	b=SYhrY8WRXlNfSKkAkVNs7LPlhUmqR2iwa/jDSI+NAqdf9xQhG+QPUPRHeMq4Ka1WNul2RhzFGjYg6Rk2rDisowNbHM+PyZ+mHl7xlcy5ThfmavIruiwwapwXbuH6CbLUlu/hRB/B/fGKJ0TqHBRNoi/RII+Ej0UFY+7Wagpd5Ls=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0X3tRVpy_1780220211;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X3tRVpy_1780220211 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 31 May 2026 17:36:51 +0800
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
Subject: [PATCH 5/9] iommu: apple-dart/ipmmu/mtk_iommu implement iova_to_phys_length
Date: Sun, 31 May 2026 17:36:33 +0800
Message-ID: <20260531093637.3893199-6-guanghuifeng@linux.alibaba.com>
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

Migrate remaining io-pgtable user drivers to implement
iova_to_phys_length, passing through mapped_length from io-pgtable.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Acked-by: Shiqiang Zhang <shiyu.zsq@linux.alibaba.com>
Acked-by: Simon Guo <wei.guo.simon@linux.alibaba.com>
---
 drivers/iommu/apple-dart.c | 11 +++++++----
 drivers/iommu/ipmmu-vmsa.c | 12 ++++++++----
 drivers/iommu/mtk_iommu.c  | 12 ++++++++----
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 17bdadb6b504..6f78bd28cee7 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -528,16 +528,19 @@ static int apple_dart_iotlb_sync_map(struct iommu_domain *domain,
 	return 0;
 }
 
-static phys_addr_t apple_dart_iova_to_phys(struct iommu_domain *domain,
-					   dma_addr_t iova)
+static phys_addr_t apple_dart_iova_to_phys_length(struct iommu_domain *domain,
+					   dma_addr_t iova, size_t *mapped_length)
 {
 	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
 	struct io_pgtable_ops *ops = dart_domain->pgtbl_ops;
 
+	if (mapped_length)
+		*mapped_length = 0;
+
 	if (!ops)
 		return 0;
 
-	return ops->iova_to_phys(ops, iova);
+	return ops->iova_to_phys_length(ops, iova, mapped_length);
 }
 
 static int apple_dart_map_pages(struct iommu_domain *domain, unsigned long iova,
@@ -1018,7 +1021,7 @@ static const struct iommu_ops apple_dart_iommu_ops = {
 		.flush_iotlb_all = apple_dart_flush_iotlb_all,
 		.iotlb_sync	= apple_dart_iotlb_sync,
 		.iotlb_sync_map	= apple_dart_iotlb_sync_map,
-		.iova_to_phys	= apple_dart_iova_to_phys,
+		.iova_to_phys_length = apple_dart_iova_to_phys_length,
 		.free		= apple_dart_domain_free,
 	}
 };
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9386b752dea2..a1b659ddbdb5 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -699,14 +699,18 @@ static void ipmmu_iotlb_sync(struct iommu_domain *io_domain,
 	ipmmu_flush_iotlb_all(io_domain);
 }
 
-static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
-				      dma_addr_t iova)
+static phys_addr_t ipmmu_iova_to_phys_length(struct iommu_domain *io_domain,
+				      dma_addr_t iova, size_t *mapped_length)
 {
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 
+	if (mapped_length)
+		*mapped_length = 0;
+
 	/* TODO: Is locking needed ? */
 
-	return domain->iop->iova_to_phys(domain->iop, iova);
+	return domain->iop->iova_to_phys_length(domain->iop, iova,
+						mapped_length);
 }
 
 static int ipmmu_init_platform_device(struct device *dev,
@@ -892,7 +896,7 @@ static const struct iommu_ops ipmmu_ops = {
 		.unmap_pages	= ipmmu_unmap,
 		.flush_iotlb_all = ipmmu_flush_iotlb_all,
 		.iotlb_sync	= ipmmu_iotlb_sync,
-		.iova_to_phys	= ipmmu_iova_to_phys,
+		.iova_to_phys_length = ipmmu_iova_to_phys_length,
 		.free		= ipmmu_domain_free,
 	}
 };
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 2be990c108de..214cab76e853 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -858,13 +858,17 @@ static int mtk_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
 	return 0;
 }
 
-static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
-					  dma_addr_t iova)
+static phys_addr_t mtk_iommu_iova_to_phys_length(struct iommu_domain *domain,
+					  dma_addr_t iova, size_t *mapped_length)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 	phys_addr_t pa;
 
-	pa = dom->iop->iova_to_phys(dom->iop, iova);
+	if (mapped_length)
+		*mapped_length = 0;
+
+	pa = dom->iop->iova_to_phys_length(dom->iop, iova, mapped_length);
+
 	if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT) &&
 	    dom->bank->parent_data->enable_4GB &&
 	    pa >= MTK_IOMMU_4GB_MODE_REMAP_BASE)
@@ -1070,7 +1074,7 @@ static const struct iommu_ops mtk_iommu_ops = {
 		.flush_iotlb_all = mtk_iommu_flush_iotlb_all,
 		.iotlb_sync	= mtk_iommu_iotlb_sync,
 		.iotlb_sync_map	= mtk_iommu_sync_map,
-		.iova_to_phys	= mtk_iommu_iova_to_phys,
+		.iova_to_phys_length = mtk_iommu_iova_to_phys_length,
 		.free		= mtk_iommu_domain_free,
 	}
 };
-- 
2.43.7

