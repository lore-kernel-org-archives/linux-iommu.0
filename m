Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39701C02
	for <iommu@lists.linux.dev>; Fri,  8 Dec 2023 01:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e94+XG1i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702000675; x=1733536675;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=un4XPFTzO6AWHemPtM6XczKOhQkrLlZxvkBGsGhl8F8=;
  b=e94+XG1ieN5kA1n0WdPt85tbl6JLm9A/vIaezWPpG+Ww0hewnCYOWHu8
   CEIvxnRNSAuVlOIknxG73sBJqAXfvlMNRxqSBPxNgkU8QsDBm+gAb3JJz
   odRcYjGJ/JRmche81JD/dRXTthCsopy1G7WZOPfzZNv1a82+CKiZrZlcq
   9+z6KbioXuprSDfensSztWMsrTbeE5MiE01UXOWJetxcY2t4ZM3yIMdpC
   bbeqq6NxcrHKadgMwGopn0dXcCh1P/ahSU/fiqOG9e+7IlNrZSMSS6639
   tiooFt62pKFKWskodpZQgzL4mF3cn9+c87dtxDQx1T6HlYGPyy/cYoa2+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="397131260"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="397131260"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 17:57:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="945266198"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="945266198"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga005.jf.intel.com with ESMTP; 07 Dec 2023 17:57:52 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2] iommu: Set owner token to SVA domain
Date: Fri,  8 Dec 2023 09:53:14 +0800
Message-Id: <20231208015314.320663-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a9c362db3920 ("iommu: Validate that devices match domains") added
an owner token to the iommu_domain. This token is checked during domain
attachment to RID or PASID through the generic iommu interfaces.

The SVA domains are attached to PASIDs through those iommu interfaces.
Therefore, they require the owner token to be set during allocation.
Otherwise, they fail to attach.

Set the owner token for SVA domains.

Fixes: a9c362db3920 ("iommu: Validate that devices match domains")
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 1 +
 1 file changed, 1 insertion(+)

Change log:
v2:
- The user domain allocation path does the right thing. Hence no need
  to fix anything.
v1:
- https://lore.kernel.org/linux-iommu/20231207021938.306738-1-baolu.lu@linux.intel.com/

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0d25468d53a6..d0a28667479a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3617,6 +3617,7 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 	domain->type = IOMMU_DOMAIN_SVA;
 	mmgrab(mm);
 	domain->mm = mm;
+	domain->owner = ops;
 	domain->iopf_handler = iommu_sva_handle_iopf;
 	domain->fault_data = mm;
 
-- 
2.34.1

