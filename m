Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBDD3E0C46
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397229; cv=none; b=I2Nj6WVgjLe+/CO6E20mY2NvrXvyK9rzJibnfr9Uphns01xvx+mdWRfEbwWO//GpVNwFiTcGHxx1GqLzyDLLaeJRsh7XbLRzPcX9IQyLoOjkWrakMlcBDE7Jok9TbyB46gl3m392nGDioMeVreRM9Ch4NgtHcaSIAP7uQngCMgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397229; c=relaxed/simple;
	bh=CeKjxseszSxfNQa6U88S28sJVv5LBIAEzhNVSHC2+lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNlPh4FvRbf/9g/kDHx5Hv8tnutZIyQmpPpYc6UDOIOq24SYp1CSIFruC4N2vxoiDVxHOuiLJ2ynQ9dXO/ssAyTbOyKveNqgLnGCBuUvs0hx6XzWe/tRTjTUvUL3aq5kO+cRXE03juVDCi1Ym7sT/ZgEo8VWbuMniCnNc/uh13Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uU/UwPX+; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uU/UwPX+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780397225; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Z6uvMZHAmHwSUWc23cUrxXysIDcjk6iA/ZFsUBabgTo=;
	b=uU/UwPX+OqIT/ZJZcHd0yyCL2I8b4siMCDF7NjS2939BP43ifjsFd1vzLMy5wzgqQccOoerHBTLTq+QgBeLeX97C04rfVVY7kf2sgDs5HCAoYGmBYIbeq7qm3jQHynoTiZfKOOelBdZyQfB2ZHQJrB1DL2tJFBnJRfZ+OFPUs/Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X44E95v_1780397222;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X44E95v_1780397222 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 18:47:02 +0800
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
Subject: [PATCH v2 15/30] iommu/mtk_v1: implement iova_to_phys_length
Date: Tue,  2 Jun 2026 18:46:22 +0800
Message-ID: <20260602104637.1219810-16-guanghuifeng@linux.alibaba.com>
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

Implement iova_to_phys_length for MediaTek v1 IOMMU driver,
returning the actual PTE mapping size.
Also fix pre-existing bug: add page offset to physical address.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/mtk_iommu_v1.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index ac97dd2868d4..8733b87c9b94 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -393,17 +393,29 @@ static size_t mtk_iommu_v1_unmap(struct iommu_domain *domain, unsigned long iova
 	return size;
 }
 
-static phys_addr_t mtk_iommu_v1_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
+static phys_addr_t mtk_iommu_v1_iova_to_phys_length(struct iommu_domain *domain,
+						    dma_addr_t iova,
+						    size_t *mapped_length)
 {
 	struct mtk_iommu_v1_domain *dom = to_mtk_domain(domain);
 	unsigned long flags;
 	phys_addr_t pa;
 
+	if (mapped_length)
+		*mapped_length = 0;
+
 	spin_lock_irqsave(&dom->pgtlock, flags);
 	pa = *(dom->pgt_va + (iova >> MT2701_IOMMU_PAGE_SHIFT));
 	pa = pa & (~(MT2701_IOMMU_PAGE_SIZE - 1));
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
+	if (!pa)
+		return PHYS_ADDR_MAX;
+
+	pa |= (iova & (MT2701_IOMMU_PAGE_SIZE - 1));
+	if (mapped_length)
+		*mapped_length = MT2701_IOMMU_PAGE_SIZE;
+
 	return pa;
 }
 
@@ -590,7 +602,7 @@ static const struct iommu_ops mtk_iommu_v1_ops = {
 		.attach_dev	= mtk_iommu_v1_attach_device,
 		.map_pages	= mtk_iommu_v1_map,
 		.unmap_pages	= mtk_iommu_v1_unmap,
-		.iova_to_phys	= mtk_iommu_v1_iova_to_phys,
+		.iova_to_phys_length = mtk_iommu_v1_iova_to_phys_length,
 		.free		= mtk_iommu_v1_domain_free,
 	}
 };
-- 
2.43.7

