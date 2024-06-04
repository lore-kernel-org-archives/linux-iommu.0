Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9234214036F
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 01:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466080; cv=none; b=VM6QLq4nMKvv12m3KUU2YRiQqrsEVos1CENxdMAfVZegvXIHvTX5nVREuqk8PV/7vYaD6yuCURrktaHMshGRH4scHZuhSAdV7UiW3g/3e1FO/1kjtmEWGYk2YO4gT3mouKuISskQvOn/zInOBAlJMr70EvG00BWgMCAkbOHbHTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466080; c=relaxed/simple;
	bh=gcVUdhVM6KwB99b7OFzWjZ/BBZdHQiOtwXYtd2+KA+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u4lSDFm76w/aElTaaPOfEmClptmmNkqZe4c1SnqksqREXxoB7S2sR4lOVjRK/n0Ttl1zXXRf9IedsBQFeE539HJNJkzSAXWspQAf1U9zPDuBe4cm/iOA99YRTbB55ZExWhexvG/ySp7r/JUSMvTQ8fZtgdk3n+BtbaXKxagPYk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FL5gpbHm; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FL5gpbHm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717466079; x=1749002079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gcVUdhVM6KwB99b7OFzWjZ/BBZdHQiOtwXYtd2+KA+I=;
  b=FL5gpbHmswqWlvgbMoIZUAg3aC7e4NA6gaMdEiJ3zfBKvNsz4q/X9qT8
   P2/o8X04zhfy3PcLQKIGtO+4kSrvyFMXnFPDhcrU8kPxf4saGljctvqSB
   yGhPtA3ikr/noNfTuNWjNaFZrs6rdYKDYGXUKSsVLUwKz+aATQwUOHR//
   fg6uDTsKrG3wzjgv8KS++rbZWd/OEOs5/WWgMkd3Cfk/G/wy7ThbZAHIo
   9nuJJzAqF0ox+v2neVI6Qx2GT2Zs04Wip5hsYx7MB0B7rbMLNJTsZt4VL
   5hEXtilWyIA5qvb6va3gKhUq8M8v2LyJXWfgqBLqt9ZPvxz9HyUAbQYC0
   w==;
X-CSE-ConnectionGUID: WA4zV7QoTWu3xgp1xoYCBg==
X-CSE-MsgGUID: bKv2IdBrTdqijZf3HtBOlA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25385009"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="25385009"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 18:54:39 -0700
X-CSE-ConnectionGUID: DnPnbKhAQ6KevfMrXwRsWg==
X-CSE-MsgGUID: pW7vflF4TpC0dcW3FuGODA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37661878"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 03 Jun 2024 18:54:35 -0700
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
Subject: [PATCH v2 09/22] media: nvidia: tegra: Use iommu_paging_domain_alloc()
Date: Tue,  4 Jun 2024 09:51:21 +0800
Message-Id: <20240604015134.164206-10-baolu.lu@linux.intel.com>
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

