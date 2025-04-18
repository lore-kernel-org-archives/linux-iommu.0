Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED9F26E162
	for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744963277; cv=none; b=QbTMl+0zKBd/TxUJ0+oC1wM9mVQ93DDWbR/t80woqjdrbMOkGTUni/pE9N1kmdDZHyJeD3fuvgTAIsIRrVWbOluOB+noYPmKSJxDX0lCaUNP5CPfW151oCLMQtJWQXZmhxsHhqr3ur1gl4ceGlJRacRJzaZYzBDUD1HI8FgENTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744963277; c=relaxed/simple;
	bh=BqVpy9UIaVKi4dFOxQ1AX2S2m4ehraAJ5mnL/a/Lylg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aB7P2OZ4drAbFsAIpqBKgKzXUGTLgxsEVJ6syfxA/RcGgxAXIZvI7T1VHYSn08m8nbNiaCRcWKNEMc8S9LqFry2BnvkJVHNkKI95wuO0vMuGbiDQdomnftpvOWtmAO5z+AFk4iqZs7jx7i5X/8BBnpgh+ed7LDFdyapJqt+JSMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZgG2Fpha; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZgG2Fpha"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744963276; x=1776499276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BqVpy9UIaVKi4dFOxQ1AX2S2m4ehraAJ5mnL/a/Lylg=;
  b=ZgG2FphaIDIfUNvZf3FbBYBWEmnPALlK998VtxAYAoUwRXEj46PhRBt6
   u0ldoqWVNMv5Tr5lzbVVfk8eEXbbbc5p0dZ0syliz3IGTDguFVSOtDJRc
   bZ2i5sm6+SUU3bmZuMKwrl9ZMPc7nx5M1OrNqyZ7Lgyes330zveco9qfv
   EaagQVuun/T7C2AcGr2PuppA2aUTl5SAqWcHbNGwQ6tXpX9sHqIDR72pe
   bt9UEsQm1YNvER2tcGGwwMssT33+KZR6YJnhsa45uIJbZZFPwCPaixURQ
   q7wJfw5HVSR60G4KYhjaWNTaPvixC+UKz2lZe4AayBpvOV/y7hkKCzx8J
   g==;
X-CSE-ConnectionGUID: fw1eLeqVQdGZQJ+B+DIvMw==
X-CSE-MsgGUID: zybN658ORW2jBzH/pQstZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="46708491"
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; 
   d="scan'208";a="46708491"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 01:01:16 -0700
X-CSE-ConnectionGUID: aaibKIoRTgWTF1ECUN3q0g==
X-CSE-MsgGUID: S/ckOaCKTbeYA0gwNqaOqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; 
   d="scan'208";a="131358607"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa008.fm.intel.com with ESMTP; 18 Apr 2025 01:01:12 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v5 4/8] iommufd/selftest: Put iopf enablement in domain attach path
Date: Fri, 18 Apr 2025 16:01:26 +0800
Message-ID: <20250418080130.1844424-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418080130.1844424-1-baolu.lu@linux.intel.com>
References: <20250418080130.1844424-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update iopf enablement in the iommufd mock device driver to use the new
method, similar to the arm-smmu-v3 driver. Enable iopf support when any
domain with an iopf_handler is attached, and disable it when the domain
is removed.

Add a refcount in the mock device state structure to keep track of the
number of domains set to the device and PASIDs that require iopf.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/iommu/iommufd/selftest.c | 57 ++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 18d9a216eb30..6bd0abf9a641 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -58,6 +58,9 @@ enum {
 	MOCK_PFN_HUGE_IOVA = _MOCK_PFN_START << 2,
 };
 
+static int mock_dev_enable_iopf(struct device *dev, struct iommu_domain *domain);
+static void mock_dev_disable_iopf(struct device *dev, struct iommu_domain *domain);
+
 /*
  * Syzkaller has trouble randomizing the correct iova to use since it is linked
  * to the map ioctl's output, and it has no ide about that. So, simplify things.
@@ -168,6 +171,8 @@ struct mock_dev {
 	int id;
 	u32 cache[MOCK_DEV_CACHE_NUM];
 	atomic_t pasid_1024_fake_error;
+	unsigned int iopf_refcount;
+	struct iommu_domain *domain;
 };
 
 static inline struct mock_dev *to_mock_dev(struct device *dev)
@@ -221,6 +226,13 @@ static int mock_domain_nop_attach(struct iommu_domain *domain,
 		up_write(&mdev->viommu_rwsem);
 	}
 
+	rc = mock_dev_enable_iopf(dev, domain);
+	if (rc)
+		return rc;
+
+	mock_dev_disable_iopf(dev, mdev->domain);
+	mdev->domain = domain;
+
 	return 0;
 }
 
@@ -229,6 +241,7 @@ static int mock_domain_set_dev_pasid_nop(struct iommu_domain *domain,
 					 struct iommu_domain *old)
 {
 	struct mock_dev *mdev = to_mock_dev(dev);
+	int rc;
 
 	/*
 	 * Per the first attach with pasid 1024, set the
@@ -256,6 +269,12 @@ static int mock_domain_set_dev_pasid_nop(struct iommu_domain *domain,
 		}
 	}
 
+	rc = mock_dev_enable_iopf(dev, domain);
+	if (rc)
+		return rc;
+
+	mock_dev_disable_iopf(dev, old);
+
 	return 0;
 }
 
@@ -610,22 +629,42 @@ static void mock_domain_page_response(struct device *dev, struct iopf_fault *evt
 {
 }
 
-static int mock_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
+static int mock_dev_enable_iopf(struct device *dev, struct iommu_domain *domain)
 {
-	if (feat != IOMMU_DEV_FEAT_IOPF || !mock_iommu_iopf_queue)
+	struct mock_dev *mdev = to_mock_dev(dev);
+	int ret;
+
+	if (!domain || !domain->iopf_handler)
+		return 0;
+
+	if (!mock_iommu_iopf_queue)
 		return -ENODEV;
 
-	return iopf_queue_add_device(mock_iommu_iopf_queue, dev);
+	if (mdev->iopf_refcount) {
+		mdev->iopf_refcount++;
+		return 0;
+	}
+
+	ret = iopf_queue_add_device(mock_iommu_iopf_queue, dev);
+	if (ret)
+		return ret;
+
+	mdev->iopf_refcount = 1;
+
+	return 0;
 }
 
-static int mock_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
+static void mock_dev_disable_iopf(struct device *dev, struct iommu_domain *domain)
 {
-	if (feat != IOMMU_DEV_FEAT_IOPF || !mock_iommu_iopf_queue)
-		return -ENODEV;
+	struct mock_dev *mdev = to_mock_dev(dev);
+
+	if (!domain || !domain->iopf_handler)
+		return;
+
+	if (--mdev->iopf_refcount)
+		return;
 
 	iopf_queue_remove_device(mock_iommu_iopf_queue, dev);
-
-	return 0;
 }
 
 static void mock_viommu_destroy(struct iommufd_viommu *viommu)
@@ -770,8 +809,6 @@ static const struct iommu_ops mock_ops = {
 	.device_group = generic_device_group,
 	.probe_device = mock_probe_device,
 	.page_response = mock_domain_page_response,
-	.dev_enable_feat = mock_dev_enable_feat,
-	.dev_disable_feat = mock_dev_disable_feat,
 	.user_pasid_table = true,
 	.viommu_alloc = mock_viommu_alloc,
 	.default_domain_ops =
-- 
2.43.0

