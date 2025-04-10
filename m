Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7A820A5E7
	for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744270341; cv=none; b=H45i/z+1ccOSrttEw0/oajf1DcDtN3B3yAfIlSAeVVS9RdIqSaO6s3xZe7uD5Ebvuc3KrVC35MxKWWzTWVJj6c5C8NK/mStqAVi8IAe6p0gfBTten1k4xfGqSUJhyx27s1bxay4DfDL5A6P+5wlEktbIjfr5RIOrwcqur5HX97w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744270341; c=relaxed/simple;
	bh=tEn9SWGr0wyK/kS8awBhhTiYrRAGyjYpl2FMYookRks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHmM8T619ObFq3B9dYD3EgTWOuXY1gdDOMQZ/3xDCcQgzaJ4/4zY093RgN0rLP+sK8VDVwXLZu18Yy1jQ3wTOeastsm8iV2QzkCHks21rt6ClPyHFBlvaP4qrIHRoWcYbrAL7edL1Bu9Kc1k2WHdFliDAELKzgEOBCbbEjhRcjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nyE2xaZA; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nyE2xaZA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744270340; x=1775806340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tEn9SWGr0wyK/kS8awBhhTiYrRAGyjYpl2FMYookRks=;
  b=nyE2xaZA93IxmHISniU1fITAk4vAnPGwOM5tLdpt/u0+OHCrhTLK8Tr1
   j5L1zRD6r8zkenAeAaAD4VGWkcLhDEyvhJJbGlMGgB1mntltPVzqGeP1a
   ZPj2bOAFQOr5Pern0XuKyhYVUKkIAtstvVYWQ3Ak57uIYQLmTwKB5RBbZ
   kcObrBTh3gjOaIrFbvpzaZK6gA2RF03iYfh6REPlwzOTwL6EIEBBAedBZ
   VuZXzeIqphx1YYayTv46wO5/b88pNd26qw7jtu4+/lD0fqPXbC+6p2xSs
   5mFpclm8OYLmlkUQ7tT5knfX2rhrk7HFx0CRMfvrWC0X0d1k6OL3h6We0
   A==;
X-CSE-ConnectionGUID: Fz7q8z3+S9WxTOpS1TJfpg==
X-CSE-MsgGUID: EEhey28sT/Ov8RQCmBhWHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="48478817"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="48478817"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 00:32:20 -0700
X-CSE-ConnectionGUID: t6e0Ev8BQLW5PKOZvT2Txg==
X-CSE-MsgGUID: IdnqZlynRfC6SAGHNYmQTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="129166471"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa008.fm.intel.com with ESMTP; 10 Apr 2025 00:32:18 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Sean Christopherson <seanjc@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iommu/vt-d: Remove an unnecessary call set_dma_ops()
Date: Thu, 10 Apr 2025 15:32:47 +0800
Message-ID: <20250410073247.1454287-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250410073247.1454287-1-baolu.lu@linux.intel.com>
References: <20250410073247.1454287-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Petr Tesarik <ptesarik@suse.com>

Do not touch per-device DMA ops when the driver has been converted to use
the dma-iommu API.

Fixes: c588072bba6b ("iommu/vt-d: Convert intel iommu driver to the iommu ops")
Signed-off-by: Petr Tesarik <ptesarik@suse.com>
Link: https://lore.kernel.org/r/20250403165605.278541-1-ptesarik@suse.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6e67cc66a204..b29da2d96d0b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3835,7 +3835,6 @@ static void intel_iommu_release_device(struct device *dev)
 	intel_pasid_free_table(dev);
 	intel_iommu_debugfs_remove_dev(info);
 	kfree(info);
-	set_dma_ops(dev, NULL);
 }
 
 static void intel_iommu_get_resv_regions(struct device *device,
-- 
2.43.0

