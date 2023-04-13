Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C12648
	for <iommu@lists.linux.dev>; Thu, 13 Apr 2023 04:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681358828; x=1712894828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KoxeI8nGmhipdmhbf/hPatJykHf7P/Wr8q6XOawTXGM=;
  b=EY4z1MKy4bot0traVRgx+GoIBv0bkFhbtNimr/w/ggSpohw9/kbDMhM1
   lswj5AcWmlsA/VCwvtSTB9ZjczvlBIlRz2c1dvrVXkVwG8Ueet+rmOo1j
   XPDvrw+sBX/SjdWkDY0NUTjE/1nIfWWLjTN4AEoCPTuiI9n91Q7lqTDSG
   2amyHKrfipev19r+iyOUlUpgbxpgBxOixUf1xXWQHWePeauPsbmHmylN3
   vzxrIGGY3R+jCfs+NbTSIqpUMn73KIrwGKHOK9JgZKwWDo610eABxFSwA
   D4Y21zzTwwEApPu6rrASlJoqVF4/D+rmLN1SD5JIVOvi4eG0MUIXlj9RM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332786642"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332786642"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 21:07:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="935361089"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="935361089"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2023 21:07:05 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/17] iommu/vt-d: Remove BUG_ON in handling iotlb cache invalidation
Date: Thu, 13 Apr 2023 12:06:41 +0800
Message-Id: <20230413040645.46157-14-baolu.lu@linux.intel.com>
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

VT-d iotlb cache invalidation request with unexpected type is considered
as a bug to developers, which can be fixed. So, when such kind of issue
comes out, it needs to be reported through the kernel log, instead of
halting the system. Replacing BUG_ON with warning reporting.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Link: https://lore.kernel.org/r/20230406065944.2773296-4-tina.zhang@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c4847a5aaf52..dd61bb554aa7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1272,7 +1272,9 @@ static void __iommu_flush_context(struct intel_iommu *iommu,
 			| DMA_CCMD_SID(source_id) | DMA_CCMD_FM(function_mask);
 		break;
 	default:
-		BUG();
+		pr_warn("%s: Unexpected context-cache invalidation type 0x%llx\n",
+			iommu->name, type);
+		return;
 	}
 	val |= DMA_CCMD_ICC;
 
@@ -1308,7 +1310,9 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
 		val_iva = size_order | addr;
 		break;
 	default:
-		BUG();
+		pr_warn("%s: Unexpected iotlb invalidation type 0x%llx\n",
+			iommu->name, type);
+		return;
 	}
 	/* Note: set drain read/write */
 #if 0
@@ -1483,7 +1487,8 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 	uint64_t addr = (uint64_t)pfn << VTD_PAGE_SHIFT;
 	u16 did = domain_id_iommu(domain, iommu);
 
-	BUG_ON(pages == 0);
+	if (WARN_ON(!pages))
+		return;
 
 	if (ih)
 		ih = 1 << 6;
-- 
2.34.1

