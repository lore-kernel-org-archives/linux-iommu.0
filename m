Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27C817C7B0;
	Thu, 30 May 2024 23:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717112374; cv=none; b=rYESjCmjpjyM0fPpjm1tomAR9jF/vvmp1nS1HwD4KmDgHC0CnVTDMuxNTC3mnCD86p8iM7OnZdzTgyQAqRrBYC0nNwE0w+K0TIJ7xWCA8R9VmwyY53YXT5X7R7+LJK4snrdGjwiS0pskrylu1GOUrCAP9mvT5pt1zPYVC7eHJQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717112374; c=relaxed/simple;
	bh=3E6NGmWsJ5y52Uzh/xkrgVHRU4wBWWswgoLvprGog4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cXO+jnGlTYkdtiuAG64qOb5oduFvUWAvhDt3SaNGyzthJPK3muMhfeFotjziFB7IIMSA7Eo51UapzxLS40QAzp1kfyApuD0JHQKfruZsn4jlEh8ly5zDtuc+O64g0rglx8FNTchJfCo9OVNutpxGMcj1+m+My5PUPXZlt7ybdhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53BC3165C;
	Thu, 30 May 2024 16:39:56 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 048453F881;
	Thu, 30 May 2024 16:39:29 -0700 (PDT)
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
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/5] iommu: sun50i: allocate page tables from below 4 GiB
Date: Fri, 31 May 2024 00:37:57 +0100
Message-Id: <20240530233800.27705-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240530233800.27705-1-andre.przywara@arm.com>
References: <20240530233800.27705-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner IOMMU is a strict 32-bit device, with the page table root
pointer as well as both level's page tables and also the target addresses
all required to be below 4GB.
The Allwinner H6 SoC only supports 32-bit worth of physical addresses
anyway, so this isn't a problem so far, but the H616 and later SoCs extend
the PA space beyond 32 bit to accommodate more DRAM.
To make sure we stay within the 32-bit PA range required by the IOMMU,
force the memory for the page tables to come from below 4GB. by using
allocations with the DMA32 flag.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/iommu/sun50i-iommu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index dd3f07384624c..c3244db5ac02f 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -682,7 +682,8 @@ sun50i_iommu_domain_alloc_paging(struct device *dev)
 	if (!sun50i_domain)
 		return NULL;
 
-	sun50i_domain->dt = iommu_alloc_pages(GFP_KERNEL, get_order(DT_SIZE));
+	sun50i_domain->dt = iommu_alloc_pages(GFP_KERNEL | GFP_DMA32,
+					      get_order(DT_SIZE));
 	if (!sun50i_domain->dt)
 		goto err_free_domain;
 
@@ -997,7 +998,7 @@ static int sun50i_iommu_probe(struct platform_device *pdev)
 
 	iommu->pt_pool = kmem_cache_create(dev_name(&pdev->dev),
 					   PT_SIZE, PT_SIZE,
-					   SLAB_HWCACHE_ALIGN,
+					   SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA32,
 					   NULL);
 	if (!iommu->pt_pool)
 		return -ENOMEM;
-- 
2.35.8

