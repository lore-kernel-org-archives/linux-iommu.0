Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB301FE10C
	for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423008; cv=none; b=mWUFkbtbmTFyT54EoNbFKVVES+V2p5lOjHEgzxx/M+Rr8QaMcpr6m54epcMTCT5gV80nc96H3DL8i2LobC1rF3hHm+hevl5S5txr/JYC+XtROy0tW3OfOW6YRK4UGHiw6nIm/7lw2FzdQxA7PPl6+k88dUx5QqO39wdvPBHE/y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423008; c=relaxed/simple;
	bh=D41hHMLFdGUJxe/VbLR9+pcP3QsA72MuzITTbh+PY6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hc3VeNG+7XSpeqFDs2wZ0ipNrlvEhELyhjJ8pVqNGaYa9MUm5hQyvD1Ziw5D7EgFLGi6yx10omNc7ti2ppzB7RtTcUbZrGvbm/Au1IZT9f1K9zv2mRCw5zztMBlCQTIQo5PBxDu0XY1Ku/ap6iCMAid36XIAkPNvRtVwyRwB4jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5937A25E3;
	Tue, 12 Nov 2024 06:50:34 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 84F1F3F66E;
	Tue, 12 Nov 2024 06:50:03 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	joro@8bytes.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2.5/3] iommu/arm-smmu-v3: Undo SMMU enable on probe failure
Date: Tue, 12 Nov 2024 14:49:59 +0000
Message-Id: <0812e9f61234cbcdc5cab7de307e1c9a8e3c9498.1731422868.git.robin.murphy@arm.com>
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

If SMMU probe fails afer arm_smmu_device_reset(), we leave the SMMU
enabled with an empty Stream Table, silently blocking all DMA. This
proves rather annoying for debugging said probe failure, so let's handle
it a bit better by putting the SMMU back into (more or less) the same
state as if it hadn't probed at all.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7908fca962fe..566d66e9c91e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4640,6 +4640,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	iommu_device_sysfs_remove(&smmu->iommu);
 free_iopf:
 	iopf_queue_free(smmu->evtq.iopf);
+	arm_smmu_device_disable(smmu);
 	return ret;
 }
 
-- 
2.39.2.101.g768bb238c484.dirty

