Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EFB44DB7F
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499941; cv=none; b=oqG5L5EyxlY3sLQRmbyyG9gnOReEn+RSuK6InMpFFxJK95sU1OlsKA6y0j/nuSynR5O+PF1QCSL8BrPB8Y6Bh6SuoEg9z1Ugznj0VEhCJK8CpRlKG5KDaigk2mdPleDa+YqgxYZPwe3uRpRJokjfOFJDt2OkUZZ9yRO+O/8eFKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499941; c=relaxed/simple;
	bh=NuEbBmEUX0tf/lVu3uOnH2owkhNq4gbBSf/bAxOGFVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCasnyy3Hihid7C8+LRnJAMv2WfQ940Ek+ixt/jl4sE5QUWRtLpWrK+MdKafDEGdnGVZQnnM9oHYs+ESVTLMiz/HqMluHPO7C3MHtzIMRBffAKVzk+EIrZKy7vS4rI1Ojl3Rh6vR5KMrUXv2Yn4o3jqrIgH678FjGj2iRvluJlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HbrcXWnW; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HbrcXWnW"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780499935; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=5ykDhaVAxXdOnsgLU7UizM8a0Siq2UzQqZmVaU1DWpg=;
	b=HbrcXWnW2jIp3HwUHsYDWt1Kk3copU9B4QEzZ91FyiSxM12yBrA9zbnhhW5vGFa/lx3qK6XhDJlc6tbAZSmkrmMvibTufsrRtYs7+L4Jayq7tLWsrNd+K8nSF8MB6QKvygIvckCieROCH3daSUjNx3LVfPYR2liq/Gf4N+Bm4JY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X47fR4F_1780499932;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X47fR4F_1780499932 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 23:18:52 +0800
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
Subject: [PATCH v3 14/32] iommu/msm: implement iova_to_phys_length
Date: Wed,  3 Jun 2026 23:17:46 +0800
Message-ID: <20260603151804.1963871-15-guanghuifeng@linux.alibaba.com>
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

Implement iova_to_phys_length for MSM IOMMU driver,
returning the actual PTE mapping size.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/msm_iommu.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 0ad5ff431d5b..1038e8141223 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -523,15 +523,16 @@ static size_t msm_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return ret;
 }
 
-static phys_addr_t msm_iommu_iova_to_phys(struct iommu_domain *domain,
-					  dma_addr_t va)
+static phys_addr_t msm_iommu_iova_to_phys_length(struct iommu_domain *domain,
+						 dma_addr_t va,
+						 size_t *mapped_length)
 {
 	struct msm_priv *priv;
 	struct msm_iommu_dev *iommu;
 	struct msm_iommu_ctx_dev *master;
 	unsigned int par;
 	unsigned long flags;
-	phys_addr_t ret = 0;
+	phys_addr_t ret = PHYS_ADDR_MAX;
 
 	spin_lock_irqsave(&msm_iommu_lock, flags);
 
@@ -558,13 +559,19 @@ static phys_addr_t msm_iommu_iova_to_phys(struct iommu_domain *domain,
 	par = GET_PAR(iommu->base, master->num);
 
 	/* We are dealing with a supersection */
-	if (GET_NOFAULT_SS(iommu->base, master->num))
+	if (GET_NOFAULT_SS(iommu->base, master->num)) {
 		ret = (par & 0xFF000000) | (va & 0x00FFFFFF);
-	else	/* Upper 20 bits from PAR, lower 12 from VA */
+		if (mapped_length)
+			*mapped_length = SZ_16M;
+	} else {
+		/* Upper 20 bits from PAR, lower 12 from VA */
 		ret = (par & 0xFFFFF000) | (va & 0x00000FFF);
+		if (mapped_length)
+			*mapped_length = SZ_4K;
+	}
 
 	if (GET_FAULT(iommu->base, master->num))
-		ret = 0;
+		ret = PHYS_ADDR_MAX;
 
 	__disable_clocks(iommu);
 fail:
@@ -706,7 +713,7 @@ static struct iommu_ops msm_iommu_ops = {
 		 */
 		.iotlb_sync	= NULL,
 		.iotlb_sync_map	= msm_iommu_sync_map,
-		.iova_to_phys	= msm_iommu_iova_to_phys,
+		.iova_to_phys_length	= msm_iommu_iova_to_phys_length,
 		.free		= msm_iommu_domain_free,
 	}
 };
-- 
2.43.7

