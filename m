Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BD8882A
	for <iommu@lists.linux.dev>; Wed, 22 Nov 2023 03:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hD4tETRb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700623839; x=1732159839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NBrfwbm+D/NKidPUfm+0chk1dT5BhEPaSaHHnHNJrj0=;
  b=hD4tETRbgt618s/S0lHrc7CIs+SYPxHlAGayTk15WkWhsA0+RX8HDoa9
   l3Puo0+wF1km2vBb4dSrVo9SkIevb4JuVE+7z6VukR9dqSTejAEkwjI55
   g6s13vgzHIqu7pWn6iriSFS3MuuwWZdoCuXIL8IzcwVZGtuuGcHzsf+kY
   YYGW8nHwlO6Kgc4Y2utxxWaP8CHIQCqEnfZolzMr7qALq+slYAOCbpsFK
   ta1Qvuo9uINhjsjzMIsXDmNx9teEXydLLjQPtDfQDArbbSDNkqnjKPa4Z
   Ub8b41RlYZrN59KfU5e/JyRakyilLFF1B1mMAGq/9WCBCftjLvaw0DOuX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="391742804"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="391742804"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 19:30:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="8090190"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa002.jf.intel.com with ESMTP; 21 Nov 2023 19:30:38 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: mohd.syazwan.abdul.halim@intel.com,
	Kunwu Chan <chentao@kylinos.cn>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] iommu/vt-d: Fix incorrect cache invalidation for mm notification
Date: Wed, 22 Nov 2023 11:26:07 +0800
Message-Id: <20231122032608.165144-7-baolu.lu@linux.intel.com>
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

Commit 6bbd42e2df8f ("mmu_notifiers: call invalidate_range() when
invalidating TLBs") moved the secondary TLB invalidations into the TLB
invalidation functions to ensure that all secondary TLB invalidations
happen at the same time as the CPU invalidation and added a flush-all
type of secondary TLB invalidation for the batched mode, where a range
of [0, -1UL) is used to indicates that the range extends to the end of
the address space.

However, using an end address of -1UL caused an overflow in the Intel
IOMMU driver, where the end address was rounded up to the next page.
As a result, both the IOTLB and device ATC were not invalidated correctly.

Add a flush all helper function and call it when the invalidation range
is from 0 to -1UL, ensuring that the entire caches are invalidated
correctly.

Fixes: 6bbd42e2df8f ("mmu_notifiers: call invalidate_range() when invalidating TLBs")
Cc: stable@vger.kernel.org
Cc: Huang Ying <ying.huang@intel.com>
Cc: Alistair Popple <apopple@nvidia.com>
Tested-by: Luo Yuzhang <yuzhang.luo@intel.com> # QAT
Tested-by: Tony Zhu <tony.zhu@intel.com> # DSA
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20231117090933.75267-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/svm.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 50a481c895b8..ac12f76c1212 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -216,6 +216,27 @@ static void intel_flush_svm_range(struct intel_svm *svm, unsigned long address,
 	rcu_read_unlock();
 }
 
+static void intel_flush_svm_all(struct intel_svm *svm)
+{
+	struct device_domain_info *info;
+	struct intel_svm_dev *sdev;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(sdev, &svm->devs, list) {
+		info = dev_iommu_priv_get(sdev->dev);
+
+		qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, 0, -1UL, 0);
+		if (info->ats_enabled) {
+			qi_flush_dev_iotlb_pasid(sdev->iommu, sdev->sid, info->pfsid,
+						 svm->pasid, sdev->qdep,
+						 0, 64 - VTD_PAGE_SHIFT);
+			quirk_extra_dev_tlb_flush(info, 0, 64 - VTD_PAGE_SHIFT,
+						  svm->pasid, sdev->qdep);
+		}
+	}
+	rcu_read_unlock();
+}
+
 /* Pages have been freed at this point */
 static void intel_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 					struct mm_struct *mm,
@@ -223,6 +244,11 @@ static void intel_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 {
 	struct intel_svm *svm = container_of(mn, struct intel_svm, notifier);
 
+	if (start == 0 && end == -1UL) {
+		intel_flush_svm_all(svm);
+		return;
+	}
+
 	intel_flush_svm_range(svm, start,
 			      (end - start + PAGE_SIZE - 1) >> VTD_PAGE_SHIFT, 0);
 }
-- 
2.34.1

