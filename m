Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6E12AE99
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 02:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722912207; cv=none; b=bw3RyRXZHvqYxhwt97IpXphwM7osI14nf2O9u1Gyhhq6Hc/m0t3rJnczuK+zAEmjOaKkkXGYHqP/MvQObw6CGEagfgOh0bBFhQQ86162qgJPWnKPTQMKVcEwnLgftXviXWsGuOspgbfnjm0i9LUqB8zELADoRSrCYl4FWW0ywBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722912207; c=relaxed/simple;
	bh=BKDP/l/ykYrd+su1McxY6adYnlMLl4k2S1MoqpKDU7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OdEAI6yrTGoTSEO1Xpz17E9Tli0AlLTImRY35zWdhEyZoxzn7kqFEtB1UnaMLq8FiO3T+vZFFd3iK2OYpahD/HQvsULtcS9zgH0V6M2MBjt6gbGXe+pGRCdkYkhZuL+xiHjQ360Zm4t+iAproVX81icXf1pUF+k7Hv++2o72wGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dPJX37v6; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dPJX37v6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722912206; x=1754448206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BKDP/l/ykYrd+su1McxY6adYnlMLl4k2S1MoqpKDU7E=;
  b=dPJX37v6igVl5hja4X5d2PBatEeIPXCy2o/8pDws8a8s1Vdpon82ual2
   xrTR+1ryBAq5kjXgmp8PnzCbN9a0GqrBMCSu2gqvRhhNHdObL7MbsNn6j
   ih37ZcY6wuk2Mu9t8ME24Jn6+0m07JCmDWCNsd/TrsMbJEOuCtJCSNc+U
   +Vn6SOqeiO5kI3f40JyFDCXjD5zNaXNP2zWmCK60kxBhNQwHdjzK0piK1
   nglV5f/vSFBqBxkF57S43SQQvjwUf7uLKhcvHeq5G4SZ/dlgKt2prHXZQ
   sYcDyxBZ/O+JCQoSxyZU0CvTHkwZBQEeUaDRM+YwNJvi91cI//Jc7Epmn
   A==;
X-CSE-ConnectionGUID: x3cpNPxLSzq2ZBttCjTyQg==
X-CSE-MsgGUID: 1nTDhc3xQmG0tlBd8gl2gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20756297"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="20756297"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 19:43:26 -0700
X-CSE-ConnectionGUID: 9V5IqpnMTdyShbtqBoWYIA==
X-CSE-MsgGUID: BCfQxyQBSY+zMxk5ZLKzKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="56572538"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 05 Aug 2024 19:43:24 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 6/7] iommu/vt-d: Add support for static identity domain
Date: Tue,  6 Aug 2024 10:39:40 +0800
Message-Id: <20240806023941.93454-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806023941.93454-1-baolu.lu@linux.intel.com>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
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

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 102 ++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2ac56e2355e1..9e7b4159e53f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4570,9 +4570,111 @@ static const struct iommu_dirty_ops intel_dirty_ops = {
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
-- 
2.34.1

