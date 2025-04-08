Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6014C4A1E;
	Tue,  8 Apr 2025 03:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744083252; cv=none; b=aS0FueO6CF/Tq+tLwUD5buDdZAejaZ7YsZpabajLzKmAo0cK341uIz+w5W+l2nYt6Wntj6Rg1ZW2flQb2/2jTVOUsA6ktBsQVUqhdqnWl2erspAgHojlgX02IVLrn+TLvlVsFCEXRJIReV7NMDinWvdvXO+z6PYWDVRR4NqNw+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744083252; c=relaxed/simple;
	bh=TRxqNba1FVNttWXGyNADBZI4wo3jt4eA8mooq34DEqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gO210D7UBKvD5MKoTAfSxGvuAKGP7VK+iXN2YuOmINZMa1iD7FKzGxsnlP4B6LGz5OEm3UbWVeHHmHxc5c4JT5StbyJXoeFsfV7zB1t/JrwU+IqxhGs7fKBvY+qnWUG4MUXH9IzvcQKw6u1P4bO+XQPrEfpEscJSVeviX0aBdcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkH0jsbE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkH0jsbE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9841C4CEE5;
	Tue,  8 Apr 2025 03:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744083251;
	bh=TRxqNba1FVNttWXGyNADBZI4wo3jt4eA8mooq34DEqA=;
	h=From:To:Cc:Subject:Date:From;
	b=MkH0jsbEibXql9rWea8fM6DvGfJCXnaKvnY2KK7uAlW0WLmZX7A7Rya5MtvtOTxE8
	 b+2zFVPdiG0/g53IWf7F9Z3uu0p+Yxe+PmFE2df6tNYfe8pW3wTYLxp4hN3f0ojIVw
	 60YyYjiPIIRgyKNAZgaGgNoPvGSo0qcpLNygQGq71KamztoOPfmR/+hlfEqZDUfTlF
	 V1be6zCj7QreIaS2ldBZMjAIYJT7QHTXymtMzwFxLdUILxQevzlA/zEixv4cFF6VUL
	 sG/5vSVODbkTkyx/sPQFIPLOtr4eeFVMQDF44Uy2+sZdrSWTlGpfRibXMgbm+dchrK
	 ir3PFrZpX1Sxw==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org,
	robin.murphy@arm.com,
	jgg@ziepe.ca,
	nicolinc@nvidia.com,
	jsnitsel@redhat.com,
	praan@google.com,
	kevin.tian@intel.com,
	ddutile@redhat.com,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [PATCH] iommu/arm-smmu-v3: Add missing S2FWB feature detection
Date: Tue,  8 Apr 2025 09:03:51 +0530
Message-ID: <20250408033351.1012411-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 67e4fe398513 ("iommu/arm-smmu-v3: Use S2FWB for NESTED domains")
introduced S2FWB usage but omitted the corresponding feature detection.
As a result, vIOMMU allocation fails on FVP in arm_vsmmu_alloc(), due to
the following check:

	if (!arm_smmu_master_canwbs(master) &&
	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
		return ERR_PTR(-EOPNOTSUPP);

This patch adds the missing detection logic to prevent allocation
failure when S2FWB is supported.

Fixes: 67e4fe398513 ("iommu/arm-smmu-v3: Use S2FWB for NESTED domains")
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 358072b4e293..c7d297ceabdb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4405,6 +4405,8 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR3);
 	if (FIELD_GET(IDR3_RIL, reg))
 		smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
+	if (FIELD_GET(IDR3_FWB, reg))
+		smmu->features |= ARM_SMMU_FEAT_S2FWB;
 
 	/* IDR5 */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR5);
-- 
2.43.0

