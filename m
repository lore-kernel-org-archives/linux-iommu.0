Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678CE34DCCD
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 07:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773645568; cv=none; b=F5var/LTS97q/wyCzAR1uQOmWo47RVPwE9/gBeyVNDQYuEAZrY3+zSbkWWwOdr6lcyvWCascBg8GbeNDRK2SOuJ6rWXsEN7GpCqx4Yi/7r7Aj0eAhWiOTw9SB544b/Vw8nU+NqU19eHtwshhZkYUNFqNYXjV+goKxmzJHev6NsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773645568; c=relaxed/simple;
	bh=jXEehlLu4eHg/cJ7PweERZHLCJv+lrqKpY3LFWQ8Gw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsWjOldk6wQqYEWooEgBsXSfOcwrT5iqOmCgSLdm6l+EArDZveM4UlijBRQGpsHZNoD4OUFg0tMuMYUJLI1DuFBN8XAvPAMp+ixwh/wGEYke9Ikjj/B+ainXhm3P4geRuKP3/AVBRkY1qoxYnniV7I1Z92DCniFEH+EfKbycXRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ipFBsYEv; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ipFBsYEv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773645568; x=1805181568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jXEehlLu4eHg/cJ7PweERZHLCJv+lrqKpY3LFWQ8Gw8=;
  b=ipFBsYEvZqOjLMy4JIEkZbb7ukNtbzzc76E8wL/FKsSBvQi2CTZTF6yi
   ReUTKZV6Hj8jWHXOR7WG1JRsc3NDlY3dj1gTF8/GqEyTU/IyG+zOtkbzB
   rLCWf2vgC5HwLH1mPVUuSGck7wczdURYqPvRCTZoXv3WsGwpk1rIvT4m+
   qoVIvk8cwpe83qy1bg79lwzuIKbhSY7I06EK7yZEJaeK7kMX9mVUvZ1zJ
   KRpia38FwM99supafY6L4/PpNokZc6SP6SiSasEiokz778DQy430OQLaX
   zJa1owgPEfKV9MYb0GgatjmngE/v+3GdeMrY53hNCqkgy0DYgXSh0CHGt
   g==;
X-CSE-ConnectionGUID: 8xNSgZ+LS7erYvnJZ7lbGg==
X-CSE-MsgGUID: Y09ge97lQEydizKIMO3i1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="92038596"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="92038596"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:19:27 -0700
X-CSE-ConnectionGUID: cDjNQQh4Q4+3JKTP00aB8A==
X-CSE-MsgGUID: V3HV3I1NSzyLLpM7AfRRXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="226496923"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa005.fm.intel.com with ESMTP; 16 Mar 2026 00:19:26 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iommu/vt-d: Only handle IOPF for SVA when PRI is supported
Date: Mon, 16 Mar 2026 15:16:40 +0800
Message-ID: <20260316071640.347227-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316071640.347227-1-baolu.lu@linux.intel.com>
References: <20260316071640.347227-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In intel_svm_set_dev_pasid(), the driver unconditionally manages the IOPF
handling during a domain transition. However, commit a86fb7717320
("iommu/vt-d: Allow SVA with device-specific IOPF") introduced support for
SVA on devices that handle page faults internally without utilizing the
PCI PRI. On such devices, the IOMMU-side IOPF infrastructure is not
required. Calling iopf_for_domain_replace() on these devices is incorrect
and can lead to unexpected failures during PASID attachment or unwinding.

Add a check for info->pri_supported to ensure that the IOPF queue logic
is only invoked for devices that actually rely on the IOMMU's PRI-based
fault handling.

Fixes: 17fce9d2336d ("iommu/vt-d: Put iopf enablement in domain attach path")
Cc: stable@vger.kernel.org
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20260310075520.295104-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/svm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index fea10acd4f02..57cd1db7207a 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -164,9 +164,12 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 	if (IS_ERR(dev_pasid))
 		return PTR_ERR(dev_pasid);
 
-	ret = iopf_for_domain_replace(domain, old, dev);
-	if (ret)
-		goto out_remove_dev_pasid;
+	/* SVA with non-IOMMU/PRI IOPF handling is allowed. */
+	if (info->pri_supported) {
+		ret = iopf_for_domain_replace(domain, old, dev);
+		if (ret)
+			goto out_remove_dev_pasid;
+	}
 
 	/* Setup the pasid table: */
 	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
@@ -181,7 +184,8 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 
 	return 0;
 out_unwind_iopf:
-	iopf_for_domain_replace(old, domain, dev);
+	if (info->pri_supported)
+		iopf_for_domain_replace(old, domain, dev);
 out_remove_dev_pasid:
 	domain_remove_dev_pasid(domain, dev, pasid);
 	return ret;
-- 
2.43.0

