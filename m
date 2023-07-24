Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5442053A6
	for <iommu@lists.linux.dev>; Mon, 24 Jul 2023 11:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196678; x=1721732678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KYIs7M+eJopUTxJV4cpg9FxLziL1nbNIFCuxJQtO2rA=;
  b=Gy7asQQpDeAZ3z1F/3Yy1X5nCPWHgdm3oFu5HYlOVeux8uI/RJd5FvQl
   BIbLPNNRrEYYdhu8HFsWHQHqva+N6z3MG6Lq5lf2MSH5UIsusk5C2FF0j
   g4fqe8UKesG4u8ot2YB/3xVzLG/8NX76Tii/b97hu28mdsAWgdXt4zF70
   K8LnSk78pepsisCT8D7jXxwRkKX9WVb9SEeM7XMD2gvFJnc0mwKYY6JH4
   pd2zSyrvKAtF+PCyE4gGpUpPhKwiRp7q8U1qyKyMyhxd6FVFvdoTIAMIU
   CYQe5ZYcbyiKrYEU01aSbIIVeiy9HqOl8fgiES3qc2cOFEaOGR/cSL3Er
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="366301850"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="366301850"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:04:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="815775830"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815775830"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 04:04:20 -0700
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
	zhenzhong.duan@intel.com
Subject: [PATCH v3 10/17] iommufd/selftest: Add a helper to get test device
Date: Mon, 24 Jul 2023 04:03:59 -0700
Message-Id: <20230724110406.107212-11-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724110406.107212-1-yi.l.liu@intel.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is need to get the selftest device (sobj->type == TYPE_IDEV) in multiple
places, so have a helper to get it.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/selftest.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index af7459e211ad..72d0c37e0b5e 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -472,29 +472,39 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	return rc;
 }
 
-/* Replace the mock domain with a manually allocated hw_pagetable */
-static int iommufd_test_mock_domain_replace(struct iommufd_ucmd *ucmd,
-					    unsigned int device_id, u32 pt_id,
-					    struct iommu_test_cmd *cmd)
+static struct selftest_obj *iommufd_test_get_device(struct iommufd_ctx *ictx,
+						    u32 id)
 {
 	struct iommufd_object *dev_obj;
 	struct selftest_obj *sobj;
-	int rc;
 
 	/*
 	 * Prefer to use the OBJ_SELFTEST because the destroy_rwsem will ensure
 	 * it doesn't race with detach, which is not allowed.
 	 */
-	dev_obj =
-		iommufd_get_object(ucmd->ictx, device_id, IOMMUFD_OBJ_SELFTEST);
+	dev_obj = iommufd_get_object(ictx, id, IOMMUFD_OBJ_SELFTEST);
 	if (IS_ERR(dev_obj))
-		return PTR_ERR(dev_obj);
+		return (struct selftest_obj *)dev_obj;
 
 	sobj = container_of(dev_obj, struct selftest_obj, obj);
 	if (sobj->type != TYPE_IDEV) {
-		rc = -EINVAL;
-		goto out_dev_obj;
+		iommufd_put_object(dev_obj);
+		return ERR_PTR(-EINVAL);
 	}
+	return sobj;
+}
+
+/* Replace the mock domain with a manually allocated hw_pagetable */
+static int iommufd_test_mock_domain_replace(struct iommufd_ucmd *ucmd,
+					    unsigned int device_id, u32 pt_id,
+					    struct iommu_test_cmd *cmd)
+{
+	struct selftest_obj *sobj;
+	int rc;
+
+	sobj = iommufd_test_get_device(ucmd->ictx, device_id);
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
 
 	rc = iommufd_device_replace(sobj->idev.idev, &pt_id);
 	if (rc)
@@ -504,7 +514,7 @@ static int iommufd_test_mock_domain_replace(struct iommufd_ucmd *ucmd,
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 
 out_dev_obj:
-	iommufd_put_object(dev_obj);
+	iommufd_put_object(&sobj->obj);
 	return rc;
 }
 
-- 
2.34.1

