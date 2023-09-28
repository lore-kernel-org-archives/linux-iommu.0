Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BEB79FC
	for <iommu@lists.linux.dev>; Thu, 28 Sep 2023 07:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695885341; x=1727421341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=caYY16c3X4qJEs7vjlwRO/5AoAt3WHXwfSZCdiD2ZmE=;
  b=MUUMRgTThCSMlVV1j4ZAkDCiQnN9ahJ6PcuzU+TcvyVcHdmKXm8mQy/F
   g+aAp8eaWWt/Te+fZL3WWhBmn6nKxpYDZDEVMpnN8ProDarasVWjq+4c8
   VkYWlZkfoHhL0Pd+5xO1+G2i+/Pc9m0Vp5TFJFlLkTABF/rXNwnpQFpvr
   2CXqJYOih/iLUOE5kDpWrP6E5EH2Ry4iaPh6XPmwo1l/bTqxlHDB9ijOA
   yvddVyVhU3n9kD3aiazM2aqmWI40jlWP72/xnU9snwxIyt6pTv5KwNYbN
   +LqUS+2BpDfjQGXGz5fVOmtVooC9h75rOJ0zcTap1qW+Lp0oZcbn3ijS1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="412914877"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="412914877"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 00:15:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="784602100"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="784602100"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga001.jf.intel.com with ESMTP; 28 Sep 2023 00:15:36 -0700
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
Subject: [PATCH v2 4/6] iommufd/hw_pagetable: Support allocating nested parent domain
Date: Thu, 28 Sep 2023 00:15:26 -0700
Message-Id: <20230928071528.26258-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928071528.26258-1-yi.l.liu@intel.com>
References: <20230928071528.26258-1-yi.l.liu@intel.com>
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
index 5be7a31cbd9c..8b3d2875d642 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -83,6 +83,9 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 
 	lockdep_assert_held(&ioas->mutex);
 
+	if (flags && !ops->domain_alloc_user)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	hwpt = iommufd_object_alloc(ictx, hwpt, IOMMUFD_OBJ_HW_PAGETABLE);
 	if (IS_ERR(hwpt))
 		return hwpt;
@@ -154,7 +157,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	struct iommufd_ioas *ioas;
 	int rc;
 
-	if (cmd->flags || cmd->__reserved)
+	if ((cmd->flags & (~IOMMU_HWPT_ALLOC_NEST_PARENT)) || cmd->__reserved)
 		return -EOPNOTSUPP;
 
 	idev = iommufd_get_device(ucmd, cmd->dev_id);
-- 
2.34.1

