Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4994046A7
	for <iommu@lists.linux.dev>; Thu, 26 Jan 2023 18:26:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEC2F14BF;
	Thu, 26 Jan 2023 10:27:18 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C45D63F71E;
	Thu, 26 Jan 2023 10:26:35 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	jgg@nvidia.com,
	baolu.lu@linux.intel.com
Subject: [PATCH v2 6/8] iommu/arm-smmu: Don't register fwnode for legacy binding
Date: Thu, 26 Jan 2023 18:26:21 +0000
Message-Id: <93678b819d70079797734d9a8b0ebdc5beca43d2.1674753627.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1674753627.git.robin.murphy@arm.com>
References: <cover.1674753627.git.robin.murphy@arm.com>
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

v2: No change

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

