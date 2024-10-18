Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D26188A18
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 05:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729231111; cv=none; b=FD9vEp+R6TGYXf5C2ui0dy/amL2P5YCy5jOOEKXTGyh1n8/o4UBJKiDNNYHr3yUMIlvJMQNiB2KZ1p+BI6KcwgwxATvuu4IN2qjW2RXS9675mUC6HKxUlY5Db7zQ6l9XQ4vidHYLQ/9Ney9mZOCOA3S05VuagpaMaHpdO/Ol6+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729231111; c=relaxed/simple;
	bh=1d3TsI4vymaiOMQGByLF7JVCA3jll3YyxdnZnCcwgPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ohLyvERDK8gY0QW6cJtVVx7etPE7bMNWI+DNidDUdmYg5mvnpdMIjTS8my4xyPGUfD1yEFlGV8FlrXBXSZ9nGSigHbauzBh2jtW+Zk3R0SQSW0kXQfO8LxKBX+TQEUrZbj4pGMrEwXpZKY32mhexhG5BOTKgaJBkTcvOSHEJoD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aiRPM23i; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aiRPM23i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729231110; x=1760767110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1d3TsI4vymaiOMQGByLF7JVCA3jll3YyxdnZnCcwgPU=;
  b=aiRPM23inxnqgABd7M1kRHncq4IoHoD/ZutOQAdz2MrTo2CxKjydRxAw
   3OIlmJ/bQioRcl+G/BZsis69icA+LNjd2NtRw8TIsaVneoEOE7Cx3tsTx
   OPXJZURHY1KSTBCfXeMJRC+CRHe0dF2rzOswam00yvCemGswlf25p1oes
   9XedAQ9kPto2DRfmYSefAqUJfbuBTyfuB6Ekk+2eZmfLq3bccuV786384
   eBeWDNU4ZGQ58vm7XpcUP6etF9Tf45mUpVwgsPKAkxWKtOSeGOBYqmUJ6
   sAu6s6QOZ2Si4WqfeGpo3tMwPpdJCCxqtbFb44apPSZ+GDCexmLI1NgDm
   A==;
X-CSE-ConnectionGUID: cmPvRKsBT1mztQQ8vJE1Cg==
X-CSE-MsgGUID: UhgU8RrERVezeNefoDAUpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39879139"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39879139"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 22:58:28 -0700
X-CSE-ConnectionGUID: QNvYhXqTScaYVOYvaAkHWw==
X-CSE-MsgGUID: uoNzn0OOTFWZITBkAYCikg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78675735"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa009.jf.intel.com with ESMTP; 17 Oct 2024 22:58:28 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	will@kernel.org
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com
Subject: [PATCH v2 3/3] iommu/vt-d: Make the blocked domain support PASID
Date: Thu, 17 Oct 2024 22:58:24 -0700
Message-Id: <20241018055824.24880-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018055824.24880-1-yi.l.liu@intel.com>
References: <20241018055824.24880-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The blocked domain can be extended to park PASID of a device to be the
DMA blocking state. By this the remove_dev_pasid() op is dropped.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 19 +++++++++++++------
 drivers/iommu/intel/pasid.c |  3 ++-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d089ac148a7e..f814fadcf34e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3412,10 +3412,15 @@ static int blocking_domain_attach_dev(struct iommu_domain *domain,
 	return 0;
 }
 
+static int blocking_domain_set_dev_pasid(struct iommu_domain *domain,
+					 struct device *dev, ioasid_t pasid,
+					 struct iommu_domain *old);
+
 static struct iommu_domain blocking_domain = {
 	.type = IOMMU_DOMAIN_BLOCKED,
 	.ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= blocking_domain_attach_dev,
+		.set_dev_pasid	= blocking_domain_set_dev_pasid,
 	}
 };
 
@@ -4282,8 +4287,9 @@ static void domain_remove_dev_pasid(struct iommu_domain *domain,
 	kfree(dev_pasid);
 }
 
-static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
-					 struct iommu_domain *domain)
+static int blocking_domain_set_dev_pasid(struct iommu_domain *domain,
+					 struct device *dev, ioasid_t pasid,
+					 struct iommu_domain *old)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
@@ -4292,10 +4298,12 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 				    INTEL_PASID_TEARDOWN_DRAIN_PRQ);
 
 	/* Identity domain has no meta data for pasid. */
-	if (domain->type == IOMMU_DOMAIN_IDENTITY)
-		return;
+	if (old->type == IOMMU_DOMAIN_IDENTITY)
+		goto out;
 
-	domain_remove_dev_pasid(domain, dev, pasid);
+	domain_remove_dev_pasid(old, dev, pasid);
+out:
+	return 0;
 }
 
 static struct dev_pasid_info *
@@ -4653,7 +4661,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.dev_disable_feat	= intel_iommu_dev_disable_feat,
 	.is_attach_deferred	= intel_iommu_is_attach_deferred,
 	.def_domain_type	= device_def_domain_type,
-	.remove_dev_pasid	= intel_iommu_remove_dev_pasid,
 	.pgsize_bitmap		= SZ_4K,
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	.page_response		= intel_svm_page_response,
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index ce0a3bf701df..abf2f54e847e 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -238,7 +238,8 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 
 /*
  * Caller can request to drain PRQ in this helper if it hasn't done so,
- * e.g. in a path which doesn't follow remove_dev_pasid().
+ * e.g. in a path which doesn't follow the set_dev_pasid() op of the
+ * blocked domain.
  * Return the pasid entry pointer if the entry is found or NULL if no
  * entry found.
  */
-- 
2.34.1

