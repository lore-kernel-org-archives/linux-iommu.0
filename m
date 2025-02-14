Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB961FCFD2
	for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 06:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513489; cv=none; b=kiw1nWVJoR5AxgSi98NVQeeY1rMYWOMWk1fEKu2rjlGYpdx/a7Mt40AByPnq9c13egJPqTIRmh6gwsriHU/tSnn1cYVYq/FydO2fy/zsgf1HKHbuN2lX4Z619CN9ZqAweNFLpdJaKP11CCa9CVVyNCUlIMk4sMdJ5J6MD2wR/is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513489; c=relaxed/simple;
	bh=fgHuJ9roGkGcY1DwYyoCbSL2BPlcZHJT3W616Z69MAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3YRvN7ncrwWxGEwZj5TE3YkDUR+uiPBN7NmJbwJt0LN2m8sBfr78sDj8EnwAQgmUoh4yeuKEEgDDzgp5UAx/nq3bO2+dCz6to9CGrF9RcOMGaJ9dl03//a/ADhpP1CvlwvsVkEP3jbOMeaExd3nn+E37SaRsxeaDvHi7RwhmvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JT9bNJ1p; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JT9bNJ1p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739513488; x=1771049488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fgHuJ9roGkGcY1DwYyoCbSL2BPlcZHJT3W616Z69MAg=;
  b=JT9bNJ1pPJrEqCCN657nBJXjzqCGgJhK5xPva38P3aN+abRLMtXcP5mC
   G7nL5+T2V+JOKrAlRFHbrO81Zup/en/0S+BMB7mZGcEYcHglqpXmdkkU/
   EXNuWr0jhwnWck/SnD55+aHp/W7ODy/268TKPPhKZMfKFpcX85bTX2AZ+
   U8PoleoJ0eDyiGP2UvkC2zIJS6iTHinczHV31TKTjooRPMs3GZMYRlNAC
   irVFCkpGofvNJFqykTtK24jSZIL7eMW60vmSlrpescmv1nYPNkmdIwOwE
   BxeeVgVpkdcPHC6G7i2WY+BFo6n+cfN9x60rUH7XfZV735wrolbO9tR+l
   Q==;
X-CSE-ConnectionGUID: GVMB8Hn9Rr229MXWmUxhuw==
X-CSE-MsgGUID: K2rYPxnMQ9eO1UlBCj746g==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40124567"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="40124567"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 22:11:28 -0800
X-CSE-ConnectionGUID: d0j8rxAwTn22ylVVX/unXQ==
X-CSE-MsgGUID: SJrsJydUR/yAre0ggqPyCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114268149"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa008.jf.intel.com with ESMTP; 13 Feb 2025 22:11:24 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 08/12] iommufd/selftest: Put iopf enablement in domain attach path
Date: Fri, 14 Feb 2025 14:11:00 +0800
Message-ID: <20250214061104.1959525-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
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
---
 drivers/iommu/iommufd/selftest.c | 52 +++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index d40deb0a4f06..a6b12cee7b00 100644
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
@@ -164,6 +167,7 @@ struct mock_dev {
 	unsigned long flags;
 	int id;
 	u32 cache[MOCK_DEV_CACHE_NUM];
+	unsigned int iopf_refcount;
 };
 
 static inline struct mock_dev *to_mock_dev(struct device *dev)
@@ -197,11 +201,19 @@ static int mock_domain_nop_attach(struct iommu_domain *domain,
 	if (domain->dirty_ops && (mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY))
 		return -EINVAL;
 
+	return mock_dev_enable_iopf(dev, domain);
+}
+
+static int mock_domain_blocking_attach(struct iommu_domain *domain,
+				       struct device *dev)
+{
+	mock_dev_disable_iopf(dev, domain);
+
 	return 0;
 }
 
 static const struct iommu_domain_ops mock_blocking_ops = {
-	.attach_dev = mock_domain_nop_attach,
+	.attach_dev = mock_domain_blocking_attach,
 };
 
 static struct iommu_domain mock_blocking_domain = {
@@ -549,22 +561,42 @@ static void mock_domain_page_response(struct device *dev, struct iopf_fault *evt
 {
 }
 
-static int mock_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
+static int mock_dev_enable_iopf(struct device *dev, struct iommu_domain *domain)
 {
-	if (feat != IOMMU_DEV_FEAT_IOPF || !mock_iommu_iopf_queue)
+	struct mock_dev *mdev = to_mock_dev(dev);
+	int ret;
+
+	if (!domain->iopf_handler)
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
+	if (!domain->iopf_handler)
+		return;
+
+	if (--mdev->iopf_refcount)
+		return;
 
 	iopf_queue_remove_device(mock_iommu_iopf_queue, dev);
-
-	return 0;
 }
 
 static void mock_viommu_destroy(struct iommufd_viommu *viommu)
@@ -709,8 +741,6 @@ static const struct iommu_ops mock_ops = {
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

