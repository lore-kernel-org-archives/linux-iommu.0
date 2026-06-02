Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F533E5A3C
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 10:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397232; cv=none; b=tFg8thNPMqF47aupACKkLO76gpgGQbwx9+J9Nl3/iWk1hbVwF4bd4130rEpOfXVaSDX3fxHv0G/JygfuTAXXdUJlNGJd3P4rZ0Q+vaj491pyIWw5cdUtfprHIR7e30955Qr3GN4Hjt6268DeL1FFF4STKPsFDLCTt2nG2rE6Avs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397232; c=relaxed/simple;
	bh=u9rhI9aM0c0TwxfdjWgnDFCOtsjvG9DC9ruiKqBsCeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2htROQNL/Q+P5CmQ0hpNoV/yyYqr2sow6iSEO+AGrsDUUrcq2j619NPTKPtsUjrkWrghjPUZvWArAAHB7/0XQqdNyl3IPdrcycsLtdeWx3jSgsPLUoa6Y/nGUT3tSlGp7O0LbOJKArJ0WhL8DLgQMRNrobGDLichlN1lK7fmAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XHS10kZF; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XHS10kZF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780397229; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Dmq5VZlTiHIu0DAcakOaUjD+KNjRLd5oRgXasfLjiiI=;
	b=XHS10kZF5bTHkqVtJX6j9hiT7GJ4TzXAypFSDmgvGnb7NjuMgLru8UypByoNCN8R7jM2p4ump0EpDAYwnkxDBs2BF2/Kdhurbj4VBeywLxBFh2KVFxbSzj9W2sP3IumLWbKJ4IokeAcG9PhCRCzJLr2CFwr4U7bbSAA2tf2lpZQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X44E97N_1780397226;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X44E97N_1780397226 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 18:47:06 +0800
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
Subject: [PATCH v2 19/30] iommu/sprd: implement iova_to_phys_length
Date: Tue,  2 Jun 2026 18:46:26 +0800
Message-ID: <20260602104637.1219810-20-guanghuifeng@linux.alibaba.com>
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

Implement iova_to_phys_length for Spreadtrum IOMMU driver,
returning the actual PTE mapping size.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/sprd-iommu.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index c1a34445d244..f8dbe24c332a 100644
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
@@ -375,14 +376,23 @@ static phys_addr_t sprd_iommu_iova_to_phys(struct iommu_domain *domain,
 	unsigned long start = domain->geometry.aperture_start;
 	unsigned long end = domain->geometry.aperture_end;
 
+	if (mapped_length)
+		*mapped_length = 0;
+
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
 
@@ -420,7 +430,7 @@ static const struct iommu_ops sprd_iommu_ops = {
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

