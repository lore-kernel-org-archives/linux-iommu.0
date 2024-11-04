Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651161ABEC1
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 01:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684508; cv=none; b=bRjbw+YzSlsqkYzFwJ7YOkx3KMi37aV6cunisiWzmezNTjRGazzmJIC5Y1sWATfGFKBYgzrQw4BqNbtufZiuIXBX2wE4a3qVhFuTD9RSYaKmlCDTHrrSxvDL8h11+OJ3x9jVoInqf/9DZFHNbEah89V1kdE1rP/tb4q04LmQkMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684508; c=relaxed/simple;
	bh=RjyMbzs1u1VZ99xwpXgLIBhgK5JbywVeNN9P5Z+O5sU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpBrAWkQha0HUw/eLCgD8w6v4AHVIk6CYi41a/+xIWN8ypXXNR6S1FtSEOrSgD2nCwoluQjYRXe5UIck3VAjO+qsxevc17g9/GmmURSmEDKNyof9LjzPKjaVLdQYPsU1CsRYJbntNa0//i0Li+rglbSwvigHxu8DJQAHS8fPdvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MFkuTGFs; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MFkuTGFs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730684507; x=1762220507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RjyMbzs1u1VZ99xwpXgLIBhgK5JbywVeNN9P5Z+O5sU=;
  b=MFkuTGFsCxVNnQQhEKdYjejwnUWvTja+s72yhH0dA6krSQJ6Ruep05EM
   Yz9hCskdWG9aYL960LgnHeqrimxtCAx/8AS5QutLK9QMEF6X4Ly7jN9+o
   Uy7MT+I2atoUYa7TPzOihZUdr79ei4D9vOyqZ2dzbBKBdJRJkCzrj8DSa
   lJr5ZMlfQNarOHtud3fakCw4SVKgmbZm1vVD7WXUr2AOg0h2qhrJGrTgH
   xiYewKtUMjNTUhgLRfTXpyEqZL2f3ik6UrSWpPYUSNeCQZhpP6xQkTPao
   lAIPTHd6Hs8PQbRn2vCb0oEPVJtfoD0YMUfJUvGhXJ/So8wSONVs8xRyx
   A==;
X-CSE-ConnectionGUID: TcbXWf44RSGeCXvGp/DYWQ==
X-CSE-MsgGUID: bopSuPipR6yc75//i9K4wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30221971"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30221971"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 17:41:47 -0800
X-CSE-ConnectionGUID: s14UIzNBRsaDRwMMM2zycQ==
X-CSE-MsgGUID: CkXgiWLpTsK5gqAWUfv0Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88020910"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa005.fm.intel.com with ESMTP; 03 Nov 2024 17:41:46 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 19/19] iommu/vt-d: Drain PRQs when domain removed from RID
Date: Mon,  4 Nov 2024 09:40:39 +0800
Message-ID: <20241104014040.106100-20-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104014040.106100-1-baolu.lu@linux.intel.com>
References: <20241104014040.106100-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As this iommu driver now supports page faults for requests without
PASID, page requests should be drained when a domain is removed from
the RID2PASID entry.

This results in the intel_iommu_drain_pasid_prq() call being moved to
intel_pasid_tear_down_entry(). This indicates that when a translation
is removed from any PASID entry and the PRI has been enabled on the
device, page requests are drained in the domain detachment path.

The intel_iommu_drain_pasid_prq() helper has been modified to support
sending device TLB invalidation requests for both PASID and non-PASID
cases.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Link: https://lore.kernel.org/r/20241101045543.70086-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c |  1 -
 drivers/iommu/intel/pasid.c |  1 +
 drivers/iommu/intel/prq.c   | 26 +++++++++-----------------
 3 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 87a3563dfe54..3878f35be09d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4069,7 +4069,6 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
 	kfree(dev_pasid);
 	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
-	intel_iommu_drain_pasid_prq(dev, pasid);
 }
 
 static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 7e76062a7ad2..31665fb62e1c 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -265,6 +265,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
 
 	devtlb_invalidation_with_pasid(iommu, dev, pasid);
+	intel_iommu_drain_pasid_prq(dev, pasid);
 }
 
 /*
diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
index 621cd26504b3..c2d792db52c3 100644
--- a/drivers/iommu/intel/prq.c
+++ b/drivers/iommu/intel/prq.c
@@ -63,26 +63,18 @@ void intel_iommu_drain_pasid_prq(struct device *dev, u32 pasid)
 	struct dmar_domain *domain;
 	struct intel_iommu *iommu;
 	struct qi_desc desc[3];
-	struct pci_dev *pdev;
 	int head, tail;
 	u16 sid, did;
-	int qdep;
 
 	info = dev_iommu_priv_get(dev);
-	if (WARN_ON(!info || !dev_is_pci(dev)))
-		return;
-
 	if (!info->pri_enabled)
 		return;
 
 	iommu = info->iommu;
 	domain = info->domain;
-	pdev = to_pci_dev(dev);
 	sid = PCI_DEVID(info->bus, info->devfn);
 	did = domain ? domain_id_iommu(domain, iommu) : FLPT_DEFAULT_DID;
 
-	qdep = pci_ats_queue_depth(pdev);
-
 	/*
 	 * Check and wait until all pending page requests in the queue are
 	 * handled by the prq handling thread.
@@ -114,15 +106,15 @@ void intel_iommu_drain_pasid_prq(struct device *dev, u32 pasid)
 	desc[0].qw0 = QI_IWD_STATUS_DATA(QI_DONE) |
 			QI_IWD_FENCE |
 			QI_IWD_TYPE;
-	desc[1].qw0 = QI_EIOTLB_PASID(pasid) |
-			QI_EIOTLB_DID(did) |
-			QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
-			QI_EIOTLB_TYPE;
-	desc[2].qw0 = QI_DEV_EIOTLB_PASID(pasid) |
-			QI_DEV_EIOTLB_SID(sid) |
-			QI_DEV_EIOTLB_QDEP(qdep) |
-			QI_DEIOTLB_TYPE |
-			QI_DEV_IOTLB_PFSID(info->pfsid);
+	if (pasid == IOMMU_NO_PASID) {
+		qi_desc_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH, &desc[1]);
+		qi_desc_dev_iotlb(sid, info->pfsid, info->ats_qdep, 0,
+				  MAX_AGAW_PFN_WIDTH, &desc[2]);
+	} else {
+		qi_desc_piotlb(did, pasid, 0, -1, 0, &desc[1]);
+		qi_desc_dev_iotlb_pasid(sid, info->pfsid, pasid, info->ats_qdep,
+					0, MAX_AGAW_PFN_WIDTH, &desc[2]);
+	}
 qi_retry:
 	reinit_completion(&iommu->prq_complete);
 	qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN);
-- 
2.43.0

