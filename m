Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DA28480
	for <iommu@lists.linux.dev>; Wed, 25 Oct 2023 13:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K6zF4434"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698240170; x=1729776170;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VCsAR60EOLjvkvfdhGiMeRwZV7/SoJUu/p67SJIwIzA=;
  b=K6zF4434XbhZwHWesSWnINFp+4N2W77Jf4l60qjvfFVcDzsKWCWwS45N
   GVSWzt89ZsmR10mtm7ts+BIL/nrdmqf7V12ffrK/e4osiG39k+i1NGO4o
   mVGIrZOrYIowS0OPLZ4TPqamKvFWHw10xzOIpRpghtrgpti+e//ehRsZG
   /nT6xagU2TnhePHHOv74iH4y8FUajWI4Ojxnizsw/hg+RHGlCbTuoOwRa
   jm7odeb2v7vvhM8JJ9cgN1X95hf4ySYOR9GMrV+LiO/xLasNM5Fx3l9p9
   hVmcBDeQbdicRQDPLsKhEdbkEbLVL+FElQuHsQ3y0FrRETHR5WRvqFQXT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="418427492"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="418427492"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 06:22:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="1090220714"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="1090220714"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 25 Oct 2023 06:22:48 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] Revert "iommu/vt-d: Remove unused function"
Date: Wed, 25 Oct 2023 21:18:54 +0800
Message-Id: <20231025131854.375388-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit c61c255e114c52682546447ed44d3470b5708134.

The pasid_set_wpe() helper, which was removed by the reverted commit,
is still used by the nesting translation support in the iommufd tree.
To avoid a merge conflict, revert the commit.

Link: https://lore.kernel.org/linux-kernel/20231025153455.283c5b12@canb.auug.org.au/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 06ddb3c927f5..8f92b92f3d2a 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -335,6 +335,15 @@ static inline void pasid_set_fault_enable(struct pasid_entry *pe)
 	pasid_set_bits(&pe->val[0], 1 << 1, 0);
 }
 
+/*
+ * Setup the WPE(Write Protect Enable) field (Bit 132) of a
+ * scalable mode PASID entry.
+ */
+static inline void pasid_set_wpe(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[2], 1 << 4, 1 << 4);
+}
+
 /*
  * Setup the P(Present) field (Bit 0) of a scalable mode PASID
  * entry.
-- 
2.34.1

