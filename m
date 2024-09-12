Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C9C1A7249
	for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 13:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146278; cv=none; b=Mvn75wPU+ElYs0fOavwDS+9IQtqQush0uRNPH9lApRRO9l6V8EdCfeHSTSR0BTiX14SPwiTtWiXCOaZVjxJS+91UVW182zOUqA+mFivFGnikBXHR3NdWKIo0cBQcnptuM5NWsqDk4K3M3sl2Bphq1Ml4i0aj4lQ2UNAGRVZZTWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146278; c=relaxed/simple;
	bh=yUnDh/XVxNNztWNMVHOs6+vmvy06PcZACc3G0r/NzUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XR2EwfcKrfp0q2MTKHwOFlP5TuAUc78wq2Tzu7mu4AHi1nON1RbAdXVS/s1/77Cq033Qxw9B+EgHQPHMNpO4kFat/stPHR2Qhk7wjJw/6p2FD5svRrKinOXkOeuZaj6+nmSU+j3/3KCrRHC7pOlz8JPWEudlk+whqK+NjeKIQ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aAkIO6dx; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aAkIO6dx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726146276; x=1757682276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yUnDh/XVxNNztWNMVHOs6+vmvy06PcZACc3G0r/NzUE=;
  b=aAkIO6dx8XphfjkhZZqS4EES6I3oLxyLBJL5Ew0Q5XA1Gi3Gu03WC1KY
   lVEKr/3xUYwFfP8B0QAvDr/yNuNPM+I4eg5oN91B7sVxKEb5vRLlprvnB
   C1yJNYwJ8kh6zzuyqtW9rLdI1oodTk0qqZNf7JjKIP/8EnhnqyD/LXexr
   NSW1+83Fa1Fwu7A5FetsaZzzLk/3bc0k19yP3nyrv3+Bmsaz8243oaktR
   0LQfVh9b1D3RWtYK/LnkGoTZs+zwEG4Gt9/ZkcI0oRmM/vRzZ4DFvAz91
   2s7jx+i7U/QTvc21U075krkLtVKHmi2MkzCNzD/4sYNH21yaHp3upXejm
   Q==;
X-CSE-ConnectionGUID: UbF0RbPjQT6HeCoru6CMTg==
X-CSE-MsgGUID: XQGj7VP7S56W/fAjpDgcHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="36380562"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="36380562"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:04:36 -0700
X-CSE-ConnectionGUID: qCedCvb+Q0aIuejJ+PRLtA==
X-CSE-MsgGUID: /KlSP8I1TCWoP9TOjFhB2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="72509960"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa005.jf.intel.com with ESMTP; 12 Sep 2024 06:04:36 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	linux-kselftest@vger.kernel.org,
	vasant.hegde@amd.com
Subject: [PATCH v2 5/6] iommu/arm-smmu-v3: Make smmuv3 set_dev_pasid() op support replace
Date: Thu, 12 Sep 2024 06:04:26 -0700
Message-Id: <20240912130427.10119-6-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912130427.10119-1-yi.l.liu@intel.com>
References: <20240912130427.10119-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

set_dev_pasid() op is going to be enhanced to support domain replacement
of a pasid. This prepares for this op definition.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 8 +++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 645da7b69bed..1d3e71569775 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -349,7 +349,7 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 	 * get reassigned
 	 */
 	arm_smmu_make_sva_cd(&target, master, domain->mm, smmu_domain->cd.asid);
-	ret = arm_smmu_set_pasid(master, smmu_domain, id, &target);
+	ret = arm_smmu_set_pasid(master, smmu_domain, id, &target, old);
 
 	mmput(domain->mm);
 	return ret;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ed2b106e02dd..f7a73b854151 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2824,7 +2824,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 }
 
 static int arm_smmu_s1_set_dev_pasid(struct iommu_domain *domain,
-				      struct device *dev, ioasid_t id)
+				     struct device *dev, ioasid_t id,
+				     struct iommu_domain *old)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
@@ -2850,7 +2851,7 @@ static int arm_smmu_s1_set_dev_pasid(struct iommu_domain *domain,
 	 */
 	arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
 	return arm_smmu_set_pasid(master, to_smmu_domain(domain), id,
-				  &target_cd);
+				  &target_cd, old);
 }
 
 static void arm_smmu_update_ste(struct arm_smmu_master *master,
@@ -2880,7 +2881,7 @@ static void arm_smmu_update_ste(struct arm_smmu_master *master,
 
 int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,
-		       struct arm_smmu_cd *cd)
+		       struct arm_smmu_cd *cd, struct iommu_domain *old)
 {
 	struct iommu_domain *sid_domain = iommu_get_domain_for_dev(master->dev);
 	struct arm_smmu_attach_state state = {
@@ -2890,6 +2891,7 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		 * already attached, no need to set old_domain.
 		 */
 		.ssid = pasid,
+		.old_domain = old,
 	};
 	struct arm_smmu_cd *cdptr;
 	int ret;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 14bca41a981b..a942f5d40051 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -806,7 +806,7 @@ void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
 
 int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,
-		       struct arm_smmu_cd *cd);
+		       struct arm_smmu_cd *cd, struct iommu_domain *old);
 
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
 void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
-- 
2.34.1

