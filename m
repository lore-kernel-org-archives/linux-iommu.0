Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF622E6CA6
	for <iommu@lists.linux.dev>; Thu,  3 Sep 2026 07:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420267; cv=none; b=bER/4uQSa0toMaxYt6iBbX3gc83AdjKD/McQrZ7d6cG5yD8JAXHpOBzmgIaT0KLnfNVtE5vMwOaD9JpaPVIx5mzcbV8fpy8FpLorhmoqta4EPFkkg8WYin70gFgfrMHO0H4DYlBSUlDhIssUWFSopYAF5bxKyUTnkcYTt4y5DU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420267; c=relaxed/simple;
	bh=3WvsOYwir7XI7lT0wiq5w0hWvcZARyz1zOMO6+FxUyY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KwWfqLwpUOPBy9tn2dA23SxKzh0PJkrl7CM0/Dcz09cGTrKe+3faqnI+KavWa1KKESA+AszHyHp6haRTZfaR4kZZ1NL14yvlSs+4l0Eizr76di+XXYNd8DIH+JaGN17DhMHfY5PNEWpJThvhzza2/NuomungDb6qO2kGkYPmepY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eUBxVKPN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eUBxVKPN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788420265; x=1819956265;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3WvsOYwir7XI7lT0wiq5w0hWvcZARyz1zOMO6+FxUyY=;
  b=eUBxVKPN8H6mj19l/Ec+aCy1Bc/MGerjgWFNuACSuF292VdkDolJn5JA
   af4t/HiTWzjrcI2vFujJfjvt5gPzN+D4HJMujesvfefOfPNCOoViSEwu4
   ZVsZZCCQVDIXS3mgIYfAhqEF757OGfFcOnZNSSSghorc03/TNJFOYRWKK
   +mQkG+w861ihyhqso0UfLFHNXcl5uQJLuA85cK5i3gbnX0WBcjFSTYbxp
   8tqhVfsG/LPdIsov/k4QFLC5bghyQoM6LokR/uE80qPflv8XiJzF51fgp
   ulzij8wZ0mE2De46T+chwuZg/fbnjtcsnk5jLKpFOfukiYYfBeLmXgf+3
   w==;
X-CSE-ConnectionGUID: +0D1gq+rSn6iWNZ9rcNTrQ==
X-CSE-MsgGUID: 6PJIHayDTBO4qYPVyq6SGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="92710918"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="92710918"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 00:24:25 -0700
X-CSE-ConnectionGUID: HXJ7fv1dQBuK6U/xaPRgTg==
X-CSE-MsgGUID: BR1R4ZNCTDiJOyxr2o4X8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="268306452"
Received: from ly-workstation.sh.intel.com ([10.239.182.64])
  by orviesa010.jf.intel.com with ESMTP; 03 Sep 2026 00:24:23 -0700
From: Yi Lai <yi1.lai@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	joro@8bytes.org,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	yeeli <seven.yi.lee@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	yi1.lai@intel.com
Subject: [PATCH] iommufd/selftest: Fix wrong return value in iommufd_test_dmabuf_get()
Date: Thu,  3 Sep 2026 15:24:19 +0800
Message-ID: <20260903072419.1485256-1-yi1.lai@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit dba4254e216d ("iommufd/selftest: Fix dmabuf leak in
iommufd_test_dmabuf_get()") broke the success path: it changed the
function to always "return 0" instead of returning the fd produced
by dma_buf_fd().

Userspace obtains the dmabuf fd from the ioctl() return value, so every
successful IOMMU_TEST_OP_DMABUF_GET now reports fd 0 instead of the real
fd, causing iommufd selftests to fail, such as:
  not ok 67 iommufd_ioas.mock_domain.dmabuf_simple
  not ok 94 iommufd_ioas.two_mock_domain.dmabuf_simple

Fix by returning rc unconditionally: on error it is the negative
errno from dma_buf_fd(), and on success it is the valid dmabuf fd.

Fixes: dba4254e216d ("iommufd/selftest: Fix dmabuf leak in iommufd_test_dmabuf_get()")
Signed-off-by: Yi Lai <yi1.lai@intel.com>
---
 drivers/iommu/iommufd/selftest.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index ee706f18f7e9..f6da927461b5 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -2056,11 +2056,9 @@ static int iommufd_test_dmabuf_get(struct iommufd_ucmd *ucmd,
 	}
 
 	rc = dma_buf_fd(dmabuf, open_flags);
-	if (rc < 0) {
+	if (rc < 0)
 		dma_buf_put(dmabuf);
-		return rc;
-	}
-	return 0;
+	return rc;
 
 err_free:
 	kfree(priv->memory);
-- 
2.43.0

