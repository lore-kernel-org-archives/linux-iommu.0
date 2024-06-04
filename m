Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AB91411D8
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 01:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466091; cv=none; b=Mvr6e1+Pnrl3vDO2t113HH7NmZMQbA7Ry40SBpZB4aP9mKDgyUjRete/MAp7qSasVqDvj1hDspU8jItDDDApPBK2pW+lXtLteFdlLf0psIMOjwh53jJlz6PGr4hRwzbFCMMXRv5DXtYa21+jCSYgcl/SqL9ED8y/kAvVtmetyZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466091; c=relaxed/simple;
	bh=kv68qkR9q97yuL81djioGxxqJnKTS0o+E5D+XI6WQks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=idBe8H+u0pv2oW4tb9QmM6xCeAOy0QliuevlEtZmYWV4NFmg4L2HGx0s8ElQJZ1Z8Nyucl+Kl1AkHf5tu9Zep5xgqEjlik/Mh1NQ+i92M8M6HEgl8Aj0RwcRhF5Ag4iB1pP5AAq5XMPw0M1auQ3z9m00Tk/3AOuf6LThgyGQvaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GZlPlV+z; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZlPlV+z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717466089; x=1749002089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kv68qkR9q97yuL81djioGxxqJnKTS0o+E5D+XI6WQks=;
  b=GZlPlV+zsLuUntfY+agB5uIMitJsYCG2VxFoK9wFmFlU9OzScqNMjCSd
   DsPVUdV8pAQUQLJQgnG16XiPbZPm8cl5Gar9LWtngRpBbKAeYXdY0vYvu
   ZJiTK5QzgyneUDH4AcaRBc7empueDr09tEnjBLhTvUHl68Becptx1hZza
   yHvBU9xXa35G83sGDh06WTHaTBfiqobF5DTbXRNy5LYNbsDU1Xv9HCgfO
   mCqxGeRQrCBkRtytwVvevBlAe/RZ1D3ugHsCI6AIq6jYIwh2LpyH3vBr8
   IyOafr8nS594YL9DPZnnwlLn4rQf4neYUTsreEu69j0ZvbjlB83FQ/Msv
   g==;
X-CSE-ConnectionGUID: Wj7UXaGLQ3OM4uCmCg7vPQ==
X-CSE-MsgGUID: rCVZHhgdR/qQVBOzMP2lRA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25385032"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="25385032"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 18:54:49 -0700
X-CSE-ConnectionGUID: /AzNYxuvQx2xoxMl9BNqEw==
X-CSE-MsgGUID: ll0cIefjRU6Vo9+7jOwqfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37661900"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 03 Jun 2024 18:54:45 -0700
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
Subject: [PATCH v2 11/22] ath10k: Use iommu_paging_domain_alloc()
Date: Tue,  4 Jun 2024 09:51:23 +0800
Message-Id: <20240604015134.164206-12-baolu.lu@linux.intel.com>
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

An iommu domain is allocated in ath10k_fw_init() and is attached to
ar_snoc->fw.dev in the same function. Use iommu_paging_domain_alloc() to
make it explicit.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 8530550cf5df..0fe47d51013c 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -1635,10 +1635,10 @@ static int ath10k_fw_init(struct ath10k *ar)
 
 	ar_snoc->fw.dev = &pdev->dev;
 
-	iommu_dom = iommu_domain_alloc(&platform_bus_type);
-	if (!iommu_dom) {
+	iommu_dom = iommu_paging_domain_alloc(ar_snoc->fw.dev);
+	if (IS_ERR(iommu_dom)) {
 		ath10k_err(ar, "failed to allocate iommu domain\n");
-		ret = -ENOMEM;
+		ret = PTR_ERR(iommu_dom);
 		goto err_unregister;
 	}
 
-- 
2.34.1

