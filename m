Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E063D3CFF
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499936; cv=none; b=Lvx7vRUuqaNDrwzFc2poCjDFDGU2yCEI6Gp38oaqY9HRgT9Fi+HsOQ+653MAxg6Mu89G1vwZ3zDA97Qli/ORNx5lL4xPhdp44uCyxr6sTz0ZQPgptYkQdswaW6612BLClMYuFIgNg1ZWAcStJOn0plwB7s6p9ae54f39KA8ihGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499936; c=relaxed/simple;
	bh=6pZrg1H9Ivm1KBa72TUG1LkookqksX/YdXuYMVIlQ4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dg2f+2WPLY5YiC/gzVJPhYnvoG/3Nt5xp08NXZQvPh+4agFm4w1j+bGnmail9EUaU8R961bDtVSjsigZAJPd/EU3N0GOoncVyo+fMmmI/pyAEfl6jqbNZQwOTRxe3diDaBug4H1fHOp/5aDmmyTi9wMjm4RZolDg0dBFahhRIRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xlM8SUMG; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xlM8SUMG"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780499930; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=p4rS05BvfO7tKKbX+DS2TrSOXcVnNjfP3PbV2BH3iGY=;
	b=xlM8SUMGmB8P4quCKOSX6jJiV0fvizjR+sBwMupI8CT6HhDSdCW53HmEXWtc3ybQKiP0ngC1fPZjh+zUTiCo5+CUtp8mpZDslJ7DFwCU2SXa0XQn0sxCHGHg1nIGLnhCKKq1KLsslSMCwk4TVLx9Sbsvs9CSYuc+tSYPaqp+l44=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X47fR2o_1780499927;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X47fR2o_1780499927 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 23:18:47 +0800
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
Subject: [PATCH v3 09/32] iommu/apple-dart: implement iova_to_phys_length
Date: Wed,  3 Jun 2026 23:17:41 +0800
Message-ID: <20260603151804.1963871-10-guanghuifeng@linux.alibaba.com>
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

Migrate Apple DART to implement iova_to_phys_length, passing through
mapped_length from io-pgtable.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/apple-dart.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 17bdadb6b504..fdc533ba72da 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -528,16 +528,17 @@ static int apple_dart_iotlb_sync_map(struct iommu_domain *domain,
 	return 0;
 }
 
-static phys_addr_t apple_dart_iova_to_phys(struct iommu_domain *domain,
-					   dma_addr_t iova)
+static phys_addr_t apple_dart_iova_to_phys_length(struct iommu_domain *domain,
+					   dma_addr_t iova, size_t *mapped_length)
 {
 	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
 	struct io_pgtable_ops *ops = dart_domain->pgtbl_ops;
 
+
 	if (!ops)
-		return 0;
+		return PHYS_ADDR_MAX;
 
-	return ops->iova_to_phys(ops, iova);
+	return ops->iova_to_phys_length(ops, iova, mapped_length);
 }
 
 static int apple_dart_map_pages(struct iommu_domain *domain, unsigned long iova,
@@ -1018,7 +1019,7 @@ static const struct iommu_ops apple_dart_iommu_ops = {
 		.flush_iotlb_all = apple_dart_flush_iotlb_all,
 		.iotlb_sync	= apple_dart_iotlb_sync,
 		.iotlb_sync_map	= apple_dart_iotlb_sync_map,
-		.iova_to_phys	= apple_dart_iova_to_phys,
+		.iova_to_phys_length = apple_dart_iova_to_phys_length,
 		.free		= apple_dart_domain_free,
 	}
 };
-- 
2.43.7

