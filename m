Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14A8EC0
	for <iommu@lists.linux.dev>; Mon, 21 Nov 2022 11:18:53 +0000 (UTC)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NG4d42xfLzHw3M;
	Mon, 21 Nov 2022 19:18:16 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 19:18:51 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 19:18:50 +0800
From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
To: <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>, <jroedel@suse.de>
CC: <iommu@lists.linux.dev>, <yangyingliang@huawei.com>,
	<wangxiongfeng2@huawei.com>
Subject: [PATCH 1/2] iommu/vt-d: Fix PCI device reference count leak in has_external pci()
Date: Mon, 21 Nov 2022 19:36:48 +0800
Message-ID: <20221121113649.190393-2-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221121113649.190393-1-wangxiongfeng2@huawei.com>
References: <20221121113649.190393-1-wangxiongfeng2@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected

for_each_pci_dev() is implemented by pci_get_device(). The comment of
pci_get_device() says that it will increase the reference count for the
returned pci_dev and also decrease the reference count for the input
pci_dev @from if it is not NULL.

If we break for_each_pci_dev() loop with pdev not NULL, we need to call
pci_dev_put() to decrease the reference count. Add the missing
pci_dev_put() before 'return true' to avoid reference count leak.

Fixes: 89a6079df791 ("iommu/vt-d: Force IOMMU on for platform opt in hint")
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/iommu/intel/iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 996a8b5ee5ee..1343b13fb1c2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3854,8 +3854,10 @@ static inline bool has_external_pci(void)
 	struct pci_dev *pdev = NULL;
 
 	for_each_pci_dev(pdev)
-		if (pdev->external_facing)
+		if (pdev->external_facing) {
+			pci_dev_put(pdev);
 			return true;
+		}
 
 	return false;
 }
-- 
2.20.1

