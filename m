Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA89215C0
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731090629; cv=none; b=fki5gXUOGOtmwF87UiBvov62P7yZ424jedysHoCCrtyTBFIoxBDn7ErG9LGGod/Y2DzxhFBvQSVvK5UQv2yovBrV1t3nwQiD8KFpBDj0/KutYnISFabcmbuOVAWVcINL3kMYba8OBZCHxs5W9iwDhYHI/PyFf3oHov2gdpcNXfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731090629; c=relaxed/simple;
	bh=OpyD2OZVfEjrkK1uu2GbX1d0BcXGqF1vj/xV7O0n3Ss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nxSwKnJ3PO2t6vIPUPP9pUlPZR7YoUoVklM0dwx4oBFDWot3PLzjh+82l+7Uv30DvRzyP4B27L7ptXLW8UnCxNmP1rUwvkaXEAdY2nUwcaDwkFUQQ6cALypMGWpCQOk4w7AXRTp7PBdlcmGHxCUz11YJuIYECReekm1ZjrQnRh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D95091691;
	Fri,  8 Nov 2024 10:30:56 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 443B93F6A8;
	Fri,  8 Nov 2024 10:30:26 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	joro@8bytes.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] iommu: Manage driver probe deferral better
Date: Fri,  8 Nov 2024 18:30:17 +0000
Message-Id: <2da0ae7f76c7466176e906fa5d7a0ae5210e8650.1731088789.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1731088789.git.robin.murphy@arm.com>
References: <cover.1731088789.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since iommu_fwspec_init() absorbed the basic driver probe deferral
check to wait for an IOMMU to register, we may as well handle the probe
deferral timeout there as well. The current inconsistency of callers
results in client devices deferring forever on an arm64 ACPI system
where an SMMU has failed its own driver probe.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c    | 2 +-
 drivers/iommu/of_iommu.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 83c8e617a2c5..dc8d11b585cd 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2842,7 +2842,7 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode)
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
 	if (!ops)
-		return -EPROBE_DEFER;
+		return driver_deferred_probe_check_state(dev);
 
 	if (fwspec)
 		return ops == iommu_fwspec_ops(fwspec) ? 0 : -EINVAL;
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index e7a6a1611d19..97987cd78da9 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -29,8 +29,6 @@ static int of_iommu_xlate(struct device *dev,
 		return -ENODEV;
 
 	ret = iommu_fwspec_init(dev, of_fwnode_handle(iommu_spec->np));
-	if (ret == -EPROBE_DEFER)
-		return driver_deferred_probe_check_state(dev);
 	if (ret)
 		return ret;
 
-- 
2.39.2.101.g768bb238c484.dirty

