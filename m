Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3201FD1
	for <iommu@lists.linux.dev>; Tue, 12 Jul 2022 00:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657584868; x=1689120868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n8OUlNT9qDkBFdgYmQfEEoxusEpBSjX1aHY1EnVMf08=;
  b=KrdKZAiQL3YmULdVbPzuEofIJDA06rEF+olK+co5jMhDbxOqZNp5+IjQ
   ojGuGQJEs7BjxF1pRGaFW8ZlA9JUrDNlyIrcMy01i7XT3wMFnaO19g1+6
   x+e4U9y5Kx3RZ+L5aXU89q/4d6DBHlOFHrzMzjlCiByf5n37jnw7y6PVU
   S7R34a74DvwhoQw8za90fEAElBMYjhb6DIotxD8VLuIHSSXolKu1pMxLI
   BsseU+OIn5QyLMIbdCEO6oGYZbnzF28iOPpfYYpXj5EEN5BLiupMiF3py
   HTDiAP/Kx2TbM5CUDc2TD6FLwtq9ad6JocfbW0nimkJoURlk+VWjHsT3y
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="310412983"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="310412983"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:14:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="592445867"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2022 17:14:15 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 24/25] iommu/vt-d: Remove global g_iommus array
Date: Tue, 12 Jul 2022 08:09:07 +0800
Message-Id: <20220712000908.3431936-25-baolu.lu@linux.intel.com>
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

The g_iommus and g_num_of_iommus is not used anywhere. Remove them to
avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lore.kernel.org/r/20220702015610.2849494-6-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 44 -------------------------------------
 1 file changed, 44 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2f64ff6e6e75..3ba0d7e76efd 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -126,9 +126,6 @@ static inline unsigned long virt_to_dma_pfn(void *p)
 	return page_to_dma_pfn(virt_to_page(p));
 }
 
-/* global iommu list, set NULL for ignored DMAR units */
-static struct intel_iommu **g_iommus;
-
 static void __init check_tylersburg_isoch(void);
 static int rwbf_quirk;
 
@@ -287,9 +284,6 @@ static LIST_HEAD(dmar_satc_units);
 #define for_each_rmrr_units(rmrr) \
 	list_for_each_entry(rmrr, &dmar_rmrr_units, list)
 
-/* bitmap for indexing intel_iommus */
-static int g_num_of_iommus;
-
 static void dmar_remove_one_dev_info(struct device *dev);
 
 int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
@@ -1694,8 +1688,6 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 		iommu->domain_ids = NULL;
 	}
 
-	g_iommus[iommu->seq_id] = NULL;
-
 	/* free context mapping */
 	free_context_table(iommu);
 
@@ -2898,36 +2890,6 @@ static int __init init_dmars(void)
 	struct intel_iommu *iommu;
 	int ret;
 
-	/*
-	 * for each drhd
-	 *    allocate root
-	 *    initialize and program root entry to not present
-	 * endfor
-	 */
-	for_each_drhd_unit(drhd) {
-		/*
-		 * lock not needed as this is only incremented in the single
-		 * threaded kernel __init code path all other access are read
-		 * only
-		 */
-		if (g_num_of_iommus < DMAR_UNITS_SUPPORTED) {
-			g_num_of_iommus++;
-			continue;
-		}
-		pr_err_once("Exceeded %d IOMMUs\n", DMAR_UNITS_SUPPORTED);
-	}
-
-	/* Preallocate enough resources for IOMMU hot-addition */
-	if (g_num_of_iommus < DMAR_UNITS_SUPPORTED)
-		g_num_of_iommus = DMAR_UNITS_SUPPORTED;
-
-	g_iommus = kcalloc(g_num_of_iommus, sizeof(struct intel_iommu *),
-			GFP_KERNEL);
-	if (!g_iommus) {
-		ret = -ENOMEM;
-		goto error;
-	}
-
 	ret = intel_cap_audit(CAP_AUDIT_STATIC_DMAR, NULL);
 	if (ret)
 		goto free_iommu;
@@ -2950,8 +2912,6 @@ static int __init init_dmars(void)
 						   intel_pasid_max_id);
 		}
 
-		g_iommus[iommu->seq_id] = iommu;
-
 		intel_iommu_init_qi(iommu);
 
 		ret = iommu_init_domains(iommu);
@@ -3077,9 +3037,6 @@ static int __init init_dmars(void)
 		free_dmar_iommu(iommu);
 	}
 
-	kfree(g_iommus);
-
-error:
 	return ret;
 }
 
@@ -3483,7 +3440,6 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	if (iommu->gcmd & DMA_GCMD_TE)
 		iommu_disable_translation(iommu);
 
-	g_iommus[iommu->seq_id] = iommu;
 	ret = iommu_init_domains(iommu);
 	if (ret == 0)
 		ret = iommu_alloc_root_entry(iommu);
-- 
2.25.1

