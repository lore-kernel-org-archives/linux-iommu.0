Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EB2288C30
	for <iommu@lists.linux.dev>; Thu,  5 Feb 2026 02:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770258856; cv=none; b=IKy1WxS3Xkg3w0+ZEhKf8EB+Gl8MCDCsni+DuPTDzmdc0n++3ckFBKWh1o04ArV0jKwLIhZ6ak9OOXVf20W8rywvai7xd+x0edGXhEd7xz9zK1Ei2ektSctYkAHxigTA2xMJJYqPb27RygGfi65V47l4mJKUjfxmZFqAgJaR4D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770258856; c=relaxed/simple;
	bh=87tdYsG+IADvhWOpphjh2r8ncmdaPwUdf7yUVWfAU24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mNSoKI4zx+3+rGmU7MLHQCF4Zm28+DpASlC9X/tqyF+9tFNzUFzq1rJQ0D1bNrV5wXcq0D0ia9EhGWH7HpqxGkpp/+r7vNH5k6/QPDQsu0R3H2NpPS6+5yQCIOyfPVSfcBDuVsVGo/8jr8GfxigjGdWgwAhHqBISN+r/707edvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ju8s7WCh; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ju8s7WCh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770258856; x=1801794856;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=87tdYsG+IADvhWOpphjh2r8ncmdaPwUdf7yUVWfAU24=;
  b=ju8s7WChIuSGtOCLZiNI5FxXQ2Wy3947rvYBScDxSYPDJ0M4v2YG/MN8
   V+5NDOMy3BFm92fd9muG5purxIWgM4y/DlJKnmBvtWE4aeEayZ/3AHSs5
   UjluARqZbWIUqcsEi3Q2fBx3qhjF0FSqExLsQFghzAobkfwkQ5ttZNFCc
   l8A5v4dUwVvraed7vhLX1sG5zpHSY6IXLRbp8sIhbMGHv790jD/putdJ0
   RDzaHZDMdL7PA/PqXfUICoRAVvFqACkNE4wZdDrXDh0WJsfa2VwjgGU5u
   Md15rhvQaV9JmEPfcLCB8xRr3HuV68d1ATXBT6uSBIdFhAngmITxwKAgf
   w==;
X-CSE-ConnectionGUID: FdyX7RhZR5GW6Iu/hzTKuQ==
X-CSE-MsgGUID: Wl9VpyYnT5a1OBEDqyObiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="74057926"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="74057926"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 18:34:15 -0800
X-CSE-ConnectionGUID: qy4jpJ6YQ0qnghEVz1NsFw==
X-CSE-MsgGUID: mHAi4ubqTNuBrTAmE3kd3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="214872048"
Received: from spr-duan.bj.intel.com ([172.16.114.123])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 18:34:13 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 0/3] iommupt/vtd: Support dirty tracking on PASID
Date: Wed,  4 Feb 2026 21:34:01 -0500
Message-ID: <20260205023405.41583-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

When we add pasid support in QEMU for passthrough device, we found
PASID attachment to a nested parent domain with dirty tracking failed.

It's because PASID-level dirty tracking is not there yet, by adding it,
we can enable PASID attachment to such domain.

Thanks
Zhenzhong


Zhenzhong Duan (3):
  iommupt/vtd: Pass dmar_domain pointer to device_set_dirty_tracking()
  iommupt/vtd: Support dirty tracking on PASID
  iommufd/selftest: Test dirty tracking on PASID

 drivers/iommu/intel/iommu.c             | 33 ++++++++++++++-----------
 tools/testing/selftests/iommu/iommufd.c | 27 ++++++++++++++++++++
 2 files changed, 45 insertions(+), 15 deletions(-)

-- 
2.47.3

