Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B5A218E82
	for <iommu@lists.linux.dev>; Thu,  5 Dec 2024 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416451; cv=none; b=qf45OTfdnFwZGWTaND6X4HmeBJDivOQVLKiK/oWudxfo3zc8n381GFbovZHgez4VdS5zj+lJHKNEbZfiXwWldOmPND3n3Wa1bPSMIO0dYD9VFJVrBxlDwC1t6zU5GSHflhz0sLoVxA7Mj8NSKQ0bn4H0YbrgO+xJ7Sq+mDOAyJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416451; c=relaxed/simple;
	bh=Ynf1V0ATUEO3xbCg+BhQRoiMEDll+MxtOj59L5XcdMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Th6uqkcqepEysr038gbcx7Qeb5xKEmgAOVOf5JyTfT2djRAd8qGjKT0dI3omf96GFln0fZpu4xfYMPzFT6OxBxtnR+bIwB4u1VVvUKEiy0Gf9C8KipZf17tAibtsiCJ1pIAr+bcuI2l/hnSfyxaCGBRF41thGpPHFmr9lH+F1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29AA016F8;
	Thu,  5 Dec 2024 08:34:37 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 37F063F5A1;
	Thu,  5 Dec 2024 08:34:08 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	joro@8bytes.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	quic_pbrahma@quicinc.com
Subject: [PATCH v2 2/4] iommu/arm-smmu: Retire probe deferral workaround
Date: Thu,  5 Dec 2024 16:33:56 +0000
Message-Id: <4167c5dfa052d4c8bb780f0a30af63dcfc4ce6c1.1733406914.git.robin.murphy@arm.com>
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

This reverts commit 229e6ee43d2a160a1592b83aad620d6027084aad.

Now that the fundamental ordering issue between arm_smmu_get_by_fwnode()
and iommu_device_register() is resolved, the race condition for client
probe no longer exists either, so retire the specific workaround.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: New

 drivers/iommu/arm/arm-smmu/arm-smmu.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 0949f2734e5d..79afc92e1d8b 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1437,17 +1437,6 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 			goto out_free;
 	} else {
 		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
-
-		/*
-		 * Defer probe if the relevant SMMU instance hasn't finished
-		 * probing yet. This is a fragile hack and we'd ideally
-		 * avoid this race in the core code. Until that's ironed
-		 * out, however, this is the most pragmatic option on the
-		 * table.
-		 */
-		if (!smmu)
-			return ERR_PTR(dev_err_probe(dev, -EPROBE_DEFER,
-						"smmu dev has not bound yet\n"));
 	}
 
 	ret = -EINVAL;
-- 
2.39.2.101.g768bb238c484.dirty

