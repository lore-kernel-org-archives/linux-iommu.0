Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813097C
	for <iommu@lists.linux.dev>; Sat, 25 Jun 2022 12:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656161802; x=1687697802;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K1A1BNwT+8Hbe6On1W0+Qd4OG/bxND97giqef+O4iOE=;
  b=etJULT9Imf7c78iqJDbBaoGforgTtyqYIoSrb0AlFsRjVIlUPJqC+QLO
   Rc/sdZ/YCOijdHXlfzxcnimFe+oxwPP6XqF++JmEO7khR5b7DlCJ45THV
   ugv01U5NWIC5nZ84Omet4TFAouzgh45SyfLydEEv0HVHfYp4jV0D/39V3
   dJtzShdJCrhjmKdnSAi1NiZwbZMx0tYuQ6zbUuUY4lFwOgZIvSUMhNAo3
   WSHF9a6RWE+xbZ4veJOxKYeAHioMpTX/Ujpv+WuH8rmUJXbVkLgKmEzR2
   yanz7csg3kL3GQfNph3QbTTInwfss0jf+0c1uNgP5B65mJbXOz0lGVxHs
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="261600735"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="261600735"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 05:56:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="586890393"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 25 Jun 2022 05:56:39 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Steve Wahl <steve.wahl@hpe.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Mike Travis <mike.travis@hpe.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Russ Anderson <russ.anderson@hpe.com>,
	iommu@lists.linux.dev,
	iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v1 4/6] iommu/vt-d: Add VTD_FLAG_IOMMU_PROBED flag
Date: Sat, 25 Jun 2022 20:52:02 +0800
Message-ID: <20220625125204.2199437-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
References: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20220625125202.taE8s5nJlmLG8idlc9h_q5hzKOjudJNJ0T-W0fbfMQg@z>

In the IOMMU hot-add path, there's a need to check whether an IOMMU
has been probed. Instead of checking the IOMMU pointer in the global
list, it's better to allocate a flag bit in iommu->flags for this
purpose.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h | 1 +
 drivers/iommu/intel/iommu.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 56c3d1a9e155..105a1e7c60d9 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -479,6 +479,7 @@ enum {
 #define VTD_FLAG_TRANS_PRE_ENABLED	(1 << 0)
 #define VTD_FLAG_IRQ_REMAP_PRE_ENABLED	(1 << 1)
 #define VTD_FLAG_SVM_CAPABLE		(1 << 2)
+#define VTD_FLAG_IOMMU_PROBED		(1 << 3)
 
 extern int intel_iommu_sm;
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 78b26fef685e..f6d7055cffd7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1695,6 +1695,7 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 	}
 
 	g_iommus[iommu->seq_id] = NULL;
+	iommu->flags &= ~VTD_FLAG_IOMMU_PROBED;
 
 	/* free context mapping */
 	free_context_table(iommu);
@@ -2951,6 +2952,7 @@ static int __init init_dmars(void)
 		}
 
 		g_iommus[iommu->seq_id] = iommu;
+		iommu->flags |= VTD_FLAG_IOMMU_PROBED;
 
 		intel_iommu_init_qi(iommu);
 
@@ -3460,7 +3462,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	int sp, ret;
 	struct intel_iommu *iommu = dmaru->iommu;
 
-	if (g_iommus[iommu->seq_id])
+	if (iommu->flags & VTD_FLAG_IOMMU_PROBED)
 		return 0;
 
 	ret = intel_cap_audit(CAP_AUDIT_HOTPLUG_DMAR, iommu);
@@ -3487,6 +3489,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 		iommu_disable_translation(iommu);
 
 	g_iommus[iommu->seq_id] = iommu;
+	iommu->flags |= VTD_FLAG_IOMMU_PROBED;
 	ret = iommu_init_domains(iommu);
 	if (ret == 0)
 		ret = iommu_alloc_root_entry(iommu);
-- 
2.25.1

