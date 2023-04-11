Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769C423A3
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 06:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681195699; x=1712731699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rMHo8yYSBVXvdzGdpugvYObeZKKcdE/cMZKOA3T4vNU=;
  b=arKqTP64Ab4WSodsY3NLU101WHjA93eb9a9I3x3C759YlKJGAnc96i3F
   wpI8pzKVAIokWEEzTK8skV8kcncQ8/4ZdLr9QPAh7u9nSvYK2vMSH0Cjk
   7eTL+7LfhT7iKXif0d02CeTJBF3rTQ9M6O8DBry6mFJyhLODBTfagdJxm
   ebzCojWbLFGjk6oDa7lUoZWawP3d73QWNiHVH2SPsG/nTTz9FSRnuBehN
   2KTatAd5EKN9VqcpzsQGsGaLUCQCMKvlx3oG5hS+mTdigAlO1ah0OwnMr
   Khezqvcsv5IIfaQJFB3GJIT1LQtGuty68UjYt8EEEHvAC/f6X4K3cA3ez
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341028505"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341028505"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:48:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018256541"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018256541"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2023 23:48:13 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/17] iommu/vt-d: Allow SVA with device-specific IOPF
Date: Tue, 11 Apr 2023 14:48:00 +0800
Message-Id: <20230411064815.31456-3-baolu.lu@linux.intel.com>
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

Currently enabling SVA requires IOPF support from the IOMMU and device
PCI PRI. However, some devices can handle IOPF by itself without ever
sending PCI page requests nor advertising PRI capability.

Allow SVA support with IOPF handled either by IOMMU (PCI PRI) or device
driver (device-specific IOPF). As long as IOPF could be handled, SVA
should continue to work.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20230324120234.313643-3-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7c2f4bd33582..caf664448ee9 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4650,7 +4650,21 @@ static int intel_iommu_enable_sva(struct device *dev)
 	if (!(iommu->flags & VTD_FLAG_SVM_CAPABLE))
 		return -ENODEV;
 
-	if (!info->pasid_enabled || !info->pri_enabled || !info->ats_enabled)
+	if (!info->pasid_enabled || !info->ats_enabled)
+		return -EINVAL;
+
+	/*
+	 * Devices having device-specific I/O fault handling should not
+	 * support PCI/PRI. The IOMMU side has no means to check the
+	 * capability of device-specific IOPF.  Therefore, IOMMU can only
+	 * default that if the device driver enables SVA on a non-PRI
+	 * device, it will handle IOPF in its own way.
+	 */
+	if (!info->pri_supported)
+		return 0;
+
+	/* Devices supporting PRI should have it enabled. */
+	if (!info->pri_enabled)
 		return -EINVAL;
 
 	ret = iopf_queue_add_device(iommu->iopf_queue, dev);
-- 
2.34.1

