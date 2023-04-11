Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C76928EF
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 06:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681195722; x=1712731722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n8EBKPy48sTV6ZkkN0Av9i1KZOvW3Gj5TdFWIOX431s=;
  b=hF2/PMlTXcxp8JiVjGen0Igu7zJhyfLkYUgALiZs0XSYdLunX34j4DEo
   RD5G7welj1Ka6JLndBih7AO81/+lwiNhNOgaLstlut8evrEP1fZZY6G1d
   G1wsSrxT3mlhBbCrfTvIVLGh1w9UpV463m8LpVdkhYZ7SqaTTV79IvwFd
   9593sayVBud2oi8x+pLXInar4rJ7u3HOY8yZix57ZU48xCtMUGJWNylri
   IbUPIHuUwh/ngPKmP4MGMRRKjQ340mVG1BKANjtDlF9UrcilfoRLVL10f
   Y91OGUwXFWOwR3QV/tGmriCRp6npIps9iZBhDes6oYGMgQq8LCGUAZidl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341028623"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341028623"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:48:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018256637"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018256637"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2023 23:48:40 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/17] iommu/vt-d: Remove BUG_ON when domain->pgd is NULL
Date: Tue, 11 Apr 2023 14:48:12 +0800
Message-Id: <20230411064815.31456-15-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411064815.31456-1-baolu.lu@linux.intel.com>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tina Zhang <tina.zhang@intel.com>

When performing domain_context_mapping or getting dma_pte of a pfn, the
availability of the domain page table directory is ensured. Therefore,
the domain->pgd checkings are unnecessary.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Link: https://lore.kernel.org/r/20230406065944.2773296-5-tina.zhang@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index dd61bb554aa7..f11347a590d7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -915,8 +915,6 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 	int level = agaw_to_level(domain->agaw);
 	int offset;
 
-	BUG_ON(!domain->pgd);
-
 	if (!domain_pfn_supported(domain, pfn))
 		/* Address beyond IOMMU's addressing capabilities. */
 		return NULL;
@@ -1910,8 +1908,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	pr_debug("Set context mapping for %02x:%02x.%d\n",
 		bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
 
-	BUG_ON(!domain->pgd);
-
 	spin_lock(&iommu->lock);
 	ret = -ENOMEM;
 	context = iommu_context_addr(iommu, bus, devfn, 1);
-- 
2.34.1

