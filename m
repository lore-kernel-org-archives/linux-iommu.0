Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5460B139CFF
	for <iommu@lists.linux.dev>; Tue,  7 Jan 2025 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736216392; cv=none; b=BsGy7PZJQVXqKJsLbhbSliYz9VIeWT2K45XhdMU0W0+U1rS4zX6uLDoPMTBn5yHnUNoPpnZSSIPL5uGDnsSTwhdVtqGiCqfv6Rw6cjS9Ely/y7vlJU5Wg9YxNAwsjbxXpbMOm3A9/Bc6V3sk/OfRS0PHC+mS78uEifAjEjj/MIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736216392; c=relaxed/simple;
	bh=FbdsAtUmXdF2u/Yms3KtHtj2wiqxHBg3vTkGayD1J4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOj6lGQsdWOTP+CpqNfnzNGzmuybSmRz3sESpxYNdf/rMTCrHpqoHwoAQHfJAJCBlcslHA5Cb4xRlpAQT9wAXD8g5jizrhdl4U/ws6bk0MxHqjjn41sVJ9Lq7yFWc6asEogcyQo0DIu9Uue5cxaUyPaSWAxYKPC16oG/pfVhk0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n0WYfFob; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n0WYfFob"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736216388; x=1767752388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FbdsAtUmXdF2u/Yms3KtHtj2wiqxHBg3vTkGayD1J4A=;
  b=n0WYfFobr3FHTIpdg1NOjAWuDAbC4MCtz6vm6AURkCvCBzy+PdgmA4D7
   F3/h0PTMwp6RDuPqIpDgIU26hZ0t0KUt7pmGIAESgVMujT4FqOV8jBo8e
   fHtGjL+90YA2DNQ7z1xApOPTw1shm/LwS+7YOCzCfXUTMUqyH8EcBB3Up
   fmiowBR1q4r0iFP6ymh6YZSyZneNUcSku3u9vgTWPfNrixh4UTe9AiBXE
   RMcx35kE/JiwdXj1dhltz41RLWWD/OC/UR9XqNqQRQ9ScGYdeuwghZC58
   t0V+KwmtMEtEK3jOw5dS44X9BXzWxLdGzZ81hQxaUGlq/WBYkdrGjAxae
   g==;
X-CSE-ConnectionGUID: hbpvaYM+R2aopI1/bZwbrw==
X-CSE-MsgGUID: J1VqTrmZQ+2ikd6f4e1AsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="47800767"
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="47800767"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 18:19:47 -0800
X-CSE-ConnectionGUID: nczGu+jJR+acbLrc0hrEUQ==
X-CSE-MsgGUID: 9xHt8pnUTZ+O9e5CFqXntg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="102442918"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by orviesa009.jf.intel.com with ESMTP; 06 Jan 2025 18:19:46 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Kees Bakker <kees@ijzerbout.nl>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE
Date: Tue,  7 Jan 2025 10:17:42 +0800
Message-ID: <20250107021746.6908-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107021746.6908-1-baolu.lu@linux.intel.com>
References: <20250107021746.6908-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kees Bakker <kees@ijzerbout.nl>

There is a WARN_ON_ONCE to catch an unlikely situation when
domain_remove_dev_pasid can't find the `pasid`. In case it nevertheless
happens we must avoid using a NULL pointer.

Signed-off-by: Kees Bakker <kees@ijzerbout.nl>
Link: https://lore.kernel.org/r/20241218201048.E544818E57E@bout3.ijzerbout.nl
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 79e0da9eb626..8f75c11a3ec4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4090,13 +4090,14 @@ void domain_remove_dev_pasid(struct iommu_domain *domain,
 			break;
 		}
 	}
-	WARN_ON_ONCE(!dev_pasid);
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
 	cache_tag_unassign_domain(dmar_domain, dev, pasid);
 	domain_detach_iommu(dmar_domain, iommu);
-	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
-	kfree(dev_pasid);
+	if (!WARN_ON_ONCE(!dev_pasid)) {
+		intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
+		kfree(dev_pasid);
+	}
 }
 
 static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
-- 
2.43.0

