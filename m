Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028483EC2CD
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397236; cv=none; b=nEEon+B/CgJ2A4WwImhU4BBUDXxoAly6BB5Pou+d6bd5OQMHFa3tbnp665NHHXKUdN3Q0fq0Vt7t2m/qnTXUQ+lGQEK8k6xk1Xb0U4q13KPzm7fug8V0/4TsGBuR7EX8or9IH/Ik5NZzNR0UsUUL1HOgPlUgB346PGk7FCS6+HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397236; c=relaxed/simple;
	bh=zFwUlRByaRxBiBzm+S9az+EuN27NZuGtV4pji/OfLKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDKOWXQQKvGEaV0SPkIrvv4Le7IAd3CTWUiU3QbywG/lo7KRslZEc2YYNVahMU4mCZDwoqdB4bXVt361wUZO+KLwn29dy8qFpqI4HJgqzTaySE69sfgBUM/b3cuV1xHTld5KcRd+VeqOcm5UCePnJd+jl+qfSf9eAxLcA1NeC2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a4AwY8SO; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a4AwY8SO"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780397233; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Kbjp/ndSpS2VzxK0fPyovqcC2Ww81EnJ32SRD/dW6zo=;
	b=a4AwY8SOd5fA86G4pqlxQIW42MynrsenGhlNX6yPORhdtaGmvlOPAS+Ly5pZXj2pwXl5JCEpwGUuBaxqbC+P74Ylo88h/QL7PhpKhrpA+WSJErpWoaroq4D48YycreGfyC8CWeSZ7OWum2i4XpJR+7cOm1BMX0AG3qGS9+5Xnx8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X44E97z_1780397229;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X44E97z_1780397229 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 18:47:10 +0800
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
Subject: [PATCH v2 22/30] iommu/virtio: implement iova_to_phys_length
Date: Tue,  2 Jun 2026 18:46:29 +0800
Message-ID: <20260602104637.1219810-23-guanghuifeng@linux.alibaba.com>
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

Implement iova_to_phys_length for virtio IOMMU driver,
returning the actual PTE mapping size.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/virtio-iommu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 587fc13197f1..c90d02cbbfd0 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -912,20 +912,27 @@ static size_t viommu_unmap_pages(struct iommu_domain *domain, unsigned long iova
 	return ret ? 0 : unmapped;
 }
 
-static phys_addr_t viommu_iova_to_phys(struct iommu_domain *domain,
-				       dma_addr_t iova)
+static phys_addr_t viommu_iova_to_phys_length(struct iommu_domain *domain,
+					      dma_addr_t iova,
+					      size_t *mapped_length)
 {
-	u64 paddr = 0;
+	u64 paddr = PHYS_ADDR_MAX;
 	unsigned long flags;
 	struct viommu_mapping *mapping;
 	struct interval_tree_node *node;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
+	if (mapped_length)
+		*mapped_length = 0;
+
 	spin_lock_irqsave(&vdomain->mappings_lock, flags);
 	node = interval_tree_iter_first(&vdomain->mappings, iova, iova);
 	if (node) {
 		mapping = container_of(node, struct viommu_mapping, iova);
 		paddr = mapping->paddr + (iova - mapping->iova.start);
+		if (mapped_length)
+			*mapped_length = mapping->iova.last -
+					 mapping->iova.start + 1;
 	}
 	spin_unlock_irqrestore(&vdomain->mappings_lock, flags);
 
@@ -1102,7 +1109,7 @@ static const struct iommu_ops viommu_ops = {
 		.attach_dev		= viommu_attach_dev,
 		.map_pages		= viommu_map_pages,
 		.unmap_pages		= viommu_unmap_pages,
-		.iova_to_phys		= viommu_iova_to_phys,
+		.iova_to_phys_length	= viommu_iova_to_phys_length,
 		.flush_iotlb_all	= viommu_flush_iotlb_all,
 		.iotlb_sync		= viommu_iotlb_sync,
 		.iotlb_sync_map		= viommu_iotlb_sync_map,
-- 
2.43.7

