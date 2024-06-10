Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9B777106
	for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 08:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009940; cv=none; b=FTFp6eoFegpz39//OVhcoBbmF8weJlOudB0jXd3iqMPrcVYSj4vmVZhPQpB4EdfugtHQzUw1G7VEsiFScb+P30230bVi0ynArbpC2rBOcwZZjuDrnUmJcRGtG9NrRzSpuI3mndGx+4aHAmbhJJJAF5sBTtchQhSJbgZDQw7Dpuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009940; c=relaxed/simple;
	bh=gcVUdhVM6KwB99b7OFzWjZ/BBZdHQiOtwXYtd2+KA+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CsTZF+dt95Lt00tcbxdv1FtUE/fuTbE+iLAlm6VOov1Vy9Q1ufOk0HTvoGuFFYOfFYWy3wPmJ5eXUO1RzuLzpyYXvtNprRxNsLLydF/2Em2H/E6nH2vIwHptMmjnoEnlgGcockF6rV3ROsbZsm2gXiRojsiiHl9kHUqUPBgjZ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OpGzbgHV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OpGzbgHV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718009938; x=1749545938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gcVUdhVM6KwB99b7OFzWjZ/BBZdHQiOtwXYtd2+KA+I=;
  b=OpGzbgHVTaxv/WxRsEGzwRMF1eJHaIypUc10IWthhmIRN9hO4xjIBGC8
   g+Pfo8WCb5E9iiaWeurAiitSYYYV5FblW8ZtWP2UwvZgDNW1CFofNXZi5
   /ErJPkBkd8PBB1mzrrMtXqINHsJX2RWbpOU/7MJ26oyIyfYvhyg3WsBEJ
   LNjuZg8uKUPx5Ejs+xzVKIo2nQxDSVDXtzJs/QL8Q5zAQbIWQJfYjYLum
   1tEMY5zzdMM2ga2l7YXKCojNr//s1zREiGGn3N0TJsBwVhCZPv8QnPl5s
   d8Dsth8rm4LZFseF4KeM/p3CnkdLmI3zPtdPuKl21f3+Wj8X9QK0yAyZ3
   A==;
X-CSE-ConnectionGUID: rRLnJBC8QFqvO3xAKk4uHQ==
X-CSE-MsgGUID: GRmNYw5/TwmWq2ZgUldFcg==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="17581651"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="17581651"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 01:58:57 -0700
X-CSE-ConnectionGUID: S518TnLfQLutDzB5t6Znmg==
X-CSE-MsgGUID: oLlb/Z4oQiiBn2odn2LRRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43432568"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jun 2024 01:58:53 -0700
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
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org,
	ath11k@lists.infradead.org,
	iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 08/21] media: nvidia: tegra: Use iommu_paging_domain_alloc()
Date: Mon, 10 Jun 2024 16:55:42 +0800
Message-Id: <20240610085555.88197-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610085555.88197-1-baolu.lu@linux.intel.com>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An iommu domain is allocated in tegra_vde_iommu_init() and is attached to
vde->dev. Use iommu_paging_domain_alloc() to make it explicit.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/media/platform/nvidia/tegra-vde/iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/nvidia/tegra-vde/iommu.c b/drivers/media/platform/nvidia/tegra-vde/iommu.c
index 5521ed3e465f..b1d9d841d944 100644
--- a/drivers/media/platform/nvidia/tegra-vde/iommu.c
+++ b/drivers/media/platform/nvidia/tegra-vde/iommu.c
@@ -78,9 +78,10 @@ int tegra_vde_iommu_init(struct tegra_vde *vde)
 		arm_iommu_release_mapping(mapping);
 	}
 #endif
-	vde->domain = iommu_domain_alloc(&platform_bus_type);
-	if (!vde->domain) {
-		err = -ENOMEM;
+	vde->domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(vde->domain)) {
+		err = PTR_ERR(vde->domain);
+		vde->domain = NULL;
 		goto put_group;
 	}
 
-- 
2.34.1

