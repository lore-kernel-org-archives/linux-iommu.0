Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E11E198A2F
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368344; cv=none; b=EFYEX2vYDp+vTzR1FaDm2K/4+fyD7fC/5HfaUdHrmGbTomy/md+otToIR74YlwVU7kLoGzGHor6is6fSRSx1ByH73wek/sQRnC2tGZbylj/Jl/GGF8hJq72WiYUrMFTAvsQJm4riiAp94LUQ2mlt5n9PF+cZV2jxFDy/d/iGchs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368344; c=relaxed/simple;
	bh=sXhqVqcxxb74TbLCt/1k7rR1bz1IQfU6AYxlmBPwA6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pvcT0+wAwsId4hW+N3X1kTUgYcT/+sHRTTPQCHW/6MA6yQIVPhGGzpTVbDf4F5+nw+kmL7kjt0vp8lL95EFo79kQFbfEElxAp4aM2Y9DGIb1uLgNPm5yRpbEr0dGIQ/2FrRTzFFJU8JirHX4Eoki5dbHT9WbUb8tel83S9eyBFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EnNvSPtc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EnNvSPtc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730368342; x=1761904342;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sXhqVqcxxb74TbLCt/1k7rR1bz1IQfU6AYxlmBPwA6g=;
  b=EnNvSPtcNDL4Jpo50eMdfDnImyxZ0E4r+YtQjHKxjxPCH/q5aCvb7Z2K
   nH78c+ICii/qH059RqQViRTiqR5AinK0yNU4h9LZjD8WnWpPfpY1ZfX1r
   xLMiXhokrKwalCpqBsB04bW+Lj1gfVAPDhBEHA/R8+/J0Kxshnu9eRFEm
   HlrWRswXQXZo312CuhID9dXFs/QNcpmoLuZXDk7QEA2k5kL4rDZlgaOJy
   asrRxUnr2/+F0dBOuWIWlL/jaRiRKZNHwkhEUkGdngHynZtdCrnGBbs4+
   OftfISqyJDhNb7GM6ArA9YQQKDzbs9l+4j9XbPXMQqQ0qtRbh5bhmk9Gf
   Q==;
X-CSE-ConnectionGUID: u423Y1RtRKCDxJHmaOWeGg==
X-CSE-MsgGUID: vXW/B09FT+2nz/Z0M761Kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40645302"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40645302"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 02:52:21 -0700
X-CSE-ConnectionGUID: THWkJZG7RwOEpVYIc1IJdA==
X-CSE-MsgGUID: ljdJC5DjT4ucx/aEa89wXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82702567"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa008.fm.intel.com with ESMTP; 31 Oct 2024 02:52:19 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joel Granados <joel.granados@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Drain PRQs when domain removed from RID
Date: Thu, 31 Oct 2024 17:51:39 +0800
Message-ID: <20241031095139.44220-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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
device, page requests are flushed in the domain detachment path.

The intel_iommu_drain_pasid_prq() helper has been modified to support
sending device TLB invalidation requests for both PASID and non-PASID
cases.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c |  1 -
 drivers/iommu/intel/pasid.c |  1 +
 drivers/iommu/intel/prq.c   | 22 +++++++---------------
 3 files changed, 8 insertions(+), 16 deletions(-)

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
index 3c50c848893f..ae7f6f34462f 100644
--- a/drivers/iommu/intel/prq.c
+++ b/drivers/iommu/intel/prq.c
@@ -66,12 +66,8 @@ void intel_iommu_drain_pasid_prq(struct device *dev, u32 pasid)
 	struct pci_dev *pdev;
 	int head, tail;
 	u16 sid, did;
-	int qdep;
 
 	info = dev_iommu_priv_get(dev);
-	if (WARN_ON(!info || !dev_is_pci(dev)))
-		return;
-
 	if (!info->pri_enabled)
 		return;
 
@@ -81,8 +77,6 @@ void intel_iommu_drain_pasid_prq(struct device *dev, u32 pasid)
 	sid = PCI_DEVID(info->bus, info->devfn);
 	did = domain ? domain_id_iommu(domain, iommu) : FLPT_DEFAULT_DID;
 
-	qdep = pci_ats_queue_depth(pdev);
-
 	/*
 	 * Check and wait until all pending page requests in the queue are
 	 * handled by the prq handling thread.
@@ -114,15 +108,13 @@ void intel_iommu_drain_pasid_prq(struct device *dev, u32 pasid)
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
+	qi_desc_piotlb(did, pasid, 0, -1, 0, &desc[1]);
+	if (pasid == IOMMU_NO_PASID)
+		qi_desc_dev_iotlb(sid, info->pfsid, info->ats_qdep, 0,
+				  MAX_AGAW_PFN_WIDTH, &desc[2]);
+	else
+		qi_desc_dev_iotlb_pasid(sid, info->pfsid, pasid, info->ats_qdep,
+					0, MAX_AGAW_PFN_WIDTH, &desc[2]);
 qi_retry:
 	reinit_completion(&iommu->prq_complete);
 	qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN);
-- 
2.43.0

