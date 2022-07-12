Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10C81FAA
	for <iommu@lists.linux.dev>; Tue, 12 Jul 2022 00:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657584829; x=1689120829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NpRwK872iEsLurKjmmUKzy5zljzIR91UH4ONOmkOXB0=;
  b=AraBg2mOYwquLVZUQaUvqSHIAztfTx+VzA3nGMDJlmlV0YMo3MHcJWrv
   pvqvMX82HNK1v5ABItM4MxAKqJhEFwx9pZlqVLsdAhj1PknO2GA9yHYdc
   Tz4LEA4cdYx5lbnbT4PTcp7g9kDa/ziE9bNddH89CdZzPcIU/NG+2Ai6+
   nLKLbvmNSJkE2ynfKGNrgk1zT3r82XCh9Jp9GVbGm/5d/uc0kgfK9H2Ht
   E/mT+YykOuWDjxWU44Umnpax/H5ReBgQp7iFdrwesVt9AmxOSUdRjqrC5
   OjKf66OZx4U/8uF4jmwDofs5FBcumoqT+sK6Ieankdt8aoUaSizulkocV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="264589910"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="264589910"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:13:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="592445717"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2022 17:13:48 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/25] iommu/vt-d: Remove unused iovad from dmar_domain
Date: Tue, 12 Jul 2022 08:08:51 +0800
Message-Id: <20220712000908.3431936-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
References: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not used anywhere. Cleanup it to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20220527053424.3111186-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 4ebf3c4da45e..8285fcfa5fea 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -543,7 +543,6 @@ struct dmar_domain {
 	u8 set_pte_snp:1;
 
 	struct list_head devices;	/* all devices' list */
-	struct iova_domain iovad;	/* iova's that belong to this domain */
 
 	struct dma_pte	*pgd;		/* virtual address */
 	int		gaw;		/* max guest address width */
-- 
2.25.1

