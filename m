Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D3C8BFC
	for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 11:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720783928; cv=none; b=ctdpn9DpoRqoX081EaFnZJbcMB0bHL6ZBCT7UAxarWz6Ly9p+fMK2vvkB338YRKjNuZQYB2m9MjeerAIYVFUqiakvgm+HHrFhYJE7BRIjeS0BmPKrm/ObOaki5NEZH+R0xH0KyXEirnNoPqmgH8HRqhhjx3rUYHLcBlqh43Z80A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720783928; c=relaxed/simple;
	bh=1eRM1ZtSRT0P+RQJIcIpwsGwyFEoxbKRhlnltAi6gqw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RvIIF5JvK8qRGAcrAW9hnDJvXESvqTFDLxJQ0MSamiFLQ/B23Kl9RE+Gxt7Tt2P3V4snfiybao4vHb08cbN24ryDclxntv729S4Kd212xaqKFKmdbwzlPfaIAV7pE9S2UCdn4fWdYIY317Glx/iI+AcR4nKzXECaWup+mjD93lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WL8X416TJz6K93x;
	Fri, 12 Jul 2024 19:29:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E6C0F140B63;
	Fri, 12 Jul 2024 19:32:02 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.48.147.152) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 12:31:56 +0100
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<ryan.roberts@arm.com>, <kevin.tian@intel.com>, <joao.m.martins@oracle.com>,
	<linuxarm@huawei.com>
Subject: [PATCH] iommu: Move IOMMU_DIRTY_NO_CLEAR define
Date: Fri, 12 Jul 2024 12:31:32 +0100
Message-ID: <20240712113132.45100-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Fixes the compile issue when CONFIG_IOMMU_API is not set.

Fixes: 4fe88fd8b4ae ("iommu/io-pgtable-arm: Add read_and_clear_dirty() support")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407121602.HL9ih1it-lkp@intel.com/
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 include/linux/iommu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7bc8dff7cf6d..104ce84647d4 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -317,6 +317,9 @@ enum iommu_dev_features {
 #define IOMMU_PASID_INVALID	(-1U)
 typedef unsigned int ioasid_t;
 
+/* Read but do not clear any dirty bits */
+#define IOMMU_DIRTY_NO_CLEAR (1 << 0)
+
 #ifdef CONFIG_IOMMU_API
 
 /**
@@ -353,9 +356,6 @@ struct iommu_dirty_bitmap {
 	struct iommu_iotlb_gather *gather;
 };
 
-/* Read but do not clear any dirty bits */
-#define IOMMU_DIRTY_NO_CLEAR (1 << 0)
-
 /**
  * struct iommu_dirty_ops - domain specific dirty tracking operations
  * @set_dirty_tracking: Enable or Disable dirty tracking on the iommu domain
-- 
2.34.1

