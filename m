Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087133D812D
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397229; cv=none; b=UMslw4e6haTj/i0f4QNTRGk5lV0TOKaRkwhDm48ERfK5/GZixioY0JI0j9rX9kmRanD3v99F1RbmY+1KgzeTmZZO2IFzjESURQ1j88Lfqzwvk+nCH5/cXXyU3qxEclknHwHBRYly30R4Bb30YyUvhDnZq/1OA1Y3jgWToSlgRDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397229; c=relaxed/simple;
	bh=JeyCTAXrQ+XH4C2fkrVz1SupA4Ue3SK5YuqrmXZnWr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZ/M44NOWoXCNfN2q36spWqcBISVoDVXZ19GDK5jptnT64VWnkugKoXzBzKFUxT8NcC5by1q3H0nuAiib1lz5e3CrRasY9mhkDVRCdHz2g/4+lRfcTMHaQafTpzNsQdLaH/5WxRX5GRCofGEQBvnn6+YVE21KiFPnwZYSmB20oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gNOijJqU; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gNOijJqU"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780397225; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RP623VqPSI+xDCv1y2SYKGV0aOycUPVbFEGyieTBg94=;
	b=gNOijJqUMv3vvtvJOXDjgOUWu3vq5nMJifl30LY7J3BTVveMc3UfpLfJQ26Y5HqAaMYNYhbyMhLBCBaFOBjLqwwuPHpUioaf0iqGWnOQwvSFhkUlyukEZ5e/EaKNyxMkarF+Ij1GV8TxNOnUadMH3vNWuyUe4eyq57ofZlb3RqE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X44E95U_1780397221;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X44E95U_1780397221 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 18:47:01 +0800
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
Subject: [PATCH v2 14/30] iommu/msm: implement iova_to_phys_length
Date: Tue,  2 Jun 2026 18:46:21 +0800
Message-ID: <20260602104637.1219810-15-guanghuifeng@linux.alibaba.com>
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

Implement iova_to_phys_length for MSM IOMMU driver,
returning the actual PTE mapping size.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/msm_iommu.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 0ad5ff431d5b..af4020ed9987 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -523,15 +523,19 @@ static size_t msm_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
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
+
+	if (mapped_length)
+		*mapped_length = 0;
 
 	spin_lock_irqsave(&msm_iommu_lock, flags);
 
@@ -558,13 +562,22 @@ static phys_addr_t msm_iommu_iova_to_phys(struct iommu_domain *domain,
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
 
-	if (GET_FAULT(iommu->base, master->num))
-		ret = 0;
+	if (GET_FAULT(iommu->base, master->num)) {
+		ret = PHYS_ADDR_MAX;
+		if (mapped_length)
+			*mapped_length = 0;
+	}
 
 	__disable_clocks(iommu);
 fail:
@@ -706,7 +719,7 @@ static struct iommu_ops msm_iommu_ops = {
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

