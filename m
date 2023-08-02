Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAE87485
	for <iommu@lists.linux.dev>; Wed,  2 Aug 2023 13:40:02 +0000 (UTC)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RGCjM1kGhzVj2S;
	Wed,  2 Aug 2023 21:38:15 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 21:39:59 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <baolu.lu@linux.intel.com>, <peterz@infradead.org>, <dwmw2@infradead.org>,
	<joro@8bytes.org>, <will@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<robin.murphy@arm.com>, <iommu@lists.linux.dev>
Subject: [PATCH -next] iommu: dmar: Remove unused extern declaration dmar_parse_dev_scope()
Date: Wed, 2 Aug 2023 21:39:34 +0800
Message-ID: <20230802133934.19712-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected

From: YueHaibing <yuehaibing@huawei.com>

Since commit 2e4552893038 ("iommu/vt-d: Unify the way to process DMAR device scope array")
this is not used anymore, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/dmar.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 27dbd4c64860..e34b601b71fd 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -106,8 +106,6 @@ static inline bool dmar_rcu_check(void)
 extern int dmar_table_init(void);
 extern int dmar_dev_scope_init(void);
 extern void dmar_register_bus_notifier(void);
-extern int dmar_parse_dev_scope(void *start, void *end, int *cnt,
-				struct dmar_dev_scope **devices, u16 segment);
 extern void *dmar_alloc_dev_scope(void *start, void *end, int *cnt);
 extern void dmar_free_dev_scope(struct dmar_dev_scope **devices, int *cnt);
 extern int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,
-- 
2.34.1

