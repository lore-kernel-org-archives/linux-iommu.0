Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96A663DE
	for <iommu@lists.linux.dev>; Tue, 30 May 2023 05:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685425162; x=1716961162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Il+8YMeI0EiWGMw/azL1HK4UGyN0VoQuqukfg2UvUJc=;
  b=RmghQYURdCzsgdYx9DK/ThpVKh9g/ZV+9tSjMJ3klrPxDztKMt2/v6Fs
   JbSczMAPd9lwESUBIwaw2MbnQGueTc7mkACBw3yzbcf8AM73MAAE4lyHR
   ktNo9TRAVethpr582VLI9oC8E1Mxnc+PZjSG4khiJi5Z7bcm92LXCI7RB
   dG5KgBJSIKtI91UD2SkxOT00i1fyKyOZdPf58GPpTbUBa38QTp3Ewu7Wf
   mgNF9MbesCyh14Xp/6LncrBTYB1F42nkS25pdhfKq/yUNVdakwDPweF9z
   vXwCZ+77z8hvzXQU3drvKjPgase8cVmnbCogSPu8+YNMevaFrAlWNI6c+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420579897"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="420579897"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 22:39:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739369946"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="739369946"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2023 22:39:18 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCHES 15/17] iommufd: Allow new hwpt_alloc flags
Date: Tue, 30 May 2023 13:37:22 +0800
Message-Id: <20230530053724.232765-16-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530053724.232765-1-baolu.lu@linux.intel.com>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have completed all puzzles for IO page fault delivery so far. We can
allow user space to opt-in the flags of IOMMU_HWPT_ALLOC_FLAGS_IOPF and
IOMMU_HWPT_ALLOC_FLAGS_USER_PASID_TABLE now.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/uapi/linux/iommufd.h         | 3 +++
 drivers/iommu/iommufd/hw_pagetable.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 65bb856dd8fb..908d12219727 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -491,6 +491,9 @@ struct iommu_hwpt_alloc {
 	__u32 flags;
 #define IOMMU_HWPT_ALLOC_FLAGS_IOPF_CAPABLE		(1 << 0)
 #define IOMMU_HWPT_ALLOC_FLAGS_USER_PASID_TABLE		(1 << 1)
+#define IOMMU_HWPT_ALLOC_FLAGS_ALL				\
+		(IOMMU_HWPT_ALLOC_FLAGS_IOPF_CAPABLE |		\
+		 IOMMU_HWPT_ALLOC_FLAGS_USER_PASID_TABLE)
 	__u32 dev_id;
 	__u32 pt_id;
 	__u32 out_hwpt_id;
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 7f18e6bd76ec..7be6bf26290f 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -208,7 +208,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	int klen = 0;
 	int rc = 0;
 
-	if (cmd->flags || cmd->__reserved)
+	if ((cmd->flags & ~IOMMU_HWPT_ALLOC_FLAGS_ALL) || cmd->__reserved)
 		return -EOPNOTSUPP;
 
 	idev = iommufd_get_device(ucmd, cmd->dev_id);
-- 
2.34.1

