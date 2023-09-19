Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391A83D3AD
	for <iommu@lists.linux.dev>; Tue, 19 Sep 2023 09:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695115560; x=1726651560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q66OHCFRu99evLMCHuExKGxiNMAzbw1601UJQaxYYqQ=;
  b=XMpk1Sd9oK8610Hr5QIu05OlIWW1Y1oop2i4gPDsR4DaztT0SmbdAEAJ
   fLUQ8f5iIYWjktTdBaOlHBkRS+uUap5R/+4wAaWeIZ/bFwhH69eYv3P2J
   tGo9Zdz3Mcm1YDIIAKm2D5mgYAL2MmHrTG+rL092wBBODamn+3+t/fBHK
   +/MxzCUhQ8QtPPQh2V96Rt785K8D3KyhIYIQ8PAimglm480Pmzdlh6gIj
   CS3m1ESxvJHeXyAoxejnfQ0K5VvaIvGfpaZjrrYzO2Azy7oIq0I8LyQlq
   JezUaBjWfCgDUQYnGnTBCl+r9P81jxR+ezkDpM98n1eQQ9aq7KGcGHCvi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="446368930"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="446368930"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 02:25:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="722804772"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="722804772"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 19 Sep 2023 02:25:34 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com
Cc: cohuck@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	mjrosato@linux.ibm.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	yi.y.sun@linux.intel.com,
	peterx@redhat.com,
	jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com,
	lulu@redhat.com,
	suravee.suthikulpanit@amd.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com
Subject: [PATCH 4/6] iommufd/hw_pagetable: Support allocating nested parent domain
Date: Tue, 19 Sep 2023 02:25:21 -0700
Message-Id: <20230919092523.39286-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919092523.39286-1-yi.l.liu@intel.com>
References: <20230919092523.39286-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This extends IOMMU_HWPT_ALLOC to allocate domains used as parent (stage-2)
in nested translation.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 5be7a31cbd9c..26a8a818ffa3 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -83,6 +83,9 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 
 	lockdep_assert_held(&ioas->mutex);
 
+	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !ops->domain_alloc_user)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	hwpt = iommufd_object_alloc(ictx, hwpt, IOMMUFD_OBJ_HW_PAGETABLE);
 	if (IS_ERR(hwpt))
 		return hwpt;
@@ -154,7 +157,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	struct iommufd_ioas *ioas;
 	int rc;
 
-	if (cmd->flags || cmd->__reserved)
+	if (cmd->flags & ~IOMMU_HWPT_ALLOC_NEST_PARENT || cmd->__reserved)
 		return -EOPNOTSUPP;
 
 	idev = iommufd_get_device(ucmd, cmd->dev_id);
-- 
2.34.1

