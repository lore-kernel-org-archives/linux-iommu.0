Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE5438F654
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 23:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780443424; cv=none; b=NdDx2roiJIJKgadTa16nR1pdm732EiDBxN307dXC8uktAF7DlH65B1Q92kBGakv0qbW2WTsxRMPPW68ndBIVHM5e+XMZitdl/oahMb2HCZ7HZto9HOsJBAsWhaveZimK7m4sO73K4hhLtupi8dFLysP3KM+iFB3vsnmi7eigH0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780443424; c=relaxed/simple;
	bh=UJfzrNHwLtO9mjdbuOxo0aC264qVGR8jQJjJigoi/2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4sutpvwQvaN0AHGW+eDsNRiZWykK+AI6T4zLuXuCy1us9j1IPjZYm88KRIXXFeKhH9uJMZ47fkDepC2Sa+wUcU7URk9/MI0T81ds1ggUY5I0CvtU2Hnid/Cb6GBg7AqBmIypwyUbloSbh7+tYWIAkVU2Znm3hgXYV4E1i4lrxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iD9umD3q; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iD9umD3q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780443422; x=1811979422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UJfzrNHwLtO9mjdbuOxo0aC264qVGR8jQJjJigoi/2k=;
  b=iD9umD3qMiUDnI05pwtcynn825OE1cXAXXy0OvStBPlpKihTikWMfYdY
   TOjokRw+mtFScuhpSgJttGr9MyjJsKvvK4gyjgt2qmy2xZGE+OIBIPjM7
   uWncnG1pJ1sPFqFXAY3a7T/H3cN5KmY0E5+HYVsPjpRXHfafEGeDIzDNv
   rrH1bbz/d79kDF+vDye9LjobQo3Ck6RFA0DF5bmJr83UpqP2BU/4G5CVS
   PHq9VtfmgUtcAH7iB0BeNJxvY2l59Z5yxcu+fN/lntkAbt1sN1gzd594n
   Lwj/qk7YmAhCpM1yyl4wYXgsQwXyCnkz5yL3z+4SH3nwHDsnyHHAQM0og
   Q==;
X-CSE-ConnectionGUID: 28cAcNUZS2imXtOdLxZQGg==
X-CSE-MsgGUID: ULxP2vJZQu2eoVgW2SUvOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81369759"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81369759"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 16:36:58 -0700
X-CSE-ConnectionGUID: OC28zMe3TcyA/LeAFdPDsg==
X-CSE-MsgGUID: O47eRbn1TS6h0G0BpyLXAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="241068760"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa007.fm.intel.com with ESMTP; 02 Jun 2026 16:36:56 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Pranjal Shrivastava <praan@google.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] iommu/vt-d: Fix Use-After-Free in probe error path
Date: Wed,  3 Jun 2026 07:34:25 +0800
Message-ID: <20260602233426.357499-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602233426.357499-1-baolu.lu@linux.intel.com>
References: <20260602233426.357499-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pranjal Shrivastava <praan@google.com>

When intel_iommu_probe_device() fails after the info structure has
been linked to the device via dev_iommu_priv_set(), the error path
calls kfree(info) but does not clear the pointer in the device
structure.

This results in a Use-After-Free regression if the pointer is accessed
by a subsequent IOMMU core call or a re-probe.

Fix this by ensuring dev_iommu_priv_set(dev, NULL) is called before
freeing the info structure in the error path.

Fixes: eda1a94caf6b ("iommu: Mark dev_iommu_priv_set() with a lockdep")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260525205628.CD4431F000E9@smtp.kernel.org/
Signed-off-by: Pranjal Shrivastava <praan@google.com>
Link: https://lore.kernel.org/r/20260531170254.60493-3-praan@google.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 849d06dfe1ae..ed6d3a0203f5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3320,6 +3320,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 clear_rbtree:
 	device_rbtree_remove(info);
 free:
+	dev_iommu_priv_set(dev, NULL);
 	kfree(info);
 
 	return ERR_PTR(ret);
-- 
2.43.0

