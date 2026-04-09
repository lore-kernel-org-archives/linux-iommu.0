Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109A03C063B
	for <iommu@lists.linux.dev>; Thu,  9 Apr 2026 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775739593; cv=none; b=Cb8ayUDJPFQTDpZ9UBZtPTN6Xrg2VTE0DFTXARNJ1vP6RWEXmnst/XYCAxST+RQ8yXw8pDqcHZN8FJavGpRLfDTYt+ALeW8CkO6o3OwXiTxH4sdoaixcmWo4UQRzs7oO6KPumKwGUEEq1CK9Qeyx9K4eSj5OwFP7eL1if5gcEEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775739593; c=relaxed/simple;
	bh=4mjSmwYwqDeDBCI+476/c2pzTgbI2J4XyUIYa4sKdpM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tUtS1dv8VnfEtIzN5lKjH4HbRmRg0PhUHJJz+iqTd52AZCMj3MlYvid9jHRyqQ1OpE+sazqYeI3diPSMiS7CRSeREB5wsu81yPnYGwT/VhR5lxBfA8Ji7z2U+V9nMpuwg0XdSiz+ID3TGs92bcmgwKct16rdWL4W4ROdMFaKoc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Iwe9vtEW; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Iwe9vtEW"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 666172F9D;
	Thu,  9 Apr 2026 05:59:45 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EB5493F641;
	Thu,  9 Apr 2026 05:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775739591; bh=4mjSmwYwqDeDBCI+476/c2pzTgbI2J4XyUIYa4sKdpM=;
	h=From:To:Cc:Subject:Date:From;
	b=Iwe9vtEW7HobOS2KwDIt3cBb2OtwY9vxZbC1qoQ4p7XN7Qj5Ao79kXlkge11T6gvS
	 jEUxIyqe4PxpTe7cVzH1llCYf05pDE6FnPZ3OVeFH6nTu557m88YtRi2gWt/Zb7MxN
	 iEiiT0t192qabsf/oUGP6K0ty0xTzVrBrcvHYqCs=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	joro@8bytes.org
Cc: iommu@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	Jon Hunter <jonathanh@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH v2] iommu: Ensure .iotlb_sync is called correctly
Date: Thu,  9 Apr 2026 13:59:41 +0100
Message-Id: <3eed961d41d3a81460031dee9f1db066f1d2e111.1775739433.git.robin.murphy@arm.com>
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
Missing or incomplete TLB maintenance at this point can then wreak all
kinds of havoc, particularly in strict DMA mode where IOVAs may be
reused right away, if DMA traffic for a subsequent new mapping hits a
stale TLB entry and goes to the wrong physical address.

Since the core code is now relying on the gather to detect when there
is legitimately something to sync, it should also take care of encoding
a successful unmap when the driver does not touch the gather itself.

Fixes: 90c5def10bea ("iommu: Do not call drivers for empty gathers")
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Closes: https://lore.kernel.org/r/8800a38b-8515-4bbe-af15-0dae81274bf7@nvidia.com
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
v2: Add tags, clarify implications in commit message [rmk]

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

