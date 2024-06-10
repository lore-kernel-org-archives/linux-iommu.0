Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C053613212E
	for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009986; cv=none; b=X8k5chvRaxH/lAmeBNFaJSn8BNNF9k4trXCB0j0/xm3eRIuGNshpONWo8LPHi3kbsVa4sVmr7zqJO+b5oBTZr6PaV0P+WZT20krYdrpnd/PdXWaOHsNjiqZUHiraDVoNK6gNorklYwZKjoMMqy1nK3ifrNSgjLfHKhcB9C0BuTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009986; c=relaxed/simple;
	bh=9YhH5rA1b+ID5Xo/cB0X+5j1j2KZOf2zs+wByq5adpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=odq9bPgybXM9UzHTlaURbz61hvtCU58askqPhPPWNHBPQJIcSaq2Y/IG8FIX8znibDsCBvNRLIcO8cjcbbP/JYK5xMqCyZcc/QMyAfMQm6kFaEu6GoEqHGiTcB9uPACl8QpF8DWRdJs7r38PPGAMPu6+oNyqkCE6aMGBXrCr7XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFKu4zVZ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFKu4zVZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718009984; x=1749545984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9YhH5rA1b+ID5Xo/cB0X+5j1j2KZOf2zs+wByq5adpQ=;
  b=aFKu4zVZ8PDA2m8Wv68/W2VlAxZ6J1GuhnB3cBb/Ov/mtQhYHPA9FcNd
   8J7B+VLO6yw2zBBhR9vsK4jHyIroFjR9aKBO7mcASqgD/vY9ncxs6XpSV
   NEOMk7uXnIzvVirgzA+LaGcyn7F2JXDroMXpqH7mMbchHgW6L4kqgpO5D
   Uig/3H8hCCGKAdNclmGqxTwOicgmE4gJvozHLCY/rEoJDkavWWWluHfDr
   yYPNWdiUv1SCvHxBhO//jr1oitPJVhCec4+Ssu4Gt1490iT3FVi1iU46i
   k0d+BwX3MFtkv7yHWmZY61uAo6/Kl0q1Fj2u+gR7tbfbLbnPuYqpXMUpO
   g==;
X-CSE-ConnectionGUID: Akhb8GouTdKe7nqhxM+6jQ==
X-CSE-MsgGUID: eL285eDcSjyDutKbaVhYGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="17581950"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="17581950"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 01:59:44 -0700
X-CSE-ConnectionGUID: 0ICSXuCKQ7SlB4hgj7FQWA==
X-CSE-MsgGUID: YSw+GqFMR2OnMFZIW7S7Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43432960"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jun 2024 01:59:40 -0700
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
Subject: [PATCH v3 17/21] ARM: dma-mapping: Use iommu_paging_domain_alloc()
Date: Mon, 10 Jun 2024 16:55:51 +0800
Message-Id: <20240610085555.88197-18-baolu.lu@linux.intel.com>
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

Since arm_iommu_create_mapping() now accepts the device, let's replace
iommu_domain_alloc() with iommu_paging_domain_alloc() to retire the former.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 arch/arm/mm/dma-mapping.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 52f9c56cc3cb..88c2d68a69c9 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1585,9 +1585,11 @@ arm_iommu_create_mapping(struct device *dev, dma_addr_t base, u64 size)
 
 	spin_lock_init(&mapping->lock);
 
-	mapping->domain = iommu_domain_alloc(dev->bus);
-	if (!mapping->domain)
+	mapping->domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(mapping->domain)) {
+		err = PTR_ERR(mapping->domain);
 		goto err4;
+	}
 
 	kref_init(&mapping->kref);
 	return mapping;
-- 
2.34.1

