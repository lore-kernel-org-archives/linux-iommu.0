Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B4A48BD55
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499956; cv=none; b=oMrtWGVABD2gj2NYeES43niN/UlCnTYi+4EQ60w6bDcqsLgxwErtrEFkwov3kXPfmIcFIHdCNhGZYbAbpeZwLbxsFmoUQhNGDWAiYGJYOtVeUG2VtjBZ8c7lWcK9nSAvDhHp4SKkrjPiEpxLKDXml3jJTP46sCqy3nYvNVs9F2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499956; c=relaxed/simple;
	bh=oyPkwHzc20XrNGeKDu1/pxB3ak3GLuqmVhS1MOFDJSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+K2H37zOD3zq9g7IYO5BpJ9VJMWUTD4rMG2a/pAGCflCK83zkEoigUNpYoCXtEnNqcNOcYjNFF5ySaKH7q6umg2lKajCQ/jYdX9BiSdXM1m2gjwMjplB5wc3d6zOaLP5E6fvg5MLkBR8WV8Ytm+AsPWzSwB4nnc2ww7qGeODsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TsA8LpKi; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TsA8LpKi"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780499950; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=cII6ny8ml7CMYCax7iOr5Pt8lHtm5RFG7dKDlrestlY=;
	b=TsA8LpKibZb/TSwbrTvQjGRKXM5oM+DD9b51NS57nHXjVcMHIrgpmmxak17/cXkfTH6X7I1YDrtiKvKGhn4rNbmbH7oY8H25srf3sTPg9N+y+rkG4SP9FHDMTZlC8C8WYvW8HhNgHvYJlNXwnt/QuyOljIUvWqfHCLd6o3Nxht0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X47fR87_1780499947;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X47fR87_1780499947 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 23:19:07 +0800
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
Subject: [PATCH v3 29/32] iommu/io-pgtable-arm: remove deprecated iova_to_phys wrapper
Date: Wed,  3 Jun 2026 23:18:01 +0800
Message-ID: <20260603151804.1963871-30-guanghuifeng@linux.alibaba.com>
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

Remove the iova_to_phys wrapper function and .iova_to_phys assignment
from ARM LPAE io-pgtable, as all callers now use iova_to_phys_length.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/io-pgtable-arm.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index f33a86fa0f6c..55a32346b586 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -731,18 +731,6 @@ static int visit_iova_to_phys(struct io_pgtable_walk_data *walk_data, int lvl,
 	return 0;
 }
 
-static phys_addr_t arm_lpae_iova_to_phys_length(struct io_pgtable_ops *ops,
-						 unsigned long iova,
-						 size_t *mapped_length);
-
-static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
-					 unsigned long iova)
-{
-	phys_addr_t phys = arm_lpae_iova_to_phys_length(ops, iova, NULL);
-
-	return (phys == PHYS_ADDR_MAX) ? 0 : phys;
-}
-
 static phys_addr_t arm_lpae_iova_to_phys_length(struct io_pgtable_ops *ops,
 						 unsigned long iova,
 						 size_t *mapped_length)
@@ -965,7 +953,6 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 	data->iop.ops = (struct io_pgtable_ops) {
 		.map_pages	= arm_lpae_map_pages,
 		.unmap_pages	= arm_lpae_unmap_pages,
-		.iova_to_phys	= arm_lpae_iova_to_phys,
 		.iova_to_phys_length	= arm_lpae_iova_to_phys_length,
 		.read_and_clear_dirty = arm_lpae_read_and_clear_dirty,
 		.pgtable_walk	= arm_lpae_pgtable_walk,
-- 
2.43.7

