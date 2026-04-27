Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D4B36CDE2;
	Mon, 27 Apr 2026 06:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777270235; cv=none; b=au5bk1DzBJIw1ibC6GeY0lut5jn9LrpAi/61WYijJXIrAmRqvoFTG6CWhEVXesx36qbD84OQgIAk9G30SuFaBOvIlK8S59YTwGVJxkLqqT7qpowMKx8gCTr/WmuxBiLYbyhp31yP2BnNTZUkSk4uhtM+ACiTBwudxFIRWLpMUzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777270235; c=relaxed/simple;
	bh=g5BKfRIkdnJuuvmrgGsKTQkhK8uuSZmj9EM3h0yB6q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8aSwE2vH5hfP9TW6LR+nGkUuH9TMpIw8W9mzhs5Jbc5snvuj+oZ7Uh90G417j9Wp6rUnflw/DtKybOtyayI6b9X6AExa/jHJEoviayRz57OHNC3Jc5PoHk0w3S2OAdG5gnCv5VKkAXJDozkEVHarNKj3c3J7/vwaTPwWQAsKDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKP5Fr9J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKP5Fr9J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458ECC2BCB8;
	Mon, 27 Apr 2026 06:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777270235;
	bh=g5BKfRIkdnJuuvmrgGsKTQkhK8uuSZmj9EM3h0yB6q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OKP5Fr9J/rmiRmuDtkx+L4oWbtQ3uTyJySNOza5GnL6Py3TPtsPeN1FZ49xJ7q9nu
	 XAZS/OC556nkM1EADIRLicbmurrRTLrLFnyXW3CqWNC8NL5SQ2kZPtZM3xtooIJthh
	 zpRy+Lti1NC9BoWyFBLylld+RUVHcTEzLqECaqbROp4h/Tsd847YRZ4mQWSOGtnkVH
	 u6GDRwAW1w3EdD1Cwx9yOFabkdlp9zX72TwOdxa2VB2wCGi+5lisJDfIp/Mh9QgMqe
	 LAJoxxOLSx1HR11kzhlWc/HzBjtvyOq9Xy8yenqqd3TBMGRdfhvwDztQYE62/Q5uT6
	 3C79S7tJiyZQg==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v4 2/4] iommufd/viommu: Associate a kvm pointer to iommufd_viommu
Date: Mon, 27 Apr 2026 11:40:03 +0530
Message-ID: <20260427061005.901854-3-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427061005.901854-1-aneesh.kumar@kernel.org>
References: <20260427061005.901854-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolin Chen <nicolinc@nvidia.com>

For TSM use case, vIOMMU will need to get access to KVM to make different
TSM calls. Associate the kvm pointer to the vIOMMU and take kvm's refcount.

Based on an original patch by Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

[nicolinc: hold kvm's users_count]
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommufd/viommu.c | 20 +++++++++++++++++---
 include/linux/iommu.h          |  1 +
 include/linux/iommufd.h        |  1 +
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 4081deda9b33..1e023d1cf8d5 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
  */
+#include <linux/kvm_host.h>
 #include "iommufd_private.h"
 
 void iommufd_viommu_destroy(struct iommufd_object *obj)
@@ -11,6 +12,8 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
 	if (viommu->ops && viommu->ops->destroy)
 		viommu->ops->destroy(viommu);
 	refcount_dec(&viommu->hwpt->common.obj.users);
+	if (viommu->kvm)
+		kvm_put_kvm(viommu->kvm);
 	xa_destroy(&viommu->vdevs);
 }
 
@@ -68,14 +71,22 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_hwpt;
 	}
 
+	if (idev->kvm && !kvm_get_kvm_safe(idev->kvm)) {
+		rc = -ENOENT;
+		goto out_put_hwpt;
+	}
+
 	viommu = (struct iommufd_viommu *)_iommufd_object_alloc_ucmd(
 		ucmd, viommu_size, IOMMUFD_OBJ_VIOMMU);
 	if (IS_ERR(viommu)) {
 		rc = PTR_ERR(viommu);
-		goto out_put_hwpt;
+		goto out_put_kvm;
 	}
 
 	xa_init(&viommu->vdevs);
+	viommu->kvm = idev->kvm;
+	if (viommu->kvm)
+		kvm_get_kvm(viommu->kvm);
 	viommu->type = cmd->type;
 	viommu->ictx = ucmd->ictx;
 	viommu->hwpt = hwpt_paging;
@@ -92,17 +103,20 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	rc = ops->viommu_init(viommu, hwpt_paging->common.domain,
 			      user_data.len ? &user_data : NULL);
 	if (rc)
-		goto out_put_hwpt;
+		goto out_put_kvm;
 
 	/* It is a driver bug that viommu->ops isn't filled */
 	if (WARN_ON_ONCE(!viommu->ops)) {
 		rc = -EOPNOTSUPP;
-		goto out_put_hwpt;
+		goto out_put_kvm;
 	}
 
 	cmd->out_viommu_id = viommu->obj.id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 
+out_put_kvm:
+	if (idev->kvm)
+		kvm_put_kvm(idev->kvm);
 out_put_hwpt:
 	iommufd_put_object(ucmd->ictx, &hwpt_paging->common.obj);
 out_put_idev:
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 555597b54083..300281dae01d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -46,6 +46,7 @@ struct iommu_dma_msi_cookie;
 struct iommu_fault_param;
 struct iommufd_ctx;
 struct iommufd_viommu;
+struct kvm;
 struct msi_desc;
 struct msi_msg;
 
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 5cdcb8d2f305..8e0505a9bd0c 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -103,6 +103,7 @@ struct iommufd_viommu {
 	struct iommufd_ctx *ictx;
 	struct iommu_device *iommu_dev;
 	struct iommufd_hwpt_paging *hwpt;
+	struct kvm *kvm;
 
 	const struct iommufd_viommu_ops *ops;
 
-- 
2.43.0

