Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D904481AB2
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 15:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499944; cv=none; b=sTSy2vIgq25zBaU2jg20aBlbnrHxbjSccPpNkyLdbr0QKFuOHggXJl3aRIAz9GB5C8RCP/hZBsd+DU7C70WefVMM6i0TUMB0f+poT1h4IoiLzA5m9teeNA1oiA2rCheY9Zr93pWgQDOUDug1XKgYYJ/63/bb55j1+Eldh+2/Hz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499944; c=relaxed/simple;
	bh=h0+03EBCv46lquOgLssQME5RC4lnmnLdmS8eP77X4L8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNtO3XWPdOtPtS+mtmCq387UZRDR6WVYqFQ9cI4YVseOZGq5mXEOggVH0dEkRmIeEBYqtQMwkBSm2vUV+BMc8pPnp5dpn4DU4Owk7kSHf/OOtsnN3q11HayVHnU1KHbG0Mg+1Dmm+utIwhVlrq68biBQ50mUBHlwqPYHrYxtOcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=R8Owicpc; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="R8Owicpc"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780499939; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=MjBO95xDSmLrp4JNHx4KMhFqFrLuEXxwuA67QFALbhc=;
	b=R8Owicpc8mgsg/lriAfy1dQYAuR4cA7Z6ZHdp6yfeBXa7edr1kYSWDDAAmYRioNnonc8UM5bVPOjtfIzVaogjBLhPmLbLHz0twlhGWT6YKdpRg0ByFf9a27Phf0DJW34CSaZK8sxcZJ8O47mPbV/2KxxoS+neFLzyFFKAP7gz78=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X47fR5K_1780499937;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X47fR5K_1780499937 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 23:18:57 +0800
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
Subject: [PATCH v3 19/32] iommu/sprd: implement iova_to_phys_length
Date: Wed,  3 Jun 2026 23:17:51 +0800
Message-ID: <20260603151804.1963871-20-guanghuifeng@linux.alibaba.com>
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

Implement iova_to_phys_length for Spreadtrum IOMMU driver,
returning the actual PTE mapping size.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/sprd-iommu.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index c1a34445d244..3c04ec040d96 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -366,8 +366,9 @@ static void sprd_iommu_sync(struct iommu_domain *domain,
 	sprd_iommu_sync_map(domain, 0, 0);
 }
 
-static phys_addr_t sprd_iommu_iova_to_phys(struct iommu_domain *domain,
-					   dma_addr_t iova)
+static phys_addr_t sprd_iommu_iova_to_phys_length(struct iommu_domain *domain,
+						  dma_addr_t iova,
+						  size_t *mapped_length)
 {
 	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
 	unsigned long flags;
@@ -376,13 +377,19 @@ static phys_addr_t sprd_iommu_iova_to_phys(struct iommu_domain *domain,
 	unsigned long end = domain->geometry.aperture_end;
 
 	if (WARN_ON(iova < start || iova > end))
-		return 0;
+		return PHYS_ADDR_MAX;
 
 	spin_lock_irqsave(&dom->pgtlock, flags);
 	pa = *(dom->pgt_va + ((iova - start) >> SPRD_IOMMU_PAGE_SHIFT));
-	pa = (pa << SPRD_IOMMU_PAGE_SHIFT) + ((iova - start) & (SPRD_IOMMU_PAGE_SIZE - 1));
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
+	if (!pa)
+		return PHYS_ADDR_MAX;
+
+	pa = (pa << SPRD_IOMMU_PAGE_SHIFT) + ((iova - start) & (SPRD_IOMMU_PAGE_SIZE - 1));
+	if (mapped_length)
+		*mapped_length = SPRD_IOMMU_PAGE_SIZE;
+
 	return pa;
 }
 
@@ -420,7 +427,7 @@ static const struct iommu_ops sprd_iommu_ops = {
 		.unmap_pages	= sprd_iommu_unmap,
 		.iotlb_sync_map	= sprd_iommu_sync_map,
 		.iotlb_sync	= sprd_iommu_sync,
-		.iova_to_phys	= sprd_iommu_iova_to_phys,
+		.iova_to_phys_length	= sprd_iommu_iova_to_phys_length,
 		.free		= sprd_iommu_domain_free,
 	}
 };
-- 
2.43.7

