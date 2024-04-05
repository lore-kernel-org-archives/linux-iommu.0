Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9569617164B
	for <iommu@lists.linux.dev>; Fri,  5 Apr 2024 16:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335938; cv=none; b=G7Y6VxzRPyYnJ217iy6tugX8xZDfXXFd9Mt9sNJtQXM7wIa715Nrov6zjw3Bs26eTVkC8d2OyUpEblPovZi20yhBnMN1B2nNQaJ12p5OK9ye4ihJCFFFDwBPD+wIh7bCd0/XUNLfiwPNiJSn83u6bYOE5KA0i4RkiJ3L65a5zXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335938; c=relaxed/simple;
	bh=GvkVtk/ILH10QcBitICz24vLolUmiAVj3m7vk23vOnU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uzk7+/bYZ+oKp6OWXL7d2gIH55JU4graq8Fb/n4yZvrNUwUInYY55SVnV4WEFhbvHRAJci+DXv2MKf2e2QcjWBzF0EC8oHzTd+2i2i3801T/LK7/Gtm5OR7ZJfwo8CC1GPKvZMAXUlTlhS8LSnOfeBse8z0qTcE0Tv1IZHFV7Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84127FEC;
	Fri,  5 Apr 2024 09:52:46 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 310563F64C;
	Fri,  5 Apr 2024 09:52:15 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	joro@8bytes.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] iommu/arm-smmu-v3: Retire disable_bypass parameter
Date: Fri,  5 Apr 2024 17:52:07 +0100
Message-Id: <ea3ac4cd595a81b5511729601b2f7d4668178438.1712335927.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The disable_bypass parameter has been mostly meaningless for a long time
since the introduction of default domains. Its original intent is now
fulfilled by the controls users have over the default domain type, and
its remaining effect in the brief window between Stream Table
initialisation and default domain creation hardly seems worth the
complication. Furthermore, thanks to 2-level Stream Tables, disabling
disable_bypass (there's another reason not to like it right there) has
never guaranteed that any particular StreamID *will* bypass anyway - any
device which might actually care about that wants RMRs - so there's not
really much lost by taking away that option (which has already been
non-default for nearing 6 years now).

As part of this, also remove the weird behaviour where we "successfully"
probe and register a non-functional SMMU if the DT "#iommu-cells"
property is wrong. I have no memory of what possessed me to think that
was a good idea at the time, and by now I suspect it's likely to break
things worse than simply failing probe would.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 46 ++++++---------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 41f93c3ab160..4eb74f0ad13b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -30,11 +30,6 @@
 #include "arm-smmu-v3.h"
 #include "../../dma-iommu.h"
 
-static bool disable_bypass = true;
-module_param(disable_bypass, bool, 0444);
-MODULE_PARM_DESC(disable_bypass,
-	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
-
 static bool disable_msipolling;
 module_param(disable_msipolling, bool, 0444);
 MODULE_PARM_DESC(disable_msipolling,
@@ -1567,17 +1562,13 @@ static void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
  * This can safely directly manipulate the STE memory without a sync sequence
  * because the STE table has not been installed in the SMMU yet.
  */
-static void arm_smmu_init_initial_stes(struct arm_smmu_device *smmu,
-				       struct arm_smmu_ste *strtab,
+static void arm_smmu_init_initial_stes(struct arm_smmu_ste *strtab,
 				       unsigned int nent)
 {
 	unsigned int i;
 
 	for (i = 0; i < nent; ++i) {
-		if (disable_bypass)
-			arm_smmu_make_abort_ste(strtab);
-		else
-			arm_smmu_make_bypass_ste(smmu, strtab);
+		arm_smmu_make_abort_ste(strtab);
 		strtab++;
 	}
 }
@@ -1605,7 +1596,7 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 		return -ENOMEM;
 	}
 
-	arm_smmu_init_initial_stes(smmu, desc->l2ptr, 1 << STRTAB_SPLIT);
+	arm_smmu_init_initial_stes(desc->l2ptr, 1 << STRTAB_SPLIT);
 	arm_smmu_write_strtab_l1_desc(strtab, desc);
 	return 0;
 }
@@ -2915,10 +2906,10 @@ static void arm_smmu_release_device(struct device *dev)
 		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
 
 	/* Put the STE back to what arm_smmu_init_strtab() sets */
-	if (disable_bypass && !dev->iommu->require_direct)
-		arm_smmu_attach_dev_blocked(&arm_smmu_blocked_domain, dev);
-	else
+	if (dev->iommu->require_direct)
 		arm_smmu_attach_dev_identity(&arm_smmu_identity_domain, dev);
+	else
+		arm_smmu_attach_dev_blocked(&arm_smmu_blocked_domain, dev);
 
 	arm_smmu_disable_pasid(master);
 	arm_smmu_remove_master(master);
@@ -3273,7 +3264,7 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
 	reg |= FIELD_PREP(STRTAB_BASE_CFG_LOG2SIZE, smmu->sid_bits);
 	cfg->strtab_base_cfg = reg;
 
-	arm_smmu_init_initial_stes(smmu, strtab, cfg->num_l1_ents);
+	arm_smmu_init_initial_stes(strtab, cfg->num_l1_ents);
 	return 0;
 }
 
@@ -3503,7 +3494,7 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
 	return ret;
 }
 
-static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
+static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 {
 	int ret;
 	u32 reg, enables;
@@ -3513,7 +3504,6 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
 	if (reg & CR0_SMMUEN) {
 		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
-		WARN_ON(is_kdump_kernel() && !disable_bypass);
 		arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
 	}
 
@@ -3620,14 +3610,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	if (is_kdump_kernel())
 		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
 
-	/* Enable the SMMU interface, or ensure bypass */
-	if (!bypass || disable_bypass) {
-		enables |= CR0_SMMUEN;
-	} else {
-		ret = arm_smmu_update_gbpa(smmu, 0, GBPA_ABORT);
-		if (ret)
-			return ret;
-	}
+	/* Enable the SMMU interface */
+	enables |= CR0_SMMUEN;
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
 				      ARM_SMMU_CR0ACK);
 	if (ret) {
@@ -4019,7 +4003,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	resource_size_t ioaddr;
 	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
-	bool bypass;
 
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu)
@@ -4030,12 +4013,9 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		ret = arm_smmu_device_dt_probe(pdev, smmu);
 	} else {
 		ret = arm_smmu_device_acpi_probe(pdev, smmu);
-		if (ret == -ENODEV)
-			return ret;
 	}
-
-	/* Set bypass mode according to firmware probing result */
-	bypass = !!ret;
+	if (ret)
+		return ret;
 
 	/* Base address */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -4099,7 +4079,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	arm_smmu_rmr_install_bypass_ste(smmu);
 
 	/* Reset the device */
-	ret = arm_smmu_device_reset(smmu, bypass);
+	ret = arm_smmu_device_reset(smmu);
 	if (ret)
 		return ret;
 
-- 
2.39.2.101.g768bb238c484.dirty

