Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261224412
	for <iommu@lists.linux.dev>; Tue, 14 Nov 2023 01:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hv/IB4Qj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699924502; x=1731460502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S/Mo+SEe2nMEOiLcS05N5VORyWVbnY8E6CLbpkYork4=;
  b=Hv/IB4QjnjY5Du8DBhBI1Ol1lmO0kLrKy4kIPonYat0hro9mOy+faXxk
   SqfdAgD+dZlTZrLu1QQWTCxq8L422xNYP8AP4rnpPKCl5l80nyiLtK0FJ
   x+hNT4kzAytUTw6cIsjLn26Szu0aamcUp1vbLS2e9TXGH1xvSwOZgkuHi
   l6lwMLvjm2mv89xeWB79eW0xJYP7h0hKjBiH1y7WIZZBvcRrVa7Fx1x39
   kuODGWAYpmYk4wuWDhuAJHtQ0UjLLq5G4dcHu88xUNTeO8VOUiQso0nSq
   dxGRuoeGScTvl1sfO2xzH07DjDurzDLmYIyHMKVG4N/jB9uM3pghHWQVm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="454833585"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="454833585"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 17:15:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="740928125"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="740928125"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga006.jf.intel.com with ESMTP; 13 Nov 2023 17:14:59 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Make context clearing consistent with context mapping
Date: Tue, 14 Nov 2023 09:10:36 +0800
Message-Id: <20231114011036.70142-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114011036.70142-1-baolu.lu@linux.intel.com>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
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
---
 drivers/iommu/intel/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c3ec09118ab1..061df1b68ff7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3931,8 +3931,8 @@ static int domain_context_clear_one_cb(struct pci_dev *pdev, u16 alias, void *op
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

