Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35832DDCD
	for <iommu@lists.linux.dev>; Wed,  2 Aug 2023 17:10:49 +0000 (UTC)
Received: from rrs24-12-35.corp.microsoft.com (unknown [131.107.147.181])
	by linux.microsoft.com (Postfix) with ESMTPSA id 30992238C43B;
	Wed,  2 Aug 2023 10:02:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 30992238C43B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1690995762;
	bh=oeSc+GkK/ZLJKOD7kmtbAT61HWgiUosa2UOiw2GfqGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hx+FXt8AW8JLtFEijOcaoT2b1eGBYaTP/edQHmJIogR6ryn6qxbSSJSjoKcCw2BnC
	 58kdLAw8DgwpSiuwo/jD5CUjwPZZwhfdAxdVT+TNCWb+2nozwB9FOtZSVGrtAro1mf
	 OqRA+tMcW8PqXNH7ZtP89uQunwUAroBWFzUIKGSc=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: easwar.hariharan@microsoft.com,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Sasha Levin <sashal@kernel.org>,
	Tomas Krcka <krckatom@amazon.de>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	iommu@lists.linux-foundation.org (open list:IOMMU DRIVERS),
	iommu@lists.linux.dev (open list:IOMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 5.15 5/6] iommu/arm-smmu-v3: Add explicit feature for nesting
Date: Wed,  2 Aug 2023 17:02:26 +0000
Message-Id: <20230802170227.1590187-6-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802170227.1590187-1-eahariha@linux.microsoft.com>
References: <20230802170227.1590187-1-eahariha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Robin Murphy <robin.murphy@arm.com>

commit 1d9777b9f3d55b4b6faf186ba4f1d6fb560c0523 upstream

In certain cases we may want to refuse to allow nested translation even
when both stages are implemented, so let's add an explicit feature for
nesting support which we can control in its own right. For now this
merely serves as documentation, but it means a nice convenient check
will be ready and waiting for the future nesting code.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Link: https://lore.kernel.org/r/136c3f4a3a84cc14a5a1978ace57dfd3ed67b688.1683731256.git.robin.murphy@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6a551a48d271..7cec4a457d91 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3703,6 +3703,10 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	smmu->ias = max(smmu->ias, smmu->oas);
 
+	if ((smmu->features & ARM_SMMU_FEAT_TRANS_S1) &&
+	    (smmu->features & ARM_SMMU_FEAT_TRANS_S2))
+		smmu->features |= ARM_SMMU_FEAT_NESTING;
+
 	arm_smmu_device_iidr_probe(smmu);
 
 	if (arm_smmu_sva_supported(smmu))
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index abaecdf8d5d2..c594a9b46999 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -646,6 +646,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_BTM		(1 << 16)
 #define ARM_SMMU_FEAT_SVA		(1 << 17)
 #define ARM_SMMU_FEAT_E2H		(1 << 18)
+#define ARM_SMMU_FEAT_NESTING		(1 << 19)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
-- 
2.25.1

