Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB99256D
	for <iommu@lists.linux.dev>; Thu,  3 Nov 2022 22:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=dAvGo
	8hUVnCJdOaOHwloI5JQG/uqE/A2irutxgEtJ8c=; b=OV3Xnbb6nUIdXSokE6oN9
	lip5QPVy2fijo9pjyjm3UtwYrIqar5X1+K4XjI6+XFjkB9gJAabjzO50uySICzbQ
	RW4x/D225ulsj9UVOeRpQU6wS8KVU5nY7C+g7F3oT0q65dZ9oKfcLT83Ozsi47H5
	/5Ms7VIZJuimlv4tF/Rmks=
Received: from localhost.localdomain (unknown [171.221.150.41])
	by smtp10 (Coremail) with SMTP id DsCowABnmznpPmRjRFnrKg--.58971S4;
	Fri, 04 Nov 2022 06:21:44 +0800 (CST)
From: Chen Lin <chen45464546@163.com>
To: will@kernel.org
Cc: robin.murphy@arm.com,
	joro@8bytes.org,
	treding@nvidia.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chen Lin <chen45464546@163.com>
Subject: [PATCH] iommu/arm-smmu: Warn once when the perfetcher errata patch fails to apply
Date: Fri,  4 Nov 2022 06:21:21 +0800
Message-Id: <20221103222121.3051-1-chen45464546@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:DsCowABnmznpPmRjRFnrKg--.58971S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw45XF4fKr43WF1xXrW3Awb_yoWkCrcEv3
	Wru3srA34rArW7Ww1Yq3Way3s2kr47Zrn7Wr4Sq3s3JrnrXFyrAan2qF95Kw4xGFy0vFy2
	qF1Yg3yxJry7WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRNBTYUUUUUU==
X-Originating-IP: [171.221.150.41]
X-CM-SenderInfo: hfkh0kqvuwkkiuw6il2tof0z/xtbB2A+unmBHMc4a7wAAsK

Default reset value of secure banked register SMMU_sACR.cache_lock is 1.
If it is not been set to 0 by secure software(eg: atf), the non-secure 
linux cannot clear ARM_MMU500_ACTLR_CPRE bit. In this situation,
the prefetcher errata is not applied successfully, warn once.

Signed-off-by: Chen Lin <chen45464546@163.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
index 658f3cc83278..2d2252b3e518 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
@@ -136,6 +136,9 @@ int arm_mmu500_reset(struct arm_smmu_device *smmu)
 		reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
 		reg &= ~ARM_MMU500_ACTLR_CPRE;
 		arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, reg);
+		reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
+		if (reg & ARM_MMU500_ACTLR_CPRE)
+			dev_warn_once(smmu->dev, "Failed to alpply prefetcher errata patch, check SMMU_sACR.cache_lock\n");
 	}
 
 	return 0;
-- 
2.25.1

