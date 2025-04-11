Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8C41F2377
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380563; cv=none; b=dQ8JPlww8MiJ02EeDoWutU0odCyB20BMGXkErPHeEDSSzkloglKdAnk7el4zTzc+t4wpJq3eWno7KKH8k3q2S0weViLa/SObtyqv2lSa7S74DBZO7SE+WQnR5UpmqEVhZOvppb+o14Bfhc4hsOiGncZaKeqsvmdd1yI5lSer/O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380563; c=relaxed/simple;
	bh=IQaH/afd5OTAHh/7f0s8I7064Ao0XSOI+4MsTFdZBTw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HyMDfEzj1OGD+7g74sVEDNq54rXAJLl5bNS8gtz6gobamYMFpVZLHYsdc6la5BlqwjZ40rF/bxpD2wQiwQWscoy8/F6/jsEjnN6ozlDfmtrkq02vwRqHIC33E2NFsT9jPVf1A+pNHFrn5AUZFnFA11W/UqDpAEI+EI2faW0y9/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12CA8106F;
	Fri, 11 Apr 2025 07:09:20 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 84E8D3F694;
	Fri, 11 Apr 2025 07:09:19 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	jgg@nvidia.com,
	nicolinc@nvidia.com
Subject: [PATCH] iommu/arm-smmu-v3: Fail aliasing StreamIDs more gracefully
Date: Fri, 11 Apr 2025 15:09:14 +0100
Message-Id: <39d54e49c8476efc4653e352150d44b185d6d50f.1744380554.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We've never supported StreamID aliasing between devices, and as such
they will never have had functioning DMA, but this is not fatal to the
SMMU itself. Although aliasing between hard-wired platform device
StreamIDs would tend to raise questions about the whole system, in
practice it's far more likely to occur relatively innocently due to
legacy PCI bridges, where the underlying StreamID mappings are still
perfectly reasonable.

As such, return a more benign -ENODEV when failing probe for such an
unsupported device (and log a more obvious error message), so that it
doesn't break the entire SMMU probe now that bus_iommu_probe() runs in
the right order and can propagate that error back. The end result is
still that the device doesn't get an IOMMU group and probably won't
work, same as before.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b4c21aaed126..c06459f7077b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3400,9 +3400,9 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		/* Insert into SID tree */
 		if (rb_find_add(&new_stream->node, &smmu->streams,
 				arm_smmu_streams_cmp_node)) {
-			dev_warn(master->dev, "stream %u already in tree\n",
+			dev_warn(master->dev, "Aliasing StreamID 0x%x unsupported, expect DMA to be broken\n",
 				 sid);
-			ret = -EINVAL;
+			ret = -ENODEV;
 			break;
 		}
 	}
-- 
2.39.2.101.g768bb238c484.dirty

