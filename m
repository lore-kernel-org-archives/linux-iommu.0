Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0248D1FC8
	for <iommu@lists.linux.dev>; Tue, 12 Jul 2022 00:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657584869; x=1689120869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qKKsYPnFKnFFJPzOZhVWU6Nqf98mNpvKExXx01NfN9M=;
  b=bgjsOzdYjDfTXDZBPP2yHpz/oUl7om3zODL9SF5zkpMQ2ycSPtzSG/Qh
   zO9BbTwifiBpixVnt8WWYH77QyHQso70xTVD00GV75Nyh9O16JNo3Wjc9
   lhafu1FXWI6Xt2rDg4aszfyMjVZx06QWK91PpWB5G15WnBYV+rQVFiUZq
   GsyG+hTqvOF6QBefluiNP7uBAv2Pftjphrn5cPE1M7+C8nAvDXVE2vcSE
   a2dFIYCcnE0/6oHT91161EjQDVIIiSEl9xv0c50dNgWN1mi3CQ5XAx+1u
   2eLCClMHffRznHXJ3WAolpsCSUR5NjzObMssm6qBoXu3ZpbJTeGVf7P0E
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="285929310"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="285929310"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:14:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="592445865"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2022 17:14:14 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 23/25] iommu/vt-d: Remove unnecessary check in intel_iommu_add()
Date: Tue, 12 Jul 2022 08:09:06 +0800
Message-Id: <20220712000908.3431936-24-baolu.lu@linux.intel.com>
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

The Intel IOMMU hot-add process starts from dmar_device_hotplug(). It
uses the global dmar_global_lock to synchronize all the hot-add and
hot-remove paths. In the hot-add path, the new IOMMU data structures
are allocated firstly by dmar_parse_one_drhd() and then initialized by
dmar_hp_add_drhd(). All the IOMMU units are allocated and initialized
in the same synchronized path. There is no case where any IOMMU unit
is created and then initialized for multiple times.

This removes the unnecessary check in intel_iommu_add() which is the
last reference place of the global IOMMU array.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lore.kernel.org/r/20220702015610.2849494-5-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 36b3649a83e8..2f64ff6e6e75 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3460,9 +3460,6 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	int sp, ret;
 	struct intel_iommu *iommu = dmaru->iommu;
 
-	if (g_iommus[iommu->seq_id])
-		return 0;
-
 	ret = intel_cap_audit(CAP_AUDIT_HOTPLUG_DMAR, iommu);
 	if (ret)
 		goto out;
-- 
2.25.1

