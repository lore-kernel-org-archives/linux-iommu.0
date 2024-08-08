Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CD618E034
	for <iommu@lists.linux.dev>; Thu,  8 Aug 2024 14:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126115; cv=none; b=BVEcokbuMpeyGsO31y+QGtNXpTTZfHGaSwcgnuK5lHjOogx7CnX9oOUaYnixg2EjfHDfrZ69ecFDUPPceoWL3pTQUI0l4ETDloyyk/g/SUAjxd0uL0fwhjTF71VS85ppq2SVFrjcu4Th1039D1JCgFC6nvKtkCx3BcKjhCcEyDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126115; c=relaxed/simple;
	bh=ftysCDxdrnWKxwFrSTDJOz3hoaatgTbR/7+r+kDiN+g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=beFmYVTS79bVk7e9TGIa+l2hlgNvimSsfBijliON+P9MxtNJumBw+qqnqrwTlBJrC5g7VnHOUbQq6IBW/B07ns25TVh3wqJ4FF8GkJgdR7BTH2BcEIgn7LijiwvaErnShj8AsJrTptrswcQJuwgGiJ55+Eb8jORuTzGDHq+zvs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WfpkT1Vhgz1xv13;
	Thu,  8 Aug 2024 22:06:41 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 06C481A016C;
	Thu,  8 Aug 2024 22:08:30 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 8 Aug
 2024 22:08:29 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<jgg@ziepe.ca>, <baolu.lu@linux.intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH -next] iommu: Remove unused declaration iommu_sva_unbind_gpasid()
Date: Thu, 8 Aug 2024 22:06:19 +0800
Message-ID: <20240808140619.2498535-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit 0c9f17877891 ("iommu: Remove guest pasid related interfaces and definitions")
removed the implementation but leave declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/linux/iommu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4d47f2c33311..04cbdae0052e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -795,8 +795,6 @@ extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
 extern void iommu_detach_device(struct iommu_domain *domain,
 				struct device *dev);
-extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
-				   struct device *dev, ioasid_t pasid);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
-- 
2.34.1

