Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8745AB43F
	for <iommu@lists.linux.dev>; Thu, 19 Jan 2023 19:18:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E02CC106F;
	Thu, 19 Jan 2023 11:19:27 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 71A913F67D;
	Thu, 19 Jan 2023 11:18:45 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: hch@lst.de,
	jgg@nvidia.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] iommu/arm-smmu: Don't register fwnode for legacy binding
Date: Thu, 19 Jan 2023 19:18:23 +0000
Message-Id: <01c68ef4d924d3671016690fa946eab306a1de07.1673978700.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1673978700.git.robin.murphy@arm.com>
References: <cover.1673978700.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using the legacy binding we bypass the of_xlate mechanism, so avoid
registering the instance fwnodes which act as keys for that. This will
help __iommu_probe_device() to retrieve the registered ops the same way
as for x86 etc. when no fwspec has previously been set up by of_xlate.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 719fbca1fe52..607f06af01b6 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -2156,7 +2156,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
+	err = iommu_device_register(&smmu->iommu, &arm_smmu_ops,
+				    using_legacy_binding ? NULL : dev);
 	if (err) {
 		dev_err(dev, "Failed to register iommu\n");
 		iommu_device_sysfs_remove(&smmu->iommu);
-- 
2.36.1.dirty

