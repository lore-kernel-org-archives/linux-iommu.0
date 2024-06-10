Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D9281734
	for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009958; cv=none; b=ZcUz+4XUwEGIua8K2FKcUeXdBmalZvyG+Iccpvua5Igrcp3PHA+4cSoLvI7RnlukxLAMmFF5mgZ2rwXxyH6gSpgR99kD6T8ULpWznlACHSkEdymDYpv6MFjmq4xm8ynncMOjUIfyc1skPMM5DuDIdnIo+3N3+57/5AfAcNnfDnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009958; c=relaxed/simple;
	bh=0YWlii2bXNnHccsmtL/FJMzKgMQQ20l9rtRa+FjY2hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sgGgTs0SjIZl5gWeu7/Ar+Iy4MOJlfGlMVLCK/PfqBiD7GEBH0GH2FnXySiorD/+tbzomJSO7Rxf3jeqinMJqKsXA1xURjNokjJNtoLebDmV32f1TOt97rTi8XwqzlUQxYu6Zyi6ClWJep8zPfzSk9Mokzm4tpqWUtJDKzO3aC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kSzpcE4/; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kSzpcE4/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718009957; x=1749545957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0YWlii2bXNnHccsmtL/FJMzKgMQQ20l9rtRa+FjY2hk=;
  b=kSzpcE4/YAe1kNJ5bxP0mSB+tieFzrCpxxEGbtu1obBc2V5J+K+tO8jk
   IIXBYfNk1+WhAcpxHpl+jjmfMPxyI7KL6D8uE7HJi+iOS6Q093TRzkxRf
   +TjcwETFvRp5jOk5MfcXW+07ryROJ5GJP7adqgygwY2XvFZYEuiFvgmVa
   kAC0GOm9h5ZH8BX6dds2OUtHfL6qqwyn8zBWIx8qMwP3SmojYBmOIQ6O0
   E9bsxZ91x4wG5W0CQuRyC7tmYKpKlSiGYwf7+TxGLCT6K123w+FU1+OPL
   q6hF9eYXm9shrUQcYvRUQjNQl77Pee+HwRBp0c20SEniPdZzELKi+M8x9
   g==;
X-CSE-ConnectionGUID: WBtPcahmSryilan33XG2Gg==
X-CSE-MsgGUID: x8YZURr1QrGmIGlAbiE2LQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="17581764"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="17581764"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 01:59:13 -0700
X-CSE-ConnectionGUID: /nHz8Xa6R1C1//x2x4ZYpg==
X-CSE-MsgGUID: fbNfhGj2Ro2X3TwDUjfe6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43432670"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jun 2024 01:59:08 -0700
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
Subject: [PATCH v3 11/21] wifi: ath11k: Use iommu_paging_domain_alloc()
Date: Mon, 10 Jun 2024 16:55:45 +0800
Message-Id: <20240610085555.88197-12-baolu.lu@linux.intel.com>
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

An iommu domain is allocated in ath11k_ahb_fw_resources_init() and is
attached to ab_ahb->fw.dev in the same function.

Use iommu_paging_domain_alloc() to make it explicit.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index ca0f17ddebba..a469647719f9 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -1001,10 +1001,10 @@ static int ath11k_ahb_fw_resources_init(struct ath11k_base *ab)
 
 	ab_ahb->fw.dev = &pdev->dev;
 
-	iommu_dom = iommu_domain_alloc(&platform_bus_type);
-	if (!iommu_dom) {
+	iommu_dom = iommu_paging_domain_alloc(ab_ahb->fw.dev);
+	if (IS_ERR(iommu_dom)) {
 		ath11k_err(ab, "failed to allocate iommu domain\n");
-		ret = -ENOMEM;
+		ret = PTR_ERR(iommu_dom);
 		goto err_unregister;
 	}
 
-- 
2.34.1

