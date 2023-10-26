Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2B618B19
	for <iommu@lists.linux.dev>; Thu, 26 Oct 2023 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SKf8lRq2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698310415; x=1729846415;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SGBMlTmr6toh8djYlkspv5ApDTa9BRAdKaaxwXIo8zw=;
  b=SKf8lRq2c+q3PQ8l7PQqWnP71ipUV/m695uvAS1XADhI04uR6LsXJELL
   wGKr6NprCmiXwFn1fZ8tHDL2CVuYrhjAIUySiOdLEFT5ypctsRFM3OKD2
   tHVClW7LacFCDqsI3KWV6q5egsn6TbQg0Lj+JxMTkTvcvLP3fKLVj0cA+
   3BtYrAyL7n/eYF6THSdnSaL2wWQGHYFAGBTb32S2+XbQ3SfUUyRcEqJoz
   4zAb4O2vFfjTj/sVhc+Cie/jk4itjqX/2FifeAJHN6OK/w4QUeD8p/6/n
   MQGFBYgQGd3KnJg7BtH+7Wkr0t2TOoNr3VKGPnW2u851/l6gLkWMEtGz7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="391361926"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="391361926"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 01:53:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="708996342"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="708996342"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga003.jf.intel.com with ESMTP; 26 Oct 2023 01:53:32 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu: Avoid unnecessary cache invalidations
Date: Thu, 26 Oct 2023 16:49:42 +0800
Message-Id: <20231026084942.17387-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iommu_create_device_direct_mappings() only needs to flush the caches
when the mappings are changed in the affected domain. This is not true
for non-DMA domains, or for devices attached to the domain that have no
reserved regions. To avoid unnecessary cache invalidations, add a check
before iommu_flush_iotlb_all().

Fixes: a48ce36e2786 ("iommu: Prevent RESV_DIRECT devices from blocking domains")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 00d0a2b5d7dc..0cb676590bfa 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1114,7 +1114,8 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
 
 	}
 
-	iommu_flush_iotlb_all(domain);
+	if (!list_empty(&mappings) && iommu_is_dma_domain(domain))
+		iommu_flush_iotlb_all(domain);
 
 out:
 	iommu_put_resv_regions(dev, &mappings);
-- 
2.34.1

