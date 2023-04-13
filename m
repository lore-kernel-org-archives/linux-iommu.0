Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3615163E
	for <iommu@lists.linux.dev>; Thu, 13 Apr 2023 04:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681358829; x=1712894829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n8EBKPy48sTV6ZkkN0Av9i1KZOvW3Gj5TdFWIOX431s=;
  b=OIrdDPPLcAfsWgZ6Ed0H++62poSNCO3qdqw5GfA2UqD8oQthMFEMyH6u
   ifivYMFjEWitd5IwqVj+TJANnXJgrhCQFA+DYWmFZcAecBpWro20ZPKaA
   bKAVx6vT6CT9RSlEi6jhcfnPKvW0wD6suF/n6zvia2bPA8YFvK5CtCjsx
   uSDMZGtvffH/pNtfu9ncMpO6V2V4VWFb3nt1nCGeq1cENXaLoezayIAoh
   eowT8T83n1/SEVtIIciu7jswQX0RU/AAo7lR+MBwTGNrPHoeNSZjU4y37
   9ek47ooXhoE1ZoxLVZQ1Qoy3a+n8k1CIDtVPIwyiEqsAEmw0z1pCPJqYV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332786650"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332786650"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 21:07:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="935361101"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="935361101"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2023 21:07:06 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/17] iommu/vt-d: Remove BUG_ON when domain->pgd is NULL
Date: Thu, 13 Apr 2023 12:06:42 +0800
Message-Id: <20230413040645.46157-15-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230413040645.46157-1-baolu.lu@linux.intel.com>
References: <20230413040645.46157-1-baolu.lu@linux.intel.com>
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

