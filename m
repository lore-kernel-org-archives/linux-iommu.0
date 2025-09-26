Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D542C261596
	for <iommu@lists.linux.dev>; Fri, 26 Sep 2025 02:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758854646; cv=none; b=fbXSJ+2OMfjQywmpzCcIqBbOe7EhJ2KretPjUFHOF9sbef5pJGrVCHo3/HLm8fiAyCTYtMfhRg4TBWg19LFODjCxlCDyr6I4hZTwnNPwWIf53pHq1Kkbpu/PFYn4lksaIb6SUz6l/5HHZz5D1X3CiJjZiqMwUMdSUBijGOqhsxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758854646; c=relaxed/simple;
	bh=Nys7nGmEzAa3Rs+7Dx+hsECm3DHD9HVcRdRnYALRaWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lVgOwirsQkkTfm6xKH5AwkVdqWS4freo50SlgrPgxsS6V558j0PYEflJAa7xyXZvpoINDbVWW3sY0MadfAR3siWHjac8Lohj+2XaAzu3e6303qQ39HnWlBXxrZDUuKE+8UqLsdm/Ce0/RXy+KlvYyTkXBnc2EG+X/Pkdo8jiUr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WjTAAf/i; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WjTAAf/i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758854644; x=1790390644;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Nys7nGmEzAa3Rs+7Dx+hsECm3DHD9HVcRdRnYALRaWw=;
  b=WjTAAf/ibo/3gB6Bls8VCMJbqC1/R+zG+uUrGYe0mR7iLskO7eMXq+0E
   GypFXgSdrmhmOzUfyneQ/ofh9HribrbFR0iDTy8xiHsiXCEyYAA+Ojs5t
   0D+dIWznEoqSUbmJ7AcT5LDVwRNAXUVANu/vt9DOLQavmD+ypuFX1siMX
   nzmZMD31lnYS5xsiAhdMjqWTDt7luLVqBeiWsWfh6mYuqwgN1o7GJY+nk
   zcuidMCfdu/4CCGNyjt3tZWaejaXsACjgf0WW7pbxYkAyg+WZg9jkFFlq
   a/BWj8wFkj+EPJY2T1hIWPcSMU2a8aBEOLGVYptfT5lq6qGTzuS6eOeYp
   A==;
X-CSE-ConnectionGUID: /eevAWHLRj+1K9ko6Rgklw==
X-CSE-MsgGUID: 1jhU8UaSRlSwzK0W7J3RvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="61354314"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="61354314"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 19:44:04 -0700
X-CSE-ConnectionGUID: jkfUqTK3T7qhzSV7pxM+Zw==
X-CSE-MsgGUID: LIMtWEstSHOsvEoYHQosKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="177948774"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa009.fm.intel.com with ESMTP; 25 Sep 2025 19:44:02 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] [PULL REQUEST] iommu/vt-d: Fixes for v6.18-rc1
Date: Fri, 26 Sep 2025 10:41:29 +0800
Message-ID: <20250926024130.157514-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following fix has been queued for the Intel iommu driver. It aims to
solve the following problem:

- Disallow dirty tracking if page walk is incoherent

This fix is not so critical for v6.17-rc. Considering the upcoming merge
window, it would be fine to include them with other patches for v6.18.
Please consider it.

Best regards,
baolu

Lu Baolu (1):
  iommu/vt-d: Disallow dirty tracking if incoherent page walk

 drivers/iommu/intel/iommu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.43.0

