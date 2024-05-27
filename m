Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB6E33C8
	for <iommu@lists.linux.dev>; Mon, 27 May 2024 23:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716852400; cv=none; b=q+pFAMmETzGQpN/R1kpMiLh1oxxa55RDhxaFaNCBDVQz8HFVtxM7YJ01SqSfjv18oUOgr0kbGwFag4IAUsnQOlS7ZDvGTln+mH56jTZmmssphheKr9puReLuDnQzl1Ejpc38/rlVqWyqFwMNAWeILYFZDsQXQObEVY5xf4etl5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716852400; c=relaxed/simple;
	bh=ziUGs70MUhsa3utiTcHful7u5bPjfpCCTk98LwUamcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cb012mGqz8SQ/NMb8oGN8uD3A7pv9ynEE+cscXFOpbeCx0znunalSeDg+I20A2ipn7gGYlQyZ7WgEIDY1V3N9B8Mv0Uj7bbWAJvL3q5LqH3U25WIf22qH5B7PZeooBjFMqSjWpiYczcOL+oMM1x8jpFqRfheLPRu7Hxnn8rCofI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jaWyt7+9; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jaWyt7+9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716852399; x=1748388399;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ziUGs70MUhsa3utiTcHful7u5bPjfpCCTk98LwUamcc=;
  b=jaWyt7+9TIVAZYp0tuFwB1mW0DyF3Z8xXQ1Nbk+mEEMkNG+Bjamuxu5G
   L3HOTvJw72o1baZnAsrJJtL7oEGIkpRhk3nMfRfeW3q8wMvoBmFHFu/7d
   ttsdBC/L8Vx9VVAAu+o8DcS8jjPPamKg9K0Upi2RyCMGsp7l6VOvP8cCe
   BBRUJzA4b7QKhLNteB8rREnI2SxN2o+CghVbDHHfkLF3g9QvpuUx//wCx
   dqgK1D3qlJKwlCZplWcTFiBovaCJ7bYnu5/oRKA9dVmaqSZFV3ocvfLLL
   7tYr+H3snz1uDfN/+6IEK3risWahyW0BzJ1rujjMxm2b1z3m6HLob/ZaY
   g==;
X-CSE-ConnectionGUID: AZPMsq+3S821N2TtmGDFmQ==
X-CSE-MsgGUID: +KPPJsBlRq+sYXOFLqwljw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24303130"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="24303130"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 16:26:38 -0700
X-CSE-ConnectionGUID: j+IfclDoTNmkENST37sIYA==
X-CSE-MsgGUID: 18KPs6p+QA2u/Zv8xlJ50Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="34954035"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 27 May 2024 16:26:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4A180184; Tue, 28 May 2024 02:26:34 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH v1 1/1] iommu/dma: Make SG mapping and syncing robust against empty tables
Date: Tue, 28 May 2024 02:26:25 +0300
Message-ID: <20240527232625.462045-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

DMA mapping and syncing API might be called for the empty SG table where
number of the original entries is 0 and a pointer to SG list may be not
initialised at all. This all worked until the change to the code that
started dereferensing SG list without checking the number of the
original entries against 0. This might lead to the NULL pointer
dereference if the caller won't perform a preliminary check for that.
Statistically there are only a few cases in the kernel that do such a
check. However, any attempt to make it alinged with the rest 99%+ cases
will be a regression due to above mentioned relatively recent change.
Instead of asking a caller to perform the checks, just return status quo
to SG mapping and syncing callbacks, so they won't crash on
uninitialised SG list.

Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Closes: https://lore.kernel.org/all/d3679496-2e4e-4a7c-97ed-f193bd53af1d@notapiano
Fixes: 861370f49ce4 ("iommu/dma: force bouncing if the size is not cacheline-aligned")
Fixes: 8cc3bad9d9d6 ("spi: Remove unneded check for orig_nents")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iommu/dma-iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f731e4b2a417..83c9013aa341 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1108,6 +1108,9 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
+	if (nelems < 1)
+		return;
+
 	if (sg_dma_is_swiotlb(sgl))
 		for_each_sg(sgl, sg, nelems, i)
 			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
@@ -1124,6 +1127,9 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
+	if (nelems < 1)
+		return;
+
 	if (sg_dma_is_swiotlb(sgl))
 		for_each_sg(sgl, sg, nelems, i)
 			iommu_dma_sync_single_for_device(dev,
@@ -1324,6 +1330,9 @@ static int iommu_dma_map_sg_swiotlb(struct device *dev, struct scatterlist *sg,
 	struct scatterlist *s;
 	int i;
 
+	if (nents < 1)
+		return nents;
+
 	sg_dma_mark_swiotlb(sg);
 
 	for_each_sg(sg, s, nents, i) {
-- 
2.43.0.rc1.1336.g36b5255a03ac

