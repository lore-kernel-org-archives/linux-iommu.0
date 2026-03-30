Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C50D3B95F9
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 10:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865480; cv=none; b=dtWE6HuXbjMpogwNcj5UF8KRr6fCx70Ape9RxAXnUf8+zN1EghtfmakKvFVo52XJjy3vCnhjNV1o9MzLFZ7hezSU9Lb62lfkNQmn35XHN9YJfgoFDq0qysEaHYcCvIDGW695r9T8i6ykmQYKRwGS3QvxvqNGR/K1ClEfuamiOLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865480; c=relaxed/simple;
	bh=Yg3qdD3cZBGXRs6RJAFqZbNFIyJ8SytcM6Rfs2wlZJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U6Y5MYA+NdIDf0QuppQkVRV5L6lBrVM4YJQUdy6q9EFUIa5Cw/CQ2b1p+I+FaYtq+6XNi5LP7ZxIF744owGHGQCDoCRKqX9Jwvmi7+ytO4Vn6UTe/e4D+NVxcWRBeeu75MAP32GkJL5D6hgGAsj34w7mqi8SMG0p/VlciVZCPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+bzuoTh; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+bzuoTh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774865479; x=1806401479;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yg3qdD3cZBGXRs6RJAFqZbNFIyJ8SytcM6Rfs2wlZJc=;
  b=J+bzuoThSedSTkqUx3Or+6DrvJRDw5ETQRvXPLbvDixwTYQ+QEty1nAC
   xBNFjfRlzgIzJSfaYFA1YH8UboZyqKu+xqfL7CdiucndYBSdE7tq56YE6
   ACj7/d0Mu9cTKyId47QD9UmiCb5dn07LEi85kY3nm+oP4/NR0cIuQw5vd
   LFCa3czDJNeaN2WgRrRLVYkz9ez0LvPNeFcrvG+CxAGlrPxa7yMA/0Xb/
   eIcPkVt/dpLg2kVUkDR/R9UFj6u9NoTvTq4GH1KfVT7yrccZeFQfPy2mh
   nJPY+fbq3vjTJ0qOTbxuX/gVAtYbBWzMcQ2a6SaoPtwja6K01UhKc+1Tc
   w==;
X-CSE-ConnectionGUID: G3TiSSW7ReCs0kBESZAaJA==
X-CSE-MsgGUID: tWJEksxFRQeXULOM8kQB7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75921130"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="75921130"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 03:11:18 -0700
X-CSE-ConnectionGUID: wLU1g7nCS5mYvVOV7mP3xw==
X-CSE-MsgGUID: vzC9qb8QRoeT7dDp6m3R7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="225913417"
Received: from spr-duan.bj.intel.com ([172.16.114.123])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 03:11:16 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 0/4] iommupt/vtd: Support dirty tracking on PASID
Date: Mon, 30 Mar 2026 06:11:03 -0400
Message-ID: <20260330101108.12594-1-zhenzhong.duan@intel.com>
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

Changelog:
v2:
- a new patch1 to add a check in intel_nested_set_dev_pasid() (Kevin)
- s/device_set_dirty_tracking/domain_set_dirty_tracking (Liuyi)
- add R-b

Zhenzhong Duan (4):
  iommu/vt-d: Block PASID attachment to nested domain with dirty
    tracking
  iommupt/vtd: Rename device_set_dirty_tracking() and pass dmar_domain
    pointer
  iommupt/vtd: Support dirty tracking on PASID
  iommufd/selftest: Test dirty tracking on PASID

 drivers/iommu/intel/iommu.c             | 33 ++++++++++++++-----------
 tools/testing/selftests/iommu/iommufd.c | 27 ++++++++++++++++++++
 2 files changed, 45 insertions(+), 15 deletions(-)

-- 
2.47.3

