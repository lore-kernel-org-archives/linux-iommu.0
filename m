Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9357410E9
	for <iommu@lists.linux.dev>; Fri,  1 Jul 2022 07:40:07 +0000 (UTC)
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id VEM00054;
        Fri, 01 Jul 2022 15:37:54 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server id
 15.1.2507.9; Fri, 1 Jul 2022 15:37:53 +0800
From: Bo Liu <liubo03@inspur.com>
To: <joro@8bytes.org>, <will@kernel.org>, <suravee.suthikulpanit@amd.com>
CC: <iommu@lists.linux-foundation.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] iommu/amd: Handle return of iommu_device_sysfs_add
Date: Fri, 1 Jul 2022 02:20:08 -0400
Message-ID: <20220701062008.6988-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid: 2022701153754142284bb54b59ca6fffe76b63419a9b2
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Message-ID: <20220701062008.uolUK1SVOP7xBQlNRF9TVD4jsGu0BGGen2LJCe3uqW4@z>

As iommu_device_sysfs_add() can fail, we should check the return value.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/iommu/amd/init.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 3c82d9c5f1c0..a3c4fdd40f04 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2058,8 +2058,11 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	amd_iommu_erratum_746_workaround(iommu);
 	amd_iommu_ats_write_check_workaround(iommu);
 
-	iommu_device_sysfs_add(&iommu->iommu, &iommu->dev->dev,
+	ret = iommu_device_sysfs_add(&iommu->iommu, &iommu->dev->dev,
 			       amd_iommu_groups, "ivhd%d", iommu->index);
+	if (ret)
+		return ret;
+
 	iommu_device_register(&iommu->iommu, &amd_iommu_ops, NULL);
 
 	return pci_enable_device(iommu->dev);
-- 
2.27.0

