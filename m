Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5C63D34B3
	for <iommu@lists.linux.dev>; Wed,  8 Apr 2026 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775659274; cv=none; b=NEh6EiaeK4RTG4Kv4CW1KRl2I6tGogbBMPzX5tKPu+vwqBQoy8uSaP6ldMvgeh0R2ZsKUhtyI+IVm14vrOzErhMVE0Yqwq1LZMAxJscyVMCZakgd06sB6TKq6pNWKW9uz/y8k5KtaiX34g6MQeMwemmB/Wf03yl6CLYzqA4LbLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775659274; c=relaxed/simple;
	bh=y05l+7axM5lCe8iitjpmvxxTZNxo3J5J7EUoq+IaEg8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SPCLEAR0CSepBFW9MD2cyOyv3ZWmAg+o4P14u6YMDc+Q5WSOGXykzWT3fphrnsePxnXl1b/5p3vtZP6HrKdUq1CKiBZuBs9r99go8ikIG1qRJ/ZE/jCfcf6OE8gbDHs+guK7LiWS3uL2RovD/H3iDFV5lpxCZ+dlYeqm70ZAU2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IC4CxZIR; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IC4CxZIR"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82768288E;
	Wed,  8 Apr 2026 07:41:05 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DD8B03F632;
	Wed,  8 Apr 2026 07:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775659271; bh=y05l+7axM5lCe8iitjpmvxxTZNxo3J5J7EUoq+IaEg8=;
	h=From:To:Cc:Subject:Date:From;
	b=IC4CxZIRyZWtlUKqlotiuifBR1pcqv6qRTnrwVIyVNt3PqcPG0zZnCcji9G1Ermvt
	 OmfN+3/TvkBsOb2d302p7sZxTMAc43FuEuC8aMAR4PqibA0yetDjSfxY61hAJmuX+z
	 UtqyQbArhyVxC9ec/h/04T4lGkBbU+6F5FM79oY4=
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: jgg@nvidia.com,
	linux@armlinux.org.uk,
	iommu@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] iommu: Ensure .iotlb_sync is called correctly
Date: Wed,  8 Apr 2026 15:40:57 +0100
Message-Id: <8982e3412563cf91e106d59228dfb6115024c75e.1775659257.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many drivers have no reason to use the iotlb_gather mechanism, but do
still depend on .iotlb_sync being called to properly complete an unmap.
Since the core code is now relying on the gather to detect when there
is legitimately something to sync, it should also take care of encoding
a successful unmap when the driver does not touch the gather itself.

Fixes: 90c5def10bea ("iommu: Do not call drivers for empty gathers")
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Closes: https://lore.kernel.org/r/8800a38b-8515-4bbe-af15-0dae81274bf7@nvidia.com
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 50718ab810a4..ee83850c7060 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2717,6 +2717,12 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 
 		pr_debug("unmapped: iova 0x%lx size 0x%zx\n",
 			 iova, unmapped_page);
+		/*
+		 * If the driver itself isn't using the gather, make sure
+		 * it looks non-empty so iotlb_sync will still be called.
+		 */
+		if (iotlb_gather->start >= iotlb_gather->end)
+			iommu_iotlb_gather_add_range(iotlb_gather, iova, size);
 
 		iova += unmapped_page;
 		unmapped += unmapped_page;
-- 
2.39.2.101.g768bb238c484.dirty

