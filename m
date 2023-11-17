Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72023FBEE
	for <iommu@lists.linux.dev>; Fri, 17 Nov 2023 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GazIZusb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700212445; x=1731748445;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0pd5FK7X1xEUkFM/KdlwbN/4e1CbLaaCS11NMMmROLc=;
  b=GazIZusbUJEd+6+obO3UcKpxL5ujof/QoaXUMKat9GMx5gy23teVFHOw
   sck3KGn5O0DgSRTKcQRxnqfc4cPgTY2LrD9JaccHeZC3WYu3iuyuESMlr
   kc9UPV6ABq2Kc3TrlbOM87rxDC3LcJBkJHHxcSJ9u7fU4PHD0x7vxuIts
   pwEzKzkjfgSnQ/gFRU4BBTkcYtlTb46b3crgqzrbWGtUQgAlzHdwm9nMY
   wootS13XT7aKA8PxMFOXDHFWYGGRxvLbManaf+cSEw15CypuszDoGMLbp
   KU/V2Up802JZkaooOlEePNcGFDkSG/0+BoMeDL8DlqI3YtBLgpVuWMrdm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="390119929"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="390119929"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 01:14:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="800443032"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="800443032"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 17 Nov 2023 01:14:00 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Luo Yuzhang <yuzhang.luo@intel.com>,
	Tony Zhu <tony.zhu@intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Fix incorrect cache invalidation for mm notification
Date: Fri, 17 Nov 2023 17:09:33 +0800
Message-Id: <20231117090933.75267-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 50a481c895b8..588385050a07 100644
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
+		qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, 0, -1UL, 1);
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

