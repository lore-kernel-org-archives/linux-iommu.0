Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4F6481FB4
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499947; cv=none; b=iEFFptoYicPtTdbE1t2MOj0HQU7N4TdbZ+Y5Ha2Zj2w3L+2wXZoti+eO2F31nUuyqKqhq6vIWUV4KI74YHAEps+PcCcIEn8nCNmhdqRjPFYZP+StISkyB5lcJ7IpbwYt8+Y9gTKclYKdIM+K2qYpXuH0ix+JjGhbM4sWdhs79EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499947; c=relaxed/simple;
	bh=XruHxIlQUxCL+b+kSRtfQRTkfWHAloDI99W7wX6rYTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIqPmKFFK1ynIOa2/m23oSjXwswVwEFGcxnrgFTp51Dqw+cWICRZ+SMZKxWYCaEMz0lGi9a+n9xvSDAAW1H6Cvd8YiKB0hF6d8D8HjKd90UKcVsVv2PMOcgGCWWqVm7gPRYLmLxKAahMcX22iP7vEd0/D6q3839zjesaSrjTktU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hV9Koh2c; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hV9Koh2c"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780499940; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QjZ8f27cqLiBL9quajEXvEuD5izxdrCDst1w3hORFvo=;
	b=hV9Koh2cxRoTfjnu9bgWdNIEROapxFIrFH7s2DA6Wf5GwVom6NfWlhUMgWczfQQpvgMpZgqXbYLbfEQrJVp3eZtJHPlkteFXfw3Jt8NqJ96sXRMgmPjQGRZn7LsLPcC3t4OE8LRXsw1luzi9R7wak5RZocgaNyzzbzoa+OtUJd8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X47fR5b_1780499938;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X47fR5b_1780499938 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 23:18:58 +0800
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
Subject: [PATCH v3 20/32] iommu/sun50i: implement iova_to_phys_length
Date: Wed,  3 Jun 2026 23:17:52 +0800
Message-ID: <20260603151804.1963871-21-guanghuifeng@linux.alibaba.com>
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

Implement iova_to_phys_length for sun50i IOMMU driver,
returning the actual PTE mapping size.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/sun50i-iommu.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index be3f1ce696ba..9f39fe4a9d4f 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -659,8 +659,9 @@ static size_t sun50i_iommu_unmap(struct iommu_domain *domain, unsigned long iova
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
@@ -669,13 +670,16 @@ static phys_addr_t sun50i_iommu_iova_to_phys(struct iommu_domain *domain,
 
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
@@ -857,7 +861,7 @@ static const struct iommu_ops sun50i_iommu_ops = {
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

