Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC60D7B
	for <iommu@lists.linux.dev>; Sat, 22 Oct 2022 03:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Oydpo
	FCe9+Y0CII8gxzK+nMqaPhZXIic+yLDuWv+Suo=; b=ZsXsb73/Wl75+dVhKfVxN
	P3yF3IdJsm+Wn9rMJJiWhILq4h8/tilw7W5L8cPqOc6dUrW8CWrTLeoKgt5hXF8y
	Pr9aKYDoNV97ZMuV3jRlExhvswaypfsvazj/b3L3Em5hCvTNc2q7VD/9A/NjpjEf
	Ah071ZEfJkJ+11aZtY9qfQ=
Received: from localhost.localdomain (unknown [171.221.146.106])
	by smtp8 (Coremail) with SMTP id DMCowAAHqiRpWVNjXpmhjQ--.55403S4;
	Sat, 22 Oct 2022 10:46:19 +0800 (CST)
From: Chen Lin <chen45464546@163.com>
To: will@kernel.org
Cc: robin.murphy@arm.com,
	joro@8bytes.org,
	treding@nvidia.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chen Lin <chen.lin5@zte.com.cn>
Subject: [PATCH] iommu/arm-smmu: Warn once when the perfetcher errata patch fails to allpy
Date: Sat, 22 Oct 2022 10:45:59 +0800
Message-Id: <20221022024559.4913-1-chen45464546@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:DMCowAAHqiRpWVNjXpmhjQ--.55403S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw45XF4fKr43WF17tF4fZrb_yoWktFcEv3
	WrZrnrA34rArW7Ww1YqFySy3sYkr47ZrZ7Wr4Sv3s3Jr9rXFyrAanFqFn5Kw4xGFy0vFy7
	tF1YqayxJry7WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8nZ23UUUUU==
X-Originating-IP: [171.221.146.106]
X-CM-SenderInfo: hfkh0kqvuwkkiuw6il2tof0z/1tbiGhuinlaEDNVZLQAAsC

From: Chen Lin <chen.lin5@zte.com.cn>

Default reset value of secure banked register SMMU_sACR.cache_lock is 1.
If it is not been set to 0 by secure software(eg: atf), the non-secure 
linux cannot clear ARM_MMU500_ACTLR_CPRE bit. In this situation,
the prefetcher errata is not applied successfully, warn once.

Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
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

