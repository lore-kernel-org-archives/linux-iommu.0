Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F5F159566
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943119; cv=none; b=e2DDKFiy9rxF9cj0LoYpXa9xEf225GTWMKBnbD7ib2LAdNNdgSrp90bayfM35DfsAtSta2WX4HFJUnJGHnl0LAVtaPiozVtFu8sr5727iqznFyq14M5siacM6cStwCl4FWSAbYKqiIZiSe4aNJiFZlMZi98cfoapYDVh6HZm+rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943119; c=relaxed/simple;
	bh=/1o0n4Ebp46skvfPhfQVbRqVGbg2E5kjrPg92uVgV3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lazc4qQ7kLIkK5w+GcRvYt1w41jkeGihL6fy4/Jsk7A4nlDum2wlo86hAae7S0q5Rm9AIfo+j8WXGJb/IQos2hyaqhOajR4QMp1uxJ4K21hC8CcsMkkoIdtr0RqpN1Z74GYOkWRD/pX/z8ZTuZ42EWB2+QAmCcpq32XznX2KPB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MNjTwlQU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MNjTwlQU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713943118; x=1745479118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/1o0n4Ebp46skvfPhfQVbRqVGbg2E5kjrPg92uVgV3s=;
  b=MNjTwlQUa/vCFJccQP1H8L3GDOQLoztEOrSTlS5V5sCVLK2oy7LcxEsg
   y5n5Gu9HXBq/7xLGaQ1NzRjbc2uxw2Ax3Y5YLJXOT428dQg6CTwq/7IRp
   V9L93r37h5Yn+Qa+eOahc6AU/nA+ZOZu+zKF8we7erNfCGdAjZpBtnGij
   insTnW8DB0YvAu8RWTf1zaAFHcUzH04i8FrMXdqwkYXwJziUj/ymQslMs
   JKGAjf3McH4z26f6JagATR6kGdIspFp/+YW/XV7fJ4fZkbD8rNLEih/z4
   dTqprsJ0E6JzKzPoT6bbsCgQ4AvNrfF14TMfvoSwOGV8PIED9HA2mZabk
   Q==;
X-CSE-ConnectionGUID: xJSRvhj6QtiFcpL1LCxNtQ==
X-CSE-MsgGUID: hegUyjCyRVySazYJyu++YA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27073208"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27073208"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 00:18:37 -0700
X-CSE-ConnectionGUID: i7sjaFeKSJSoYuE4+8mGrA==
X-CSE-MsgGUID: F6BQhTMMRO+cs0MKhuSuDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24665518"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 24 Apr 2024 00:18:35 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/18] iommu/vt-d: Use cache_tag_flush_range_np() in iotlb_sync_map
Date: Wed, 24 Apr 2024 15:16:38 +0800
Message-Id: <20240424071644.178250-13-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424071644.178250-1-baolu.lu@linux.intel.com>
References: <20240424071644.178250-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iotlb_sync_map callback is called by the iommu core after non-present
to present mappings are created. The iommu driver uses this callback to
invalidate caches if IOMMU is working in caching mode and second-only
translation is used for the domain. Use cache_tag_flush_range_np() in this
callback.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240416080656.60968-7-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f3926ad7d737..c9ac8a1b635f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1501,20 +1501,6 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 		iommu_flush_dev_iotlb(domain, addr, mask);
 }
 
-/* Notification for newly created mappings */
-static void __mapping_notify_one(struct intel_iommu *iommu, struct dmar_domain *domain,
-				 unsigned long pfn, unsigned int pages)
-{
-	/*
-	 * It's a non-present to present mapping. Only flush if caching mode
-	 * and second level.
-	 */
-	if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
-		iommu_flush_iotlb_psi(iommu, domain, pfn, pages, 0, 1);
-	else
-		iommu_flush_write_buffer(iommu);
-}
-
 /*
  * Flush the relevant caches in nested translation if the domain
  * also serves as a parent
@@ -4544,14 +4530,8 @@ static bool risky_device(struct pci_dev *pdev)
 static int intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 				      unsigned long iova, size_t size)
 {
-	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	unsigned long pages = aligned_nrpages(iova, size);
-	unsigned long pfn = iova >> VTD_PAGE_SHIFT;
-	struct iommu_domain_info *info;
-	unsigned long i;
+	cache_tag_flush_range_np(to_dmar_domain(domain), iova, iova + size - 1);
 
-	xa_for_each(&dmar_domain->iommu_array, i, info)
-		__mapping_notify_one(info->iommu, dmar_domain, pfn, pages);
 	return 0;
 }
 
-- 
2.34.1

