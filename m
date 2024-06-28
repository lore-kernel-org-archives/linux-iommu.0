Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B27153517
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565565; cv=none; b=COv7pG5yC2zahmIscdmEfD+nWwDFMWi9vDZzB9v4R0K0osuq+DhHRov7TFPYl2rgL1w7+9cldK09m/KWjapOEcX66AHuGSmTYvhCVTC4G/Zi/+oqqIJe8E6rlrQL8M5hFR+uVr9yAh8x9YPzMRXyswiXUqakyJGLTwPn5f0DRRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565565; c=relaxed/simple;
	bh=6KplxLnkxXhaTu+Rm36QZZfbkAxa8vrWYEkYUVuXQtc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CgeFnEn8MIb2emL7ge/Ab4CfuTuXbf8z22cUX3ZzUh1owuUYKOnkFEVYl9ICItcGd8HIVtKodwkeYy1y9de+0g8J9etLW99CiMMYrqRYuLui/dhw+wtjQ9ibBCaIcQQ+yWjA9gQN9hknPNXHmpkCprtuMtb6op6oTRjW9kHcvkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=czchY3YG; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="czchY3YG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719565563; x=1751101563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6KplxLnkxXhaTu+Rm36QZZfbkAxa8vrWYEkYUVuXQtc=;
  b=czchY3YGw+RFxpxjprdQukwF5fC64rHuUy56hvQj/ffkBB/y0OEoqJ7n
   rE9o+GsIrc/DCW6aT3nAa9fJZnLH2o3+BPkSoc2rHF3Y6RWjdnO85aemF
   kYisZ846EJQjg/zFTS5EafLczfUqgMYp2IUuQEWPve3Fd1h3BcP8HrwpC
   xUjIKiZ0T6DV2r6bXfx9yQZpo4IDuz1owS9Uezm/95aaj8cB3FRHHh5OW
   L+bBR+9S46S8+xtlUYLS9j2nLBRbGq7k6EmZkMdvjZtU1P7vXK6LQV0Sc
   +OkXLFbthUaAp36MVq957Bc6RyoE1C8L27rjo9UtBz6qH1g4PCzOLqWGK
   A==;
X-CSE-ConnectionGUID: GZBzeCFVQt+gJ/2+4AXiCw==
X-CSE-MsgGUID: a1k9DGgfQOOsil2mjHI7Bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="20613697"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="20613697"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 02:06:03 -0700
X-CSE-ConnectionGUID: 2SFGxyO9QzOb7ycCZKlw+g==
X-CSE-MsgGUID: jQSNVI7BSGCMBFLkPC22zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="44517067"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa006.fm.intel.com with ESMTP; 28 Jun 2024 02:06:03 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	robin.murphy@arm.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 5/7] iommufd/selftest: Add a helper to get test device
Date: Fri, 28 Jun 2024 02:05:55 -0700
Message-Id: <20240628090557.50898-6-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628090557.50898-1-yi.l.liu@intel.com>
References: <20240628090557.50898-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is need to get the selftest device (sobj->type == TYPE_IDEV) in
multiple places, so have a helper to for it.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/selftest.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 1404eca156a8..782e3c469530 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -802,29 +802,39 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	return rc;
 }
 
-/* Replace the mock domain with a manually allocated hw_pagetable */
-static int iommufd_test_mock_domain_replace(struct iommufd_ucmd *ucmd,
-					    unsigned int device_id, u32 pt_id,
-					    struct iommu_test_cmd *cmd)
+static struct selftest_obj *
+iommufd_test_get_self_test_device(struct iommufd_ctx *ictx, u32 id)
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
+		return ERR_CAST(dev_obj);
 
 	sobj = container_of(dev_obj, struct selftest_obj, obj);
 	if (sobj->type != TYPE_IDEV) {
-		rc = -EINVAL;
-		goto out_dev_obj;
+		iommufd_put_object(ictx, dev_obj);
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
+	sobj = iommufd_test_get_self_test_device(ucmd->ictx, device_id);
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
 
 	rc = iommufd_device_replace(sobj->idev.idev, &pt_id);
 	if (rc)
@@ -834,7 +844,7 @@ static int iommufd_test_mock_domain_replace(struct iommufd_ucmd *ucmd,
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 
 out_dev_obj:
-	iommufd_put_object(ucmd->ictx, dev_obj);
+	iommufd_put_object(ucmd->ictx, &sobj->obj);
 	return rc;
 }
 
-- 
2.34.1

