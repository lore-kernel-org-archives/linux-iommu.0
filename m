Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C63864B
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 01:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VvIq7WL_1698801803;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VvIq7WL_1698801803)
          by smtp.aliyun-inc.com;
          Wed, 01 Nov 2023 09:23:29 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: jgg@ziepe.ca
Cc: kevin.tian@intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] iommufd/selftest: Remove unused function
Date: Wed,  1 Nov 2023 09:23:23 +0800
Message-Id: <20231101012323.33154-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function are defined in the selftest.c file, but not called
elsewhere, so delete the unused function.

drivers/iommu/iommufd/selftest.c:511:1: warning: unused function 'get_md_pagetable_nested'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7104
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/iommu/iommufd/selftest.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 256f93715a0d..758d328a44cd 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -515,25 +515,6 @@ get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
 	return hwpt;
 }
 
-static inline struct iommufd_hw_pagetable *
-get_md_pagetable_nested(struct iommufd_ucmd *ucmd, u32 mockpt_id,
-			struct mock_iommu_domain_nested **mock_nested)
-{
-	struct iommufd_hw_pagetable *hwpt;
-
-	hwpt = __get_md_pagetable(ucmd, mockpt_id, IOMMUFD_OBJ_HWPT_NESTED);
-	if (IS_ERR(hwpt))
-		return hwpt;
-	if (hwpt->domain->type != IOMMU_DOMAIN_NESTED ||
-	    hwpt->domain->ops != &domain_nested_ops) {
-		iommufd_put_object(&hwpt->obj);
-		return ERR_PTR(-EINVAL);
-	}
-	*mock_nested = container_of(hwpt->domain,
-				    struct mock_iommu_domain_nested, domain);
-	return hwpt;
-}
-
 struct mock_bus_type {
 	struct bus_type bus;
 	struct notifier_block nb;
-- 
2.20.1.7.g153144c

