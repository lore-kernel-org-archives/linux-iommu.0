Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03D915C0
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 03:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680232454; x=1711768454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=owAQuglYUXn61ccVagcCsfFJlDM4UNA2/AnhmRojT/A=;
  b=A0VCaHJq7JR3XaRijARFVvCqUHRaHBQC/WR+OQknKhGcBeQt8JS0ILsw
   XWAQtEamB+wv3sgFJ+Fsi90pfDtODr/Y3owBg3DGWuAL/zocq0LrNf9M+
   EBoq/pR1GwZGKcHjNrjEGAo5xyBtFTgeTfyX4Scr5zMDLXU3ZpRhdEgO6
   nE8hwntDhhOgvDqYOGcIo77jSKSdFkF//MxIoUvIcNKr9/yLKnHvEZ/1g
   kTUCxOTqkc7dWG6f9uVYm4WWwSjRcihGSJS+tpUZItg9i1LzM5iwuUCUP
   Q9rSC8mb0s7JipAugiS91yKfq2DpZfWKbBgbRrmxguNT60VlhdfEmVRrq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="342991736"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="342991736"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 20:14:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="635144751"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="635144751"
Received: from test.bj.intel.com ([10.238.158.71])
  by orsmga003.jf.intel.com with ESMTP; 30 Mar 2023 20:13:53 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 4/7] iommu/vt-d: Remove BUG_ON when domain->pgd is NULL
Date: Thu, 30 Mar 2023 22:42:33 -0400
Message-Id: <20230331024236.2716001-5-tina.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331024236.2716001-1-tina.zhang@intel.com>
References: <20230331024236.2716001-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When performing domain_context_mapping or searching dma-pte of a pfn,
with invalid domain page table directory address, which is unexpected,
shouldn't crash kernel. Therefore, using if() instead of BUG_ON.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/iommu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index de7fe7dcbc5c..e1881d48c2aa 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -915,10 +915,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 	int level = agaw_to_level(domain->agaw);
 	int offset;
 
-	BUG_ON(!domain->pgd);
-
-	if (!domain_pfn_supported(domain, pfn))
-		/* Address beyond IOMMU's addressing capabilities. */
+	if (unlikely(!domain->pgd || !domain_pfn_supported(domain, pfn)))
 		return NULL;
 
 	parent = domain->pgd;
@@ -1927,6 +1924,9 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	struct context_entry *context;
 	int ret;
 
+	if (unlikely(!domain->pgd))
+		return -EINVAL;
+
 	WARN_ON(did == 0);
 
 	if (hw_pass_through && domain_type_is_si(domain))
@@ -1935,8 +1935,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	pr_debug("Set context mapping for %02x:%02x.%d\n",
 		bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
 
-	BUG_ON(!domain->pgd);
-
 	spin_lock(&iommu->lock);
 	ret = -ENOMEM;
 	context = iommu_context_addr(iommu, bus, devfn, 1);
-- 
2.34.1

