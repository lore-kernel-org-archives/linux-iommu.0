Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E64748A
	for <iommu@lists.linux.dev>; Wed,  2 Aug 2023 13:32:38 +0000 (UTC)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RGCWb56XDzLnvv;
	Wed,  2 Aug 2023 21:29:47 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 21:32:30 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<yuehaibing@huawei.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] iommu/amd: Remove unsued extern declaration amd_iommu_init_hardware()
Date: Wed, 2 Aug 2023 21:32:01 +0800
Message-ID: <20230802133201.17512-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected

From: YueHaibing <yuehaibing@huawei.com>

Commit 2c0ae1720c09 ("iommu/amd: Convert iommu initialization to state machine")
left behind this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/amd-iommu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 953e6f12fa1c..99a5201d9e62 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -32,7 +32,6 @@ struct task_struct;
 struct pci_dev;
 
 extern int amd_iommu_detect(void);
-extern int amd_iommu_init_hardware(void);
 
 /**
  * amd_iommu_init_device() - Init device for use with IOMMUv2 driver
-- 
2.34.1

