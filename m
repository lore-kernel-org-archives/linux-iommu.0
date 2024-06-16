Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B207175B;
	Sun, 16 Jun 2024 22:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718577756; cv=none; b=pnXg2F4ORFqD3CeZ6KFk2y5BRp+b31PFFGCH8bBcsJe/g8WC+Yb6NzneUHjhGdOQ28TNt4rprPk6ao4h3+LBpD+t/3px0j1DXh4gLyl/yWB/n9cwU9f3rIWh8kMzPq9ERd5tglgg+FgO2k4IZYjUx5Je/xrKMq0RFmlHdh+1Wzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718577756; c=relaxed/simple;
	bh=oJy/Zmj5XUU6pKV6Q6Kr678M8yXP0Oor1J7NQ/e3MKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oiusvZT/wRrebJEaCK//+Wva1d7ZUo6A7nLK2PZpgA7HjTab9Va2AhPdwHXZCZdPuw4mmiN/uIShEa6P+QbdPKf876Uo2PR+7a9N0/AgqMhwla6MjOs7nbAM9YjPMoKFY+1ifOAbuW3UmbCsGaMmsHqYhHrqY+fGJ+xEITCDoM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E03A1476;
	Sun, 16 Jun 2024 15:42:59 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85D573F73B;
	Sun, 16 Jun 2024 15:42:32 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Chris Morgan <macromorgan@hotmail.com>,
	Ryan Walklin <ryan@testtoast.com>,
	Philippe Simons <simons.philippe@gmail.com>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/5] iommu: sun50i: allocate page tables from below 4 GiB
Date: Sun, 16 Jun 2024 23:40:53 +0100
Message-Id: <20240616224056.29159-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <20240616224056.29159-1-andre.przywara@arm.com>
References: <20240616224056.29159-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner IOMMU is a strict 32-bit device, with its input addresses,
the page table root pointer as well as both level's page tables and also
the target addresses all required to be below 4GB.
The Allwinner H6 SoC only supports 32-bit worth of physical addresses
anyway, so this isn't a problem so far, but the H616 and later SoCs extend
the PA space beyond 32 bit to accommodate more DRAM.
To make sure we stay within the 32-bit PA range required by the IOMMU,
force the memory for the page tables to come from below 4GB. by using
allocations with the DMA32 flag.
Also reject any attempt to map target addresses beyond 4GB, and print a
warning to give users a hint while this fails.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/iommu/sun50i-iommu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index dd3f07384624c..20a07f829085d 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -602,6 +602,14 @@ static int sun50i_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	u32 *page_table, *pte_addr;
 	int ret = 0;
 
+	/* the IOMMU can only handle 32-bit addresses, both input and output */
+	if ((uint64_t)paddr >> 32) {
+		ret = -EINVAL;
+		dev_warn_once(iommu->dev,
+			      "attempt to map address beyond 4GB\n");
+		goto out;
+	}
+
 	page_table = sun50i_dte_get_page_table(sun50i_domain, iova, gfp);
 	if (IS_ERR(page_table)) {
 		ret = PTR_ERR(page_table);
@@ -682,7 +690,8 @@ sun50i_iommu_domain_alloc_paging(struct device *dev)
 	if (!sun50i_domain)
 		return NULL;
 
-	sun50i_domain->dt = iommu_alloc_pages(GFP_KERNEL, get_order(DT_SIZE));
+	sun50i_domain->dt = iommu_alloc_pages(GFP_KERNEL | GFP_DMA32,
+					      get_order(DT_SIZE));
 	if (!sun50i_domain->dt)
 		goto err_free_domain;
 
@@ -997,7 +1006,7 @@ static int sun50i_iommu_probe(struct platform_device *pdev)
 
 	iommu->pt_pool = kmem_cache_create(dev_name(&pdev->dev),
 					   PT_SIZE, PT_SIZE,
-					   SLAB_HWCACHE_ALIGN,
+					   SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA32,
 					   NULL);
 	if (!iommu->pt_pool)
 		return -ENOMEM;
-- 
2.39.4

