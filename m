Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB90140380
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 01:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466075; cv=none; b=cJeZeZe2ttBsRyYFm7cKN4Kp80MjYfryC3bLrWsvOIbR6xjR8Vyr9fYCvum3VH6PaSFIliN+Lrbe+qLqJ4DW/+DYMkG7B5cp2uRjJzTV21a8tOahTgZ2N1bMPO1FzE441ldvGxCjHtDiFz1oHuVoJhWAzQAI0HBLAmB8NRrTyN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466075; c=relaxed/simple;
	bh=3intrfdlq62sPZGdllNzLo1Ahf/WR8/6yPI2eqBXYY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V2xmhus0sServqArbWoUN9M1A7A6qHWmTkO4HTENt3ffHZCiPJaKD1sFpyfpS/DtC7WckFBfUIjWhI00p618FBJZuwj4l/NHICuQ62ZFz9+AsAnbbA7GVjnlNz5/NYgZVSu29wMbYBdKe5M8jpEuX3OkqUquKaKsIr9O4W5amsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Boy63i1q; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Boy63i1q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717466074; x=1749002074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3intrfdlq62sPZGdllNzLo1Ahf/WR8/6yPI2eqBXYY8=;
  b=Boy63i1qpGgOm0rPIKOHlFR1n2jlCGnXcZfG0oDQxT3MuN3vjNP9jTqC
   5/HhFviImC/lgEr91+RICIUY7z1T82omT8c8GxuxP8V2jXsSrhDkaaHMB
   CPJi+QVVZMky5z/2GMcx1k5fnIjaSTFk1Rxi0AQOuFex2m3wuLigvLMoV
   +mv9hjM7CKk+HeFt72k6GyLRjkutugpsXtJg1XQ4iQ+dT2fz4TvKLd/QD
   lmx7W/9/s8e03OJ2x6xBB14UUi7+htnZhnge+FdBARUYkTLBwkCTDdefo
   tYL7i3YHQUbGb6j1AdONwQun91x03EdEY9AUg3O6m5gsQukG7CZvCJHZ5
   w==;
X-CSE-ConnectionGUID: nwadf/eqRFuPx0HHfjGhkA==
X-CSE-MsgGUID: GlvfrxrqQJq72hA6ND4ydA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25384990"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="25384990"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 18:54:34 -0700
X-CSE-ConnectionGUID: z1Bd9oYQTbCgJn8uWSeXAQ==
X-CSE-MsgGUID: gJw4bU42SyyJ0W4xw8ZCEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37661869"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 03 Jun 2024 18:54:30 -0700
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
Subject: [PATCH v2 08/22] gpu: host1x: Use iommu_paging_domain_alloc()
Date: Tue,  4 Jun 2024 09:51:20 +0800
Message-Id: <20240604015134.164206-9-baolu.lu@linux.intel.com>
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

An iommu domain is allocated in host1x_iommu_attach() and is attached to
host->dev. Use iommu_paging_domain_alloc() to make it explicit.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/gpu/host1x/dev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 3a0aaa68ac8d..f86a6b12f24a 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -404,9 +404,10 @@ static struct iommu_domain *host1x_iommu_attach(struct host1x *host)
 		if (err < 0)
 			goto put_group;
 
-		host->domain = iommu_domain_alloc(&platform_bus_type);
-		if (!host->domain) {
-			err = -ENOMEM;
+		host->domain = iommu_paging_domain_alloc(host->dev);
+		if (IS_ERR(host->domain)) {
+			err = PTR_ERR(host->domain);
+			host->domain = NULL;
 			goto put_cache;
 		}
 
-- 
2.34.1

