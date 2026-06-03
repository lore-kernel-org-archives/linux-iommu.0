Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449E948033E
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499940; cv=none; b=qHkFuKaROJuxHgorz1sKJNM+xKdaG2gaTvoNT1jBkhtef7EmxA2iMmrguRwRHmA+X1DjC4FhqlzvvHOEPyurQHg4I7UKG5jbDIoGEPQtNI57h8RNiXIsZdVR5We5A964oao9I1itfK9E8Uki+5yi/KvroWbbnp9xGevz8YbPtSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499940; c=relaxed/simple;
	bh=TwPlHK7C2kY2tjPK7vpetXLhPuD918Q5/UZzEDfqkQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2DOvitm9OyZEyUBaK6Izcz/e+FA2VvJ7vi9avxKA1COQbTZ07/B32dKAr0teiYKj0sKYq+irt7HVKfK6ehYIu5lu/w8ONAooUjjwQrPZSEOg7x2GIyO8bfGaGSd0dnAVdNmuMopnjDI7+/OU1YgOoV5/c90fz7hfMwowB1NNPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wlrj/QCl; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wlrj/QCl"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780499929; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=iqg8jVUeg5vulwkVyAexMfFQNB/RSusVVmcIuPE1fjY=;
	b=wlrj/QCl4uqYTmkmTP/HFsqX20vKedbg8j90oHKDjmfdoN0+qV2WNDTfapCLF2xMpLMcsKsrHvCE7HNFdjVbjSewIViVC+Ps1UsQ39a9v1VqUfcjRg/hnG9oE7JLPUxkeil6r/nyQIwYarDBcnHw5yMCUUxaocCfg6BkYvpFKAU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X47fR2c_1780499926;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X47fR2c_1780499926 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 23:18:46 +0800
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
Subject: [PATCH v3 08/32] iommu/qcom_iommu: implement iova_to_phys_length
Date: Wed,  3 Jun 2026 23:17:40 +0800
Message-ID: <20260603151804.1963871-9-guanghuifeng@linux.alibaba.com>
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

Migrate Qualcomm IOMMU to implement iova_to_phys_length, calling
ops->iova_to_phys_length on the io-pgtable layer.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index a1e8cf29f594..9e0e8b5caec1 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -489,19 +489,20 @@ static void qcom_iommu_iotlb_sync(struct iommu_domain *domain,
 	qcom_iommu_flush_iotlb_all(domain);
 }
 
-static phys_addr_t qcom_iommu_iova_to_phys(struct iommu_domain *domain,
-					   dma_addr_t iova)
+static phys_addr_t qcom_iommu_iova_to_phys_length(struct iommu_domain *domain,
+					   dma_addr_t iova, size_t *mapped_length)
 {
 	phys_addr_t ret;
 	unsigned long flags;
 	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
 	struct io_pgtable_ops *ops = qcom_domain->pgtbl_ops;
 
+
 	if (!ops)
-		return 0;
+		return PHYS_ADDR_MAX;
 
 	spin_lock_irqsave(&qcom_domain->pgtbl_lock, flags);
-	ret = ops->iova_to_phys(ops, iova);
+	ret = ops->iova_to_phys_length(ops, iova, mapped_length);
 	spin_unlock_irqrestore(&qcom_domain->pgtbl_lock, flags);
 
 	return ret;
@@ -602,7 +603,7 @@ static const struct iommu_ops qcom_iommu_ops = {
 		.unmap_pages	= qcom_iommu_unmap,
 		.flush_iotlb_all = qcom_iommu_flush_iotlb_all,
 		.iotlb_sync	= qcom_iommu_iotlb_sync,
-		.iova_to_phys	= qcom_iommu_iova_to_phys,
+		.iova_to_phys_length = qcom_iommu_iova_to_phys_length,
 		.free		= qcom_iommu_domain_free,
 	}
 };
-- 
2.43.7

