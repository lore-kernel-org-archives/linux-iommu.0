Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FD44A99A2
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941005; cv=none; b=sus8nK4xaEIYK5Jk7bnZ90iTdgdc4iX+aiXRVVdFdxFvKE5hWCsllHuOURp4tQlvcirOhuw6Bj2k06fBmz/65FgkTNB++GD6Xzgt7AYQDychdpCJxPcO4ofDimwHvHX7wd/CZl6Xyqo7R7TJL+VPNZQcofAJ1LM1osPdSHAcOh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941005; c=relaxed/simple;
	bh=qZ97WV+Bmf61BkqszfOZ/IyHAJ1T40e7IqxYc0omenc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uehFsR/vhMy/DFBadZKVWppKHA0uAUBRZezgaHvYNkSvnf9iuPQ0d3N5V+vFzPbEtgF0NhUk36Ugy2wut6Q0chTRBB0PHHQJ3DBlLbrpqxUBbpikScaBWu5dm+Pcj8iGup4l+S3pGHtLkodbcHv/Ab0cPVqcJMQczHwRB6lkCEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RTMGREfj; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RTMGREfj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788941005; x=1820477005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qZ97WV+Bmf61BkqszfOZ/IyHAJ1T40e7IqxYc0omenc=;
  b=RTMGREfjcC7s0FgCZa405hEhRB8fnsceYardlT6wuRzfvnSQnbl08Bvf
   0AhiIEp0PgXYGQRO3gS4QROcj/l5AmqyeT6tn4ekJ9D2DOGkYCfnBeda6
   hJ2thmTt65yD8GtaUB4aj+0hFARc5JIDqnnlb1a3QnIizjYmB+vvWvgvP
   ZUfbsiZ7vx3wUCfo7Eletz9m93ENsy5ZywKlikb+tfdQ21z7vs2ocyyEL
   iM1CF4E62OLdr3eCW5afWXiu5A4ztAxq0eGsFSfmD6pwlih8+41sqsdHB
   FBAwmVboKfbFP3uOQE3CImW0ooXKiJYUTUbvVbBhGdyEK4/XVEDJ5ktL0
   w==;
X-CSE-ConnectionGUID: WB0oWFiiTDKelXzMWSkCig==
X-CSE-MsgGUID: LmQfkl9QT5OMBsnZAvqIfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106726532"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="106726532"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 01:03:24 -0700
X-CSE-ConnectionGUID: 7Fk2oQjRRWmIH01c1CeBFg==
X-CSE-MsgGUID: 6F2MB3ptR0CBb/9Ve8Xq4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="301119295"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by orviesa002.jf.intel.com with ESMTP; 09 Sep 2026 01:03:22 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 7/7] iommu/vt-d: Drop old iopf ref only after attach succeeds
Date: Wed,  9 Sep 2026 15:51:06 +0800
Message-ID: <20260909075106.738691-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909075106.738691-1-baolu.lu@linux.intel.com>
References: <20260909075106.738691-1-baolu.lu@linux.intel.com>
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
---
 drivers/iommu/intel/iommu.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 99cf6716f602..c1529be63650 100644
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

