Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DE4357CED
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 03:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790566770; cv=none; b=WkidMtyrz0DWZfyumtFI7XUywyTEVJ+DmNNlfGxU5tTYnUNNsjeUsbmFw2D0HRpkRtKEWexp0sLz1GizDtuzVxhlze450FzNha70z1goOYiaCvVEW8zI5CxIz8zaZW+S8AID9L7niZOumW9jNR6r2SzZeSedOk3bNjgLumSQmZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790566770; c=relaxed/simple;
	bh=7tITvt/mW/Sxh4NJyCUqWEFofzjYSM07/nRHQcaLzNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kVIos+ek1VOGRYAQdHtwh8aRbdC8cVFIaoPIPsIPTN9PO0F00N2qQzR52mwPrgYRPzmGk0dHCnohVExVDQdNj9caOG5ZShYyMtqRl4ckJ/kTP9LD1XA0iBHhReWYZPJWNUe6mR+JjDUDBRur2dw1RzI77VHw8T3ceFgxYNrVsHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WtGfwB/I; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WtGfwB/I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790566769; x=1822102769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7tITvt/mW/Sxh4NJyCUqWEFofzjYSM07/nRHQcaLzNA=;
  b=WtGfwB/I5QfSKWul8NMmfR79FY1/xbDO2IHhkfu2S58D9n63KhRqkOmf
   vdeagzxzGk4yQsy0J9ArlDUEZ4oHBUqTESO+CCFRfVey+upUZrQ4ViRM2
   L9tVFKEOoZA5xAbDwiNTaRI0yIMbqinwG01zdtA8+nPR29I1wO2no5dKW
   XgPfcFLWOYa2TvYamxfGU0hXzYVwv/elPCSnNR2ranw07CtgvAcpaJiJ4
   PIWmmwag6frpc2AGAOL+7cgGouaHbqoD6LTtz+0glstAFpsALE5nf+uci
   /1Avn1+jmmLyGpS3pO8YZbcUKobsxVC+qjyOeZ3j3S30KyXJOh4XO35Sq
   A==;
X-CSE-ConnectionGUID: ZtrVJNrRS+m/tE7YnzA84g==
X-CSE-MsgGUID: DNKDvIZvSU+k7s/mQ0IBYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="101917228"
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="101917228"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 20:39:28 -0700
X-CSE-ConnectionGUID: qsSjn7EuTyKjQzVMscv+9g==
X-CSE-MsgGUID: 2vObYafTSUWraTfejA/oXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="283004113"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa005.fm.intel.com with ESMTP; 27 Sep 2026 20:39:27 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] iommu/vt-d: Drop old iopf ref only after attach succeeds
Date: Mon, 28 Sep 2026 11:27:21 +0800
Message-ID: <20260928032722.2868623-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928032722.2868623-1-baolu.lu@linux.intel.com>
References: <20260928032722.2868623-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

identity_domain_attach_dev() currently removes the old domain’s iopf
reference before programming pass-through. If pass-through setup fails,
attach fails but the old domain is still effectively attached — now
with its IOPF ref already dropped.

This can undercount info->iopf_refcount and may disable iopf queue
handling while the old domain can still issue page requests.

Fix it by removing the old domain’s iopf reference only after
pass-through setup succeeds, matching other attach paths.

Fixes: 236dd58fabd2 ("iommu/vt-d: Fix iopf_refcount leak on RID domain replacement")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1fb9b80f3b5e..e3ec7f3b7826 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3985,6 +3985,14 @@ static int identity_domain_attach_dev(struct iommu_domain *domain,
 	if (dev_is_real_dma_subdevice(dev))
 		return 0;
 
+	if (sm_supported(iommu))
+		ret = intel_pasid_setup_pass_through(iommu, dev, IOMMU_NO_PASID);
+	else
+		ret = device_setup_pass_through(dev);
+
+	if (ret)
+		return ret;
+
 	/*
 	 * The identity domain has no iopf_handler, so no IOPF reference is
 	 * taken for it.  The reference held by the old domain must still be
@@ -3992,16 +4000,9 @@ static int identity_domain_attach_dev(struct iommu_domain *domain,
 	 * not affect the IOPF reference count.
 	 */
 	iopf_for_domain_remove(old, dev);
+	info->domain_attached = true;
 
-	if (sm_supported(iommu))
-		ret = intel_pasid_setup_pass_through(iommu, dev, IOMMU_NO_PASID);
-	else
-		ret = device_setup_pass_through(dev);
-
-	if (!ret)
-		info->domain_attached = true;
-
-	return ret;
+	return 0;
 }
 
 static int identity_domain_set_dev_pasid(struct iommu_domain *domain,
-- 
2.43.0

