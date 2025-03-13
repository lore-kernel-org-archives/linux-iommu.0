Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A239B1F9A86
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 05:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741843185; cv=none; b=T/ueCeoGbtbjJ9kn2kAq/czd2fP1OXZGRmgu96Yg4nBWEdE4vmlifI9Kf5v7K1YJl3gSPDoQeIgBs/wZXZ8rd7SmbMEYIAg+iTkd8U9BJb34AnR0sU1oka4r7Bth0otUwIec1gH3IAokF35NwUDGmfzvKwZ98KGadwHqftMqijQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741843185; c=relaxed/simple;
	bh=s1PXrY/OFMhTX64vUdRGU7rxgkMPIx/1FasQUBWKJdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bToU/29m3sqewzHSLcKWfp2Lz2r6Tf1zX+aJd5hnifBTGg2HBrU2pwL0ODydb1NULPj8Fje5tjfV9JhwWPBdsUMUxnPQcfYZGRkg/gk6l08pkNXmhsQ0k7qiVA/JFHKsGYc8gKJw/QWX3c7LU4t/5xIZJd4PJnfVhNTfMRRJTjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/ly3YIp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/ly3YIp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741843184; x=1773379184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s1PXrY/OFMhTX64vUdRGU7rxgkMPIx/1FasQUBWKJdo=;
  b=a/ly3YIpyL9DXKbOWmDz8tkYoWAXGr8py0zA536fw1yDfo7rRinWhw54
   wcghJa0M2fX3VXcAR6RDWyfgB31QJm+0uG9li6IxcWsD5rGuSdPpe7roa
   2DRW3xs/6Q+vdOdMby8rJmmB0NRaPNfg3tv2sRMaE3b3n1X8uMRDFG7wa
   Vq3UJHBkKI9nO3Hu1E5FsWGRMTSPF0I15TrFVmukQvyKfTFNFDCeKN1J2
   9qrIO+VYn1yItfsux71TGHJZ9yWWjqcsMNDq0h2v78g1ENfcDwiR7onsS
   SiAZfhSx+rOD9/1HDBrprRUdxjg4u/mqKrV1hor3TZ1CfaGTQK9b7ib0K
   w==;
X-CSE-ConnectionGUID: I2NqcH6jTLy5DpUiTTAuQw==
X-CSE-MsgGUID: vP9hEPh/SnebXlokYliSvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="54323647"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="54323647"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 22:19:43 -0700
X-CSE-ConnectionGUID: Xy5Dr7K4QjyintJu9zIlmQ==
X-CSE-MsgGUID: nUWUKirPQqycC+nUSq+HgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="151807039"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa001.fm.intel.com with ESMTP; 12 Mar 2025 22:19:40 -0700
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
	Jason Gunthorpe <jgg@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 1/8] iommu/arm-smmu-v3: Put iopf enablement in the domain attach path
Date: Thu, 13 Mar 2025 13:19:46 +0800
Message-ID: <20250313051953.4064532-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
References: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

SMMUv3 co-mingles FEAT_IOPF and FEAT_SVA behaviors so that fault reporting
doesn't work unless both are enabled. This is not correct and causes
problems for iommufd which does not enable FEAT_SVA for it's fault capable
domains.

These APIs are both obsolete, update SMMUv3 to use the new method like AMD
implements.

A driver should enable iopf support when a domain with an iopf_handler is
attached, and disable iopf support when the domain is removed.

Move the fault support logic to sva domain allocation and to domain
attach, refusing to create or attach fault capable domains if the HW
doesn't support it.

Move all the logic for controlling the iopf queue under
arm_smmu_attach_prepare(). Keep track of the number of domains on the
master (over all the SSIDs) that require iopf. When the first domain
requiring iopf is attached create the iopf queue, when the last domain is
detached destroy it.

Turn FEAT_IOPF and FEAT_SVA into no ops.

Remove the sva_lock, this is all protected by the group mutex.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Acked-by: Will Deacon <will@kernel.org>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  86 +-------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 105 +++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  39 ++-----
 3 files changed, 91 insertions(+), 139 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 9ba596430e7c..605d1dd0e1cc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -13,8 +13,6 @@
 #include "arm-smmu-v3.h"
 #include "../../io-pgtable-arm.h"
 
-static DEFINE_MUTEX(sva_lock);
-
 static void __maybe_unused
 arm_smmu_update_s1_domain_cd_entry(struct arm_smmu_domain *smmu_domain)
 {
@@ -257,84 +255,6 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 	return true;
 }
 
-bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master)
-{
-	/* We're not keeping track of SIDs in fault events */
-	if (master->num_streams != 1)
-		return false;
-
-	return master->stall_enabled;
-}
-
-bool arm_smmu_master_sva_supported(struct arm_smmu_master *master)
-{
-	if (!(master->smmu->features & ARM_SMMU_FEAT_SVA))
-		return false;
-
-	/* SSID support is mandatory for the moment */
-	return master->ssid_bits;
-}
-
-bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master)
-{
-	bool enabled;
-
-	mutex_lock(&sva_lock);
-	enabled = master->sva_enabled;
-	mutex_unlock(&sva_lock);
-	return enabled;
-}
-
-static int arm_smmu_master_sva_enable_iopf(struct arm_smmu_master *master)
-{
-	struct device *dev = master->dev;
-
-	/*
-	 * Drivers for devices supporting PRI or stall should enable IOPF first.
-	 * Others have device-specific fault handlers and don't need IOPF.
-	 */
-	if (!arm_smmu_master_iopf_supported(master))
-		return 0;
-
-	if (!master->iopf_enabled)
-		return -EINVAL;
-
-	return iopf_queue_add_device(master->smmu->evtq.iopf, dev);
-}
-
-static void arm_smmu_master_sva_disable_iopf(struct arm_smmu_master *master)
-{
-	struct device *dev = master->dev;
-
-	if (!master->iopf_enabled)
-		return;
-
-	iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
-}
-
-int arm_smmu_master_enable_sva(struct arm_smmu_master *master)
-{
-	int ret;
-
-	mutex_lock(&sva_lock);
-	ret = arm_smmu_master_sva_enable_iopf(master);
-	if (!ret)
-		master->sva_enabled = true;
-	mutex_unlock(&sva_lock);
-
-	return ret;
-}
-
-int arm_smmu_master_disable_sva(struct arm_smmu_master *master)
-{
-	mutex_lock(&sva_lock);
-	arm_smmu_master_sva_disable_iopf(master);
-	master->sva_enabled = false;
-	mutex_unlock(&sva_lock);
-
-	return 0;
-}
-
 void arm_smmu_sva_notifier_synchronize(void)
 {
 	/*
@@ -353,6 +273,9 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 	struct arm_smmu_cd target;
 	int ret;
 
+	if (!(master->smmu->features & ARM_SMMU_FEAT_SVA))
+		return -EOPNOTSUPP;
+
 	/* Prevent arm_smmu_mm_release from being called while we are attaching */
 	if (!mmget_not_zero(domain->mm))
 		return -EINVAL;
@@ -406,6 +329,9 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 	u32 asid;
 	int ret;
 
+	if (!(master->smmu->features & ARM_SMMU_FEAT_SVA))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	smmu_domain = arm_smmu_domain_alloc();
 	if (IS_ERR(smmu_domain))
 		return ERR_CAST(smmu_domain);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 358072b4e293..a8b1b8b17992 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2712,6 +2712,7 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 
 static struct arm_smmu_master_domain *
 arm_smmu_find_master_domain(struct arm_smmu_domain *smmu_domain,
+			    struct iommu_domain *domain,
 			    struct arm_smmu_master *master,
 			    ioasid_t ssid, bool nested_ats_flush)
 {
@@ -2722,6 +2723,7 @@ arm_smmu_find_master_domain(struct arm_smmu_domain *smmu_domain,
 	list_for_each_entry(master_domain, &smmu_domain->devices,
 			    devices_elm) {
 		if (master_domain->master == master &&
+		    master_domain->domain == domain &&
 		    master_domain->ssid == ssid &&
 		    master_domain->nested_ats_flush == nested_ats_flush)
 			return master_domain;
@@ -2748,6 +2750,58 @@ to_smmu_domain_devices(struct iommu_domain *domain)
 	return NULL;
 }
 
+static int arm_smmu_enable_iopf(struct arm_smmu_master *master,
+				struct arm_smmu_master_domain *master_domain)
+{
+	int ret;
+
+	iommu_group_mutex_assert(master->dev);
+
+	if (!IS_ENABLED(CONFIG_ARM_SMMU_V3_SVA))
+		return -EOPNOTSUPP;
+
+	/*
+	 * Drivers for devices supporting PRI or stall require iopf others have
+	 * device-specific fault handlers and don't need IOPF, so this is not a
+	 * failure.
+	 */
+	if (!master->stall_enabled)
+		return 0;
+
+	/* We're not keeping track of SIDs in fault events */
+	if (master->num_streams != 1)
+		return -EOPNOTSUPP;
+
+	if (master->iopf_refcount) {
+		master->iopf_refcount++;
+		master_domain->using_iopf = true;
+		return 0;
+	}
+
+	ret = iopf_queue_add_device(master->smmu->evtq.iopf, master->dev);
+	if (ret)
+		return ret;
+	master->iopf_refcount = 1;
+	master_domain->using_iopf = true;
+	return 0;
+}
+
+static void arm_smmu_disable_iopf(struct arm_smmu_master *master,
+				  struct arm_smmu_master_domain *master_domain)
+{
+	iommu_group_mutex_assert(master->dev);
+
+	if (!IS_ENABLED(CONFIG_ARM_SMMU_V3_SVA))
+		return;
+
+	if (!master_domain || !master_domain->using_iopf)
+		return;
+
+	master->iopf_refcount--;
+	if (master->iopf_refcount == 0)
+		iopf_queue_remove_device(master->smmu->evtq.iopf, master->dev);
+}
+
 static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
 					  struct iommu_domain *domain,
 					  ioasid_t ssid)
@@ -2764,15 +2818,17 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
 		nested_ats_flush = to_smmu_nested_domain(domain)->enable_ats;
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	master_domain = arm_smmu_find_master_domain(smmu_domain, master, ssid,
-						    nested_ats_flush);
+	master_domain = arm_smmu_find_master_domain(smmu_domain, domain, master,
+						    ssid, nested_ats_flush);
 	if (master_domain) {
 		list_del(&master_domain->devices_elm);
-		kfree(master_domain);
 		if (master->ats_enabled)
 			atomic_dec(&smmu_domain->nr_ats_masters);
 	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+
+	arm_smmu_disable_iopf(master, master_domain);
+	kfree(master_domain);
 }
 
 /*
@@ -2803,6 +2859,7 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 	struct arm_smmu_domain *smmu_domain =
 		to_smmu_domain_devices(new_domain);
 	unsigned long flags;
+	int ret;
 
 	/*
 	 * arm_smmu_share_asid() must not see two domains pointing to the same
@@ -2835,12 +2892,19 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 		master_domain = kzalloc(sizeof(*master_domain), GFP_KERNEL);
 		if (!master_domain)
 			return -ENOMEM;
+		master_domain->domain = new_domain;
 		master_domain->master = master;
 		master_domain->ssid = state->ssid;
 		if (new_domain->type == IOMMU_DOMAIN_NESTED)
 			master_domain->nested_ats_flush =
 				to_smmu_nested_domain(new_domain)->enable_ats;
 
+		if (new_domain->iopf_handler) {
+			ret = arm_smmu_enable_iopf(master, master_domain);
+			if (ret)
+				goto err_free_master_domain;
+		}
+
 		/*
 		 * During prepare we want the current smmu_domain and new
 		 * smmu_domain to be in the devices list before we change any
@@ -2860,8 +2924,8 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 		    !arm_smmu_master_canwbs(master)) {
 			spin_unlock_irqrestore(&smmu_domain->devices_lock,
 					       flags);
-			kfree(master_domain);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_iopf;
 		}
 
 		if (state->ats_enabled)
@@ -2880,6 +2944,12 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 		wmb();
 	}
 	return 0;
+
+err_iopf:
+	arm_smmu_disable_iopf(master, master_domain);
+err_free_master_domain:
+	kfree(master_domain);
+	return ret;
 }
 
 /*
@@ -3475,8 +3545,7 @@ static void arm_smmu_release_device(struct device *dev)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 
-	if (WARN_ON(arm_smmu_master_sva_enabled(master)))
-		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
+	WARN_ON(master->iopf_refcount);
 
 	/* Put the STE back to what arm_smmu_init_strtab() sets */
 	if (dev->iommu->require_direct)
@@ -3561,18 +3630,8 @@ static int arm_smmu_dev_enable_feature(struct device *dev,
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
-		if (!arm_smmu_master_iopf_supported(master))
-			return -EINVAL;
-		if (master->iopf_enabled)
-			return -EBUSY;
-		master->iopf_enabled = true;
-		return 0;
 	case IOMMU_DEV_FEAT_SVA:
-		if (!arm_smmu_master_sva_supported(master))
-			return -EINVAL;
-		if (arm_smmu_master_sva_enabled(master))
-			return -EBUSY;
-		return arm_smmu_master_enable_sva(master);
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -3588,16 +3647,8 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
-		if (!master->iopf_enabled)
-			return -EINVAL;
-		if (master->sva_enabled)
-			return -EBUSY;
-		master->iopf_enabled = false;
-		return 0;
 	case IOMMU_DEV_FEAT_SVA:
-		if (!arm_smmu_master_sva_enabled(master))
-			return -EINVAL;
-		return arm_smmu_master_disable_sva(master);
+		return 0;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index bd9d7c85576a..fe6b88affa4a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -830,9 +830,8 @@ struct arm_smmu_master {
 	bool				ats_enabled : 1;
 	bool				ste_ats_enabled : 1;
 	bool				stall_enabled;
-	bool				sva_enabled;
-	bool				iopf_enabled;
 	unsigned int			ssid_bits;
+	unsigned int			iopf_refcount;
 };
 
 /* SMMU private data for an IOMMU domain */
@@ -908,8 +907,14 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
 struct arm_smmu_master_domain {
 	struct list_head devices_elm;
 	struct arm_smmu_master *master;
+	/*
+	 * For nested domains the master_domain is threaded onto the S2 parent,
+	 * this points to the IOMMU_DOMAIN_NESTED to disambiguate the masters.
+	 */
+	struct iommu_domain *domain;
 	ioasid_t ssid;
 	bool nested_ats_flush : 1;
+	bool using_iopf : 1;
 };
 
 static inline struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
@@ -987,11 +992,6 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
-bool arm_smmu_master_sva_supported(struct arm_smmu_master *master);
-bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master);
-int arm_smmu_master_enable_sva(struct arm_smmu_master *master);
-int arm_smmu_master_disable_sva(struct arm_smmu_master *master);
-bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master);
 void arm_smmu_sva_notifier_synchronize(void);
 struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 					       struct mm_struct *mm);
@@ -1001,31 +1001,6 @@ static inline bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 	return false;
 }
 
-static inline bool arm_smmu_master_sva_supported(struct arm_smmu_master *master)
-{
-	return false;
-}
-
-static inline bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master)
-{
-	return false;
-}
-
-static inline int arm_smmu_master_enable_sva(struct arm_smmu_master *master)
-{
-	return -ENODEV;
-}
-
-static inline int arm_smmu_master_disable_sva(struct arm_smmu_master *master)
-{
-	return -ENODEV;
-}
-
-static inline bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master)
-{
-	return false;
-}
-
 static inline void arm_smmu_sva_notifier_synchronize(void) {}
 
 #define arm_smmu_sva_domain_alloc NULL
-- 
2.43.0

