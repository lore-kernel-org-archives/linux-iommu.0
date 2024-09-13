Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CADF1BAED2;
	Fri, 13 Sep 2024 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726227927; cv=none; b=sqitKUvhZI+IOzVRUUR1wJb5xlS6qM6iOuGcizqHaoGS+LEtx1MEl53nI3xDgmoPhBRqcWyJLPUmOMeNER6Q6+n/BfgPKPQYVdln6f4r/tE471kSoIjLLL9OqHwsDR9kLq4ki+nOG/FTHC6inbdbf+/5ioEaPTF1Vlo51QnmnXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726227927; c=relaxed/simple;
	bh=yI/YdEzUxnbqQlsPHNM+E/+LIgmQwvyu/UUnjDxNwS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bZg9seRFc72X40NIEapMLhSKJlCRKamP0eC554d4gJ4jFYrCmaU7s8Rxi2MtM+C/QOFwl0NNNJfollYN0fnC3ZSL3FUFjleNtbQudxNHomSoEPS7KShelK1dh3W1/dnmC26I5/jdcjRdaLQihCekB61eXzqnOLNy+OBEnGVBVgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hp0Vdf3L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hp0Vdf3L"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26364C4CED1;
	Fri, 13 Sep 2024 11:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726227927;
	bh=yI/YdEzUxnbqQlsPHNM+E/+LIgmQwvyu/UUnjDxNwS8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Hp0Vdf3LmtddAbaYrY/fHpyvA+KDCnKjHGDo6W2b+9tXqgkgoe0v6zatj4kgskf0y
	 R5kwYaGVC7CySH6IDbTP9tyoEQJjmS1JzLSPfky+Y1k3QV1qk6XdTjkytFJQ0J7DP/
	 pV7cDBhOGFiO3sYsAbyhgxfK7xLYuDL2b0NQHNqmiB4GvdqwiJ5Ew0OWPIcHSxTWpl
	 IFf/J3f+nOn3gHnRDHSP5WBPxkuvAlvTQznHz9h894Kvn4m/6KWL7IwgH3GVjuBo0B
	 4mk5qPxl89/m9NM9dkzb/fTzdwIAqympoUzDO6oufhy2Fp+aDxD9ut7MADGCLj0IO7
	 SCTunpFgDQa5A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF79FA3748;
	Fri, 13 Sep 2024 11:45:27 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Fri, 13 Sep 2024 13:44:50 +0200
Subject: [PATCH v2 4/5] iommufd: Enable PRI when doing the
 iommufd_hwpt_alloc
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-jag-iopfv8-v2-4-dea01c2343bc@samsung.com>
References: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
In-Reply-To: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
To: David Woodhouse <dwmw2@infradead.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.15-dev-00a43
X-Developer-Signature: v=1; a=openpgp-sha256; l=1694;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=DxEbBmnkeSWlQ/5MEXCH0l7yNP6fyq/9U3DrRBtODeQ=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGbkJdN3nIyQtewYxO5dzLpub6VBCQvASt1vP
 lOAMWJPVRuvTYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJm5CXTAAoJELqXzVK3
 lkFPctcL+QHiIJxPNK8u2+QZbImwSx9KtOG1MIiyOjy1prL1mFeCx3hv6fyrYsZCBYZnVFQCnC5
 OKY6Ot6kNutAzzaHvu+wFxeGddX25+OJL9VRjwSPv4hRHGdK+ojK2etw+3/V1jdURYxBRyf37ew
 mkpmo1QTBDb2e8dqWUXQa9dliujivt92tXPIdiSPMFJz1pPZD0guvljBA3JdLEpKERGubE6EIhb
 PuWihQnMVVcaNtPhsjy/9XbRnklRtaMVoM+CSnchCXq+BSTczuwvYIvTdyxKOOvtFMKEGBK8w0/
 o6azqmqwvHDVuk6/DirH/w1kDqsGhbLHcjJNtQAfWhxZls/qwkAxE1jZPFnDxtXu6ikOo/aJwdC
 rSf5p/ppZd0uaiO116XZ9pWvVBfq++VcpqL1Fwbh9X5eLN1qGtNRsgBoY2HMVNw5D5ho3SpGgHI
 i+2OUylhqVMFDlzJyCXkP1l6udZe1MR5z/ppRBWeHhXAzTHb3d8KpsCQz/26dkyjMV+iEfmX0D7
 x8=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

Add IOMMU_HWPT_FAULT_ID_VALID as part of the valid flags when doing an
iommufd_hwpt_alloc allowing the use of an iommu fault allocation
(iommu_fault_alloc) with the IOMMU_HWPT_ALLOC ioctl.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/iommu/intel/iommu.c          | 3 ++-
 drivers/iommu/iommufd/hw_pagetable.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5acc52c62e8c..3d1c971eb9e5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3718,7 +3718,8 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 	}
 
 	if (flags &
-	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
+	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING
+	       | IOMMU_HWPT_FAULT_ID_VALID)))
 		return ERR_PTR(-EOPNOTSUPP);
 	if (nested_parent && !nested_supported(iommu))
 		return ERR_PTR(-EOPNOTSUPP);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index aefde4443671..88074e459995 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -107,7 +107,8 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			  const struct iommu_user_data *user_data)
 {
 	const u32 valid_flags = IOMMU_HWPT_ALLOC_NEST_PARENT |
-				IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+				IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
+				IOMMU_HWPT_FAULT_ID_VALID;
 	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
 	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_hw_pagetable *hwpt;

-- 
2.43.0


