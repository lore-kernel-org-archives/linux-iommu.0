Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F7217E
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 02:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686710902; x=1718246902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UGWXKlFwoha8aQZA4PcpDVrWAANHfSgY3CsRnwLIe6c=;
  b=a0+U6IQ5EdhQP35L6gr0wvawf4BRZU/vGOm0zeTiZNIUK6WYApbJhCev
   R0FDHPlJZIn1jwBbx2UwPwpSmGV5IEP+szU/CotZ44VSW3mlq6NCVANOG
   PmQ+7q3SCTNCH7JK6/PsMTdqil1Bj4Y4ZIpKF4cJbLn6nPNdwTkWHnV3q
   5QnmQLGDHiSqB0TOzIvsbxSE8zuWNECeVu1hMsahLfBWCFCnQR3J1/5xd
   jbaZXLi0HOnC8KZ8JFl956SNaYA2Kt2pClFzxk6HNm69EnHkopv2dDJ42
   eStzxda+Xg2HUnB6Aft/s47DIe6OeQDrtoqWO1BCSgUGTa46FgmE8EydL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="348164472"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="348164472"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 19:48:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711884219"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="711884219"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga002.jf.intel.com with ESMTP; 13 Jun 2023 19:48:20 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Yanfei Xu <yanfei.xu@intel.com>,
	Suhui <suhui@nfschina.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] iommu/vt-d: Remove commented-out code
Date: Wed, 14 Jun 2023 10:47:05 +0800
Message-Id: <20230614024705.88878-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230614024705.88878-1-baolu.lu@linux.intel.com>
References: <20230614024705.88878-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These lines of code were commented out when they were first added in commit
ba39592764ed ("Intel IOMMU: Intel IOMMU driver"). We do not want to restore
them because the VT-d spec has deprecated the read/write draining hit.

VT-d spec (section 11.4.2):
"
 Hardware implementation with Major Version 2 or higher (VER_REG), always
 performs required drain without software explicitly requesting a drain in
 IOTLB invalidation. This field is deprecated and hardware  will always
 report it as 1 to maintain backward compatibility with software.
"

Remove the code to make the code cleaner.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Link: https://lore.kernel.org/r/20230609060514.15154-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4c0b7424c45e..e5c111ff4dd9 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1312,15 +1312,7 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
 			iommu->name, type);
 		return;
 	}
-	/* Note: set drain read/write */
-#if 0
-	/*
-	 * This is probably to be super secure.. Looks like we can
-	 * ignore it without any impact.
-	 */
-	if (cap_read_drain(iommu->cap))
-		val |= DMA_TLB_READ_DRAIN;
-#endif
+
 	if (cap_write_drain(iommu->cap))
 		val |= DMA_TLB_WRITE_DRAIN;
 
-- 
2.34.1

