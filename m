Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FD86A8BE
	for <iommu@lists.linux.dev>; Thu,  8 Feb 2024 09:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383659; cv=none; b=OY2ihdmPy/V679Zh2v+Qa366esYC4WOz/5eCFhLJoauo7jgygU/RBXY9l27lRWv2QjRmtFmP2xHvF84TaNi/zxn4E8V4FPi0IL3PThuT67ruPWZEujWPaccjRibwg0IjYCVXOuhp7QP6y74xXwYIGtR4+o29m7EjtGTTAUpu4uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383659; c=relaxed/simple;
	bh=GfZd+JEhD2jTwwbKWrI6hzvpQqkOQgWgJY3OFvAaJwg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sddp1tF3HQRUeLfxLstquX8dzDDFhF50bV0RkTP94tn/ZxE+bGXSDFAKWBurwZ9ZI5bHYVkq/JvbnipohPMnLXBldUA+MhLLEXy9xIoti3a2HSNs9ThudAtV9WUfQh2ZjolksBlp2XZ4WiquB///pcoqV27KD1bCe94PPI9lT1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YyLMhqkb; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YyLMhqkb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707383658; x=1738919658;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GfZd+JEhD2jTwwbKWrI6hzvpQqkOQgWgJY3OFvAaJwg=;
  b=YyLMhqkbDX3wBjjeaNMIerQLnERLIDDvFD13bxM4nhBV4poFLUULXUzl
   iLOkwmkk0wvwmGxGfU52FLRHXBX/mYihUtRMzcc+6d81Q5hmqoUvhUlSc
   8hayK9wSqTc5c4GFpzSJITj+K3qDKOqnDhpuHO7crgzfjHrqnngFkPuiv
   dKl12Z4XcDOV9rqx4X90N64bQNTN/ve6u3hEn+ZuROE4wepxR86A6Old8
   piHfOffiRJTvFE1Q2vY+d/0YdMNmu1XESNxe6BqtyzTXGgzyR68Z5kPbX
   OjgDFlUiaS6p5xvabLya+x9/tcFLLlPKmZ9kpMebhIVvWjluY6AdpglSS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1475034"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1475034"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 01:14:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="32672164"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa001.fm.intel.com with ESMTP; 08 Feb 2024 01:14:16 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	robin.murphy@arm.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	yi.y.sun@linux.intel.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com
Subject: [PATCH] iommu/vt-d: Set SSADE when attaching to a parent with dirty tracking
Date: Thu,  8 Feb 2024 01:14:14 -0800
Message-Id: <20240208091414.28133-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Should set the SSADE (Second Stage Access/Dirty bit Enable) bit of the
pasid entry when attaching a device to a nested domain if its parent
has already enabled dirty tracking.

Fixes: 111bf85c68f6 ("iommu/vt-d: Add helper to setup pasid nested translation")
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
base commit: 547ab8fc4cb04a1a6b34377dd8fad34cd2c8a8e3
---
 drivers/iommu/intel/pasid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 3239cefa4c33..9be24bb762cf 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -658,6 +658,8 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 	pasid_set_domain_id(pte, did);
 	pasid_set_address_width(pte, s2_domain->agaw);
 	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
+	if (s2_domain->dirty_tracking)
+		pasid_set_ssade(pte);
 	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_NESTED);
 	pasid_set_present(pte);
 	spin_unlock(&iommu->lock);
-- 
2.34.1

