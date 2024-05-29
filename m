Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD671667E2
	for <iommu@lists.linux.dev>; Wed, 29 May 2024 05:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960978; cv=none; b=KMfseZ1vX6HdfkgDcIRwdrbFU/gNyc6H6rwEI365AwmkNIxMO+ypiYVAwjfwaB8D5/A8rwl1F2T6KOtKY7sh5pziDSWo8h+KG9t71spDXxwfT4qQUqrNK3Hpdu+7xO0jLLN7DqxZv0PxMizJ92SQlvwDzhonWi4IEFF1sQsFzQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960978; c=relaxed/simple;
	bh=QPVW+nVXZ/Qv6phdysqv5NqIfLXG+N6nb5d8ku5/Eew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AvUM9yaded+hll6guNmqsiP0Qq5uji/Dc6/78GxTftskzFdJzpsbkJ4wUrBwP2C6Iyk8Dl6lB/BZQKpH4dCCeuTvIW9dEpixeMXxUqPy6dn0QthvykuV9Et/pEMInCXDdG7HfL5Qz+w7Deh963LdfOgBYQdtP5tSutUE8VD+4hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XHQA2cWS; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XHQA2cWS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716960977; x=1748496977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QPVW+nVXZ/Qv6phdysqv5NqIfLXG+N6nb5d8ku5/Eew=;
  b=XHQA2cWSSiifFWvxB9OB7xViBo4cg6hDxe6cZz0Y7OpR0G9Oi23ewhRB
   D+MAKKNXPoUldErORXJ9UQx2mUgI+8B5qfNPjnpfiraavPFTG3h0iXhJr
   TF9oTXDPFh24WFsKb6mL3RK8sCdZXuSCrLrbfV7wPKFnnYSAsAp2IOkGW
   j/M4T6M5/3uPXU9bEmEE6wxq2LwEmwxe1+zkY+MxxKXOQObSyPH75dlc7
   VG94eZfr9nclPHVaEdTV4vNnmJrAuUNeeP9SHRxFZdSBIZk7A1GlVqlOd
   zVIo5PM6SkadqXFEA+7h4kyx9prIKBNPsKtWmlAPwSwjVTc+Kxun/60HL
   A==;
X-CSE-ConnectionGUID: i8/Gxd+OSi+HLCMfsLEj1g==
X-CSE-MsgGUID: rHEYgh+OS6C/J28TR2fsQA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13568912"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13568912"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 22:35:39 -0700
X-CSE-ConnectionGUID: H0Tfydb8Sd2Y4vK78rZTQg==
X-CSE-MsgGUID: ejihKNhgR8KfyMoR83nR7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35257652"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2024 22:35:34 -0700
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
Subject: [PATCH 08/20] gpu: host1x: Use iommu_paging_domain_alloc()
Date: Wed, 29 May 2024 13:32:38 +0800
Message-Id: <20240529053250.91284-9-baolu.lu@linux.intel.com>
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

An iommu domain is allocated in host1x_iommu_attach() and is attached to
host->dev. Use iommu_paging_domain_alloc() to make it explicit.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/gpu/host1x/dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 3a0aaa68ac8d..46a2447c1124 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -404,9 +404,9 @@ static struct iommu_domain *host1x_iommu_attach(struct host1x *host)
 		if (err < 0)
 			goto put_group;
 
-		host->domain = iommu_domain_alloc(&platform_bus_type);
-		if (!host->domain) {
-			err = -ENOMEM;
+		host->domain = iommu_paging_domain_alloc(host->dev);
+		if (IS_ERR(host->domain)) {
+			err = PTR_ERR(host->domain);
 			goto put_cache;
 		}
 
-- 
2.34.1

