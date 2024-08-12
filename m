Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC5114E2DE
	for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 07:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723447180; cv=none; b=SRwmuGE0pDGPDb/PFWrNqnsRxHja/2u8ILEQoprhjbIJIP8iXH6sjsshKWJQcRjpt2w8/rF17d5Slw+T9eTxCr0h2PIoYiSUmZQDBUyxqUVazmCbuYH5VFjYfxt76QxQFZJboJfwhKPr8QJSe4cX5sYRvLkY5QGP7DwkoqJHeec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723447180; c=relaxed/simple;
	bh=aqYxynmKWAzN3tmbJym4kTD4ZpqMVDx6t8F0Da0JRmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B5M69WY1fuuUzv2pwg44AliHhbPVj8sOahuzAsxMQ8QB/pWzscLYLQGnOdKGG9kyU80r1TkvvnArUx65drapAGxKzYpoaERsSNhITwGUO2iTrb/+caVKdNGTsXR3kubu6GJiwGz7EuRK1YYUddHgax/OIq0uiyNx1PbfF0Tg7Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YfVlf7Xr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YfVlf7Xr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723447179; x=1754983179;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aqYxynmKWAzN3tmbJym4kTD4ZpqMVDx6t8F0Da0JRmQ=;
  b=YfVlf7Xr8zeRT6NKNAddyTfVUaQLL9aOCa/kvlUAHrCgWbL8LwjXIJWO
   VqNi7K0/maeMbN3JWSzbYfTEZ66ObHqx8zdUVsugrZC5TMbcDM6MRpQDM
   9E/6Tc4/FPBZoguj+3GCQPNxNZUkZKZfQiNy24N04DJH56+k1nIkrIYVk
   bQ7h93YOVTZ64JnUlbIQNNyr/M9QrcqtZLNCxt7G8TW7eDPAiQ3sp6U8s
   PG9tVGEnkotaM1OnsgSmhvlKtuVe0OXEH1FnCu612tHY2uWkFMSYaClG8
   OvNfazjEFOZbfsPrZ3uPyFzRR6YqUr/astZ7Rr6cAvhaRu03LES2xPnWk
   A==;
X-CSE-ConnectionGUID: OR+xmGrSTw+cD0+OmqPK/w==
X-CSE-MsgGUID: kPePFUq2S6eiFMcwrd0XWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="32217117"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="32217117"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 00:19:38 -0700
X-CSE-ConnectionGUID: VWRcncRhSaqSUrpAwR+Z0Q==
X-CSE-MsgGUID: S6zhtof9Ryq4v5H0Ei0bBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="81410745"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa002.fm.intel.com with ESMTP; 12 Aug 2024 00:19:34 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 1/1] gpu: host1x: Use iommu_paging_domain_alloc()
Date: Mon, 12 Aug 2024 15:16:05 +0800
Message-Id: <20240812071605.9513-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20240610085555.88197-8-baolu.lu@linux.intel.com
---
 drivers/gpu/host1x/dev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index f006bc931324..b62e4f0e8130 100644
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

