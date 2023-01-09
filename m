Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C736515A4
	for <iommu@lists.linux.dev>; Mon,  9 Jan 2023 01:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673229483; x=1704765483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=puzEiCLaFj6PIN4/Wwibk3XN7n6katY+/NOVoiu348c=;
  b=O5/2AH7MA8Pmw7Pd1baxmnHsxh2LaaI6t+YKUdUz84r8PccgLeP7TtMF
   /CRrYlH+B3OdiWLLmfLLD6Tp5RLBIAFgTYhxiFnbCoAQmtvBljVpaxoOo
   EQhbD8uyKXYiHW23DZZnxQ0n/x5+F1Glyy9HNJTc0Tz7MtL9wTxSXvf4I
   ru8jhm9sfsypco1Oh8Y+5hc00cpb+F4h8DCfk2mzADUR2hq/7OM72PUxA
   EXktvJw/BFTlblbEYP62xW7oru3EmGsNEUtUeUc7xXS9jBdzCC3+xsjVl
   pndaqlUcjkp77bbAAqBuXOcDSifUag6Jbm1NPdg1gd6KWijbFSxlPhd6i
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="322848731"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="322848731"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2023 17:57:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="649867421"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="649867421"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2023 17:57:50 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/4] iommu/vt-d: Remove unused fields in svm structures
Date: Mon,  9 Jan 2023 09:49:53 +0800
Message-Id: <20230109014955.147068-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230109014955.147068-1-baolu.lu@linux.intel.com>
References: <20230109014955.147068-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

They aren't used anywhere. Remove them to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h | 4 ----
 drivers/iommu/intel/svm.c   | 2 --
 2 files changed, 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index f89f63d7a72a..e7c732979364 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -762,18 +762,14 @@ struct intel_svm_dev {
 	struct device *dev;
 	struct intel_iommu *iommu;
 	struct iommu_sva sva;
-	u32 pasid;
 	int users;
 	u16 did;
-	u16 dev_iotlb:1;
 	u16 sid, qdep;
 };
 
 struct intel_svm {
 	struct mmu_notifier notifier;
 	struct mm_struct *mm;
-
-	unsigned int flags;
 	u32 pasid;
 	struct list_head devs;
 };
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index d38a54396c23..d1e445f03aa6 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -351,11 +351,9 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	sdev->did = FLPT_DEFAULT_DID;
 	sdev->sid = PCI_DEVID(info->bus, info->devfn);
 	sdev->users = 1;
-	sdev->pasid = svm->pasid;
 	sdev->sva.dev = dev;
 	init_rcu_head(&sdev->rcu);
 	if (info->ats_enabled) {
-		sdev->dev_iotlb = 1;
 		sdev->qdep = info->ats_qdep;
 		if (sdev->qdep >= QI_DEV_EIOTLB_MAX_INVS)
 			sdev->qdep = 0;
-- 
2.34.1

