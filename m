Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCDF1DF738
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730138337; cv=none; b=mxCM4qyi4sofemRzfQVmP+AQ22T8+2vlwCq1YfZn7nLw7KKDAR0rT1h4MYxJ+gFI4xNH5Weg7nMNjO+8E65xAiKsyAotZ5IuPObgbv92YVpsH2SH/vz80cxrmxdDvw8yBFQndjwNVEpQOD3HeMIb4oTpLNAdbr12z32gYXUbTiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730138337; c=relaxed/simple;
	bh=wocp5ZvXcnsvqZIOtPa6wvGa1zqRtBzitdBAQsMdU4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BBCRFYeWhuTTnXC3bVWDItsYjuei9tYBnBzgBb8QU8aelTHBoA9vs6Pe/fZwvd3T8o5ItuBJsz0LqcBLLL3jWUbpkvFSQtx+UBvhH8AR706+oQihE6gChfQewePxHKk90VLSqANOUBww7wSnjJAp7r0uGeMeA9mBhGBBb8dsc9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0511213D5;
	Mon, 28 Oct 2024 10:59:19 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 421D43F66E;
	Mon, 28 Oct 2024 10:58:47 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org,
	laurent.pinchart@ideasonboard.com,
	mchehab@kernel.org,
	andersson@kernel.org,
	mathieu.poirier@linaro.org
Cc: hns@goldelico.com,
	b-padhi@ti.com,
	andreas@kemnade.info,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: [PATCH 1/4] remoteproc/omap: Handle ARM dma_iommu_mapping
Date: Mon, 28 Oct 2024 17:58:35 +0000
Message-Id: <6186e311cb6f64a787f87fd41e49a73f409b789c.1730136799.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1730136799.git.robin.murphy@arm.com>
References: <cover.1730136799.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's no longer practical for the OMAP IOMMU driver to trick
arm_setup_iommu_dma_ops() into ignoring its presence, so let's use the
same tactic as other IOMMU API users on 32-bit ARM and explicitly kick
the arch code's dma_iommu_mapping out of the way to avoid problems.

Fixes: 4720287c7bf7 ("iommu: Remove struct iommu_ops *iommu from arch_setup_dma_ops()")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/remoteproc/omap_remoteproc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index 9ae2e831456d..3260dd512491 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -37,6 +37,10 @@
 
 #include <linux/platform_data/dmtimer-omap.h>
 
+#ifdef CONFIG_ARM_DMA_USE_IOMMU
+#include <asm/dma-iommu.h>
+#endif
+
 #include "omap_remoteproc.h"
 #include "remoteproc_internal.h"
 
@@ -1323,6 +1327,19 @@ static int omap_rproc_probe(struct platform_device *pdev)
 	/* All existing OMAP IPU and DSP processors have an MMU */
 	rproc->has_iommu = true;
 
+#ifdef CONFIG_ARM_DMA_USE_IOMMU
+	/*
+	 * Throw away the ARM DMA mapping that we'll never use, so it doesn't
+	 * interfere with the core rproc->domain and we get the right DMA ops.
+	 */
+	if (pdev->dev.archdata.mapping) {
+		struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(&pdev->dev);
+
+		arm_iommu_detach_device(&pdev->dev);
+		arm_iommu_release_mapping(mapping);
+	}
+#endif
+
 	ret = omap_rproc_of_get_internal_memories(pdev, rproc);
 	if (ret)
 		return ret;
-- 
2.39.2.101.g768bb238c484.dirty

