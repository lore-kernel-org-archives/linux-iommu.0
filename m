Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F81851C4A
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 02:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244292; cv=none; b=n+r1yNy9Fg9u7Eeib7UraZ9EE2OL9698hNtkIdcR9PTl45aJlsNPNAS31i5K2Lk5sBvpMbhPE/Z1kD6wbmBG/OlhsgxGwJsUrjBU8NYGuNIFzGAsLbqzB8BhjDLhU+f+HsSS22pCITexKbncLvESQiYcck+EVZ2oUTZCvsDgXNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244292; c=relaxed/simple;
	bh=deFbhjCg3D4MlJfauctTLDOm141eNNZjML2Qbu39cek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N/0SG3VK6PhYW8hD5tJ5Zbs7KlTLigzDVh1w3fNW8vI1A81HRP3se1uiGnhZN43LuMFHZyqbkmMdrzpoF7g7BrwU8DiccemCHfAS/AiEOH2aZ4GM+cORBBsUJ9cInhqgrru4/3nSVYTd7HoZuiWGv+7HdqnmiBOh4+ONyGuMY/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BCV/iwsl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BCV/iwsl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725244291; x=1756780291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=deFbhjCg3D4MlJfauctTLDOm141eNNZjML2Qbu39cek=;
  b=BCV/iwsl1qQxTG4lxkQq19QG1uCPAAujhNM+Z4mfqjJ8+2cYCj0GkqI3
   xXvIZ+O/LQNVomWnT5XhLKXjOwRt/8XqEGuGQUiaHmY+meDfwv1xMftw5
   DQ35CQWuR/DqFjvUh3FM9F08DWidxY9gcz854I5GF5XO+a+oWMukzI1Pr
   iFPvpMVPTJWWRNUrm8BD2daTpqwl9sMt0gCmyVQ9cju24JkvHASYGGlRa
   FT/rB0xf40CAbQmcim6xHy3oL5N/9I7tTHwx0O+sg6YBYjHSqL60kytKa
   gtbPbNy2PAiyBXiKDTevAn+vcUqX5+x+q5a0uQiT6tys1qHGHjpyu5kna
   A==;
X-CSE-ConnectionGUID: +oJkxDDKQBKVGrye+kDiJg==
X-CSE-MsgGUID: JzDo0c/qR+ah84M+hcROLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23994306"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="23994306"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 19:31:31 -0700
X-CSE-ConnectionGUID: qSsEiDwkSCuscu0MPJVf8A==
X-CSE-MsgGUID: 8Ba3g9LcT2Kmr7UEHlgLjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69359316"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 01 Sep 2024 19:31:29 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Sanjay K Kumar <sanjay.k.kumar@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/14] iommu/vt-d: Add support for static identity domain
Date: Mon,  2 Sep 2024 10:27:16 +0800
Message-Id: <20240902022724.67059-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902022724.67059-1-baolu.lu@linux.intel.com>
References: <20240902022724.67059-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Software determines VT-d hardware support for passthrough translation by
inspecting the capability register. If passthrough translation is not
supported, the device is instructed to use DMA domain for its default
domain.

Add a global static identity domain with guaranteed attach semantics for
IOMMUs that support passthrough translation mode.

The global static identity domain is a dummy domain without corresponding
dmar_domain structure. Consequently, the device's info->domain will be
NULL with the identity domain is attached. Refactor the code accordingly.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240809055431.36513-7-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 114 ++++++++++++++++++++++++++++++++++--
 drivers/iommu/intel/svm.c   |   2 +-
 2 files changed, 111 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 41c47410736b..df34416ba7bf 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3693,11 +3693,9 @@ int prepare_domain_attach_device(struct iommu_domain *domain,
 static int intel_iommu_attach_device(struct iommu_domain *domain,
 				     struct device *dev)
 {
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	int ret;
 
-	if (info->domain)
-		device_block_translation(dev);
+	device_block_translation(dev);
 
 	ret = prepare_domain_attach_device(domain, dev);
 	if (ret)
@@ -4305,11 +4303,17 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 					 struct iommu_domain *domain)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct dev_pasid_info *curr, *dev_pasid = NULL;
 	struct intel_iommu *iommu = info->iommu;
+	struct dmar_domain *dmar_domain;
 	unsigned long flags;
 
+	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
+		intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+		return;
+	}
+
+	dmar_domain = to_dmar_domain(domain);
 	spin_lock_irqsave(&dmar_domain->lock, flags);
 	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
 		if (curr->dev == dev && curr->pasid == pasid) {
@@ -4536,9 +4540,111 @@ static const struct iommu_dirty_ops intel_dirty_ops = {
 	.read_and_clear_dirty = intel_iommu_read_and_clear_dirty,
 };
 
+static int context_setup_pass_through(struct device *dev, u8 bus, u8 devfn)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	struct context_entry *context;
+
+	spin_lock(&iommu->lock);
+	context = iommu_context_addr(iommu, bus, devfn, 1);
+	if (!context) {
+		spin_unlock(&iommu->lock);
+		return -ENOMEM;
+	}
+
+	if (context_present(context) && !context_copied(iommu, bus, devfn)) {
+		spin_unlock(&iommu->lock);
+		return 0;
+	}
+
+	copied_context_tear_down(iommu, context, bus, devfn);
+	context_clear_entry(context);
+	context_set_domain_id(context, FLPT_DEFAULT_DID);
+
+	/*
+	 * In pass through mode, AW must be programmed to indicate the largest
+	 * AGAW value supported by hardware. And ASR is ignored by hardware.
+	 */
+	context_set_address_width(context, iommu->msagaw);
+	context_set_translation_type(context, CONTEXT_TT_PASS_THROUGH);
+	context_set_fault_enable(context);
+	context_set_present(context);
+	if (!ecap_coherent(iommu->ecap))
+		clflush_cache_range(context, sizeof(*context));
+	context_present_cache_flush(iommu, FLPT_DEFAULT_DID, bus, devfn);
+	spin_unlock(&iommu->lock);
+
+	return 0;
+}
+
+static int context_setup_pass_through_cb(struct pci_dev *pdev, u16 alias, void *data)
+{
+	struct device *dev = data;
+
+	if (dev != &pdev->dev)
+		return 0;
+
+	return context_setup_pass_through(dev, PCI_BUS_NUM(alias), alias & 0xff);
+}
+
+static int device_setup_pass_through(struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
+	if (!dev_is_pci(dev))
+		return context_setup_pass_through(dev, info->bus, info->devfn);
+
+	return pci_for_each_dma_alias(to_pci_dev(dev),
+				      context_setup_pass_through_cb, dev);
+}
+
+static int identity_domain_attach_dev(struct iommu_domain *domain, struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	int ret;
+
+	device_block_translation(dev);
+
+	if (dev_is_real_dma_subdevice(dev))
+		return 0;
+
+	if (sm_supported(iommu)) {
+		ret = intel_pasid_setup_pass_through(iommu, dev, IOMMU_NO_PASID);
+		if (!ret)
+			iommu_enable_pci_caps(info);
+	} else {
+		ret = device_setup_pass_through(dev);
+	}
+
+	return ret;
+}
+
+static int identity_domain_set_dev_pasid(struct iommu_domain *domain,
+					 struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+
+	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
+		return -EOPNOTSUPP;
+
+	return intel_pasid_setup_pass_through(iommu, dev, pasid);
+}
+
+static struct iommu_domain identity_domain = {
+	.type = IOMMU_DOMAIN_IDENTITY,
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev	= identity_domain_attach_dev,
+		.set_dev_pasid	= identity_domain_set_dev_pasid,
+	},
+};
+
 const struct iommu_ops intel_iommu_ops = {
 	.blocked_domain		= &blocking_domain,
 	.release_domain		= &blocking_domain,
+	.identity_domain	= &identity_domain,
 	.capable		= intel_iommu_capable,
 	.hw_info		= intel_iommu_hw_info,
 	.domain_alloc		= intel_iommu_domain_alloc,
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 0e3a9b38bef2..ef12e95e400a 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -311,7 +311,7 @@ void intel_drain_pasid_prq(struct device *dev, u32 pasid)
 	domain = info->domain;
 	pdev = to_pci_dev(dev);
 	sid = PCI_DEVID(info->bus, info->devfn);
-	did = domain_id_iommu(domain, iommu);
+	did = domain ? domain_id_iommu(domain, iommu) : FLPT_DEFAULT_DID;
 	qdep = pci_ats_queue_depth(pdev);
 
 	/*
-- 
2.34.1

