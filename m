Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D101AC891
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723721284; cv=none; b=J7fU9iPnuXJZdYq7WnMZVSkE9wU9SZ/vtga0hYXq/A8r6gLIjZ8/vmJP/xNgoHTmRpBU6KDIKqqX7lDXnC3iqfvNrDdGeiJEbTozibyg+TywgizfW5e7uL+kjAedKWbVVTxv/mVWctM6qYMwNIRm0DJITMRkJOcqWZilZ8b31js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723721284; c=relaxed/simple;
	bh=F5qknYrD550WwTmca4CqHS2UKkpYdXa8HGtjjLALQVQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N0o50pzXQBi8Lq6aIJBQYdgdfxiM4q7l0WvkXqM32ZX+UI52sOS6tQ0KM2IiMg2EYjcsJs0zMrn/SToP75BkD0Z+9O0uf+udMuZmtXdyDvIe9rYNwJaUmpSQlMu95D/oegbAaVUahwvL98wzNv0bJ2KG3NeTtcZ3uZsc49A+bN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wl2mR4zp4z1S7x6;
	Thu, 15 Aug 2024 19:23:03 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 590AF1A0188;
	Thu, 15 Aug 2024 19:27:57 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 15 Aug
 2024 19:27:56 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@ziepe.ca>, <nicolinc@nvidia.com>, <iommu@lists.linux.dev>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH] iommu/arm-smmu-v3: Remove the unused empty definition
Date: Thu, 15 Aug 2024 19:15:04 +0800
Message-ID: <20240815111504.48810-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf500003.china.huawei.com (7.202.181.241)

arm_smmu_sva_remove_dev_pasid() has been removed since commit d38c28dbefee
("iommu/arm-smmu-v3: Put the SVA mmu notifier in the smmu_domain"), remain
the empty definition untouched in header file, which is used when
CONFIG_ARM_SMMU_V3_SVA is not set. So, let's remove the unused definition.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 14bca41a981b..c425c878bbd4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -860,10 +860,5 @@ static inline void arm_smmu_sva_notifier_synchronize(void) {}
 
 #define arm_smmu_sva_domain_alloc NULL
 
-static inline void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
-						 struct device *dev,
-						 ioasid_t id)
-{
-}
 #endif /* CONFIG_ARM_SMMU_V3_SVA */
 #endif /* _ARM_SMMU_V3_H */
-- 
2.17.1

