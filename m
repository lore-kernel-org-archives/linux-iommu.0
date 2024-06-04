Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8184913F454
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 01:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466065; cv=none; b=EK0swBMOC87XV5F9fO3eK7zC+RH0bDvW+G978fmT4BB+3OoRbeZ8EsXt1S8hKz9mWBENIdhpu4hyRZjpbZSFciTOOdBtcRs6Xf00gSk3IUyIXfdpUy1lfMmAY4hA5Gsqe6ciRrvMOTXQAKGGRuK+lPndC2+PKCUHopCRKGlSDTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466065; c=relaxed/simple;
	bh=Y8tmajavNhEb2U4e54gDZyZwgTBk84qW7m36BoQgWp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iHyuqylaIueHfDwnlDzPlRjE+yevMOxjPPgF1IzeDVm5Xy5Mswimbyf1YrVFpE6B21ZUR6l9vxlDrusAaL6liw34hg0/hFi29yosHN8WUJ49td2mBL+7+0vG6c53CB2ESE6AlGKb7GiBbxqn2ivl5ik8axQjNvGUaCdAD1ZDRt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KXuCHG+6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KXuCHG+6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717466064; x=1749002064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y8tmajavNhEb2U4e54gDZyZwgTBk84qW7m36BoQgWp0=;
  b=KXuCHG+6IJBSBfhb4lOgwBoN7SwhyImuy8jyE4bXjBMgDqJoJLnX3p4q
   jApEFRn2Yh72q+HpDC6exNXVOaZpnGbPLkkBi9wVmKiIB43Lj5lxwSjRg
   s6KVIVw2D0ySS1C29IdIfEm+S8dUNav+7zPwAhci7YintSgEhayX3hH0Y
   NiRp0f/dOClAyQVTqx6Nt8JtZm5+gIDUqlxau8wvVxmmASQymyHhs3ASR
   N8svGxf1tjM3YH734EhcihiTR+flRgSSPoRmVYALknQGV+jAd8RdZgDm4
   p9I32TCEJJPI9p/O8lqPPCVpYl6uQ9wKG6sGhs1ZrvHf8lsBD1NZhcLbI
   Q==;
X-CSE-ConnectionGUID: qjnks4BxSb+Zu3uqpglFaw==
X-CSE-MsgGUID: AwgyhDA5TyKrwabN8GkswA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25384957"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="25384957"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 18:54:24 -0700
X-CSE-ConnectionGUID: q82kEK5bRvekjrNhIFC1Zw==
X-CSE-MsgGUID: CmxBK1IlQW2p11gUJOibRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37661843"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 03 Jun 2024 18:54:20 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 06/22] drm/msm: Use iommu_paging_domain_alloc()
Date: Tue,  4 Jun 2024 09:51:18 +0800
Message-Id: <20240604015134.164206-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604015134.164206-1-baolu.lu@linux.intel.com>
References: <20240604015134.164206-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The domain allocated in msm_iommu_new() is for the @dev. Replace
iommu_domain_alloc() with iommu_paging_domain_alloc() to make it explicit.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/gpu/drm/msm/msm_iommu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index d5512037c38b..2a94e82316f9 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -407,10 +407,13 @@ struct msm_mmu *msm_iommu_new(struct device *dev, unsigned long quirks)
 	struct msm_iommu *iommu;
 	int ret;
 
-	domain = iommu_domain_alloc(dev->bus);
-	if (!domain)
+	if (!device_iommu_mapped(dev))
 		return NULL;
 
+	domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(domain))
+		return ERR_CAST(domain);
+
 	iommu_set_pgtable_quirks(domain, quirks);
 
 	iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
-- 
2.34.1

