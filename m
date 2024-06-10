Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02376768EF
	for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 08:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009934; cv=none; b=nwOVSUURI1ZYHSpuDIlt5+OCAhhaASgGQvVPihFz3J6zrQb3gUQ7sNyNwDKyhB4oC2yttxyf4HBDNxTEv1VzjzUIybkbQ24aScvOxKQGq1tRMn3qnQnQKq6YgJOlr05RE39qZHJ5vdukj+K7oCTwzPVfn26hKRcY++bzdAA4baA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009934; c=relaxed/simple;
	bh=3intrfdlq62sPZGdllNzLo1Ahf/WR8/6yPI2eqBXYY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uQlRvFNd5igwACn1nFo9hb6Ug6hRXcjUHavbiO2+Xq4Qk3DTx+9n4ivXyecIISjT244iggfyzjLPMg8NKovgufSMZCrYIsO4UEq68xh/6UBFeeAoqzKVbxQJaVHulr2tquUKtkGPofOmMP4G8Xcj60pMIj3ooUEAq9uE8tm83sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GrvelJR8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GrvelJR8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718009933; x=1749545933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3intrfdlq62sPZGdllNzLo1Ahf/WR8/6yPI2eqBXYY8=;
  b=GrvelJR8lc4v8Nby6CPs0NUw/nHUGoklKtcPbh4bQaS89AUi+nUodsfU
   7d7xiW1IQux0rqGb9K/kyFuo3azx3weZFz4TZxAX28vBstTDtbBEmGbLf
   QZHr7nt28h+T7y+hp26VqvEl5xYWzQkab+ctu16ighOS4koaNfp604siz
   SpN6gWZr7oCfIWcrZvql8JSpb+LNM6JMps0xEyxGeUJq1A6nv+Ryl864+
   j1e0YaTXcPL7vkzZq0Z3HorxvsR29WFUgjZpWcZuepAsX5gkFV/cv4dLB
   Xo5maXEGGU+Wo/Hs3nOna1PcxAcuDEoacoEbi5p4rtgpjeJqMvWYEqZ8L
   g==;
X-CSE-ConnectionGUID: Ku0RCdp0Qe6Yf/VMqIE9Iw==
X-CSE-MsgGUID: j+R8HRCGQFuTIrlIGKdy2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="17581632"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="17581632"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 01:58:52 -0700
X-CSE-ConnectionGUID: Ilzg052XTkGNg5Xl4jMrRA==
X-CSE-MsgGUID: 2uqmD9gJTn61hulUVOHf8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43432549"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jun 2024 01:58:48 -0700
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
Subject: [PATCH v3 07/21] gpu: host1x: Use iommu_paging_domain_alloc()
Date: Mon, 10 Jun 2024 16:55:41 +0800
Message-Id: <20240610085555.88197-8-baolu.lu@linux.intel.com>
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

