Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852363E8359
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397234; cv=none; b=LpemlyxjpYh/N+kjUW9P+3wj5chOoJgFbevv9MZ0TkJwHzd13EyaATq+3onElIET8fEF9pDUkq4g/XVgaBlYQrblbfghCMJzDZABNMTZAXKB1jpBmDCmQ4JoBqFzhtj0odcA+YIXZjQ7oAeOMu7sXC039G2mtSOuCK45flj6mrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397234; c=relaxed/simple;
	bh=kKgu2b7OHdWADFOplS+Nkp1c7no4pmerjeqSOFQcuKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INAQ5S7pCBEY/Sz80/Z7Jlv4H232K12z7Xf02/2G2/T/kqCZDhTs4lmLWQg5yrmIJsTHy3h+eomfHuZHe1dkdTTRESKvQpe1Si4Hb8X1NzFbXJethqOFA3/EuQoDFxIX7E02ix2DjVX8UO7VuKYg2ROgtfGcrf5QcHEBMIF2XO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=luRRR9q1; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="luRRR9q1"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780397230; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=i4l5Y0trE0yKZKVwzh0g8Q2sXJKWMQOzssN47hgN7EY=;
	b=luRRR9q1uOBbZ5Kdku++wEQ99Zx6VVvL8obWvaJYfL2yDUfTEUqI0uokgfdNT+KFWWB3HMR7ylXfS7yumFvA3cUiL/cwq8ErRRBtQ9b7pNNpYUJxv9LT3IkMOWuUjUEavUETI70JV4H6yimOSQk3ARUI65VTnjY47BTq7Rkp7L4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X44E97Y_1780397227;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X44E97Y_1780397227 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 18:47:08 +0800
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
Subject: [PATCH v2 20/30] iommu/sun50i: implement iova_to_phys_length
Date: Tue,  2 Jun 2026 18:46:27 +0800
Message-ID: <20260602104637.1219810-21-guanghuifeng@linux.alibaba.com>
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

Implement iova_to_phys_length for sun50i IOMMU driver,
returning the actual PTE mapping size.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/sun50i-iommu.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index be3f1ce696ba..dcd7d926886a 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -659,23 +659,30 @@ static size_t sun50i_iommu_unmap(struct iommu_domain *domain, unsigned long iova
 	return SZ_4K;
 }
 
-static phys_addr_t sun50i_iommu_iova_to_phys(struct iommu_domain *domain,
-					     dma_addr_t iova)
+static phys_addr_t sun50i_iommu_iova_to_phys_length(struct iommu_domain *domain,
+						    dma_addr_t iova,
+						    size_t *mapped_length)
 {
 	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
 	phys_addr_t pt_phys;
 	u32 *page_table;
 	u32 dte, pte;
 
+	if (mapped_length)
+		*mapped_length = 0;
+
 	dte = sun50i_domain->dt[sun50i_iova_get_dte_index(iova)];
 	if (!sun50i_dte_is_pt_valid(dte))
-		return 0;
+		return PHYS_ADDR_MAX;
 
 	pt_phys = sun50i_dte_get_pt_address(dte);
 	page_table = (u32 *)phys_to_virt(pt_phys);
 	pte = page_table[sun50i_iova_get_pte_index(iova)];
 	if (!sun50i_pte_is_page_valid(pte))
-		return 0;
+		return PHYS_ADDR_MAX;
+
+	if (mapped_length)
+		*mapped_length = SZ_4K;
 
 	return sun50i_pte_get_page_address(pte) +
 		sun50i_iova_get_page_offset(iova);
@@ -857,7 +864,7 @@ static const struct iommu_ops sun50i_iommu_ops = {
 		.flush_iotlb_all = sun50i_iommu_flush_iotlb_all,
 		.iotlb_sync_map = sun50i_iommu_iotlb_sync_map,
 		.iotlb_sync	= sun50i_iommu_iotlb_sync,
-		.iova_to_phys	= sun50i_iommu_iova_to_phys,
+		.iova_to_phys_length	= sun50i_iommu_iova_to_phys_length,
 		.map_pages	= sun50i_iommu_map,
 		.unmap_pages	= sun50i_iommu_unmap,
 		.free		= sun50i_iommu_domain_free,
-- 
2.43.7

