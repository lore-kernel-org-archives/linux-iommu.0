Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13024168C1C
	for <iommu@lists.linux.dev>; Wed, 29 May 2024 05:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960982; cv=none; b=IxecGxOavo6MKnqKwzjrYEUUQ5KeqsK6T9LKDpR+9SbCxs6fYVE9jQa+AWyg5t1faj0Y8SCIoIjSy8U5b8Het+84ho34U3OFif8ilUn6lqdjyjnlbniYrkfIwOHhWOUSjRsO71/xybqPDJgpFjKC6S3/TWcgqgSP6PhJvgi72W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960982; c=relaxed/simple;
	bh=kv68qkR9q97yuL81djioGxxqJnKTS0o+E5D+XI6WQks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rOqTNXJov5Vod7RETYgZ6U/JRCVdC3gl8ta5JC+ztnQwbqDNt3M31vJO9kUe7ojN4Hy3wf3p443/kw8q44YAl3p65m8jIcavgsIXYmu8hsise2fiphX+JfncrfkL5vv1r8Cf4ArggQBr61IVVcr5MuxaI7sU/bxW4rjG+JoJ/uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HcQziK3t; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HcQziK3t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716960981; x=1748496981;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kv68qkR9q97yuL81djioGxxqJnKTS0o+E5D+XI6WQks=;
  b=HcQziK3tU8ko5rBsD4T4oy7vsL7TH7tjnzBVa88FmSktuZJlFltrT1sj
   GGNKv1gLDi9hVohbJ8TGph1YSKXPT3ynNzkULpbtVq8s5q7L2Q6aAawq5
   3/nDwaA5OpxpR+pPdW6tN3UU1PuMjfrUFy6oi9tqmxFdxC9lODcbEeZ8e
   1MkI1nWvKHCOg6dU3f7YJ/jaCHLDkOIwqXSeifFN/M/rgUQExaOkY1hXN
   iJ2hNdoFdCtHgGSOph+FTSREP8e2DW52kOBJDM2PxLFkgL249iAtBewHH
   COxKPevdmKJ7fQasVLTCKtyduVdQh7tar10ytPYeP+qCFEss52fi3IJrj
   Q==;
X-CSE-ConnectionGUID: AOpkrK5oSD2//eaJ7EE8nQ==
X-CSE-MsgGUID: KMtI/oWFRO+xUwf4TsxJgg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13568997"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13568997"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 22:35:53 -0700
X-CSE-ConnectionGUID: C5UxFXeCS62GXV5ofkH9mg==
X-CSE-MsgGUID: 0gi2TYzwQaSnWJDrgXMwWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35257688"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2024 22:35:49 -0700
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
Subject: [PATCH 11/20] ath10k: Use iommu_paging_domain_alloc()
Date: Wed, 29 May 2024 13:32:41 +0800
Message-Id: <20240529053250.91284-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529053250.91284-1-baolu.lu@linux.intel.com>
References: <20240529053250.91284-1-baolu.lu@linux.intel.com>
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

