Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7445DAD5E
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887079; cv=none; b=QV/NwxDJ46tZlmUXzUOwcHY7lYwXt3U2JrKru55FzfVwkfUqhsX6PKKovtODQ9pPZNiHU5Iu2f9nPcHca4ctT0CxQ9/8mafSgojUGxIlxqe65spx0zmE9OxTH1qvj5ehFO3CPfSFHbxb9wuLOfflrTJaHk+99XqPgjk/Op4PR34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887079; c=relaxed/simple;
	bh=xqFKTWSUwefa3IQqf8Cs12OwyrtvbxpXOhnWmVULs5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D0tYLV8pagJyZHQzXEabZ74ItpIQYpJGAVBJ61AFcOob6VZk3MsVHYQtIQoHDrdtQga7d1hoF/AxaRk6zZZY9mdQjI5yB5e+CI58ZONy6AdHBRFSVo28/FdESETb0+8q6s9D5kirfNNQ0NflNo/LeyKZsM3DMEozPeGVItQjPFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23CA11515;
	Thu, 13 Mar 2025 10:31:27 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D1D533F673;
	Thu, 13 Mar 2025 10:31:15 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	heiko@sntech.de
Subject: [PATCH 2/3] iommu/rockchip: Register in a sensible order
Date: Thu, 13 Mar 2025 17:31:05 +0000
Message-Id: <e69532f00bf49d98322b96788edb7e2e305e4006.1741886382.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1741886382.git.robin.murphy@arm.com>
References: <cover.1741886382.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently Rockchip calls iommu_device_register() before it's finished
setting up the hardware and driver state, and as such it now gets
unhappy in various ways when registration starts working the way it was
always intended to, and probing client devices straight away. Reorder
the operations to ensure that what we're registering is a prepared and
functional IOMMU instance.

Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/rockchip-iommu.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 48826d1ccfd8..9d2120a9232a 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1256,14 +1256,6 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
-	if (err)
-		goto err_unprepare_clocks;
-
-	err = iommu_device_register(&iommu->iommu, &rk_iommu_ops, dev);
-	if (err)
-		goto err_remove_sysfs;
-
 	/*
 	 * Use the first registered IOMMU device for domain to use with DMA
 	 * API, since a domain might not physically correspond to a single
@@ -1290,12 +1282,19 @@ static int rk_iommu_probe(struct platform_device *pdev)
 
 	dma_set_mask_and_coherent(dev, rk_ops->dma_bit_mask);
 
+	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
+	if (err)
+		goto err_pm_disable;
+
+	err = iommu_device_register(&iommu->iommu, &rk_iommu_ops, dev);
+	if (err)
+		goto err_remove_sysfs;
+
 	return 0;
-err_pm_disable:
-	pm_runtime_disable(dev);
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
-err_unprepare_clocks:
+err_pm_disable:
+	pm_runtime_disable(dev);
 	clk_bulk_unprepare(iommu->num_clocks, iommu->clocks);
 	return err;
 }
-- 
2.39.2.101.g768bb238c484.dirty

