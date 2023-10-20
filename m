Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9FE1118B
	for <iommu@lists.linux.dev>; Fri, 20 Oct 2023 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GxJ4ebbl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697793602; x=1729329602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f3ChlmDgc3Aoc0IRtb5mlD1+NYbTx+ovRakpUdpzvbk=;
  b=GxJ4ebblgWAiWO0KdrDPVCNhNoaksVbqxF6f51qZRoiD2rJp5NqwjSBM
   1H+lmvgH5Lo82fZ66dNmFbL/QmXSvkpF7fvRWROxaqZu3U22yyTfITd7Q
   m99PlxygyO1eQTLLIzgKjcoQLrpxTZ0yZVC9OPAsvl4T3PDvneOk/MjAm
   JqrjWDKv3XLsUEVSAcaiyEdccnir0rYNtqPkL0vWFSa11tWORHb3RKGeS
   uGTVuT5WsGeaGdwUksyAAq0MhDnBDcvU1BtvHG2lLKfCGGWB/iP8W00WK
   kxiLKfEdqkq1wua/Ldfg0rtaurZlVdEHfixbbsyyucW7Hrniouahj0Xt+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="366693407"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="366693407"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:20:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="707179463"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="707179463"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga003.jf.intel.com with ESMTP; 20 Oct 2023 02:20:01 -0700
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
	joao.m.martins@oracle.com,
	xin.zeng@intel.com
Subject: [PATCH v5 06/10] iommufd: Share iommufd_hwpt_alloc with IOMMUFD_OBJ_HWPT_NESTED
Date: Fri, 20 Oct 2023 02:19:42 -0700
Message-Id: <20231020091946.12173-7-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020091946.12173-1-yi.l.liu@intel.com>
References: <20231020091946.12173-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolin Chen <nicolinc@nvidia.com>

Allow iommufd_hwpt_alloc() to have a common routine but jump to different
allocators corresponding to different user input pt_obj types, either an
IOMMUFD_OBJ_IOAS for a PAGING hwpt or an IOMMUFD_OBJ_HWPT_PAGING as the
parent for a NESTED hwpt.

Also, move the "flags" validation to the hwpt allocator (paging), so that
later the hwpt_nested allocator can do its own separate flags validation.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 43 ++++++++++++++++++----------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 52df5b2bb329..24cd84a5fe8f 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -81,6 +81,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			  struct iommufd_device *idev, u32 flags,
 			  bool immediate_attach)
 {
+	const u32 valid_flags = IOMMU_HWPT_ALLOC_NEST_PARENT;
 	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
 	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_hw_pagetable *hwpt;
@@ -90,6 +91,8 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 
 	if (flags && !ops->domain_alloc_user)
 		return ERR_PTR(-EOPNOTSUPP);
+	if (flags & ~valid_flags)
+		return ERR_PTR(-EOPNOTSUPP);
 
 	hwpt_paging = __iommufd_object_alloc(ictx, hwpt_paging,
 					     IOMMUFD_OBJ_HWPT_PAGING,
@@ -161,33 +164,41 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
-	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_ioas *ioas = NULL;
+	struct iommufd_object *pt_obj;
 	struct iommufd_device *idev;
-	struct iommufd_ioas *ioas;
 	int rc;
 
-	if ((cmd->flags & (~IOMMU_HWPT_ALLOC_NEST_PARENT)) || cmd->__reserved)
+	if (cmd->__reserved)
 		return -EOPNOTSUPP;
 
 	idev = iommufd_get_device(ucmd, cmd->dev_id);
 	if (IS_ERR(idev))
 		return PTR_ERR(idev);
 
-	ioas = iommufd_get_ioas(ucmd->ictx, cmd->pt_id);
-	if (IS_ERR(ioas)) {
-		rc = PTR_ERR(ioas);
+	pt_obj = iommufd_get_object(ucmd->ictx, cmd->pt_id, IOMMUFD_OBJ_ANY);
+	if (IS_ERR(pt_obj)) {
+		rc = -EINVAL;
 		goto out_put_idev;
 	}
 
-	mutex_lock(&ioas->mutex);
-	hwpt_paging = iommufd_hwpt_paging_alloc(ucmd->ictx, ioas, idev,
-						cmd->flags, false);
-	if (IS_ERR(hwpt_paging)) {
-		rc = PTR_ERR(hwpt_paging);
-		goto out_unlock;
+	if (pt_obj->type == IOMMUFD_OBJ_IOAS) {
+		struct iommufd_hwpt_paging *hwpt_paging;
+
+		ioas = container_of(pt_obj, struct iommufd_ioas, obj);
+		mutex_lock(&ioas->mutex);
+		hwpt_paging = iommufd_hwpt_paging_alloc(ucmd->ictx, ioas, idev,
+							cmd->flags, false);
+		if (IS_ERR(hwpt_paging)) {
+			rc = PTR_ERR(hwpt_paging);
+			goto out_unlock;
+		}
+		hwpt = &hwpt_paging->common;
+	} else {
+		rc = -EINVAL;
+		goto out_put_pt;
 	}
-	hwpt = &hwpt_paging->common;
 
 	cmd->out_hwpt_id = hwpt->obj.id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
@@ -199,8 +210,10 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 out_hwpt:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &hwpt->obj);
 out_unlock:
-	mutex_unlock(&ioas->mutex);
-	iommufd_put_object(&ioas->obj);
+	if (ioas)
+		mutex_unlock(&ioas->mutex);
+out_put_pt:
+	iommufd_put_object(pt_obj);
 out_put_idev:
 	iommufd_put_object(&idev->obj);
 	return rc;
-- 
2.34.1

