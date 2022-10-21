Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD567B
	for <iommu@lists.linux.dev>; Fri, 21 Oct 2022 03:53:24 +0000 (UTC)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MtrCt2xXBzHv1k;
	Fri, 21 Oct 2022 11:53:14 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 11:53:22 +0800
Received: from huawei.com (10.67.164.66) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 11:53:21 +0800
From: Longfang Liu <liulongfang@huawei.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<liulongfang@huawei.com>
Subject: [PATCH 2/2] iommu: fix smmu initialization memory leak problem
Date: Fri, 21 Oct 2022 11:51:47 +0800
Message-ID: <20221021035147.15292-3-liulongfang@huawei.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20221021035147.15292-1-liulongfang@huawei.com>
References: <20221021035147.15292-1-liulongfang@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected

When iommu_device_register() in arm_smmu_device_probe() fails,
in addition to sysfs needs to be deleted, device should also
be disabled, and the memory of iopf needs to be released to
prevent memory leak of iopf.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a1db07bed6a9..c70defb0c866 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3816,11 +3816,16 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
 	if (ret) {
 		dev_err(dev, "Failed to register iommu\n");
-		iommu_device_sysfs_remove(&smmu->iommu);
-		return ret;
+		goto err_sysfs_remove;
 	}
 
 	return 0;
+
+err_sysfs_remove:
+	iommu_device_sysfs_remove(&smmu->iommu);
+	arm_smmu_device_disable(smmu);
+	iopf_queue_free(smmu->evtq.iopf);
+	return ret;
 }
 
 static int arm_smmu_device_remove(struct platform_device *pdev)
-- 
2.24.0

