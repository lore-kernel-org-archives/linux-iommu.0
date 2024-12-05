Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC661CD2B
	for <iommu@lists.linux.dev>; Thu,  5 Dec 2024 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416452; cv=none; b=l5Xy491C31LYrJFsjLaOnIz3bfCbZ48X+1csAHeZd/Gx4XyQzgKE++VzVX+7edXRDH/RfCl5tdFlMjOccglEJnHpfqAYApHsNarPtNKSYOVHLp8Mi0+7MCqAuv/eAMe9kYVabR8/7N2rJ/d13VMQAtvp/HG2ZkgMpVYT7hf3XN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416452; c=relaxed/simple;
	bh=7mf+Srn1tUHSZb8qzo0KsJum6Bp7Sy+f6D8Oe7wPD+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cK8qdHomVdl90GwXfn9AST2mlEof1VA9EwB2dUW6XnMs+5Rsp1DV40pmksN7HPGFk7snekwU4wRVO3lt5zaXbaiTxHSJTp0pD9V+0hVrglMD6iTlCH4F7Yu8ohsbKbmI6JVQ5P6rDZSvQjvxx8gtcO2Bu54ZaDkgezah8aWI+g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 584F31713;
	Thu,  5 Dec 2024 08:34:38 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6FC153F5A1;
	Thu,  5 Dec 2024 08:34:09 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	joro@8bytes.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	quic_pbrahma@quicinc.com
Subject: [PATCH v2 3/4] iommu/arm-smmu-v3: Clean up more on probe failure
Date: Thu,  5 Dec 2024 16:33:57 +0000
Message-Id: <5137901958471cf67f2fad5c2229f8a8f1ae901a.1733406914.git.robin.murphy@arm.com>
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

kmemleak noticed that the iopf queue allocated deep down within
arm_smmu_init_structures() can be leaked by a subsequent error return
from arm_smmu_device_probe(). Furthermore, after arm_smmu_device_reset()
we will also leave the SMMU enabled with an empty Stream Table, silently
blocking all DMA. This proves rather annoying for debugging said probe
failure, so let's handle it a bit better by putting the SMMU back into
(more or less) the same state as if it hadn't probed at all.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Squash disable fix, get labels right

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e1eae4ecfa02..264a686d30cb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4663,7 +4663,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	/* Initialise in-memory data structures */
 	ret = arm_smmu_init_structures(smmu);
 	if (ret)
-		return ret;
+		goto err_free_iopf;
 
 	/* Record our private device structure */
 	platform_set_drvdata(pdev, smmu);
@@ -4674,22 +4674,29 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	/* Reset the device */
 	ret = arm_smmu_device_reset(smmu);
 	if (ret)
-		return ret;
+		goto err_disable;
 
 	/* And we're up. Go go go! */
 	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
 				     "smmu3.%pa", &ioaddr);
 	if (ret)
-		return ret;
+		goto err_disable;
 
 	ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
 	if (ret) {
 		dev_err(dev, "Failed to register iommu\n");
-		iommu_device_sysfs_remove(&smmu->iommu);
-		return ret;
+		goto err_free_sysfs;
 	}
 
 	return 0;
+
+err_free_sysfs:
+	iommu_device_sysfs_remove(&smmu->iommu);
+err_disable:
+	arm_smmu_device_disable(smmu);
+err_free_iopf:
+	iopf_queue_free(smmu->evtq.iopf);
+	return ret;
 }
 
 static void arm_smmu_device_remove(struct platform_device *pdev)
-- 
2.39.2.101.g768bb238c484.dirty

