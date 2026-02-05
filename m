Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE270396B67
	for <iommu@lists.linux.dev>; Thu,  5 Feb 2026 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770284049; cv=none; b=uGtMO5kDYNT4f4lDlRqHiBbqhPaTzC3/rO17TYVBWL2jKlUD/tzInTWBkZ8knO87k1+JkTo+v9Y8lBm3Vc0/9ewMfBRjTrcvmmOTRFQWGaohxK/nYhQqEFKRhg2GxgKGyy4Ob8rSNYl6ddQE81P2CCOJ/S//+eONqlianQlpFyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770284049; c=relaxed/simple;
	bh=L8+8hHtf/3VrVO55nqtF5hrOPfzu68DB6z4ykUnqtcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RYcPlm8DOR6UrD32bU2j10XvPQqjhNRdDaYfjYXW0DmVqhRC7Ay3jkwkTQyj3t4fJBW+AqZt5RNVWMv7vAIUT+Q/SnddhniLV3io9elYN83sL8LlYw+1lEXBiJ9IYCoddKPpRyYReskrlRA5vhBiJjCr6XxBpeWiT7qNTK/XwKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCnr9MNZIRpxAQgAA--.13992S2;
	Thu, 05 Feb 2026 17:34:05 +0800 (CST)
Received: from localhost.localdomain (unknown [219.142.137.151])
	by mail (Coremail) with SMTP id AQAAfwBXse4HZIRpuDMZAA--.29205S2;
	Thu, 05 Feb 2026 17:34:00 +0800 (CST)
From: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
To: will@kernel.org,
	joro@8bytes.org
Cc: robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Subject: [PATCH] iommu/arm-smmu-v3: Restrict MMU-700 errata 2268618 and 2812531 to affected
Date: Thu,  5 Feb 2026 17:33:56 +0800
Message-ID: <20260205093356.4328-1-daizhiyuan@phytium.com.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwBXse4HZIRpuDMZAA--.29205S2
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=daizhiyuan
	@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Kw4UAr47Kry3tw43tFW5KFg_yoW8GrW8p3
	Z5G3sY93s8WF1fAa9rJ3yDZw15Gas5Aa15Jay5u390gryDKry5GryxKayjgF4kCrWUXF1f
	AF1vq3y5CF15ArJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

According to SDEN-1786925, Arm errata 2268618 and 2812531 are present in
r0p0, r0p1, and r1p0, and fixed in r1p1.

Introduce this patch to avoid performance degradation caused by
restricting features on unaffected revisions.

Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d16d35c78c06..7eadb27eb9be 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4272,11 +4272,13 @@ static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
 				smmu->features &= ~ARM_SMMU_FEAT_NESTING;
 			break;
 		case IIDR_PRODUCTID_ARM_MMU_700:
-			/* Arm erratum 2812531 */
-			smmu->features &= ~ARM_SMMU_FEAT_BTM;
-			smmu->options |= ARM_SMMU_OPT_CMDQ_FORCE_SYNC;
-			/* Arm errata 2268618, 2812531 */
-			smmu->features &= ~ARM_SMMU_FEAT_NESTING;
+			if (variant <= 1 && revision < 0) {
+				/* Arm erratum 2812531 */
+				smmu->features &= ~ARM_SMMU_FEAT_BTM;
+				smmu->options |= ARM_SMMU_OPT_CMDQ_FORCE_SYNC;
+				/* Arm errata 2268618, 2812531 */
+				smmu->features &= ~ARM_SMMU_FEAT_NESTING;
+			}
 			break;
 		}
 		break;
-- 
2.51.0

