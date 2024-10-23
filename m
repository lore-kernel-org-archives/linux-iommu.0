Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE2115B122
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672861; cv=none; b=LsEYoSQ0IHCbECKWEtCnMRo7FxhExoVupGHEuvJVDxlxZ/1SOuIv76sdWCuRlK0F4uglLm22IU5d0vnSJcCWr4NchO2T3Z38jMUVaWabmIH1DybChyDpzAyCImaPPJvabTh3uoa57ro1pNeQktQujj2NJEmfD7P8xFG5sar+S38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672861; c=relaxed/simple;
	bh=+7tOHXxJe1qheqba1DP3WAlFgc9rCHygnziCtv2fj3g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A9ODcdDlKcfEKrxeRkpwaUs/Mo/5pmBTV364dMb2Haec9hdqyAYG5RQKpqvT3IfEHLwS/58QOcyn5bErt3k3GmFvs/mUX4cNm5neaVuSPKoF2RBLHDobgEo6/EyD2TP2jRFEqLuQ5Ya9zf80Dd9ih8U4DM/XSjkLRWsNZEWusUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGlUq+fY; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGlUq+fY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729672860; x=1761208860;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+7tOHXxJe1qheqba1DP3WAlFgc9rCHygnziCtv2fj3g=;
  b=NGlUq+fYrlnxGvJYNVuOCGvAbEeykBfF3OySbvRSv0R7oj5qTkNXSuTb
   fTkLWtTREIv+mYHVl5Pvnz29pXNUMtbvzBdgV2JihBlw7qVRmg9QgdV6d
   UW8BsssN5tnCbEnk7APlP0y5XnhDpPNwKkiei/N4MGdXNDfvJnjcIw9q7
   R+7CMfJbKjmDRH7AicVdMCW1T27FveLAuWphGpF90+DzPaClLENhwQPYk
   OzggMtvqV9qh+LObO2pAFm05YypkMT2yXRSElh66vzCLbgnu0mBBbYl/s
   U6yOh+1QOkGc51AfRbwiJrQxM+E+WTPgCJjZgGNrZnpNoRUpH/peInrhW
   w==;
X-CSE-ConnectionGUID: l7MvWp5cRNenwqAagjPegw==
X-CSE-MsgGUID: 4RYtA1R7SyusQhN8wU77pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="32108924"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="32108924"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 01:40:54 -0700
X-CSE-ConnectionGUID: l2C+6qjyTBmml93p2LLVjA==
X-CSE-MsgGUID: ZGjevFnIRqSpSsHQQQezFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="80048646"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 01:40:49 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	chao.p.peng@intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 0/2] vtd: Minor cleanup
Date: Wed, 23 Oct 2024 16:37:13 +0800
Message-Id: <20241023083715.582149-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This cleanup the vtd dump code to dump entry when it's present.
See patch log for details.

Thanks
Zhenzhong

Changelog:
v2:
- Add Fixes tag in patch1 (Baolu)
- Refine commit log in patch2 (Baolu)

Zhenzhong Duan (2):
  iommu/vt-d: Fix checks in dmar_fault_dump_ptes()
  iommu/vt-d: Fix checks in pgtable_walk()

 drivers/iommu/intel/iommu.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

-- 
2.34.1

