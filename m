Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA22136E13
	for <iommu@lists.linux.dev>; Tue, 16 Apr 2024 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254908; cv=none; b=PHvayDsCt8Z2P7A5Qjwj3vko8TE7MxggdYN2IXQmVV98EWYE+bxoThV/Xo17HrQ0dnGwMu+/B0VoEkbCeCXsXEXjAvAzf12GexwhatugeDRkoFr8kXpFy9cYglnqATIwZytIt00q5+aHlKkW4i2q8lb0YbgZW/IpNZb4T9AmclA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254908; c=relaxed/simple;
	bh=ePebjA42EEg4fNupv2UJLpk0LEzyEJBQW6TWXoPl6Fw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B47zQsr8bHOBerxjOnpuZnCsP/29njpEfP+QT+XzeQ7K9LuhrcxFyj9OBVZhb1HqOMcyJvYwTo4TsdTRKvKu2fDsU6TOg9U9z7U/4VPMXE+0dxF7Vq+jJpp2Zq4IEwDs19g7cv+4HCFfhQdXpsyrYH08STsg7L13FqdR1mPScw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aGnPYpqF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aGnPYpqF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713254907; x=1744790907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ePebjA42EEg4fNupv2UJLpk0LEzyEJBQW6TWXoPl6Fw=;
  b=aGnPYpqFi/yzi1ti9+1OkP9n5FbB+sAPjSQQyWrWG0ATAz7wIphcxMsH
   CSsbzrQctiM4yNUIzyN4c8yMfwNFmk7Yv3PoDfOQx4rX3wfJlxCWWcIzo
   TmFmFAwjtRoQytj0hE1ZUTRDFWPN6oL6jXxzlX143g/JwsUWMbfo1FqSj
   GDdIm5J9OwWRKnQJ2lmrCMmicfnpSz6t3eOJBFJZzArPANv0lW3wApUYz
   2UxXswEVX1WfmJ0JtQLu/kLBo+bFBWuPmAOreh+WlMGv/d3pFFrPki5GH
   Ee8DHtkNnd+SQXnXEQPWy/H05dvVxpfJX7TLeD0RWF9E3HhBlaaUNim14
   Q==;
X-CSE-ConnectionGUID: CmS9lS+aTpaf4ImkHosfYg==
X-CSE-MsgGUID: siwBg2kPTSCILBatz4Jn4A==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="12466463"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="12466463"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 01:08:26 -0700
X-CSE-ConnectionGUID: IaI4hzeWTIi6qqYFXi0kTg==
X-CSE-MsgGUID: Th6md6o5QeW05IAIEouoqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22077707"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 16 Apr 2024 01:08:25 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 04/12] iommu/vt-d: Use cache_tag_flush_all() in flush_iotlb_all
Date: Tue, 16 Apr 2024 16:06:48 +0800
Message-Id: <20240416080656.60968-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416080656.60968-1-baolu.lu@linux.intel.com>
References: <20240416080656.60968-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flush_iotlb_all callback is called by the iommu core to flush
all caches for the affected domain. Use cache_tag_flush_all() in
this callback.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ac413097058c..4eca107389b4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1556,25 +1556,7 @@ static void parent_domain_flush(struct dmar_domain *domain,
 
 static void intel_flush_iotlb_all(struct iommu_domain *domain)
 {
-	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	struct iommu_domain_info *info;
-	unsigned long idx;
-
-	xa_for_each(&dmar_domain->iommu_array, idx, info) {
-		struct intel_iommu *iommu = info->iommu;
-		u16 did = domain_id_iommu(dmar_domain, iommu);
-
-		if (dmar_domain->use_first_level)
-			domain_flush_pasid_iotlb(iommu, dmar_domain, 0, -1, 0);
-		else
-			iommu->flush.flush_iotlb(iommu, did, 0, 0,
-						 DMA_TLB_DSI_FLUSH);
-
-		iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
-	}
-
-	if (dmar_domain->nested_parent)
-		parent_domain_flush(dmar_domain, 0, -1, 0);
+	cache_tag_flush_all(to_dmar_domain(domain));
 }
 
 static void iommu_disable_protect_mem_regions(struct intel_iommu *iommu)
-- 
2.34.1

