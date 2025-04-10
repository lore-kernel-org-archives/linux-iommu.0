Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4323267F7E
	for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744284243; cv=none; b=eEHDR/pSTQV2jDb6qYklTsZLWGfiHkNUPhWiPFZqeLLaGpvMp7FoHbAs92/fDIGlAAewWTJc2crMMuLKn6i2seQs0y3skr3++AZ1g10sh83+OG8Dm5/pz8PM7BYtS/Wl9dfoiktxrpgv+GogQ9o40DVKNuShQUNj+c5o3mtMtTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744284243; c=relaxed/simple;
	bh=ZpJRcgRPPvr1dbeU8awzO83J0hZZRmNCC19u/pWXEYI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KE5Gvq8nazoGrW8S0GHfqoxo0qGyR9xpaTX0+zCRSHOBDLocXgkC36YIKJulyAaPAQUhBOPDd7k8bwnlWu1LIxjUCqP50jxPZKbZ8wz07kMOnYxXzXRV42yvv/Jl63y5pTHcxzfbxs2d8KxkjU245FsrX5wmb8GU7dxmW/Gfw4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3630E106F;
	Thu, 10 Apr 2025 04:24:01 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3B3293F6A8;
	Thu, 10 Apr 2025 04:24:00 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH] iommu: Clear iommu-dma ops on cleanup
Date: Thu, 10 Apr 2025 12:23:48 +0100
Message-Id: <e788aa927f6d827dd4ea1ed608fada79f2bab030.1744284228.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If iommu_device_register() encounters an error, it can end up tearing
down already-configured groups and default domains, however this
currently still leaves devices hooked up to iommu-dma (and even
historically the behaviour in this area was at best inconsistent across
architectures/drivers...) Although in the case that an IOMMU is present
whose driver has failed to probe, users cannot necessarily expect DMA to
work anyway, it's still arguable that we should do our best to put
things back as if the IOMMU driver was never there at all, and certainly
the potential for crashing in iommu-dma itself is undesirable. Make sure
we clean up the dev->dma_iommu flag along with everything else.

Reported-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c8033ca66377..095f9e9afe8c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -538,6 +538,9 @@ static void iommu_deinit_device(struct device *dev)
 	dev->iommu_group = NULL;
 	module_put(ops->owner);
 	dev_iommu_free(dev);
+#ifdef CONFIG_IOMMU_DMA
+	dev->dma_iommu = false;
+#endif
 }
 
 static struct iommu_domain *pasid_array_entry_to_domain(void *entry)
-- 
2.39.2.101.g768bb238c484.dirty

