Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508968C13
	for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 12:39:02 +0000 (UTC)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rc0zZ3xVKz1L9Fs;
	Thu, 31 Aug 2023 20:37:14 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 31 Aug
 2023 20:38:53 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux-tegra@vger.kernel.org>, <iommu@lists.linux.dev>, Thierry Reding
	<thierry.reding@gmail.com>, Krishna Reddy <vdumpa@nvidia.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] iommu/tegra-smmu: Fix the NULL vs IS_ERR() bug for debugfs_create_dir()
Date: Thu, 31 Aug 2023 20:38:46 +0800
Message-ID: <20230831123846.3137304-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected

The debugfs_create_dir() function returns error pointers.
It never returns NULL. So use IS_ERR() to check it.

Fixes: d1313e7896e9 ("iommu/tegra-smmu: Add debugfs support")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/iommu/tegra-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index e445f80d0226..cd1d80c4c673 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1056,7 +1056,7 @@ DEFINE_SHOW_ATTRIBUTE(tegra_smmu_clients);
 static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
 {
 	smmu->debugfs = debugfs_create_dir("smmu", NULL);
-	if (!smmu->debugfs)
+	if (IS_ERR(smmu->debugfs))
 		return;
 
 	debugfs_create_file("swgroups", S_IRUGO, smmu->debugfs, smmu,
-- 
2.34.1

