Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1831CD2B
	for <iommu@lists.linux.dev>; Thu,  5 Dec 2024 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416450; cv=none; b=r0DPD0SFTegNTGznLemEBbyHtXzbM0NBIKqLimAPiCaIYVOkrG0YgoDpXlmMDkN/f4joZFqIiCHWTH3g27veopubRpd4skBWR2vQOcXXU0fqERybpLhKzh7paEmoKP6tUkgmcW2CgZvsAFhFmRzWWWYClMrE5FmLZYtw41drG5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416450; c=relaxed/simple;
	bh=uxJq0k+k9zJmmmjb/s7/QZED3KRAdFXCMCXhpOtndXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KwLT1caqdAAFEiuE6ILzg2rzuK6hNszQzPVApgh9RBw7kOYl3B7zmV+bmerlKZ8REEvY+RZZGdNzHuWv615+SbmlTvxEjyw2bU+XJBV896OuVzLWeOuFKZDET2RXP7Q6bhrMPfJZA+JxKjhcPw9GcOtsgQQEvkIutWOyIXgmAMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5F07169E;
	Thu,  5 Dec 2024 08:34:35 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 096273F5A1;
	Thu,  5 Dec 2024 08:34:06 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	joro@8bytes.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	quic_pbrahma@quicinc.com
Subject: [PATCH v2 1/4] iommu/arm-smmu: Make instance lookup robust
Date: Thu,  5 Dec 2024 16:33:55 +0000
Message-Id: <6d7ce1dc31873abdb75c895fb8bd2097cce098b4.1733406914.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1733406914.git.robin.murphy@arm.com>
References: <cover.1733406914.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Relying on the driver list was a cute idea for minimising the scope of
our SMMU device lookups, however it turns out to have a subtle flaw. The
SMMU device only gets added to that list after arm_smmu_device_probe()
returns success, so there's actually no way the iommu_device_register()
call from there could ever work as intended, even if it wasn't already
hampered by the fwspec setup not happening early enough.

Switch both arm_smmu_get_by_fwnode() implementations to use a platform
bus lookup instead, which *will* reliably work. Also make sure that we
don't register SMMUv2 instances until we've fully initialised them, to
avoid similar consequences of the lookup now finding a device with no
drvdata. Moving the error returns is also a perfect excuse to streamline
them with dev_err_probe() in the process.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Tweak commit message

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  4 +--
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 31 ++++++++++-----------
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a5c7002ff75b..e1eae4ecfa02 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3237,8 +3237,8 @@ static struct platform_driver arm_smmu_driver;
 static
 struct arm_smmu_device *arm_smmu_get_by_fwnode(struct fwnode_handle *fwnode)
 {
-	struct device *dev = driver_find_device_by_fwnode(&arm_smmu_driver.driver,
-							  fwnode);
+	struct device *dev = bus_find_device_by_fwnode(&platform_bus_type, fwnode);
+
 	put_device(dev);
 	return dev ? dev_get_drvdata(dev) : NULL;
 }
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 650664e0f6e3..0949f2734e5d 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1411,8 +1411,8 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 static
 struct arm_smmu_device *arm_smmu_get_by_fwnode(struct fwnode_handle *fwnode)
 {
-	struct device *dev = driver_find_device_by_fwnode(&arm_smmu_driver.driver,
-							  fwnode);
+	struct device *dev = bus_find_device_by_fwnode(&platform_bus_type, fwnode);
+
 	put_device(dev);
 	return dev ? dev_get_drvdata(dev) : NULL;
 }
@@ -2227,21 +2227,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 					i, irq);
 	}
 
-	err = iommu_device_sysfs_add(&smmu->iommu, smmu->dev, NULL,
-				     "smmu.%pa", &smmu->ioaddr);
-	if (err) {
-		dev_err(dev, "Failed to register iommu in sysfs\n");
-		return err;
-	}
-
-	err = iommu_device_register(&smmu->iommu, &arm_smmu_ops,
-				    using_legacy_binding ? NULL : dev);
-	if (err) {
-		dev_err(dev, "Failed to register iommu\n");
-		iommu_device_sysfs_remove(&smmu->iommu);
-		return err;
-	}
-
 	platform_set_drvdata(pdev, smmu);
 
 	/* Check for RMRs and install bypass SMRs if any */
@@ -2250,6 +2235,18 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	arm_smmu_device_reset(smmu);
 	arm_smmu_test_smr_masks(smmu);
 
+	err = iommu_device_sysfs_add(&smmu->iommu, smmu->dev, NULL,
+				     "smmu.%pa", &smmu->ioaddr);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to register iommu in sysfs\n");
+
+	err = iommu_device_register(&smmu->iommu, &arm_smmu_ops,
+				    using_legacy_binding ? NULL : dev);
+	if (err) {
+		iommu_device_sysfs_remove(&smmu->iommu);
+		return dev_err_probe(dev, err, "Failed to register iommu\n");
+	}
+
 	/*
 	 * We want to avoid touching dev->power.lock in fastpaths unless
 	 * it's really going to do something useful - pm_runtime_enabled()
-- 
2.39.2.101.g768bb238c484.dirty

