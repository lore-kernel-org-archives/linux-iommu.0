Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7639A1DEFC8
	for <iommu@lists.linux.dev>; Tue,  8 Oct 2024 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393470; cv=none; b=VaAN2CVRAlDV6Rl5FcAmHW9DaGUqe0ccFCLL5/M4GfVn9P1xHlZ3GS6I2Y4Xx3Gpym4FlADAZwOTncy5jDU98YeIh5SfNVUO42HTI37ZpjvQ/YPvRYho06h9gQJXaEvouY2aaXPnBKm1ShDR5rrjRDUm8ifqHxuMbSfjqTy5AQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393470; c=relaxed/simple;
	bh=b3gscylhJq0HJq57Wu9T5f3FPDlL8fSY3iQUh87Ep0w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P+D8Os5la6ibpuMZNtmC3zC6IrO0II4tskYKklN6cdIkm+FGO++0wYTQgg3WHKGjN2Ppje/PAYGhjhNEclhc1lNZK3L7WJj4ie79W6JVs3Oo20zLHj6PXsmw80a9xVE1rzks2S2puAktqilmL7okMGLBfto6GkzHNxl+L4Ackdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E17DDA7;
	Tue,  8 Oct 2024 06:18:18 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B840B3F640;
	Tue,  8 Oct 2024 06:17:47 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	jgg@nvidia.com,
	linux-omap@vger.kernel.org,
	Beleswar Padhi <b-padhi@ti.com>,
	"H . Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] iommu/omap: Don't register ops by fwnode
Date: Tue,  8 Oct 2024 14:17:38 +0100
Message-Id: <c44545c6d07c65d89daa297298c27bb0f15c8b84.1728393458.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OMAP driver still has its own traditional firmware parsing and
instance handling in omap_iommu_probe_device(), rather than using the
generic fwnode-based paths. However, it also passes a hwdev to
iommu_device_register(), thus registering a fwnode for each ops
instance, wherein __iommu_probe_device() then fails to find matching ops
for a client device with no fwspec and thus a NULL iommu_fwnode.

Since omap-iommu is not known to coexist with any other IOMMU hardware
and shares the same ops between all instances, we can reasonably remove
the hwdev/fwnode registration to put it back into "legacy" mode where
the ops are effectively global and ->probe_device remains responsible
for filtering individual clients.

Reported-by: Beleswar Padhi <b-padhi@ti.com>
Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
Fixes: 17de3f5fdd35 ("iommu: Retire bus ops")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/omap-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index c9528065a59a..425ae8e551dc 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1230,7 +1230,7 @@ static int omap_iommu_probe(struct platform_device *pdev)
 		if (err)
 			return err;
 
-		err = iommu_device_register(&obj->iommu, &omap_iommu_ops, &pdev->dev);
+		err = iommu_device_register(&obj->iommu, &omap_iommu_ops, NULL);
 		if (err)
 			goto out_sysfs;
 		obj->has_iommu_driver = true;
-- 
2.39.2.101.g768bb238c484.dirty

