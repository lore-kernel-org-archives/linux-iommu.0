Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E5D882A
	for <iommu@lists.linux.dev>; Wed, 22 Nov 2023 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BjaR7wRy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700623836; x=1732159836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HNzfhWQdyUFZ+2JhkpASHOjsLgru+N06mUEX2ecKBAw=;
  b=BjaR7wRyYoc/uxaECAiHjC3y7cvSPpiVfOSwyCdam/FLcH9TZHodU9rV
   0sBQJZ7Q5g5M3jLPN2nOH/0LqbCgZr7WxdHDrPRoGrJu4aInTU9uSo6gJ
   6qcnKL/xFE8IAvTlszVONB0qLVJLzH/kBr2uvFPPcgcXkU1aHjzpFms1q
   xOgGAeqx81q/kYrri3UfxGPN8T5F93hNE1Zv5MHXPEqgk0l0DmAxMzMoJ
   dLiIvSC9aNewwTdI0+4jYhxqyrXc9XAKOCroZ97OdsUjXV/V+BHfqHvaf
   TB6yu0ru3NJNQETadN2detsFA01d4Wi2u1cbUzDAW2rm8UN93RjkWi15u
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="391742788"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="391742788"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 19:30:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="8090181"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa002.jf.intel.com with ESMTP; 21 Nov 2023 19:30:35 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: mohd.syazwan.abdul.halim@intel.com,
	Kunwu Chan <chentao@kylinos.cn>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] iommu/vt-d: Make context clearing consistent with context mapping
Date: Wed, 22 Nov 2023 11:26:05 +0800
Message-Id: <20231122032608.165144-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122032608.165144-1-baolu.lu@linux.intel.com>
References: <20231122032608.165144-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the iommu probe_device path, domain_context_mapping() allows setting
up the context entry for a non-PCI device. However, in the iommu
release_device path, domain_context_clear() only clears context entries
for PCI devices.

Make domain_context_clear() behave consistently with
domain_context_mapping() by clearing context entries for both PCI and
non-PCI devices.

Fixes: 579305f75d34 ("iommu/vt-d: Update to use PCI DMA aliases")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20231114011036.70142-4-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9bddd4fbbdf8..4c257ccf9dc3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3928,8 +3928,8 @@ static int domain_context_clear_one_cb(struct pci_dev *pdev, u16 alias, void *op
  */
 static void domain_context_clear(struct device_domain_info *info)
 {
-	if (!info->iommu || !info->dev || !dev_is_pci(info->dev))
-		return;
+	if (!dev_is_pci(info->dev))
+		domain_context_clear_one(info, info->bus, info->devfn);
 
 	pci_for_each_dma_alias(to_pci_dev(info->dev),
 			       &domain_context_clear_one_cb, info);
-- 
2.34.1

