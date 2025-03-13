Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FDC225D6
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887077; cv=none; b=cMbQdvpl6WFMMWp/GNjOxPsx/tzBS/TXgompJCWv+mvdz3Wf89YnSJlxI00Psy2egW29aF7vLh4PS9TtBYe5RIeiQBKmtbgwA64bAOHytbTToHZEKcKW/O+SuyemWYsTN+MQBcY29qnMyioYKhMzYJE+UNjrAZ4BSCSYGzt7Vag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887077; c=relaxed/simple;
	bh=s/lsaVfHO4XLmDszHNOKY4qu4AGmPwv56g0kKxbvTUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UNkSs2b1n/grtKWKOglIMh87zO0Tc9YnY2qvnMqrv9CbC2lDGDrBfy1bNuqlBhr3eeAW83ohzBCKoQYLHZKtFWlrAjCRUQCEJThBIOvaawdlxqcav6pwRVZqUlEQqVAUhDs4ASs2jRUkWilSTTS/O5+Mgb/bu62AyQbV6qawLRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5F16150C;
	Thu, 13 Mar 2025 10:31:25 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5101C3F673;
	Thu, 13 Mar 2025 10:31:14 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	heiko@sntech.de,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 1/3] iommu/rockchip: Allocate per-device data sensibly
Date: Thu, 13 Mar 2025 17:31:04 +0000
Message-Id: <771e91cf16b3048e93f657153b76905665878fa2.1741886382.git.robin.murphy@arm.com>
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

Now that DT-based probing is finally happening in the right order again,
it reveals an issue in Rockchip's of_xlate, which can now be called
during registration, but is using the global dma_dev which is only
assigned later. However, this makes little sense when we're already
looking up the correct IOMMU device, who should logically be the owner
of the devm allocation anyway.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/rockchip-iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 323cc665c357..48826d1ccfd8 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1148,12 +1148,12 @@ static int rk_iommu_of_xlate(struct device *dev,
 	struct platform_device *iommu_dev;
 	struct rk_iommudata *data;
 
-	data = devm_kzalloc(dma_dev, sizeof(*data), GFP_KERNEL);
+	iommu_dev = of_find_device_by_node(args->np);
+
+	data = devm_kzalloc(&iommu_dev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	iommu_dev = of_find_device_by_node(args->np);
-
 	data->iommu = platform_get_drvdata(iommu_dev);
 	data->iommu->domain = &rk_identity_domain;
 	dev_iommu_priv_set(dev, data);
-- 
2.39.2.101.g768bb238c484.dirty

