Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DC31FAF
	for <iommu@lists.linux.dev>; Sat,  6 May 2023 13:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683379633; x=1714915633;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6kF0WZAR4rQ0vQdOZz3ojMQj9WSdjbV+mkgN/IGSPOs=;
  b=QSwG1OR7tnBsDAcJo1g9A1qy+RNcyfrNpzdIpIC1+ZhXF/bwnGH251Zw
   gWq5CA3uCjgNyfPPkTaxqXkS8+svfevcgZ7C84LsBSox1rBkS1+vU4ztm
   ENQj3VqzFGedrOPeh2mQAD055nD6hXHDeWGcy70shluyTemRpcjS2hDCI
   ztuOe/UvbRe8VVKp/zD1gRHR/P3KIUNmcxjwV9BCUfZ6vOv0OjVmOjF4X
   UWgBdOND9vPmqHiysWwPxvD+gkJaKVnpkH+boc/HAuY7nkjzEim5F6zsi
   E2aDuwfYm5L+PeejO1znL4Rqrz/1QyPJTagKaQ920uiUfI3lP0+hymFwi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="412631140"
X-IronPort-AV: E=Sophos;i="5.99,255,1677571200"; 
   d="scan'208";a="412631140"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2023 06:27:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="944265958"
X-IronPort-AV: E=Sophos;i="5.99,255,1677571200"; 
   d="scan'208";a="944265958"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.97.184])
  by fmsmga006.fm.intel.com with ESMTP; 06 May 2023 06:27:12 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	"Robin Murphy" <robin.murphy@arm.com>
Cc: "Will Deacon" <will@kernel.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	torvalds@linux-foundation.org,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH] iommu: Add Kconfig help text for IOMMU_SVA
Date: Sat,  6 May 2023 06:31:34 -0700
Message-Id: <20230506133134.1492395-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shared Virtual Addressing (SVA) is not immediately intuitive to people
who work outside IOMMU subsystem, add some explanation to make it less
opaque.
Link: https://lore.kernel.org/lkml/ZE70doFi8X3KgfrV@ziepe.ca/t/#meaa938c91857665b376db59e16b532ba9d4ea013
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/Kconfig | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index db98c3f86e8c..0f7181007dc1 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# PDX-License-Identifier: GPL-2.0-only
 # The IOVA library may also be used by non-IOMMU_API users
 config IOMMU_IOVA
 	tristate
@@ -155,7 +155,14 @@ config IOMMU_DMA
 
 # Shared Virtual Addressing
 config IOMMU_SVA
-	bool
+	bool "Shared Virtual Addressing"
+	help
+	  IOMMU and CPU share page tables for user processes thus DMA can use
+	  CPU virtual address. Under intel architecture, it is also called
+	  Shared Virtual Memory (SVM).
+	  With SVA, DMA requests are tagged with PCIe Process Address Space ID
+	  (PASID) or Substream ID (ARM SMMU term) with which page tables are
+	  associated.
 
 config FSL_PAMU
 	bool "Freescale IOMMU support"
-- 
2.25.1

