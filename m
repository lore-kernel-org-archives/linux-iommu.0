Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477AC57C715;
	Thu, 17 Sep 2026 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653792; cv=none; b=r425y4BddfUnL1WJcBB5j7wiWJolhpVlxOqlvnjF6sIVnyvNv/WXivj0HeGwrzUuDX5zabAI2XPyU+b7AmhuxwcRDIJPvoS2BoG7T4iyEYKtaIaFBnpz9FYXf3Jthq9tdqcUUT+NGg1bIyu+sLev1qfZCUC8yP1/NQDToBkXWWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653792; c=relaxed/simple;
	bh=YZtKoM/a/CTrNr/NXer57PB2adeZTwdJ8R2O9Ner4K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iM6m4Q18QgpUMOH3lTIUK68RpXl2NJgi4X0dCJH8lOyEO209sBOkIG0FBNTClPpR7ZxDT1CATGCLMHq+aDGP/hj8th5O9q6JqvGu25tv2+XrzM36jO+uIi7olPJ7k5jajd6lD1nji9UNFMsNQY+MpuzGSEnS6Euu4/75oJCSfsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRWob39+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRWob39+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423901F000FF;
	Thu, 17 Sep 2026 14:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789653789;
	bh=7tyAQCrPqe5cIWkqIQCLhlpGkaY0VQtDzrIlPeSjyt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dRWob39+RraIzMlZG3LBxOO2hKuUT7THDy8C0/wJ89Yywu1x0HlCbt4lOaZIdAZQn
	 ltEf9WHXYocjXLrOTfTrU0qeJ8EKDxlLGRu1wN0yB8du85E2pYhC0Eut5qYau3Tyyv
	 X5XhABAG8tp/hlGGfPVQeGz8ZUFiMwL10g0RkWJm/p4X9rOfHf9Q2YQJEgiDivA70/
	 vSip73qkiTsA6r2Ygavempb2x6hUTzRzRajK35XKU9PHr5mUp1iq02sCXKuABlqQxo
	 rnwa3IeyDlX8lz2+bWLA4Nt2yuKrp8gEyQ/gARu8VijemMA2rw7jWwhrm+R2+NPPFg
	 C+70w6J85sdAA==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v6 04/11] iommufd/viommu: Keep a reference to the KVM file
Date: Thu, 17 Sep 2026 19:31:52 +0530
Message-ID: <20260917140159.1163281-5-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolin Chen <nicolinc@nvidia.com>

The TSM vDevice operations need access to the KVM associated with the
device's vIOMMU. Save the device's KVM file in the iommufd_viommu when the
vIOMMU is allocated, and take a file reference so it remains valid for the
lifetime of the vIOMMU.

Release the reference when the vIOMMU is destroyed.

Based on an original patch by Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

[nicolinc: hold kvm's users_count]
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
[aneesh.kumar: Switch to use kvm_file]
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommufd/viommu.c | 5 +++++
 include/linux/iommufd.h        | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 4081deda9b33..bf5d58d55939 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
  */
+#include <linux/file.h>
 #include "iommufd_private.h"
 
 void iommufd_viommu_destroy(struct iommufd_object *obj)
@@ -11,6 +12,8 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
 	if (viommu->ops && viommu->ops->destroy)
 		viommu->ops->destroy(viommu);
 	refcount_dec(&viommu->hwpt->common.obj.users);
+	if (viommu->kvm_file)
+		fput(viommu->kvm_file);
 	xa_destroy(&viommu->vdevs);
 }
 
@@ -76,6 +79,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	}
 
 	xa_init(&viommu->vdevs);
+	if (idev->kvm_file)
+		viommu->kvm_file = get_file(idev->kvm_file);
 	viommu->type = cmd->type;
 	viommu->ictx = ucmd->ictx;
 	viommu->hwpt = hwpt_paging;
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 0a0bb4abfbd2..3267717f676d 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -103,6 +103,7 @@ struct iommufd_viommu {
 	struct iommufd_ctx *ictx;
 	struct iommu_device *iommu_dev;
 	struct iommufd_hwpt_paging *hwpt;
+	struct file *kvm_file;
 
 	const struct iommufd_viommu_ops *ops;
 
-- 
2.43.0

