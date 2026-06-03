Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52D3481658
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499945; cv=none; b=BxZS3kkLOy9VFvktRfkndvfhupQeAlM9U1mLSDhj8TbGk42I41xVI0cbKlfourxS8UAXeEiBDRwzueDjARQ9EH1DEVk3qsYDfgTBp/ANxcgDa+91fEblHPFT18ueLR3IDA1YDns7w0dRczNkJWVruf7N24gmoNeyi2PPes6uhzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499945; c=relaxed/simple;
	bh=NkXQT+EmLB460QPTlkwMLKaUnNH/iAGSqRTue56ZKcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWutMnW3HgO2VcVaxeKerMQXs66RoIDDWOlrsa9G1z0EA2dVpq1zRlspxHHfC7uxQ6gPAYnBOzxwjO+whBfTPmp0gXHeglV8x1kB+KkIAlMgePMs5oXnK9Vg4qF+1daEiczNS+5AbiaEbCM3qVlWeEsiXIjI7ACG/D+V3782nxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jHQk/RoA; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jHQk/RoA"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780499938; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=KZgq1eaNBXtMeM2COnghIdZmSnxtaNxaK4JO7Z48KHI=;
	b=jHQk/RoA3JpiWR8rmDFY1yav/gXXE7p7mcJKtS1Ek6spGrRPpD4ckwNPGnuhZiuPIk6xRbvKojc/8zN4goGFsGDrViEd8cp9UzAI7gWOigk0RxBanbUZ6wZFQOm1soGQHwmKOZ03MO4ec862jJMX7FPDbNmuKMwTA7CSeLrFzeg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X47fR4o_1780499935;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X47fR4o_1780499935 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 23:18:55 +0800
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
Subject: [PATCH v3 17/32] iommu/rockchip: implement iova_to_phys_length
Date: Wed,  3 Jun 2026 23:17:49 +0800
Message-ID: <20260603151804.1963871-18-guanghuifeng@linux.alibaba.com>
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

Implement iova_to_phys_length for Rockchip IOMMU driver,
returning the actual PTE mapping size.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/rockchip-iommu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 0013cf196c57..a51c29340b98 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -648,12 +648,12 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 	return ret;
 }
 
-static phys_addr_t rk_iommu_iova_to_phys(struct iommu_domain *domain,
-					 dma_addr_t iova)
+static phys_addr_t rk_iommu_iova_to_phys_length(struct iommu_domain *domain,
+					 dma_addr_t iova, size_t *mapped_length)
 {
 	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
 	unsigned long flags;
-	phys_addr_t pt_phys, phys = 0;
+	phys_addr_t pt_phys, phys = PHYS_ADDR_MAX;
 	u32 dte, pte;
 	u32 *page_table;
 
@@ -670,6 +670,8 @@ static phys_addr_t rk_iommu_iova_to_phys(struct iommu_domain *domain,
 		goto out;
 
 	phys = rk_ops->pt_address(pte) + rk_iova_page_offset(iova);
+	if (mapped_length)
+		*mapped_length = SPAGE_SIZE;
 out:
 	spin_unlock_irqrestore(&rk_domain->dt_lock, flags);
 
@@ -1187,7 +1189,7 @@ static const struct iommu_ops rk_iommu_ops = {
 		.attach_dev	= rk_iommu_attach_device,
 		.map_pages	= rk_iommu_map,
 		.unmap_pages	= rk_iommu_unmap,
-		.iova_to_phys	= rk_iommu_iova_to_phys,
+		.iova_to_phys_length = rk_iommu_iova_to_phys_length,
 		.free		= rk_iommu_domain_free,
 	}
 };
-- 
2.43.7

